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
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic", -- or "strict" if you want more
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,
      },
    },
  },

  -- Extra LSP behavior (formatting, etc.)
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable inlay hints per buffer when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end,
      })

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
          -- Save cursor/view position
          local view = vim.fn.winsaveview()

          -- Format buffer using Black via stdin
          vim.cmd("%!black -q -")

          -- Restore cursor/view
          vim.fn.winrestview(view)
        end,
    })
    end,
  },
}
