function po --description='copy password from password-store (OSC52 compatible)'
	command pass show -c "$argv"; and pbpaste | osc52
end
