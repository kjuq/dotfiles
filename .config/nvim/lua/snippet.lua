local M = {}

M.all = {
	date = function()
		return assert(os.date('%Y-%m-%d'))
	end,
	time = function()
		return assert(os.date('%H:%M'))
	end,
	timem = function()
		return assert(os.date('%H:%M:%S'))
	end,
}

M.cpp = {
	forauto = [[for (auto ${1} : ${2} ) {${0}}]],
	rep = [[for (int ${1} : rep(${2}, ${3})) {${0}}]],
	cout = [[cout << ${0} << endl;]],
	cin = [[cin >> ${0};]],
}

M.lua = {
	autocmd = {
		[[vim.api.nvim_create_autocmd({ '${1}' }, {]],
		[[	pattern = '${2}',]],
		[[	group = vim.api.nvim_create_augroup('${3}', {}),]],
		[[	callback = function()${0}end]],
		[[})]],
	},
	lazySpec = {
		[[---@module 'lazy']],
		[[---@type LazySpec]],
		[[local spec = { '${0}' }]],
		[[]],
		[[local map = require('kjuq.utils.lazy').generate_map('', '')]],
		[[spec.keys = {}]],
		[[]],
		[[spec.opts = {}]],
		[[]],
		[[spec.config = function(_, opts)]],
		[[	require('').setup(opts)]],
		[[end]],
		[[]],
		[[return spec]],
	},
	feedkeys = {
		[[vim.api.nvim_feedkeys('${0}', 'n', true)]],
	},
	feedkeysEscape = {
		[[vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('${0}', true, false, true), 'n', false)]],
	},
	listdir = {
		[[---@param dir string]],
		[[---@return table?]],
		[[local listdir = function(dir)]],
		[[	local req, err = vim.uv.fs_scandir(dir)]],
		[[	if not req then]],
		[[		error(err)]],
		[[		return nil]],
		[[	end]],
		[[	local result = {}]],
		[[	while true do]],
		[[		local name, type = vim.uv.fs_scandir_next(req)]],
		[[		if not name then]],
		[[			break]],
		[[		end -- no more entries]],
		[[		local full_path = dir .. '/' .. name]],
		[[		result[#result + 1] = full_path]],
		[[	end]],
		[[	return result]],
		[[end]],
		[[]],
	},
}

M.markdown = {
	marpInit = {
		[[---]],
		[[marp: true]],
		[[theme: default]],
		[[paginate: true]],
		[[lang: ja # Necessary for Japanese-word-breaking]],
		[[style: |]],
		[[  h1, h2, h3, h4, h5, h6, p { word-break: auto-phrase; }]],
		[[  h1 { color: #2c5aa0; }]],
		[[  h2 { color: #4a7ba7; }]],
		[[  section { font-size: 18px; }]],
		[[  table { font-size: 0.8em; }]],
		[[  .columns { /* Split screen */]],
		[[    display: grid;]],
		[[    grid-template-columns: repeat(2, minmax(0, 1fr));]],
		[[    gap: 1rem;]],
		[[  }]],
		[[---]],
	},
	marpLatexmath = {
		[[<!-- https://qiita.com/tomtsutom0122/items/e0ab6b6ccbd369db1aa2 -->]],
		[[<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"></script>]],
		[[<script type="text/x-mathjax-config">]],
		[[	MathJax.Hub.Config({]],
		[[	tex2jax: {]],
		[[		inlineMath: [['$', '$'] ],]],
		[=[		displayMath: [ ['$$','$$'], ["\[","\]"] ]]=],
		[[		}]],
		[[	});]],
		[[</script>]],
	},
	marpMermaid = {
		[[<script type="module">]],
		[[	import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@latest/dist/mermaid.esm.min.mjs';]],
		[[	mermaid.initialize({ startOnLoad: false });]],
		[[	await mermaid.run({ querySelector: '.language-mermaid', });]],
		[[	// Set auto-scaling to true for Mermaid diagrams only]],
		[[	document.querySelectorAll('marp-pre[is="marp-pre"][data-auto-scaling]').forEach(pre => {]],
		[[		if (pre.querySelector('code.language-mermaid')) {]],
		[[			pre.setAttribute('data-auto-scaling', 'true');]],
		[[		}]],
		[[	});]],
		[[</script>]],
	},
	marpSmalltable = {
		[[<style scoped>]],
		[[	table { table-layout: fixed; width: 100%; display:table; font-size: 18px; }]],
		[[</style>]],
	},
	image = {
		[[![${1:description}](${2:imgpath})]],
	},
	imageLeft = {
		[[![${1:description} bg right width:600](${2:imgpath})]],
	},
}

M.python = {
	ifmain = {
		[[if __name__ == '__main__':]],
		[[	main()]],
	},
	ifmainExit = {
		[[if __name__ != '__main__':]],
		[[	exit()]],
	},
	traverse = {
		[[import os]],
		[[from typing import Generator]],
		[[]],
		[[def traverse_dir(path: str) -> Generator[str, None, None]:]],
		[[	expanded_path = os.path.expanduser(path)]],
		[[	for dirpath, _, filenames in os.walk(expanded_path):]],
		[[		for filename in filenames:]],
		[[			yield os.path.join(dirpath, filename)]],
	},
	debug = {
		[[import logging]],
		[[logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(message)s')]],
		[[logging.debug('MESSAGE')]],
	},
	graph = {
		[[import matplotlib.pyplot as plt]],
		[[import numpy as np]],
		[[]],
		[[x = np.linspace(-10, 10, 400)  # range of x]],
		[[y = ${1:x**2}]],
		[[]],
		[[plt.plot(x, y)]],
		[[]],
		[[plt.title('Graph of y = f(x)')]],
		[[plt.xlabel('x')]],
		[[plt.ylabel('y')]],
		[[]],
		[[plt.show()]],
	},
	execSync = {
		[=[cmd: list[str] = ['echo', 'hello']]=],
		[[result = subprocess.run(cmd, capture_output=True, text=True)]],
		[[print(result.stdout)]],
		[[if result.stderr:]],
		[[	print('Error:', result.stderr)]],
	},
	dependencies = {
		[=[# /// script]=],
		[=[# dependencies = []=],
		[=[# 	'matplotlib',]=],
		[=[# ]]=],
		[=[# ///]=],
	},
}

M.sh = {
	scriptDir = [[script_dir="\$( cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]],
	scriptName = [[script_name="$(basename "$0")"]],
}

M.tex = {
	thebibliography = {
		[[\begin{thebibliography}{99}]],
		[[	\item{${1:LABEL}} ${2:TARGET}]],
		[[\end{thebibliography}]],
	},
	bibitem = {
		[[\bibitem{${1:LABEL}} ${2:TARGET}]],
	},
	url = {
		[[\url{${1:TARGET}}]],
	},
	lstinputlisting = {
		[[\lstinputlisting[caption = ${1:CAPTION}, label = ${2:LABEL}]{${3:PATH_TO_FILE}}]],
	},
	image = {
		[=[\begin{figure}[${1:POSITION}]]=],
		[[	\includegraphics[${2:OPTION}]{${3:PATH}}]],
		[[	\caption{${4}]],
		[[	\label{${5}]],
		[=[\end{figure}]=],
	},
}

M.typst = {
	image = {
		[[#figure(]],
		[[	image("${1:PATH}", width: 80%),]],
		[[	caption: []],
		[[		A caption. This is an example text.]],
		[[	],]],
		[[) <${2:LABEL}>]],
	},
	template = {
		[[#import "@preview/js:0.1.3": * // https://typst.app/universe/package/js/]],
		[[#show: js.with(]],
		[[	lang: "ja",]],
		[[	seriffont: "Libertinus Serif", // or "Libertinus Serif", ...]],
		[[	seriffont-cjk: "Noto Serif CJK JP", // or "Yu Mincho", "Hiragino Mincho ProN", ...]],
		[[	sansfont: "Hack Nerd Font", // or "Arial", "Helvetica", ...]],
		[[	sansfont-cjk: "Noto Sans CJK JP", // or "Yu Gothic", "Hiragino Kaku Gothic ProN", ...]],
		[[	paper: "a4", // "a*", "b*", or (paperwidth, paperheight) e.g. (210mm, 297mm)]],
		[[	fontsize: 12pt,]],
		[[	baselineskip: auto,]],
		[[	textwidth: auto,]],
		[[	lines-per-page: auto,]],
		[[	book: false, // or true]],
		[[	cols: 1, // 1, 2, 3, ...]],
		[[	non-cjk: regex("[\u0000-\u2023]"),  // or "latin-in-cjk" or any regex]],
		[[	cjkheight: 0.88, // height of CJK in em]],
		[[)]],
		[[]],
		[[#maketitle(]],
		[[	title: "Typst日本語用テンプレートjs",]],
		[[	// authors: "NAME",]],
		[[	// authors: ("NAME", "NAME"),]],
		[[	// authors: (("NAME", "UNIVERSITY"), ("NAME", "UNIVERSITY")),]],
		[[	authors: (("NAME", "UNIVERSITY", "mail@address.org"), ("NAME", "UNIVERSITY")),]],
		[[	// abstract: []],
		[[	// 	Typst template that imitates jsarticle/jsbook of #LaTeX]],
		[=[	// ]]=],
		[[)]],
	},
	titleFullpage = {
		[=[#show: rest => {]=],
		[=[	// 最初のページのみ特別なレイアウトを適用]=],
		[=[	align(center + horizon)[]=],
		[=[		#v(30%) // ページの上から30%の位置に配置]=],
		[=[		#text(22pt, weight: "bold")[TITLE]]=],
		[=[		#v(42%) // ページの中央より少し下に配置]=],
		[=[		NAME]=],
		[=[		#v(1fr) // 残りのスペースを埋める]=],
		[=[		#text(11pt)[2025-99-99]]=],
		[=[	]]=],
		[=[	pagebreak()]=],
		[=[	rest]=],
		[=[}]=],
	},
	setHeading = '#set heading(numbering: "1.1")',
}

return M
