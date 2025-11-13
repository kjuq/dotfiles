local M = {}

M.snippets = {
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

return M
