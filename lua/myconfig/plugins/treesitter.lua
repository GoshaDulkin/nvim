return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python","c", "go" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}

