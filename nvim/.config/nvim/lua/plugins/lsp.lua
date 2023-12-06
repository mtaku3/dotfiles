local efmTools = {
	stylua = {
		formatCanRange = true,
		formatCommand = "stylua --color Never ${--range-start:charStart} ${--range-end:charEnd} -",
		formatStdin = true,
		rootMarkers = { "stylua.toml", ".stylua.toml" },
	},
	isort = {
		formatCommand = "isort --quiet -",
		formatStdin = true,
		rootMarkers = {
			".isort.cfg",
			"pyproject.toml",
			"setup.cfg",
			"setup.py",
		},
	},
	black = {
		formatCommand = "black --no-color -q -",
		formatStdin = true,
	},
	prettierd = {
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
	},
	eslint_d = {
		formatCommand = "eslint_d --fix-to-stdout --stdin-filename '${INPUT}' --stdin",
		formatStdin = true,
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
	},
}
local efmLanguages = {
	lua = { efmTools["stylua"] },
	python = { efmTools["isort"], efmTools["black"] },
	javascript = { efmTools["eslint_d"], efmTools["prettierd"] },
	javascriptreact = { efmTools["eslint_d"], efmTools["prettierd"] },
	["javascript.jsx"] = { efmTools["eslint_d"], efmTools["prettierd"] },
	typescript = { efmTools["eslint_d"], efmTools["prettierd"] },
	typescriptreact = { efmTools["eslint_d"], efmTools["prettierd"] },
	["typescript.tsx"] = { efmTools["eslint_d"], efmTools["prettierd"] },
	json = { efmTools["prettierd"] },
}

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
						efm = {
							init_options = {
								documentFormatting = true,
								documentRangeFormatting = true,
								hover = false,
								documentSymbol = false,
								codeAction = true,
								completion = false,
							},
							filetypes = vim.tbl_keys(efmLanguages),
							servers = {
								languages = efmLanguages,
							},
						},
						lua_ls = {
							servers = {
								Lua = {
									workspace = { checkThirdParty = false },
									telemetry = { enable = false },
								},
							},
						},
						pylsp = {
							servers = {
								plugins = {
									autopep8 = { enabled = false },
									flake8 = { enabled = true },
									yapf = { enabled = false },
								},
							},
						},
						texlab = {},
						tsserver = {},
					},
					on_attach = function(_, bufnr)
						local nmap = function(keys, func, desc)
							if desc then
								desc = "LSP: " .. desc
							end

							vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
						end
						local telescope = require("telescope.builtin")

						nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
						nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

						nmap("gd", telescope.lsp_definitions, "Goto Definition")
						nmap("gr", telescope.lsp_references, "Goto References")
						nmap("gI", telescope.lsp_implementations, "Goto Implementation")
						nmap("<leader>D", telescope.lsp_type_definitions, "Type Definition")
						nmap("<leader>ds", telescope.lsp_document_symbols, "Document Symbols")
						nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")

						nmap("K", vim.lsp.buf.hover, "Hover Documentation")
						nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

						nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
						nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
						nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
						nmap("<leader>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, "Workspace List Folders")

						nmap("<leader>f", function()
							vim.lsp.buf.format({ name = "efm" })
						end, "Format current buffer with LSP")
					end,
				},
				config = function(_, opts)
					local manson_lspconfig = require("mason-lspconfig")

					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
					manson_lspconfig.setup({ ensure_installed = vim.tbl_keys(opts.servers) })
					manson_lspconfig.setup_handlers({
						function(server_name)
							require("lspconfig")[server_name].setup({
								init_options = (opts.servers[server_name] or {}).init_options,
								capabilities = opts.capabilities,
								on_attach = opts.on_attach,
								settings = (opts.servers[server_name] or {}).servers,
								filetypes = (opts.servers[server_name] or {}).filetypes,
							})
						end,
					})
				end,
			},
		},
	},
}
