function c
	set --export CDPATH '.' $cdpath
	cd $argv
	set --local success $status
	set --erase CDPATH
	return $success
end

function cnew
	if not contains $PWD $cdpath
		set --universal --export --append cdpath "$PWD"
		echo "$PWD is successfully added to cdpath"
	else
		echo "$PWD is already in cdpath"
		return 1
	end
end

function clist
	echo "$cdpath"
end

function cdelete
	if set --local idx $(contains -i $PWD $cdpath)
		set --erase cdpath[$idx]
		echo "$PWD is successfully removed from cdpath"
	else
		echo 'pwd is not in cdpath'
		return 1
	end
end
