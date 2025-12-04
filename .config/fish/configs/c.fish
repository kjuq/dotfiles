function c
	set --export CDPATH $bmpath
	cd $argv
	set --local success $status
	set --erase CDPATH
	return $success
end

function cnew
	if not contains $PWD $bmpath
		set --universal --export --append bmpath "$PWD"
		echo "$PWD is successfully added to bmpath"
	else
		echo "$PWD is already in bmpath"
		return 1
	end
end

function clist
	echo "$bmpath"
end

function cdelete
	if set --local idx $(contains -i $PWD $bmpath)
		set --erase bmpath[$idx]
		echo "$PWD is successfully removed from bmpath"
	else
		echo 'pwd is not in bmpath'
		return 1
	end
end
