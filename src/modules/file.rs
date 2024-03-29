use std::error::Error;
use std::fs::{read_dir, File, ReadDir};
use std::io::{self, prelude::*, BufReader, Lines};
use std::path::{Display, Path, PathBuf};

pub fn write(path: &str, content: String) {
    let path: &Path = Path::new(&path);
    let for_display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", for_display, why),
        Ok(file) => file,
    };

    if let Err(why) = file.write_all(content.as_bytes()) {
        panic!("couldn't write to {}: {}", for_display, why)
    }
}

pub fn read_lines(path: &str) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let file_content: File = File::open(path).unwrap();
    let line_contents: Lines<BufReader<File>> = io::BufReader::new(file_content).lines();
    for line_content in line_contents {
        result.push(line_content.unwrap());
    }
    result
}

pub fn write_only(path: &str) {
    let path: &Path = Path::new(&path);
    let for_display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", for_display, why),
        Ok(file) => file,
    };

    if let Err(why) = file.write_all("".as_bytes()) {
        panic!("couldn't write to {}: {}", for_display, why)
    }
}

pub fn get_base_file() -> Result<Vec<PathBuf>, Box<dyn Error>> {
    let directory_items: ReadDir = read_dir("./articles")?;
    let mut base_files: Vec<PathBuf> = Vec::new();
    for item in directory_items {
        base_files.push(item?.path());
    }
    Ok(base_files)
}
