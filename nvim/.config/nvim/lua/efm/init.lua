local M = {}

local default_settings = {
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = false,
		documentSymbol = false,
		codeAction = true,
		completion = false,
	},
	settings = {
		languages = {
			lua = { require("efm.settings.stylua").formatter },
			python = { require("efm.settings.isort").formatter, require("efm.settings.black").formatter },
			rust = { require("efm.settings.rustfmt").formatter },
			javascript = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			javascriptreact = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			["javascript.jsx"] = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			typescript = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			typescriptreact = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			["typescript.tsx"] = {
				require("efm.settings.eslint_d").linter,
				require("efm.settings.eslint_d").formatter,
				require("efm.settings.prettierd").formatter,
			},
			yaml = { require("efm.settings.prettierd").formatter },
		},
	},
}

function M.setup(languages, other_settings)
	local settings = vim.tbl_deep_extend(
		"keep",
		languages and { settings = { languages = languages } } or {},
		other_settings or {},
		default_settings
	)
	require("plugins.lsp.utils").setup("efm", settings)
end

return M
