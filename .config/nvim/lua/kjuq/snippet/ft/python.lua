local M = {}

M.snippets = {
	ifmain = {
		[[if __name__ == '__main__':]],
		[[	main()]],
	},
	ifmainExit = {
		[[if __name__ != '__main__':]],
		[[	exit()]],
	},
	traverse = {
		[[import os]],
		[[from typing import Generator]],
		[[]],
		[[def traverse_dir(path: str) -> Generator[str, None, None]:]],
		[[	expanded_path = os.path.expanduser(path)]],
		[[	for dirpath, _, filenames in os.walk(expanded_path):]],
		[[		for filename in filenames:]],
		[[			yield os.path.join(dirpath, filename)]],
	},
	debug = {
		[[import logging]],
		[[logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(message)s')]],
		[[logging.debug('MESSAGE')]],
	},
	graph = {
		[[import matplotlib.pyplot as plt]],
		[[import numpy as np]],
		[[]],
		[[x = np.linspace(-10, 10, 400)  # range of x]],
		[[y = ${1:x**2}]],
		[[]],
		[[plt.plot(x, y)]],
		[[]],
		[[plt.title('Graph of y = f(x)')]],
		[[plt.xlabel('x')]],
		[[plt.ylabel('y')]],
		[[]],
		[[plt.show()]],
	},
	execSync = {
		[=[cmd: list[str] = ['echo', 'hello']]=],
		[[result = subprocess.run(cmd, capture_output=True, text=True)]],
		[[print(result.stdout)]],
		[[if result.stderr:]],
		[[	print('Error:', result.stderr)]],
	},
	dependencies = {
		[=[# /// script]=],
		[=[# dependencies = []=],
		[=[# 	'matplotlib',]=],
		[=[# ]]=],
		[=[# ///]=],
	},
}

return M
