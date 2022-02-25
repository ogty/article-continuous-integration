use std::fs::File;
use std::io::{prelude::*, self};
use std::path::{Path, Display};
use std::collections::HashMap;

extern crate regex;
use regex::Regex;


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
    let tmp = io::BufReader::new(file).lines();
    for line in tmp {
        result.push(line.unwrap());
    }
    return result;
}


pub fn ci(path: &str) {
    let languages = vec![
        "python", 
        "julia",
        "rust",
        "c",
        "cpp",
        "java",
        "javascript",
        "typeScript",
        "go",
        "swift",
        "php",
        "cs",
        "scala",
        "haskell",
        "lua",
    ];

    let single_line_comment_out_prefix = vec![
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
    let re_number: Regex = Regex::new(r"^\d+$").unwrap();
    let mut article_line_count: usize = 0;
    let mut result: Vec<String> = Vec::new();

    let article_data: Vec<String> = read_lines(&article_script_path);
    for line in &article_data {
        if re_number.is_match(line) {
            article_line_count += 1;
            continue;
        }

        result.push(line.clone());
        if let Some(captures) = re_code_snippet.captures(&line) {
            let path: &str = captures.name("path").unwrap().as_str();
            let lang: &str = captures.name("lang").unwrap().as_str();
            let source_code_number: &String = &article_data[article_line_count + 1];
            let source_code_path: String = format!("{}/{}", project_path, path);
            let source_data: Vec<String> = read_lines(&source_code_path);

            let mut source_code_count: usize = 0;
            for line in &source_data {
                if line == &format!("{} {}", language_comment_map[&lang], source_code_number) {
                    source_code_count += 1;
                    for mached_line in &source_data[source_code_count..] {
                        if mached_line == &format!("{} -{}", language_comment_map[&lang], source_code_number) {
                            break
                        }
                        result.push(mached_line.clone());
                    }
                }
                source_code_count += 1;
            }
        }
        article_line_count += 1;
    }
    write(&article_path, result.join("\n"));
}
