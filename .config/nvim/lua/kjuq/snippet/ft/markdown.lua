local mdsnp = require('kjuq.snippet.module').snippets.new()

mdsnp:add('marp.init', {
	[[---]],
	[[marp: true]],
	[[math: mathjax]],
	[[style: section { font-size: 22px; }]],
	[[---]],
	[[]],
	[[# ${0}]],
	[[]],
	[[---]],
})

mdsnp:add('marp.latexmath', {
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
})

mdsnp:add('marp.smalltable', {
	[[<style scoped>]],
	[[	table { table-layout: fixed; width: 100%; display:table; font-size: 18px; }]],
	[[</style>]],
})

mdsnp:add('image', {
	[[![${1:description}](${2:imgpath})]],
})

mdsnp:add('image.left', {
	[[![${1:description} bg right width:600](${2:imgpath})]],
})

mdsnp:add('comment', {
	[[<!-- ${1} -->]],
})

mdsnp:add('link', {
	[[[${1:description}](${2:path})]],
})

return mdsnp
