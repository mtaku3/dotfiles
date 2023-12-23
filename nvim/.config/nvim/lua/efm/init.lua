local M = {}

local config = {
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = false,
		documentSymbol = false,
		codeAction = true,
		completion = false,
	},
}

function M.setup(languages, other_settings)
	settings = vim.tbl_extend("error", { settings = { languages = languages } }, other_settings or {}, config)
	require("plugins.lsp.utils").setup("efm", settings)
end

return M
