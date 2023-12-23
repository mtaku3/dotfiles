return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					{ "williamboman/mason.nvim", config = true },
					"creativenull/efmls-configs-nvim",
					"hrsh7th/nvim-cmp",
					"nvim-telescope/telescope.nvim",
				},
				opts = {
					servers = {
						lua_ls = {
							settings = {
								Lua = {
									workspace = { checkThirdParty = false },
									telemetry = { enable = false },
								},
							},
						},
						pylsp = {
							settings = {
								plugins = {
									autopep8 = { enabled = false },
									flake8 = { enabled = true },
									yapf = { enabled = false },
								},
							},
						},
						texlab = {},
						tsserver = {},
						grammarly = {
							autostart = false,
							filetypes = { "Markdown", "Text", "tex" },
						},
						solargraph = {},
						tailwindcss = {},
						rust_analyzer = {
							settings = {
								["rust-analyzer"] = {
									check = {
										command = "clippy",
									},
								},
							},
						},
					},
				},
				config = function(_, opts)
					local mason_lspconfig = require("mason-lspconfig")

					mason_lspconfig.setup({ ensure_installed = vim.list_extend({ "efm" }, vim.tbl_keys(opts.servers)) })
					require("efm").setup()
					for name, config in pairs(opts.servers) do
						require("plugins.lsp.utils").setup(name, config)
					end
				end,
			},
		},
	},
}
