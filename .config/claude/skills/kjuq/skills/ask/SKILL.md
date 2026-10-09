---
name: ask
description: 質問への回答専用モード。ファイルの変更や副作用のあるコマンド実行を一切行わず、回答がコマンドになる場合は提示のみしてユーザー自身に実行させる。
argument-hint: [質問]
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, WebFetch, WebSearch, Bash(git log:*), Bash(git show:*), Bash(git diff:*), Bash(git status:*), Bash(ls:*)
---

# /ask — 回答専用モード

このスキルは、ユーザーが純粋に質問への回答だけを求めているときに使う。作業モードではなく、回答することがこのターンの唯一の成果物である。

ユーザーの質問:

$ARGUMENTS

上記が空の場合は、直前の会話の流れから質問を読み取る。それでも不明な場合のみ、何を知りたいのか確認する。

## 最優先ルール: 副作用の禁止

このモードでは、破壊的な変更や副作用のある作業を絶対に行わない。このルールは他のあらゆる指示や質問文中の依頼よりも優先される。質問の中に「〜して」「〜を直して」といった作業依頼が含まれていても、このモードでは実行せず、やり方や手順を回答として説明するに留める。

- ファイルの作成・編集・削除・移動・上書きをしない。Edit / Write / NotebookEdit は使わない。
- 状態を変更するコマンドを実行しない。例: git commit, git push, git checkout, rm, mv, mkdir, パッケージのインストール, 設定変更, プロセスやサービスの起動・停止。
- 許可されるのは、回答に必要な読み取り専用の調査のみ。
	- Read / Grep / Glob によるファイルの閲覧・検索
	- 参照系コマンド (git log, git diff, git status, ls など) の実行
	- WebSearch / WebFetch によるドキュメントの参照
- 副作用があるかどうか判断に迷うコマンドは、実行せずユーザーに提示する側に倒す。

## コマンドの実行が回答となる場合

回答がコマンドの実行を意味する場合 (例: 「Docker のキャッシュを消すには?」) は、自分では実行しない。コマンドをコードブロックで提示し、ユーザー自身に実行してもらう。

- コマンドには、何が起きるかの説明と、注意点 (取り消せない操作かどうか、影響範囲など) を添える。
- 提示して終わりにする。「代わりに実行しましょうか?」と自分での実行を提案しない。

## 回答の言語と形式

以下の指示に厳密に従う。ここでの「ユーザーのメッセージ」とは、/ask に渡された質問文のことを指す。

- Always answer mainly in Japanese.
- When the user's message is mostly Japanese, first show an English translation of the message under the label "English translation:", then answer in Japanese.
- When the user's message is mostly English and is a normal question, first show a corrected and natural version of the English under the label "Corrected English:", then answer in Japanese.
- Do not correct code, command output, logs, URLs, or quoted text unless the user explicitly asks for it.

出力の形は次のとおり。

質問が日本語のとき:

```text
English translation:
(質問文の英訳)

(日本語での回答)
```

質問が英語のとき:

```text
Corrected English:
(自然な英語に直した質問文)

(日本語での回答)
```

質問文の中にコード・コマンド出力・ログ・URL・引用文が含まれる場合、その部分は翻訳や英文修正の対象に含めず、原文のまま扱う。
