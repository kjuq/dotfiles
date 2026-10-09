---
name: start-todo
description: /create-todo で積んだ TODO に着手する。番号か自然言語で TODO を指定し、<Project root>/_kjuq/blueprint/ の計画ファイルに従って作業する。
argument-hint: [<num> | どの TODO かの説明]
disable-model-invocation: true
---

# `/start-todo`: TODO に着手する

`/create-todo` で積んだ TODO を選び、その blueprint に従って作業する。

指定:

$ARGUMENTS

## 1. パスを決める

- Project root は `git rev-parse --show-toplevel` で求める。git リポジトリでなければカレントディレクトリを Project root とする。
- blueprint ディレクトリは `<Project root>/_kjuq/blueprint/`、TODO 一覧は `<Project root>/_kjuq/TODO.md`。
- どちらも存在しなければ、TODO がまだ無いことを伝えて終了する。

## 2. TODO を特定する

指定の形に応じて対象を決める。

- 数字のとき: `<Project root>/_kjuq/blueprint/<num>-*.md` に一致するファイルを対象にする。見つからなければその旨と TODO.md の一覧を示して終了する。
- 自然言語のとき: TODO.md の各行のサマリーと、必要なら blueprint の中身を読み、指示に最も合う TODO を選ぶ。
	- 一つに絞り込めれば、どの TODO (番号とサマリー) に着手するかを一行伝えてから進める。
	- 候補が複数あって決めきれない場合や、該当するものが無い場合は、候補を示してユーザーに選んでもらう。
- 空のとき: TODO.md の一覧を示し、どれに着手するかをユーザーに選んでもらう。

## 3. 着手する

- 対象の blueprint を読み、背景・やりたいこと・完了条件を把握する。メモにある関連ファイルや URL にも目を通す。
- blueprint 作成時から状況が変わっている可能性があるので、関連するコードや設定の現状を確認してから作業する。
- blueprint の内容に曖昧な点や、現状と食い違う点があり、それが作業の方向を左右する場合はユーザーに確認する。些細なことは妥当な判断で進め、最後に報告する。
- 完了条件を満たすまで作業する。コミットや push などは、ユーザーの普段の指示に従い、明示的な依頼が無ければ行わない。

## 4. 完了後

- 何をしたか、完了条件を満たしたかを報告する。満たせなかった項目があれば正直に伝える。
- TODO.md と blueprint の後始末 (行の削除、完了の印付け、blueprint への作業メモの追記など) は勝手に行わず、どうするかをユーザーに確認する。
