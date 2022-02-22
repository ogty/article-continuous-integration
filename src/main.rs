use std::env;

use regex::Regex;

mod modules;

fn main() {
    let args: Vec<String> = env::args().collect();
    let path: &str = &args[1];

    let article_path: &String = &format!("./articles/{}.md", path);
    let project_path: String = format!("./projects/{}", path);
    
    let re_code_snippet: Regex = Regex::new(r"```(?P<lang>\w+):(?P<path>.*)").unwrap();
    let re_number: Regex = Regex::new(r"^\d+$").unwrap();
    let mut article_line_count: usize = 0;
    let mut result: Vec<String> = Vec::new();

    let article_data: Vec<String> = modules::file::read_lines(&article_path);
    for line in &article_data {
        if re_number.is_match(line) {
            article_line_count += 1;
            continue;
        }

        result.push(line.clone());
        if let Some(captures) = re_code_snippet.captures(&line) {
            let path: &str = captures.name("path").unwrap().as_str();
            // let lang: &str = captures.name("lang").unwrap().as_str();
            let source_code_number: &String = &article_data[article_line_count + 1];
            let source_code_path: String = format!("{}/{}", project_path, path);
            let source_data: Vec<String> = modules::file::read_lines(&source_code_path);

            let mut source_code_count: usize = 0;
            for line in &source_data {
                if line == &format!("// {}", source_code_number) {
                    source_code_count += 1;
                    for mached_line in &source_data[source_code_count..] {
                        if mached_line == &format!("// -{}", source_code_number) {
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
    modules::file::write(&article_path, result.join("\n"));
}
