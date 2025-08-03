M = {}

M.snippets = {
	{ trigger = 'forauto', body = [[for (auto ${1:e} : ${2:elements}) {${0}}]] },
	{ trigger = 'rep', body = [[for (int ${1:i} : rep(${2:0}, ${3:10})) {${0}}]] },
	{ trigger = 'cout', body = [[cout << ${0} << endl;]] },
	{ trigger = 'cin', body = [[cin >> ${0};]] },
}

return M
