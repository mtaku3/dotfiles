local M = {}

M.formatter = {
	formatCommand = "eslint_d --fix-to-stdout --stdin-filename '${INPUT}' --stdin",
	formatStdin = true,
	rootMarkers = {
		".eslintrc",
		".eslintrc.cjs",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"package.json",
	},
}

M.linter = {
	prefix = "eslint_d",
	lintSource = "efm/eslint_d",
	lintCommand = "eslint_d --no-color --format visualstudio --stdin-filename '${INPUT}' --stdin",
	lintStdin = true,
	lintFormats = { "%f(%l,%c): %trror %m", "%f(%l,%c): %tarning %m" },
	lintIgnoreExitCode = true,
	rootMarkers = {
		".eslintrc",
		".eslintrc.cjs",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"package.json",
	},
}

return M
