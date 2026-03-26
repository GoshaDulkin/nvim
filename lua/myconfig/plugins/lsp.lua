return {
  -- Mason package manager
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- Mason ↔ LSP bridge
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "gopls", "pyright" },
      handlers = {
        -- Default handler (runs for every server)
        function(server_name)
          local lspconfig = require("lspconfig")
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- ------------------- Go -------------------
        gopls = function()
          local lspconfig = require("lspconfig")
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                gofumpt = true,
                staticcheck = true,
                analyses = {
                  unusedparams = true,
                  shadow = true,
                },
              },
            },
          })
        end,

        -- ------------------- Python -------------------
        pyright = function()
          local lspconfig = require("lspconfig")
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          lspconfig.pyright.setup({
            capabilities = capabilities,
          })
        end,
      },
    },
  },

  -- Extra LSP behavior (formatting, etc.)
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Go: format via LSP
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Python: format via Black safely
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
          local filepath = vim.fn.expand("%:p")
          if filepath ~= "" and vim.fn.filereadable(filepath) == 1 then
            -- Run Black on the file
            vim.cmd("silent! !black " .. filepath)
            -- No edit! needed, buffer stays safe
          end
        end,
      })
    end,
  },
}
