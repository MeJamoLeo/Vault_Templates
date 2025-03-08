---
tags:
  - "#algorithm-practice"
  - "#競技プログラミング"
  - "#nix-package-manager"
  - "#common-lisp"
  - "#sbcl"
---
[アルゴリズムと数学　演習問題集 - AtCoder](https://atcoder.jp/contests/math-and-algorithm)

## `flake.nix`の例

まず、SBCL 2.3.6を含む開発環境を定義するための`flake.nix`ファイルの内容例を示します。以下の内容を`flake.nix`として保存してください（Nix Flakesを利用して、SBCL 2.3.6をパッケージに含めた開発シェル環境を構築します）:

```nix
{
  description = "SBCL 2.3.6 development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # nixpkgsのソース（不安定版を使用）

  outputs = { self, nixpkgs, ... }:
    let
      system = builtins.currentSystem;               # 現在のシステム (例: x86_64-linux)
      pkgs   = import nixpkgs { inherit system; };    # 対応するプラットフォームのnixpkgsをインポート
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.sbcl_2_3_6                      # SBCL 2.3.6 パッケージを含める
        ];
        # 必要に応じて他のツールをpackagesに追加可能
      };
    };
}
```

上記の`flake.nix`では、`devShells`の中でSBCL 2.3.6をビルド入力に含めたシェル環境を定義しています。`nixpkgs`には`nixos-unstable`チャンネルを指定していますが、安定版の特定リリースに固定したい場合は適宜URLを変更できます（例: `"github:NixOS/nixpkgs/nixos-23.11"` 等）。`builtins.currentSystem`を使うことで、自分の環境（システム）のアーキテクチャに合ったパッケージセットが自動選択されます。

## セットアップ手順

SBCL 2.3.6環境を構築するための手順を、`nix`コマンドを用いて順を追って説明します。

1. **プロジェクトディレクトリの作成**（任意）: SBCL用の環境を構築するためのディレクトリを用意します。例として`sbcl-env`という名前のディレクトリを作成します。
    
    ```bash
    mkdir sbcl-env && cd sbcl-env
    ```
    
    （既にプロジェクトディレクトリがある場合はその中で進めて構いません。）
    
2. **`flake.nix`の作成**: 上述の内容をコピーして、プロジェクトディレクトリ内に`flake.nix`という名前で保存します。エディタでファイルを作成し、上記のコードブロックを貼り付けてください。保存後、Gitで管理している場合は`git add flake.nix`しておくと良いでしょう。
    
3. **フレークのセットアップ**: ターミナルでプロジェクトディレクトリに移動し、`nix develop`コマンドを実行します。このコマンドにより、`flake.nix`で定義した開発シェルに入ることができます。`nix develop`はフレークの出力からデフォルトの開発シェル(`devShells.<system>.default`)を探し出し、その環境でシェルを起動します ([nix develop - Nix Reference Manual](https://nix.dev/manual/nix/2.17/command-ref/new-cli/nix3-develop#:~:text=If%20no%20flake%20output%20attribute,the%20following%20flake%20output%20attributes))。
    
    ```bash
    nix develop
    ```
    
    ※初回実行時には`nixpkgs`のリポジトリがダウンロードされるため少し時間がかかります。`flake.nix`内で指定した`nixpkgs`リビジョンに基づいてSBCL 2.3.6が取得され、シェル環境が構築されます。
    
4. **環境の確認**: `nix develop`によってシェルが起動したら、SBCLが利用可能になっていることを確認します。例えば以下のように`sbcl --version`コマンドを実行し、バージョンが`2.3.6`と表示されることを確認してください。
    
    ```bash
    $ sbcl --version
    SBCL 2.3.6
    ```
    
    このように表示されれば、SBCL 2.3.6を含む開発環境のセットアップは成功です。あとはそのまま次のセクションのようにSBCLを利用できます。
    

> **Note:** Nix Flakesを使用するには、Nix 2.4以降のCLI(`nix`コマンド)が必要です。もしまだ従来の`nix-env`や`nix-shell`しか使えない設定の場合は、`nix.conf`で`experimental-features = nix-command flakes`を有効にしてください。

## 環境の使用方法

開発シェル環境内でSBCLを使って、対話的なREPLを起動したり、Lispスクリプトを実行したりすることができます。以下にそれぞれの方法を説明します。

### SBCL REPLの起動

環境内で単に `sbcl` コマンドを実行すると、SBCLのインタラクティブなREPL（Read-Eval-Print Loop）が起動します。起動時にはSBCLのバナーが表示され、プロンプトが`*`で示されます ([Getting Started - Steel Bank Common Lisp](https://www.sbcl.org/getting.html#:~:text=Make%20sure%20that%20,produce%20a%20banner%20like%20this))。例えば:

```bash
$ sbcl
This is SBCL 2.3.6, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
...[省略]...
*
```

上記のようにSBCLが起動し、`*`プロンプトが表示されたら入力待ち状態です。この状態でCommon Lispの式を入力すれば、その場で評価結果が表示されます。REPL上では自由にLispのコードを試すことができます。

REPLを終了するには、SBCLに組み込まれている終了用関数を呼び出します。プロンプトで `(quit)` と入力してEnterを押すとSBCLを終了できます ([Getting Started - Steel Bank Common Lisp](https://www.sbcl.org/getting.html#:~:text=))。例えば:

```lisp
* (quit)
```

これでSBCLの対話環境を抜け、元のシェルに戻ります。

### Lispスクリプトの実行

SBCLはスクリプト実行モードも備えており、Lispプログラムをスクリプトとして実行できます。開発シェル環境内で、`sbcl --script <ファイル名>`というコマンドを使うことで、指定したLispファイルを読み込んで実行し、実行後にSBCLが終了します ([Running Lisp from the terminal](https://comp-348.github.io/lisp-running-from-terminal.html#:~:text=The%20first%20of%20the%20two,your%20terminal%2C%20and%20then%20exit))。例えば、以下のような`hello.lisp`というファイルがあるとします:

```common-lisp
;; hello.lisp (サンプルLispスクリプト)
(format t "Hello, Lisp!~%")
```

このファイルを`--script`オプションで実行してみます:

```bash
$ sbcl --script hello.lisp
Hello, Lisp!
$
```

上記のように、ファイル内のコードが評価され、"Hello, Lisp!"という出力が表示された後、SBCLのプロセスが終了します ([Running Lisp from the terminal](https://comp-348.github.io/lisp-running-from-terminal.html#:~:text=%24%20sbcl%20,))。`--script`はShebang行（`#!/usr/bin/env sbcl --script`のような記述）と組み合わせてスクリプトを直接実行可能にすることもできます。

**補足:** スクリプトを実行する際に、実行後もREPLに入りたい場合は`--load`オプションを使う方法もあります。`sbcl --load <ファイル名>`とすると、指定したファイルを読み込んだ上で対話的なREPLに入ります ([Running Lisp from the terminal](https://comp-348.github.io/lisp-running-from-terminal.html#:~:text=If%20you%20use%20%60,can%20interact%20with%20your%20program))。しかし通常のスクリプト実行用途であれば`--script`の方が便利です。

以上が、Nixで構築したSBCL 2.3.6環境の使い方になります。開発シェル内ではSBCLおよび関連するツールを用いてCommon Lispの開発や実行を行うことができます。必要に応じて`flake.nix`の`packages`に他のライブラリやツール（例えばQuicklispやエディタなど）を追加することで、より充実した開発環境に拡張することも可能です。