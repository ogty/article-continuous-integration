extern crate itertools;
use itertools::izip;
extern crate regex;
use regex::{ Regex, Captures };
extern crate urlencoding;
use urlencoding::encode;

pub use crate::modules::comment::comment_out;
pub use crate::modules::file::{ write, read_lines };


pub fn ci(path: &str, is_relative_path: bool) {
    let mut article_script_path: String = format!("{}.txt", path);
    let mut article_path: String = format!("{}.md", path);
    let mut project_path: String = String::new();

    if !is_relative_path {
        article_script_path = format!("./articles/{}", article_script_path);
        article_path = format!("./articles/{}", article_path);
        project_path = format!("./projects/{}", path);
    }

    // Getting the regular expression and matching index of a code block
    let re_code_snippet: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*)").unwrap();
    let re_code_block_operation: Regex = Regex::new(r"```(?P<lang>\w+)```(?P<path>.*)").unwrap();
    let mut article_data: Vec<String> = read_lines(&article_script_path);
    let mut matched_indexes: Vec<usize> = Vec::new();
    let mut matched_code_block_indexes: Vec<usize> = Vec::new();

    for (article_line_count, article_line) in article_data.iter().enumerate() {
        if re_code_snippet.is_match(article_line) {
            matched_indexes.push(article_line_count);
        } else if re_code_block_operation.is_match(article_line) {
            matched_code_block_indexes.push(article_line_count);
        }
    }

    let code_block_start_indexes: Vec<usize> = matched_indexes.clone();

    let mut result: Vec<String> = Vec::new();
    let mut for_playground: Vec<String> = Vec::new();

    // Get the source code of the file specified by the code block.
    for matched_index in matched_indexes {
        let code_block_start_line: String = article_data[matched_index].to_string();

        let splited_code_block_start_line: Vec<&str> = code_block_start_line.split(':').collect();
        let lang: String = splited_code_block_start_line[0].replace("```", "");
        let comment_out_prefix: String = comment_out(&lang);

        let source_code_path: String = if is_relative_path {
            splited_code_block_start_line[1].to_string()
        } else {
            format!("{}/{}", project_path, splited_code_block_start_line[1])
        };

        let source_code_data: Vec<String> = read_lines(&source_code_path);
        let code_block_number: &String = &article_data[matched_index + 1];
        let mut comment_out_start_end: Vec<usize> = Vec::new();

        // Get the first and last indices of a comment-out
        for (count, source_code_line) in source_code_data.iter().enumerate() {
            if source_code_line == &format!("{} {}", comment_out_prefix, code_block_number) {
                comment_out_start_end.push(count);
            } else if source_code_line == &format!("{} -{}", comment_out_prefix, code_block_number) {
                comment_out_start_end.push(count);
            }
        }

        if !comment_out_start_end.is_empty() {
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
        let mut source_code_for_calculate: Vec<String> = Vec::new(); 
        let matched_line: String = article_data[matched_code_block_index].to_string();
        let matched: Captures = re_code_block_operation.captures(&matched_line).unwrap();
        let lang: &str = matched.name("lang").unwrap().as_str();
        let path: &str = matched.name("path").unwrap().as_str();

        source_code_for_calculate.push(format!("```{}", lang));
        let file_path_and_code_block_number: Vec<&str> = path.split('+').collect::<Vec<&str>>();

        for unit in file_path_and_code_block_number.iter().map(|x| x.replace(' ', "")) {
            let splited_unit: Vec<&str> = unit.split(':').collect::<Vec<&str>>();
            let program_file_path: &str = splited_unit[0];
            let code_block_number: &str = splited_unit[1];

            let source_code_path: String = if is_relative_path {
                program_file_path.to_string()
            } else {
                format!("{}/{}", project_path, program_file_path)
            };

            let source_code_data: Vec<String> = read_lines(&source_code_path);
            let mut comment_out_start_end: Vec<usize> = Vec::new();

            // Get the first and last indices of a comment-out
            for (count, source_code_line) in source_code_data.iter().enumerate() {
                if source_code_line == &format!("{} {}", comment_out(&String::from(lang)), code_block_number) {
                    comment_out_start_end.push(count);
                } else if source_code_line == &format!("{} -{}", comment_out(&String::from(lang)), code_block_number) {
                    comment_out_start_end.push(count);
                }
            }

            if !comment_out_start_end.is_empty() {
                let source: String = source_code_data[(comment_out_start_end[0] + 1)..comment_out_start_end[1]].join("\n");
                source_code_for_calculate.push(source);
            }
        }
        source_code_for_calculate.push(String::from("```"));
        calculated_result.push(source_code_for_calculate.join("\n"));
    }

    // Delete the numbers in the code block and insert the corresponding source code
    for (code_block_start_index, source_code) in izip!(code_block_start_indexes, result) {
        article_data.remove(code_block_start_index + 1);
        article_data.insert(code_block_start_index + 1, source_code);
    }

    // Get an index to insert the playground URL
    let mut indexes_to_add_url: Vec<usize> = Vec::new();
    let re_for_playground: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*):(?P<message>.*)").unwrap();
    for (index, article_line) in article_data.iter().enumerate() {
        if re_for_playground.is_match(article_line) {
            indexes_to_add_url.push(index);
        }
    }

    // Get line index for source code operations
    let mut code_block_operations_indexes: Vec<usize> = Vec::new();
    let cloned_article = article_data.clone();
    for (code_block_operation_count, article_line) in cloned_article.into_iter().enumerate() {
        if re_code_block_operation.is_match(&article_line) {
            code_block_operations_indexes.push(code_block_operation_count);
        }
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
