use std::error::Error;
use std::fs::{ File, ReadDir, read_dir };
use std::io::{ prelude::*, self, Lines, BufReader };
use std::path::{ Path, PathBuf, Display };


pub fn write(path: &str, content: String) {
    let path: &Path = Path::new(&path);
    let for_display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", for_display, why),
        Ok(file) => file,
    };

    match file.write_all(content.as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", for_display, why),
        Ok(_) => (),
    }
}


pub fn read_lines(path: &str) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let file_content: File = File::open(path).unwrap();
    let line_contents: Lines<BufReader<File>> = io::BufReader::new(file_content).lines();
    for line_content in line_contents {
        result.push(line_content.unwrap());
    }
    return result;
}


pub fn write_only(path: &str) {
    let path: &Path = Path::new(&path);
    let for_display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", for_display, why),
        Ok(file) => file,
    };

    match file.write_all("".as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", for_display, why),
        Ok(_) => (),
    }
}


pub fn get_base_file() -> Result<Vec<PathBuf>, Box<dyn Error>> {
    let directory_items: ReadDir = read_dir("./articles")?;
    let mut base_files: Vec<PathBuf> = Vec::new();
    for item in directory_items.into_iter() {
        base_files.push(item?.path());
    }
    Ok(base_files)
}
