local M = {}

M.formatter = {
	formatCommand = "rustfmt --emit=stdout",
	formatStdin = true,
	rootMarkers = {
		"Cargo.toml",
	},
}

return M
