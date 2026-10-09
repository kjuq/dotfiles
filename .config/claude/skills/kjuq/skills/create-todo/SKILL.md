---
name: create-todo
description: Queue a TODO for later. Creates a plan file in <Project root>/_kjuq/blueprint/ and appends a one-line summary with a link to <Project root>/_kjuq/TODO.md.
argument-hint: [TODO の内容]
disable-model-invocation: true
---

# `/create-todo`: TODO を積む

今後やりたいことを、後で `/start-todo` から着手できる形で保存する。このスキルでは TODO の記録だけを行い、TODO の中身 (実装など) には着手しない。

TODO の内容:

$ARGUMENTS

## 1. 内容を確定する

- 上記が空でなければ、その内容で TODO を作る。必要に応じて会話の流れや関連するコードを読み、blueprint を書くための情報を補う。
- 上記が空なら、どんな TODO を作るかをユーザーにヒアリングする。最低限、次を聞き出す。
	- 何をやりたいか
	- なぜやりたいか (背景や動機)
	- 完了の条件 (どうなったら終わりか)
- ヒアリングは必要な分だけにする。内容から自明なことや、コードを読めば分かることは聞かない。

## 2. パスを決める

- Project root は `git rev-parse --show-toplevel` で求める。git リポジトリでなければカレントディレクトリを Project root とする。
- blueprint ディレクトリは `<Project root>/_kjuq/blueprint/`、TODO 一覧は `<Project root>/_kjuq/TODO.md`。存在しなければ作成する。
- `_kjuq` はグローバルに git ignore されているので、git に add やコミットはしない。

## 3. 番号とファイル名を決める

- `<num>` は既存の番号の最大値 + 1 とする。既存の番号は、blueprint ディレクトリ内のファイル名の先頭の数字と、TODO.md 内のリンクの番号の両方から拾う。どちらにもなければ 1 から始める。
- `<num>` はゼロ埋めしない (例: `1`, `2`, `10`)。
- ファイル名は `<num>-some-title-in-english.md` とする。タイトル部分は内容を表す短い英語の kebab-case (小文字・ハイフン区切り、3〜6 語程度) にする。

## 4. blueprint を書く

`<Project root>/_kjuq/blueprint/<num>-some-title-in-english.md` を作成する。後で別のセッションがこのファイルだけを読んで着手できるよう、会話の文脈に頼らず自己完結した内容にする。本文は日本語で書く。

テンプレート:

```markdown
# <タイトル (日本語)>

作成日: YYYY-MM-DD

## 背景

なぜやりたいのか。きっかけや現状の問題。

## やりたいこと

何をするのか。分かっている範囲で具体的に。

## 完了条件

どうなったら完了とみなすか。

## メモ

関連するファイルのパス、参考 URL、検討中の案、未決事項など。なければ節ごと省略する。
```

## 5. TODO.md に追記する

`<Project root>/_kjuq/TODO.md` の末尾に次の書式で一行追記する。リンクは TODO.md からの相対パスにする。

```markdown
- summary ([<num>](blueprint/<num>-some-title-in-english.md))
```

- summary は日本語の簡潔な一行にする。
- TODO.md の既存の行は変更しない。

## 6. 報告する

作成した blueprint のパスと、TODO.md に追記した行をユーザーに伝える。着手するときは `/start-todo <num>` を使えることも添える。
