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
				},
			})
			vim.keymap.set("n", "<leader>f", ":Format<CR>", { desc = "Format current buffer" })
		end,
	},
}
