<h1 align="center">Continuous Article Integration</h1>

記事コンテンツをプロジェクトと統合して管理するための便利な CLI ツールです。

単純なコードブロックでファイル指定ができる機能ではなく、プロジェクトとして管理することでユーザーが得られるコンテンツとしての一体感を提供したいと思って作りました。記事を管理しているフォルダやリポジトリを公開する場合、参照するファイルが 1 つであるよりも、プロジェクトに含まれる 1 つのファイルとして存在していた方がユーザーが得るものが多いと思います。この CLI ツールはそれを提供します。

---

## 機能

- [x] 新しい記事とプロジェクトの作成
- [x] コードブロックでのファイル指定
- [x] Playground URL 追加(Rust のみ)

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

`Cargo build` コマンドで作成した `/target/debug/cai.exe` は、Zenn の記事を管理しているフォルダの直下に置いてください。

```bash
$ cai init [option] <title> <topics>
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
`.txt` ファイルである理由は、記事として認識されないようにするためです。

プロジェクトの有無に関わらず、以下のコマンドを実行すると、`<uuid>.md` ファイルが作成されます。ファイル名をコピーするのは面倒ですが...。

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
$ cai init This is the title
```

## 例

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

`main.rs`にコメントを追記します。

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

## Playground URL を追記する

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
