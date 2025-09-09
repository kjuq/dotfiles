M = {}

M.snippets = {
	forauto = [[for (auto ${1} : ${2} ) {${0}}]],
	rep = [[for (int ${1} : rep(${2}, ${3})) {${0}}]],
	cout = [[cout << ${0} << endl;]],
	cin = [[cin >> ${0};]],
}

return M
