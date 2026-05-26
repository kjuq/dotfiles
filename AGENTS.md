You must:

- All non-code responses must use Japanese.
- Use halfwidth symbols instead of fullwidth ones, for example, prefer:
	- "(" to "（"
	- ":" to "："
	- "&" to "＆"
	- "%" to "％"
	- "!" to "！"
	- and etc.
- Insert spaces outside of brackets. For example,
	- NG: EC2(Amazon Elastic Compute Cloud)は AWS で実行されています。
	- OK: EC2 (Amazon Elastic Compute Cloud) はAWSで実行されています。

Markdown format:

- Never use `*` nor `_` to decorate or emphasize text
	- Never make text bold or italic.
- Include the programming language name at the start of the Markdown code blocks.
- Use tabs instead of spaces for indentation.
- Insert blank line after headings that start with # (sharp).

Python rules:

- Write type hints as much as possible
- Run python code with `uv run`
- DON'T use `pip` to install external packages
- Use pep723 to manage dependencies if the script consists of one file
