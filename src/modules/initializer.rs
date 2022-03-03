use std::fs::File;
use std::io::prelude::*;
use std::path::{ Path, Display };


pub fn mkdir(id: &str) {
    let _ = std::fs::create_dir(format!("./projects/{}", &id));
}


pub trait Initializer {
    fn write(&mut self, path: &str);
}


pub struct ArticleInitializer {
    pub title: String,
    pub topics: Vec<String>,
}


impl Default for ArticleInitializer {
    fn default() -> ArticleInitializer {
        ArticleInitializer {
            title: String::new(),
            topics: Vec::new(),
        }
    }
}


impl Initializer for ArticleInitializer {
    fn write(&mut self, path: &str) {
        let path: &Path = Path::new(&path);
        let for_display: Display = path.display();
        let mut template: String = String::from("---\ntitle: <title>\nemoji: 🐒\ntype: tech\ntopics: [<topics><last>]\npublished: false\n---");

        if !self.title.is_empty() {
            let topics_length: usize = self.topics.len();
            if topics_length > 0 {
                if topics_length > 2 {
                    let before_last: usize = topics_length - 1;
                    template = template
                        .replace("<title>", &self.title)
                        .replace("<topics>", &self.topics[..before_last].join(", "))
                        .replace("<last>", &self.topics[before_last]);

                } else {
                    template = template
                        .replace("<title>", &self.title)
                        .replace("<topics>", &self.topics[0])
                        .replace("<last>", "");
                }
            } else {
                template = template
                    .replace("<title>", &self.title)
                    .replace("<topics>", "")
                    .replace("<last>", "");
            }
        } else {
            template = template
                .replace("<title>", "")
                .replace("<topics>", "")
                .replace("<last>", "");
        }

        let mut file: File = match File::create(&path) {
            Err(why) => panic!("couldn't create {}: {}", for_display, why),
            Ok(file) => file,
        };

        if let Err(why) = file.write_all(template.as_bytes()) { panic!("couldn't write to {}: {}", for_display, why) }
    }
}
