local M = {}

M.formatter = {
	formatCommand = "isort --quiet -",
	formatStdin = true,
	rootMarkers = {
		".isort.cfg",
		"pyproject.toml",
		"setup.cfg",
		"setup.py",
	},
}

return M
