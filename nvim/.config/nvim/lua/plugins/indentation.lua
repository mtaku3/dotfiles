return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"Darazaki/indent-o-matic",
		opts = {
			max_lines = 2048,
			standard_widths = { 2, 4, 8 },

			-- Don't detect 8 spaces indentations inside files without a filetype
			filetype_ = {
				standard_widths = { 2, 4 },
			},
		},
	},
}
