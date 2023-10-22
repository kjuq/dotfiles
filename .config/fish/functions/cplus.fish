function cplus --description='compile and execute a cpp file'
	set --local output "/tmp/cplus_output"

	command g++ -std=c++20 \
	            -Wall \
	            -Wextra \
	            -Wno-unused-const-variable \
	            -fsanitize=address \
	            -D_GLIBCXX_DEBUG \
	            -I/opt/homebrew/include/ \
	            -o "$output" \
	            "$argv"

	if [ $status = 0 ]
		"$output"
	end
end
