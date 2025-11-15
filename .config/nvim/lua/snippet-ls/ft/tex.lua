local M = {}

M.snippets = {
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

return M
