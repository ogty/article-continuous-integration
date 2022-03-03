use std::collections::HashMap;


pub fn comment_out(language: &String) -> String {
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
        "html",
        "css",
    ];
    
    let single_line_comment_out_prefixes: Vec<&str> = vec![
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
        "<!--",
        "/*",
    ];
    
    let languages_comment_out: HashMap<_, _> = languages.iter().zip(single_line_comment_out_prefixes.iter()).collect();
    let result = languages_comment_out.get(&language.as_str()).unwrap();
    return result.to_string()
}
