<h1 align="center">Continuous Article Integration</h1>

## 目次

- [機能](https://github.com/ogty/continuous-article-integration#%E4%BD%BF%E3%81%84%E6%96%B9)
- [対応言語](https://github.com/ogty/continuous-article-integration#%E5%AF%BE%E5%BF%9C%E8%A8%80%E8%AA%9E)
- [使い方](https://github.com/ogty/continuous-article-integration#%E4%BD%BF%E3%81%84%E6%96%B9)
  - [ベースファイルの作成](https://github.com/ogty/continuous-article-integration/blob/main/README.md#%E3%83%99%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90)  
  - [記事の作成](https://github.com/ogty/continuous-article-integration/blob/main/README.md#%E8%A8%98%E4%BA%8B%E3%81%AE%E4%BD%9C%E6%88%90)
  - [ファイル名とタイトルを表示させる](https://github.com/ogty/continuous-article-integration/blob/main/README.md#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D%E3%81%A8%E3%82%BF%E3%82%A4%E3%83%88%E3%83%AB%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%95%E3%81%9B%E3%82%8B)
- [コマンド一覧](https://github.com/ogty/continuous-article-integration/blob/main/README.md#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E4%B8%80%E8%A6%A7)
  - [オプション](https://github.com/ogty/continuous-article-integration/blob/main/README.md#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
- [例1](https://github.com/ogty/continuous-article-integration#%E4%BE%8B1)
- [例2](https://github.com/ogty/continuous-article-integration#%E4%BE%8B2)
- [Playground URL を追記する](https://github.com/ogty/continuous-article-integration#playground-url-%E3%82%92%E8%BF%BD%E8%A8%98%E3%81%99%E3%82%8Brust-%E3%81%AE%E3%81%BF)
- [コードブロック同士を足し算する](https://github.com/ogty/continuous-article-integration#%E3%82%B3%E3%83%BC%E3%83%89%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E5%90%8C%E5%A3%AB%E3%82%92%E8%B6%B3%E3%81%97%E7%AE%97%E3%81%99%E3%82%8B)

---

## 機能

- [x] 新しい記事とプロジェクトの作成
- [x] コードブロックでのファイル指定
- [x] Playground URL 追加(Rust のみ)
- [x] コードブロック演算

## 対応言語

- C
- C#(cs)
- C++(cpp)
- Go
- Haskell
- Java
- Javascript
- Julia
- Lua
- PHP
- Python
- Rust
- Scala
- Swift
- TypeScript

````md
```cpp:main.cpp
#include <iostream>

using namespace std;

int main(){
  cout << "Hello, world!" << endl;
  return 0;
}
```
````

##### 言語を追加する場合は、言語とそれに対応するコメントアウトの形式を配列に追加するだけです。

## 使い方

```
$ cargo build
```

`Cargo build` コマンドで作成した `/target/debug/cai.exe` は、記事を管理しているフォルダの直下に置いてください。

### ベースファイルの作成

```bash
$ cai init <title> <topics> [option]
```

オプションとして `-p` を指定すると、`projects` の直下にファイル名と同じ名前のフォルダが作成されます。

```bash
$ cai init -p "This is the title" Topic1 Topic2
```

例えば、上記のコマンドを実行すると、`articles/<uuid>.txt`と`projects/<uuid>`が作成されます。

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

オプションを指定しない場合は、`articles/<uuid>.txt`だけが作成されます。
`.txt` ファイルである理由は、記事として認識されないようにするため、コンテンツのアップデートを可能にするためです。Githubでは`README.txt`ファイルよりも`README.md`ファイルが優先されます。

### 記事の作成

プロジェクトの有無に関わらず、以下のコマンドを実行すると、`<uuid>.md` ファイルが作成されます。

```bash
$ cai <path>
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

また、`init`だけ、あるいは`title`だけで新しい記事を作成することもできます。

```bash
$ cai init "This is the title"
```

### ファイル名とタイトルを表示させる

ファイル名とタイトルを表示させるには以下のコマンドを実行します。

```bash
$ cai show
```

## コマンド一覧

コマンドやオプションで拡張子を含める必要はありません。

- `init <title> <topics> [option]` : ベースファイルの作成
- `show` : `articles` 直下にあるファイル名とタイトルを表示
- `<file name>` : 記事(`.md`)の作成

##### `articles`直下に`<file name>.txt`が無い場合は、相対パスとみなされます。

### オプション

- `-p` : プロジェクトを同時に作成
- `-n` : 空のベースファイルを作成
- `--name <file name>` : 任意のファイル名を指定
  
## 例1

「Rust で Hello, world!」という記事を書く場合をベースにしてみます。

```bash
$ cai init -p "RustでHello, world!" Rust
```

上記のコマンドを実行したときのフォルダ構成は以下のようになっています。

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
```

`projects/<uuid>`に移動して以下を実行します。

```bash
$ cd projects/<uuid>
$ cargo init --name project
```

ここまでのフォルダ構成 ↓

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

`main.rs`にコメントを追記します。このコメントの`1`の部分はコードブロック内と同じであればどんなものでも可能です。

```rust:src/main.rs
// 1
fn main() {
    println!("Hello, world!");
}
// -1
```

`articles/<uuid>.txt`に`main.rs`で表示させたいコードの範囲の番号を書いたコードスニペットを追記します。

````txt:articles/<uuid>.txt
---
title: RustでHello, world!
emoji: 🐒
type: tech
topics: [Rust]
published: false
---

```rust:src/main.rs
1
```
````

以下のコマンドを実行します。

```bash
$ cai <uuid>
```

そうすると`articles/<uuid>.md`が作成され、以下のような内容になっています。

````md:<uuid>.md
---
title: RustでHello, world!
emoji: 🐒
type: tech
topics: [Rust]
published: false
---

```rust:src/main.rs
fn main() {
    println!("Hello, world!");
}
```
````

これで`published: true`にすれば Github に Push して記事をデプロイできます。

## 例2

プロジェクト内のソースコードをREADMEで使用するケース

フォルダ構成 ↓

```
└─cai.exe
```

ベースファイルの作成ですが、これは`touch`コマンドを使った方が早いです。

```bash
$ cai init --name README -n
$ # touch README.txt
```

もし`cai.exe`をデスクトップなどに配置して他のプロジェクトで使用する場合は、`--name`オプションに相対パスを入力することで解決できます。

```bash
$ cai init --name ./<folder name>/README -n
```

フォルダ構成 ↓

```
├─README.txt
└─cai.exe
```

`Hello, world!`と表示するPythonプログラムを作成し、コメントを記述しておきます。

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

フォルダ構成 ↓

```
├─main.py
├─README.txt
└─cai.exe
```

記事を作成します。

```bash
$ cai README
```

**`README.md`**

````md
```python:./main.py
print("Hello, world!")
```
````

フォルダ構成 ↓

```
├─main.py
├─README.md
├─README.txt
└─cai.exe
```

## Playground URL を追記する(Rust のみ)

Rust 限定ですが、Playground の URL を追記できます。

````txt:<uuid>.txt
```rust:src/main.rs:サンプルコード
1
```
````

上記のように`<言語>:<パス>:<リンク用文字列>`とすることで、そのコードブロック内のプログラムの Playground URL を追記できます。

````md:<uuid>.md
[サンプルコード](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=fn%20main%28%29%20%7B%0A%20%20%20%20println%21%28%22Hello%2C%20world%21%22%29%3B%0A%7D)

```rust:src/main.rs:サンプルコード
fn main() {
    println!("Hello, world!");
}
```
````

## コードブロック同士を足し算する

ファイルの特定のコメントアウトの範囲同士を結合することができます。

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

上記の 2 つのファイルのコメントアウトの範囲を結合する場合は以下のように記述します。

**`*.txt`**

````txt
```rust```src/main.rs:1 + src/hello.rs:1
````

コード同士は、記述された順番に上から結合されていきます。

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
