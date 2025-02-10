local texsnp = require('kjuq.snippet.module').snippets.new()

texsnp:add('thebibliography', {
	[[\begin{thebibliography}{99}]],
	[[	\item{${1:LABEL}} ${2:TARGET}]],
	[[\end{thebibliography}]],
})

texsnp:add('bibitem', {
	[[\bibitem{${1:LABEL}} ${2:TARGET}]],
})

texsnp:add('url', {
	[[\url{${1:TARGET}}]],
})

texsnp:add('lstinputlisting', {
	[[\lstinputlisting[caption = ${1:CAPTION}, label = ${2:LABEL}]{${3:PATH_TO_FILE}}]],
})

texsnp:add('image', {
	[=[\begin{figure}[${1:POSITION}]]=],
	[[	\includegraphics[${2:OPTION}]{${3:PATH}}]],
	[[	\caption{${4}]],
	[[	\label{${5}]],
	[=[\end{figure}]=],
})

return texsnp
