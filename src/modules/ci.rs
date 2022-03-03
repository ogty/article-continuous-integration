use std::collections::HashMap;
use std::fs::File;
use std::io::{prelude::*, self, Lines, BufReader};
use std::path::{Path, Display};

extern crate itertools;
use itertools::izip;
extern crate regex;
use regex::{Regex, Captures};
extern crate urlencoding;
use urlencoding::encode;


fn write(path: &str, content: String) {
    let path: &Path = Path::new(&path);
    let display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", display, why),
        Ok(file) => file,
    };

    match file.write_all(content.as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", display, why),
        Ok(_) => (),
    }
}


pub fn read_lines(path: &str) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let file: File = File::open(path).unwrap();
    let tmp: Lines<BufReader<File>> = io::BufReader::new(file).lines();
    for line in tmp {
        result.push(line.unwrap());
    }
    return result;
}


pub fn ci(path: &str, is_relative_path: bool) {
    let languages: Vec<&str> = vec![
        "python", 
        "julia",
        "rust",
        "c",
        "cpp",
        "java",
        "javascript",
        "typescript",
        "go",
        "swift",
        "php",
        "cs",
        "scala",
        "haskell",
        "lua",
    ];

    let single_line_comment_out_prefix: Vec<&str> = vec![
        "#", 
        "#",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "//",
        "--",
        "--",
    ];

    let language_comment_map: HashMap<_, _> = languages.iter().zip(single_line_comment_out_prefix.iter()).collect();

    let mut article_script_path: String = format!("{}.txt", path);
    let mut article_path: String = format!("{}.md", path);
    let mut project_path: String = String::new();

    if is_relative_path == false {
        article_script_path = format!("./articles/{}", article_script_path);
        article_path = format!("./articles/{}", article_path);
        project_path = format!("./projects/{}", path);
    }

    // Getting the regular expression and matching index of a code block
    let re_code_snippet: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*)").unwrap();
    let re_code_block_operation: Regex = Regex::new(r"```(?P<lang>\w+)```(?P<path>.*)").unwrap();
    let mut article_line_count: usize = 0;
    let mut article_data: Vec<String> = read_lines(&article_script_path);
    let mut matched_indexes: Vec<usize> = Vec::new();
    let mut matched_code_block_indexes: Vec<usize> = Vec::new();
    for article_line in &article_data {
        if re_code_snippet.is_match(article_line) {
            matched_indexes.push(article_line_count);
        } else if re_code_block_operation.is_match(article_line) {
            matched_code_block_indexes.push(article_line_count);
        }
        article_line_count += 1;
    }

    let code_block_start_indexes: Vec<usize> = matched_indexes.clone();

    let mut result: Vec<String> = Vec::new();
    let mut for_playground: Vec<String> = Vec::new();

    // Get the source code of the file specified by the code block.
    for matched_index in matched_indexes {
        let code_block_start_line: String = article_data[matched_index].to_string();

        let splited_code_block_start_line: Vec<&str> = code_block_start_line.split(":").collect();
        let lang = splited_code_block_start_line[0].replace("```", "");
        let comment_out_prefix: &&&str = language_comment_map.get(&lang.as_str()).unwrap();

        let source_code_path: String = if is_relative_path {
            splited_code_block_start_line[1].to_string()
        } else {
            format!("{}/{}", project_path, splited_code_block_start_line[1])
        };

        let source_code_data: Vec<String> = read_lines(&source_code_path);
        let code_block_number: &String = &article_data[matched_index + 1];
        let mut count: usize = 0;
        let mut comment_out_start_end: Vec<usize> = Vec::new();

        // Get the first and last indices of a comment-out
        for source_code_line in &source_code_data {
            if source_code_line == &format!("{} {}", comment_out_prefix, code_block_number) {
                comment_out_start_end.push(count);
            } else if source_code_line == &format!("{} -{}", comment_out_prefix, code_block_number) {
                comment_out_start_end.push(count);
            }
            count += 1;
        }

        if comment_out_start_end.len() > 0 {
            let source: String = source_code_data[(comment_out_start_end[0] + 1)..comment_out_start_end[1]].join("\n");
            // If you specify a playground URL
            if splited_code_block_start_line.len() == 3 {
                let cloned_source: String = source.clone();
                if lang == "rust" {
                    for_playground.push(format!("[{}](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code={})\n", splited_code_block_start_line[2], encode(&cloned_source)));
                } 
            }

            result.push(source);
        }
    }

    // Code block operations
    let mut calculated_result: Vec<String> = Vec::new();
    for matched_code_block_index in matched_code_block_indexes {
        let mut tmp_result: Vec<String> = Vec::new(); 
        let matched_line: String = article_data[matched_code_block_index].to_string();
        let tmp: Captures = re_code_block_operation.captures(&matched_line).unwrap();
        let lang: &str = tmp.name("lang").unwrap().as_str();
        let path: &str = tmp.name("path").unwrap().as_str();

        tmp_result.push(format!("```{}", lang));
        let file_path_and_code_block_number = path.split("+").collect::<Vec<&str>>();

        for i in file_path_and_code_block_number.iter().map(|x| x.replace(" ", "")) {
            let tmp: Vec<&str> = i.split(":").collect::<Vec<&str>>();
            let program_file_path: &str = tmp[0];
            let code_block_number: &str = tmp[1];

            let source_code_path: String = if is_relative_path {
                program_file_path.to_string()
            } else {
                format!("{}/{}", project_path, program_file_path)
            };

            let source_code_data: Vec<String> = read_lines(&source_code_path);
            let mut count: usize = 0;
            let mut comment_out_start_end: Vec<usize> = Vec::new();

            // Get the first and last indices of a comment-out
            for source_code_line in &source_code_data {
                if source_code_line == &format!("{} {}", language_comment_map.get(&lang).unwrap(), code_block_number) {
                    comment_out_start_end.push(count);
                } else if source_code_line == &format!("{} -{}", language_comment_map.get(&lang).unwrap(), code_block_number) {
                    comment_out_start_end.push(count);
                }
                count += 1;
            }

            if comment_out_start_end.len() > 0 {
                let source: String = source_code_data[(comment_out_start_end[0] + 1)..comment_out_start_end[1]].join("\n");
                tmp_result.push(source);
            }
        }
        tmp_result.push(String::from("```"));
        calculated_result.push(tmp_result.join("\n"));
    }

    // Delete the numbers in the code block and insert the corresponding source code
    for (code_block_start_index, source_code) in izip!(code_block_start_indexes, result) {
        article_data.remove(code_block_start_index + 1);
        article_data.insert(code_block_start_index + 1, source_code);
    }

    // Get an index to insert the playground URL
    let mut index: usize = 0;
    let mut indexes_to_add_url: Vec<usize> = Vec::new();
    let re_for_playground: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*):(?P<message>.*)").unwrap();
    for article_line in &article_data {
        if re_for_playground.is_match(article_line) {
            indexes_to_add_url.push(index);
        }
        index += 1;
    }

    // Get line index for source code operations
    let mut code_block_operations_indexes: Vec<usize> = Vec::new();
    let mut code_block_operation_count: usize = 0;
    let cloned_article = article_data.clone();
    for article_line in cloned_article {
        if re_code_block_operation.is_match(&article_line) {
            code_block_operations_indexes.push(code_block_operation_count);
        }
        code_block_operation_count += 1;
    }

    // Delete lines for source code operations and insert calculation results
    for (code_block_operations_index, source_code) in izip!(code_block_operations_indexes, calculated_result) {
        article_data.remove(code_block_operations_index);
        article_data.insert(code_block_operations_index, source_code);
    }

    // Insert the playground URL
    let mut index_adjustment: usize = 0;
    for (index_to_add_url, playground_url) in izip!(indexes_to_add_url, for_playground) {
        article_data.insert(index_to_add_url + index_adjustment , playground_url);
        index_adjustment += 1;
    }

    write(&article_path, article_data.join("\n"));
}
