return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			use_default_mappings = false,
			window = {
				position = "current",
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					-- ["<leader>"] = {
					-- 	"toggle_node",
					-- 	nowait = true,
					-- },
					["<CR>"] = "open",
					-- ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["a"] = {
						"add",
						config = {
							show_path = "none",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.keymap.set("n", "<leader>e", ":Neotree reveal<CR>", { desc = "Toggle file explorer" })
		end,
	},
}
