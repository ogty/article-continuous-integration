use std::fs::File;
use std::io::{prelude::*, self, Lines, BufReader};
use std::path::{Path, Display};
use std::collections::HashMap;

extern crate regex;
use regex::Regex;
extern crate urlencoding;
use urlencoding::encode;
extern crate itertools;
use itertools::izip;


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


fn read_lines(path: &str) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let file: File = File::open(path).unwrap();
    let tmp: Lines<BufReader<File>> = io::BufReader::new(file).lines();
    for line in tmp {
        result.push(line.unwrap());
    }
    return result;
}


//
//
// TODO: Change the variable name
//
//

pub fn tmpci(path: &str) {
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
    let article_script_path: &String = &format!("./articles/{}.txt", path);
    let article_path: &String = &format!("./articles/{}.md", path);
    let project_path: String = format!("./projects/{}", path);
    
    let re_code_snippet: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*)").unwrap();
    let xxx: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*):(?P<message>.*)").unwrap();
    let mut article_line_count: usize = 0;

    let mut article_data: Vec<String> = read_lines(&article_script_path);

    let mut matched_indexes = Vec::new();
    for article_line in &article_data {
        if re_code_snippet.is_match(article_line) {
            matched_indexes.push(article_line_count);
        }
        article_line_count += 1;
    }

    let a = matched_indexes.clone();
    
    let mut result = Vec::new();
    let mut for_playground = Vec::new();

    for matched_index in matched_indexes {
        let tmp = article_data[matched_index].to_string();

        let splited_tmp: Vec<&str> = tmp.split(":").collect();
        let lang = splited_tmp[0].replace("```", "");
        let comment_out_prefix = language_comment_map.get(&lang.as_str()).unwrap();

        if splited_tmp.len() == 3 {
            let source_code_path: String = format!("{}/{}", project_path, splited_tmp[1]);
            let source_code_data: Vec<String> = read_lines(&source_code_path);
            let code_block_number = &article_data[matched_index + 1];
            let mut count: usize = 0;
            let mut tmp = Vec::new();
            for source_code_line in &source_code_data {
                if source_code_line == &format!("{} {}", comment_out_prefix, code_block_number) {
                    tmp.push(count);
                } else if source_code_line == &format!("{} -{}", comment_out_prefix, code_block_number) {
                    tmp.push(count);
                }
                count += 1;
            }
            let source = source_code_data[(tmp[0] + 1)..tmp[1]].join("\n");
            let cloned_source = source.clone();
            
            if lang == "rust" {
                for_playground.push(format!("[{}](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code={})\n", splited_tmp[2], encode(&cloned_source)));
            } 

            result.push(source);
        } else {
            let source_code_path: String = format!("{}/{}", project_path, splited_tmp[1]);
            let source_code_data: Vec<String> = read_lines(&source_code_path);
            let code_block_number = &article_data[matched_index + 1];
            let mut count: usize = 0;
            let mut tmp = Vec::new();
            for source_code_line in &source_code_data {
                if source_code_line == &format!("{} {}", comment_out_prefix, code_block_number) {
                    tmp.push(count);
                } else if source_code_line == &format!("{} -{}", comment_out_prefix, code_block_number) {
                    tmp.push(count);
                }
                count += 1;
            }
            let source = source_code_data[(tmp[0] + 1)..tmp[1]].join("\n");
            result.push(source);
        }
    }

    for (j, k) in izip!(a, result) {
        article_data.remove(j + 1);
        article_data.insert(j + 1, k);
    }

    let mut zzz = 0;
    let mut yyy = Vec::new();
    for article_line in &article_data {
        if xxx.is_match(article_line) {
            yyy.push(zzz);
        }
        zzz += 1;
    }

    let mut t = 0;
    for (j, k) in izip!(yyy, for_playground) {
        article_data.insert(j + t , k);
        t += 1;
    }
    write(&article_path, article_data.join("\n"));
}
