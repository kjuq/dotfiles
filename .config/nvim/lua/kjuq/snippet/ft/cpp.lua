M = {}

M.snippets = {
	forauto = [[for (auto ${1:e} : ${2:elements}) {${0}}]],
	rep = [[for (int ${1:i} : rep(${2:0}, ${3:10})) {${0}}]],
	cout = [[cout << ${0} << endl;]],
	cin = [[cin >> ${0};]],
}

return M
