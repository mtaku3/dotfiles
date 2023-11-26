return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          { "williamboman/mason.nvim", config = true },
          "hrsh7th/nvim-cmp",
          "nvim-telescope/telescope.nvim",
        },
        opts = {
          servers = {
            lua_ls = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
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
            -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

            nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
            nmap("<leader>wl", function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "Workspace List Folders")

            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
              vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
          end
        },
        config = function(_, opts)
          local manson_lspconfig = require("mason-lspconfig")

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
          manson_lspconfig.setup({ ensure_installed = vim.tbl_keys(opts.servers) })
          manson_lspconfig.setup_handlers({
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
                settings = opts.servers[server_name],
                filetypes = (opts.servers[server_name] or {}).filetypes,
              })
            end,
          })
        end,
      },
    },
  },
}