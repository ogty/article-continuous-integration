use std::env;
use std::fs::{File, ReadDir};
use std::io::prelude::*;
use std::path::{Path, Display};
use std::path;
use std::error::Error;
use std::fs;

extern crate uuid;
use uuid::Uuid;

mod modules;
use crate::modules::initializer::{ Initializer, ArticleInitializer };


fn write_only(path: &str) {
    let path: &Path = Path::new(&path);
    let display: Display = path.display();

    let mut file: File = match File::create(&path) {
        Err(why) => panic!("couldn't create {}: {}", display, why),
        Ok(file) => file,
    };

    match file.write_all("".as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", display, why),
        Ok(_) => (),
    }
}


// 1
fn read_dir() -> Result<Vec<path::PathBuf>, Box<dyn Error>> {
    let dir: ReadDir = fs::read_dir("./articles")?;
    let mut files: Vec<path::PathBuf> = Vec::new();
    for item in dir.into_iter() {
        files.push(item?.path());
    }
    Ok(files)
}
// -1


fn main() {
    let mut args: Vec<String> = env::args().collect();

    if args[1] == "init" {
        let mut article_script_path: String = String::new();
        let mut id: String = String::new();

        if args.contains(&String::from("--name")) {
            let tmp: usize = args.iter().position(|r| r == &String::from("--name")).unwrap();
            id = args[tmp + 1].clone();
            article_script_path = format!("{}.txt", &id);
        } else {
            id = Uuid::new_v4().to_string();
            article_script_path = format!("./articles/{}.txt", &id);
        }

        args.push(String::from(""));
        let mut initializer: ArticleInitializer = ArticleInitializer{ ..Default::default() };

        if args.contains(&String::from("-n")) {
            write_only(&article_script_path);
        } else {
            if args.contains(&String::from("-p")) {
                initializer.title = args[3].to_string();
                initializer.topics = (&args[4..]).to_vec();
                initializer.write(&article_script_path);
                modules::initializer::mkdir(&id);
            } else {
                initializer.title = args[2].to_string();
                initializer.topics = (&args[3..]).to_vec();
                initializer.write(&article_script_path);
            }
        }
    } else if args[1] == "show" {
        read_dir().unwrap().iter().for_each(|path| {
            let tmp: String = format!("{}", path.display());
            if tmp.ends_with(".txt") {
                let content: Vec<String> = modules::ci::read_lines(&tmp);
                if content.len() > 1 {
                    println!("{} | {}", path.display(), content[1]);
                }
            }
        });
    } else {
        if Path::new(&format!("./articles/{}.txt", &args[1])).exists() {
            modules::ci::ci(&args[1], false);
        } else {
            modules::ci::ci(&args[1], true);
        }
    }
}
