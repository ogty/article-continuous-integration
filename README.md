# Article Continuous Integration

A useful CLI tool for managing article content integrated with a project.

We want to provide a sense of unity as content that users can get by managing it as a project, rather than just a function that allows file specification in a simple code block.
If you want to publish a folder or repository where you are managing articles, it is a fact that there is more for users to get if it exists as a single file included in a project, rather than just one file to refer to. I want to provide that.

## Feature

- [x] Create new articles and projects
- [x] Specifying files in code blocks
- [ ] Add PlayGround URL to code block

## Usage

```
$ cargo build
```

The `/target/debug/aci.exe` created by the `cargo build` command should be placed directly under the folder where you maintain your Zenn articles.

```bash
$ aci init [option] <title> <topics>
```

If `-p` is specified for `[option]`, a folder with the same name as the file name will be created directly under `projects`.

```bash
$ aci init -p "This is the title" Topic1 Topic2
```

For example, the above command will create `articles/<uuid>.txt` and `projects/<uuid>`.

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
```

```txt:<uuid>.txt
---
title: This is the title
emoji: 🐒
type: tech
topics: [topic1, topic2]
published: false
---
```

If you remove the `-p` option

If you remove the option (`-p`), only `articles/<uuid>.txt` will be created.
The reason it is a `.txt` file is to prevent it from being recognized as an article.

If you run the following command with or without a project, it will create a `<uuid>.md` file. Copying the file name is a pain, but...

```bash
$ aci <path>
```

```
├─images
├─books
├─articles
│  ├─<uuid>.txt
│  └─<uuid>.md
└─projects
   └─<uuid>
```

```md:<uuid>.md
---
title: This is the title
emoji: 🐒
type: tech
topics: [topic1, topic2]
published: false
---
````

It is also possible to run the command to create a new article with just `init` or just `title`.

```bash
$ aci init This is the title
```

## Languages supported

- Python
- Julia
- Rust
- C
- C++(cpp)
- C#(cs)
- Java
- Javascript
- TypeScript
- Go
- Swift
- PHP
- Scala
- Haskell
- Lua

The `()` is the language of the snippet, all in lowercase.

````md
```cpp:main.cpp
#include <iostream>

using namespace std;

int main(){
  cout << "Hello world." << endl;
  return 0;
}
```
````

## Example

Let's say you want to write an article called "Hello, world in Rust!"

```bash
$ aci init -p "Hello, world! in Rust"
```

The folder structure when the above command is executed is as follows.

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
```

Go to `projects/<uuid>` and run the following.

```bash
$ cd projects/<uuid>
$ cargo init --name project
```

Folder structure so far ↓

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
      ├─src
      │  └─main.rs
      └─Cargo.toml
```

Add a comment to `main.rs`.

```rust:src/main.rs
// 1
fn main() {
    println!("Hello, world!");
}
// -1
```

Add a code snippet to `articles/<uuid>.txt` with the number of the code range you want to display in `main.rs`.

````txt:articles/<uuid>.txt
---
title: Hello, world! in Rust
emoji: 🐒
type: tech
topic: [Rust]
published: false
---

```rust:src/main.rs
1
```
````

Execute the following command.

```bash
$ aci <uuid>
```

Then `articles/<uuid>.md` will be created, and it will have the following contents.

````md:<uuid>.md
---
title: Hello, world! in Rust
emoji: 🐒
type: tech
topic: [Rust]
published: false
---

```rust:src/main.rs
fn main() {
    println!("Hello, world!");
}
```
````

Now you can push to Github and deploy the article by setting `published: true`.
