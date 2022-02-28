use std::env;
use std::fs::File;
use std::io::prelude::*;
use std::path::{Path, Display};

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

fn main() {
    let mut args: Vec<String> = env::args().collect();

    if args[1] == "init" {
        let mut article_script_path = String::new();
        let mut id = String::new();

        if args.contains(&String::from("--name")) {
            let tmp = args.iter().position(|r| r == &String::from("--name")).unwrap();
            id = args[tmp + 1].clone();
            article_script_path = format!("./articles/{}.txt", &id);
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


    } else {
        modules::ci::tmpci(&args[1]);
    }
}
