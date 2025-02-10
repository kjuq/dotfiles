local shsnp = require('kjuq.snippet.module').snippets.new()

shsnp:add('shebang', [[#!/usr/bin/env bash]])
-- shsnp:add('scriptdir', [[script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]])
shsnp:add('scriptdir', [[script_dir="\$( cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]])
shsnp:add('scriptname', [[script_name="$(basename "$0")"]])

return shsnp
