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

function M.setup(settings)
	require("plugins.lsp.utils").setup("efm", vim.tbl_extend("error", config, settings))
end

return M
