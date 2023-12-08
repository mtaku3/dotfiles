local M = {}

M.formatter = {
	formatCanRange = true,
	formatCommand = "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize} ${--use-tabs=!insertSpaces}",
	formatStdin = true,
	rootMarkers = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.mjs",
		".prettierrc.cjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	},
}

return M
