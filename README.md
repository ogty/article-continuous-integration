# Article Continuous Integration

A useful CLI tool for managing article content integrated with a project.

## Usage

```
$ cargo build
```

The `/target/debug/aci.exe` created by the `cargo build` command should be placed directly under the folder where you maintain your Zenn articles.

```bash
$ aci <path>   # windows
$ ./aci <path> # macos and linux
```

***

**`xxxxx.txt`**

````txt:xxxxx.txt
```rust:src/main.rs
1
```
````

<div align="center">↓</div>

**`xxxxx/src/main.rs`**

```
// 1
fn main() {
  println!("Hello, world!");
}
// -1
```

<div align="center">↓</div>

**`xxxxx.md`**

````md:xxxxx.md
```rust:main.rs
fn main() {
  println!("Hello, world!");
}
```
````
