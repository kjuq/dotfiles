function cplus --description="compile and execute a cpp file"
	set --local output "/tmp/cplus_output"

	command g++ \
		-std=c++20 \
		-Wall \
		-Wextra \
		# Detect memory-related diagnostics
		-fsanitize=address \
		# GNU's libstdc++ debug mode
		-D_GLIBCXX_DEBUG \
		# Clang's libc++ debug mode
		-D_LIBCPP_ENABLE_DEBUG_MODE \
		-I"$HOMEBREW_PREFIX/include/" \
		-o "$output" \
		"$argv"

	if [ $status = 0 ]
		"$output"
	end
end
