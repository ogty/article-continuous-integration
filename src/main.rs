use std::env;

extern crate uuid;
use uuid::Uuid;

mod modules;
use crate::modules::initializer::{ Initializer, ArticleInitializer };


fn main() {
    let mut args: Vec<String> = env::args().collect();

    if args[1] == "init" {
        let id: Uuid = Uuid::new_v4();
        let article_script_path: String = format!("./articles/{}.txt", &id);
        args.push(String::from(""));
    
        let mut initializer: ArticleInitializer = ArticleInitializer{ ..Default::default() };
        
        if args.contains(&String::from("-p")) {
            initializer.title = args[3].to_string();
            initializer.topics = (&args[4..]).to_vec();
            initializer.write(&article_script_path);
            modules::initializer::mkdir(&id.to_string());
        } else {
            initializer.title = args[2].to_string();
            initializer.topics = (&args[3..]).to_vec();
            initializer.write(&article_script_path);
        }

    } else {
        modules::ci::tmpci(&args[1]);
    }
}
