use std::env;
use std::error::Error;
use std::fs::{ File, ReadDir, read_dir };
use std::io::prelude::*;
use std::path::{ Path, Display, PathBuf };

extern crate uuid;
use uuid::Uuid;

mod modules;
use crate::modules::initializer::{ Initializer, ArticleInitializer };


// TODO: I don't like something about it.
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


// TODO: I don't like something about it.
fn get_article_base_files() -> Result<Vec<PathBuf>, Box<dyn Error>> {
    let dir: ReadDir = read_dir("./articles")?;
    let mut files: Vec<PathBuf> = Vec::new();
    for item in dir.into_iter() {
        files.push(item?.path());
    }
    Ok(files)
}


// TODO: I don't know how to write command descriptions.
fn print_usage() {
    eprintln!(r"
    Name:

            aci - article continuous integration

    Usage: 

            aci <command> [options]

    Commands:
    
            init
                Initialize a new article.
    
            show
                Show all articles and title.

            path
                Print the path of the current article.

            help
                Print this help message.

    Options:
    
            -p, --project
                xxxxxxxxxx

            -e, --empty
                xxxxxxxxxx

            -n, --name
                xxxxxxxxxx

    ")
}


fn main() {
    let mut args: Vec<String> = env::args().collect();

    if args.len() == 1 {
        print_usage();
        std::process::exit(1);
    }

    // Initialize the article base.
    if args[1] == "init" {
        let mut article_script_path: String = String::new();
        let mut id: String = String::new();

        // Specify the name of the txt file
        if args.contains(&String::from("-n")) || args.contains(&String::from("--name")) {
            let tmp: usize = args
                .iter()
                .position(|r| r == &String::from("-n") || r == &String::from("--name"))
                .unwrap();

            id = args[tmp + 1].clone();
            article_script_path = format!("{}.txt", &id);
        } else {
            id = Uuid::new_v4().to_string();
            if Path::new("./articles/").exists() {
                article_script_path = format!("./articles/{}.txt", &id);
            } else {
                article_script_path = format!("{}.txt", &id);
            }
        }

        args.push(String::from(""));
        let mut initializer: ArticleInitializer = ArticleInitializer{ ..Default::default() };

        // Create articles for zenn or otherwise
        if args.contains(&String::from("-e")) || args.contains(&String::from("--empty")) {
            write_only(&article_script_path);
        } else {
            if args.contains(&String::from("-p")) || args.contains(&String::from("--project")) {
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

    // Show txt files and titles directly under articles
    } else if args[1] == "show" {
        get_article_base_files().unwrap().iter().for_each(|path| {
            let tmp: String = format!("{}", path.display());
            if tmp.ends_with(".txt") {
                let content: Vec<String> = modules::ci::read_lines(&tmp);
                if content.len() > 1 {
                    println!("{} | {}", path.display(), content[1]);
                }
            }
        });

    // Show help message
    } else if args[1] == "help" {
        print_usage();

    // Create an md file from a selected txt file
    } else {
        if Path::new(&format!("./articles/{}.txt", &args[1])).exists() {
            modules::ci::ci(&args[1], false);
        } else {
            modules::ci::ci(&args[1], true);
        }
    }
}
