function c
	set --export CDPATH $cdpath && set --prepend CDPATH '.' && cd $argv && set --erase CDPATH
end

function cnew
	if not contains $PWD $cdpath
		set --universal --append cdpath "$PWD"
	else
		echo 'already added'
		return 1
	end
end

function clist
	echo "$cdpath"
end

function cdelete
	if set --local idx $(contains -i $PWD $cdpath)
		set -e cdpath[$idx]
	else
		echo 'pwd is not in cdpath'
		return 1
	end
end
