return {
  {
    "mhartington/formatter.nvim",
    config = function(_, opts)
      require("formatter").setup({
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
      })
      vim.keymap.set("n", "<leader>f", ":Format<CR>", { desc = "Format current buffer" })
    end,
  },
}
