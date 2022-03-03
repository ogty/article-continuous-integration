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
        "<!--",
        "/*",
    ];
    
    let language_comment_map: HashMap<_, _> = languages.iter().zip(single_line_comment_out_prefix.iter()).collect();
    let result = language_comment_map.get(&language.as_str()).unwrap();
    return result.to_string()
}
