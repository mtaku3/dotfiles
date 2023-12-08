local M = {}

M.formatter = {
	formatCanRange = true,
	formatCommand = "stylua --color Never ${--range-start:charStart} ${--range-end:charEnd} -",
	formatStdin = true,
	rootMarkers = { "stylua.toml", ".stylua.toml" },
}

return M
