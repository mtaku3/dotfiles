return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					python = {
						require("formatter.filetypes.python").isort,
						require("formatter.filetypes.python").black,
					},
					javascript = {
						require("formatter.filetypes.javascript").biome,
					},
					javascriptreact = {
						require("formatter.filetypes.javascriptreact").biome,
					},
					typescript = {
						require("formatter.filetypes.typescript").biome,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").biome,
					},
					json = {
						require("formatter.filetypes.json").biome,
					},
				},
			})
			vim.keymap.set("n", "<leader>f", ":Format<CR>", { desc = "Format current buffer" })
		end,
	},
}
