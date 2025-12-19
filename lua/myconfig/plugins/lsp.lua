
return {
  -- Mason package manager
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  -- Mason LSP integration
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
  },
  -- LSP configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Default LSP capabilities (no cmp_nvim_lsp required)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- ------------------- Go -------------------
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt = true,      -- strict formatting
            staticcheck = true,  -- linting
            analyses = {
              unusedparams = true,
              shadow = true,
            },
          },
        },
      })

      -- ------------------- Python -------------------
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- ------------------- Auto-format on save -------------------

      -- Go files: use gopls
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Python files: use Black
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
          -- Run black on the current file
          vim.cmd("silent! !black %")
          vim.cmd("edit!")  -- reload file after formatting
        end,
      })
    end,
  },
}
