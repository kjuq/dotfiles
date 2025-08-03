local M = {}

M.snippets = {
	{
		trigger = 'thebibliography',
		body = {
			[[\begin{thebibliography}{99}]],
			[[	\item{${1:LABEL}} ${2:TARGET}]],
			[[\end{thebibliography}]],
		},
	},
	{
		trigger = 'bibitem',
		body = {
			[[\bibitem{${1:LABEL}} ${2:TARGET}]],
		},
	},
	{
		trigger = 'url',
		body = {
			[[\url{${1:TARGET}}]],
		},
	},
	{
		trigger = 'lstinputlisting',
		body = {
			[[\lstinputlisting[caption = ${1:CAPTION}, label = ${2:LABEL}]{${3:PATH_TO_FILE}}]],
		},
	},
	{
		trigger = 'image',
		body = {
			[=[\begin{figure}[${1:POSITION}]]=],
			[[	\includegraphics[${2:OPTION}]{${3:PATH}}]],
			[[	\caption{${4}]],
			[[	\label{${5}]],
			[=[\end{figure}]=],
		},
	},
}

return M
