[sample code](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=mod%20modules%3B%0Ause%20crate%3A%3Amodules%3A%3Ainitializer%3A%3A%7B%20Initializer%2C%20ArticleInitializer%20%7D%3B%0Ause%20crate%3A%3Amodules%3A%3Afile%3A%3A%7B%20write_only%2C%20get_base_file%20%7D%3B)

```rust:./src/main.rs:sample code
mod modules;
use crate::modules::initializer::{ Initializer, ArticleInitializer };
use crate::modules::file::{ write_only, get_base_file };
```