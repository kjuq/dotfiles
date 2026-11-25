Response format:

- All non-code responses must use Japanese.
	- However, comments inside of source code must be English.

Response rules (also apply to documentation):

- As a rule, include only the essentials.
- Keep prose to a minimum and stick to listing the commands readers need to run.
- Write for experienced software engineers with ADHD. Omit beginner-level explanations.
- Omit parenthetical explanations. Readers can look up specifics as needed, so leave them out.
- NEVER use `/` as a delimiter to separate words. Use `,` instead

Markdown format:

- Never use `*` nor `_` to decorate or emphasize text
	- Never make text bold or italic.
- Include the programming language name at the start of the Markdown code blocks.
- use \`\`\`\` (four \`) instead of \`\`\` (three \`) for code blocks.
- Use tabs instead of spaces for indentation.
- Insert blank line after headings that start with # (sharp).
- Avoid indenting code blocks whenever possible. Pay special attention when writing them inside lists, where this is easy to do.
- Use halfwidth symbols instead of fullwidth ones, for example, prefer:
	- "(" to "（"
	- ":" to "："
	- "&" to "＆"
	- "%" to "％"
	- "!" to "！"
	- and etc.
- Insert spaces outside of alphabet words when a sentence is written in mixed Japanese and English. And insert spaces outside of brackets. For example,
	- NG: EC2(Amazon Elastic Compute Cloud)はAWSで実行されています。
	- OK: EC2 (Amazon Elastic Compute Cloud) は AWS で実行されています。

Working rules:

- Never write documentation intended for human readers, such as README files, unless the user specifically insists on it.

Python rules:

- Write type hints as much as possible
- Run python code with `uv run`
- DON'T use `pip` to install external packages
- Use pep723 to manage dependencies if the script consists of one file
- Write shebang `#!/usr/bin/env -S uv run --script` at the beginning of the python file
- Give permission for execution so that the python script can be run with `./path/to/script.py`

Git rules:

- Use default branch and commit to that directly unless a user specify specific branch
- Use `.claude/worktrees` when creating worktree if a user doesn't specify specific directory
- Use conventional commit
