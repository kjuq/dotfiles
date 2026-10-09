---
name: create-todo
description: Queue a TODO for later.
argument-hint: [TODO description]
disable-model-invocation: true
---

# `/create-todo`: TODO を積む

今後やりたいことを、後で `/start-todo` から着手できる形で保存する。このスキルでは TODO の記録だけを行い、TODO の中身 (実装など) には着手しない。

このスキルでは、ユーザーへの質問は極力控え、1 shot で TODO を積むことを最優先にする。blueprint は概要の記述に留まっても構わない。

blueprint には、与えられた情報と、明らかに確定している情報だけを書く。推測で本文を膨らませない。曖昧な点や決まっていない点は、`/refine-todo` がユーザーに確認を取りながら詰める。

TODO の内容:

$ARGUMENTS

## 1. 内容を確定する

- 上記が空でなければ、その内容で TODO を作る。
- 上記が空なら、直前の会話の流れから TODO にすべき内容を読み取る。
- blueprint に書いてよいのは次の情報だけである。
	- ユーザーが TODO の内容として与えた情報
	- 会話の中で明示的に確定した情報 (ユーザーが述べたこと、合意済みの方針など)
	- 疑いなく確定している事実 (会話で言及されたファイルのパスなど)
- 推測や提案、一般論で内容を補わない。「たぶんこうだろう」「こうすると良さそう」という内容は書かない。内容を補うためにコードを調べることもしない。
- 分からないことや決まっていないことがあっても、ユーザーには聞かない。埋めずにそのまま残し、`/refine-todo` に任せる。
- ユーザーに聞くのは、上記が空で会話の流れからも何を積むべきか全く読み取れない場合だけにする。その場合も「何をやりたいか」だけを一度聞く。

## 2. パスを決める

- Project root は `git rev-parse --show-toplevel` で求める。git リポジトリでなければカレントディレクトリを Project root とする。
- blueprint ディレクトリは `<project-root>/_kjuq/blueprint/`、TODO 一覧は `<project-root>/_kjuq/TODO.md`。存在しなければ作成する。
- `_kjuq` はグローバルに git ignore されているので、git に add やコミットはしない。

## 3. 番号とファイル名を決める

- `<num>` は既存の番号の最大値 + 1 とする。既存の番号は、blueprint ディレクトリ内のファイル名の先頭の数字と、TODO.md 内のリンクの番号の両方から拾う。どちらにもなければ 1 から始める。
- `<num>` はゼロ埋めしない (例: `1`, `2`, `10`)。
- ファイル名は `<num>-some-title-in-english.md` とする。タイトル部分は内容を表す短い英語の kebab-case (小文字・ハイフン区切り、3〜6 語程度) にする。

## 4. blueprint を書く

`<project-root>/_kjuq/blueprint/<num>-some-title-in-english.md` を作成する。後で別のセッションがこのファイルだけを読めるよう、会話の中で確定した情報は会話の文脈に頼らずに書き写す。本文は日本語で書く。

- 書くべき情報が無い節は、推測で埋めずに「未定」とだけ書く。
- 分量が少なくても構わない。数行の blueprint でもよい。

テンプレート:

```markdown
# <タイトル (日本語)>

作成日: YYYY-MM-DD

## 背景

なぜやりたいのか。きっかけや現状の問題。

## やりたいこと

何をするのか。与えられた範囲で。

## 完了条件

どうなったら完了とみなすか。

## メモ

与えられた関連ファイルのパス、参考 URL、ユーザーが挙げた案など。なければ節ごと省略する。
```

## 5. TODO.md に追記する

`<project-root>/_kjuq/TODO.md` の末尾に次の書式で一行追記する。リンクは TODO.md からの相対パスにする。

```markdown
- summary: [<num>](blueprint/<num>-some-title-in-english.md)
```

- summary は日本語の簡潔な一行にする。
- TODO.md の既存の行は変更しない。

## 6. 報告する

作成した blueprint のパスと、TODO.md に追記した行をユーザーに伝える。詳細を詰めるときは `/refine-todo <num>`、着手するときは `/start-todo <num>` を使えることも添える。
