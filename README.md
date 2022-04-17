<h1 align="center">Article Continuous Integration</h1>

<p align="center">A useful CLI tool for managing article content integrated with a project.</p>
<br />

## Contents

- [Features](https://github.com/ogty/article-continuous-integration#features)
- [Suppoted Languages](https://github.com/ogty/article-continuous-integration#supported-file-formats)
- [Usage](https://github.com/ogty/article-continuous-integration#usage)
  - [Create base file](https://github.com/ogty/article-continuous-integration#create-base-file)
  - [Create article](https://github.com/ogty/article-continuous-integration#create-article)
  - [Display file name and title](https://github.com/ogty/article-continuous-integration#display-file-name-and-title)
- [Commands](https://github.com/ogty/article-continuous-integration#commands)
  - [Options](https://github.com/ogty/article-continuous-integration#options)
- [Example 1](https://github.com/ogty/article-continuous-integration#example-1)
- [Example 2](https://github.com/ogty/article-continuous-integration#example-2)
- [Adding playground URL(Rust only)](https://github.com/ogty/article-continuous-integration#adding-playground-urlrust-only)
- [Add code blocks together](https://github.com/ogty/article-continuous-integration#add-code-blocks-together)
- [When using Awk](https://github.com/ogty/article-continuous-integration#when-using-awk)

---

## Features

- [x] Create new articles and projects
- [x] Specifying files in code blocks
- [x] Add PlayGround URL to code block(Rust only)
- [x] Code Block Operation
- [x] Visualization of directories by tree structure
- [x] Create a table of contents from a heading
- [x] Expanding data in a file
- [ ] Preview base file

## Supported File Formats
- Awk
- Bash
- Bat
- C
- C#
- C++
- CSS
- Dart
- Go
- Haskell
- HTML
- Java
- JavaScript
- Julia
- Lisp
- Lua
- Makefile
- Nim
- Objective-C
- PHP
- PowerShell
- Python
- R
- Ruby
- Rust
- Scala
- ShellScript
- Swift
- TypeScript
- ...

````md
```cpp:main.cpp
#include <iostream>

using namespace std;

int main() {
  cout << "Hello, world!" << endl;
  return 0;
}
```
````

##### To add a language, you just need to rewrite the program a little.

## Usage

```
$ cargo build
```

The `/target/debug/aci.exe` created by the `cargo build` command should be placed directly under the folder where you maintain your Zenn articles.

### Create base file

```bash
$ aci init [title] [topics] [options]
```

If `-p` is specified for `[options]`, a folder with the same name as the file name will be created directly under `projects`.

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

```txt
---
title: This is the title
emoji: 🐒
type: tech
topics: [topic1, topic2]
published: false
---
```

If you don't specify any options, only `articles/<uuid>.txt` will be created. The reason it is a `.txt` file is to prevent it from being recognized as an article and to allow updates to the content; Github gives priority to the `README.md` file over the `README.txt` file.

### Create article

If you run the following command with or without a project, it will create a `<uuid>.md` file. Copying the file name is a pain, but...

```bash
$ aci make <uuid>
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
```

It is also possible to run the command to create a new article with just `init` or just `title`.

```bash
$ aci init "This is the title"
```

### Display file name and title

To display the file name and title, execute the following command.

```bash
$ aci show
```

## Commands

    aci <command> [options]

It is not necessary to include the extension in the commands or options.

- `init [title] [topics] [options]` : Create a base file
- `make <file name>` : Create articles (`.md`)
- `show` : Show the file name and title directly under articles
- `help` : Show help message

##### If there is no `<file name>.txt` directly under articles, it will be considered as a relative path.

### Options

- `-p, --project` : Create projects at the same time
- `-e, --empty` : Create an empty base file
- `-n, --name <file name>` : Specify any file name

## Example 1

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

Folder structure ↓

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

Add a comment to `main.rs`. The `1` part of this comment can be anything, as long as it is the same as in the code block.

```rust
// 1
fn main() {
    println!("Hello, world!");
}
// -1
```

Add a code snippet to `articles/<uuid>.txt` with the number of the code range you want to display in `main.rs`.

````txt
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

````md
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

## Example 2

Case where source code in the project is used in README

Folder structure ↓

```
└─aci.exe
```

Create the base file, but it is faster to use the `touch` command for this.

```bash
$ aci init -e -n README
$ # touch README.txt
```

If you want to place `aci.exe` on the desktop or some other location for use in other projects, you can solve this by entering a relative path in the `--name` option. In this case, the path specified in the code block in the base file must also be relative to `aci.exe`.

```bash
$ aci init -e -n ./<folder name>/README
```

Folder structure ↓

```
├─README.txt
└─aci.exe
```

Create a Python program to display "Hello, world!" and comment it.

**`main.py`**

```python
# 1
print("Hello, world!")
# -1
```

**`README.txt`**

````txt
```python:./main.py
1
```
````

Folder structure ↓

```
├─main.py
├─README.txt
└─aci.exe
```

Create an article.

```bash
$ aci README
```

**`README.md`**

````md
```python:./main.py
print("Hello, world!")
```
````

Folder structure ↓

```
├─main.py
├─README.md
├─README.txt
└─aci.exe
```

## Adding playground URL(Rust only)

You can add a Playground URL, which is only available in Rust.

````txt
```rust:src/main.rs:sample code
1
```
````

You can add the Playground URL of the program in the code block by using `<language>:<path>:<string for link>` as above.

````md
[sample code](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=fn%20main%28%29%20%7B%0A%20%20%20%20println%21%28%22Hello%2C%20world%21%22%29%3B%0A%7D)

```rust:src/main.rs:sample code
fn main() {
    println!("Hello, world!");
}
```
````

## Add code blocks together

It is possible to combine specific comment-out ranges of files together.

**`src/main.rs`**

```rust
// 1
fn main() {
   hello();
}
// -1
```

**`src/hello.rs`**

```rust
// 1
fn hello() {
   println!("Hello, world!");
}
// -1
```

To combine the comment-out ranges of the two files above, write the following

**`*.txt`**

````txt
```rust```src/main.rs:1 + src/hello.rs:1
````

The codes are merged together in the order in which they are written, starting from the top.

**`*.md`**

````md
```rust
fn main() {
   hello();
}
fn hello() {
   println!("Hello, world!");
}
```
````

## When using Awk

Running the `awk` command produces the same results as using the `aci` command.

```bash
$ awk -f ./main.awk README.txt > README.md
```

````txt
```<language>:<path>:<start>:<end>:[url string]```
````

If you want to refer to the source code from a code block, do as above.

**`README.txt`**

````txt
Code block for awk command ↓

```rust:./main.rs:start:end```

Add the playground URL ↓

```rust:./main.rs:start:end:sample```

Code block for aci command ↓

```rust:./main.rs
1
```

General code block ↓

```rust
fn main() {
    println!("Hello, world!");
}
```

Code block operation for awk commands ↓

```rust|main.rs:start:end hello.rs:start:end```
````

**`main.rs`**

```rust
// start
fn main() {
    println!("Hello, world!");
}
// end
```

**`hello.rs`**

```rust
// start
fn main() {
    println!("Hello, Rust!");
}
// end
```

The paths in the code blocks in the base file are relative to the base file.

**`README.md`**

````md
Code block for awk commands ↓

```rust:./main.rs
fn main() {
    println!("Hello, world!");
}
```

Add the playground URL ↓

```rust
fn main() {
    println!("Hello, world!");
}
```

[sample](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=fn%20main%28%29%20%7B%0A%20%20%20%20println%21%28%22Hello%2C%20world%21%22%29%3B%0A%7D)

Code block for aci command ↓

```rust:./main.rs
1
```

General code block ↓

```rust
fn main() {
    println!("Hello, world!");
}
```

Code block operation for awk commands ↓

```rust
fn main() {
    println!("Hello, world!");
}

fn main() {
    println!("Hello, Rust!");
}
```
````
