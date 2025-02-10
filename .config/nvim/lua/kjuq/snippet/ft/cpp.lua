local cppsnp = require('kjuq.snippet.module').snippets.new()

cppsnp:add('forauto', [[for (auto ${1:e} : ${2:elements}) {${0}}]])
cppsnp:add('rep', [[for (int ${1:i} : rep(${2:0}, ${3:10})) {${0}}]])
cppsnp:add('cout', [[cout << ${0} << endl;]])
cppsnp:add('cin', [[cin >> ${0};]])

return cppsnp
