use std::env;
use std::path::Path;

extern crate uuid;
use uuid::Uuid;

// 1
mod modules;
use crate::modules::initializer::{ Initializer, ArticleInitializer };
use crate::modules::file::{ write_only, get_base_file };
// -1

fn print_usage() {
    eprintln!(r"

    Name:

            aci - article continuous integration

    Usage: 

            aci <command> [options]

    Commands:
    
            init [title] [topics]
                            Initialize a new article.
    
            make <file name>
                            Print the path of the current article.

            show
                            Show all articles and title.

            help
                            Print this help message.

    Options:
    
            -p, --project
                            Create projects simultaneously

            -e, --empty
                            Create an empty base file

            -n, --name
                            Specify file name

    ")
}


fn main() {
    let mut args: Vec<String> = env::args().skip(1).collect();

    if args.is_empty() {
        print_usage();
        return;
    }

    let command: &str = &args[0];

    // Initialize the article base.
    if command == "init" {
        let file_name: String = if args.contains(&String::from("-n")) || args.contains(&String::from("--name")) {
            let name_option_index: usize = args
                .iter()
                .position(|r| r == &String::from("-n") || r == &String::from("--name"))
                .unwrap();
            let cloned_file_name: String = args[name_option_index + 1].clone();
            args.retain(|r| r != &String::from("-n") && r != &String::from("--name"));
            cloned_file_name
        } else {
            Uuid::new_v4().to_string()
        };

        let base_file_path = if Path::new("./articles/").exists() {
            format!("./articles/{}.txt", &file_name)
        } else {
            format!("{}.txt", &file_name)
        };

        args.push(String::from(""));
        let mut initializer: ArticleInitializer = ArticleInitializer{ ..Default::default() };

        // Create articles for zenn or otherwise
        if args.contains(&String::from("-e")) || args.contains(&String::from("--empty")) {
            write_only(&base_file_path);
        } else {
            if args.contains(&String::from("-p")) || args.contains(&String::from("--project")) {
                modules::initializer::mkdir(&file_name);
            }

            args.retain(|r| r != &String::from("-p") && r != &String::from("--project"));

            initializer.title = args[1].to_string();
            initializer.topics = (&args[2..]).to_vec();
            initializer.write(&base_file_path);
        }

    // Show txt files and titles directly under articles
    } else if command == "show" {
        get_base_file().unwrap().iter().for_each(|path| {
            let maybe_base_file_path: String = format!("{}", path.display());
            if maybe_base_file_path.ends_with(".txt") {
                let content: Vec<String> = modules::ci::read_lines(&maybe_base_file_path);
                if content.len() > 1 {
                    println!("{:<40} | {}", maybe_base_file_path.split('\\').last().unwrap(), content[1].replace("title:", ""));
                }
            }
        });

    // Show help message
    } else if command == "help" {
        print_usage();

    // Create an md file from a selected txt file
    } else if command == "make" {
        let file_name: &String = &args[1];
        if Path::new(&format!("./articles/{}.txt", file_name)).exists() {
            modules::ci::ci(file_name, false);
        } else {
            modules::ci::ci(file_name, true);
        }
    }
}
