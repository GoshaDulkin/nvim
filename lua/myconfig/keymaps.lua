vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>e", ":e<space>", opts)
keymap("n", "<leader>bd", ":bd<CR>", opts)

keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show line diagnostics" })

keymap("n", "<leader>r", function()
  vim.cmd("w")
  vim.cmd("!g++ % -o %< && %<")
end, { desc = "Compile and run current C++ file on Windows" })

keymap("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Copied path: " .. vim.fn.expand("%:p"))
end, { desc = "Copy file path to clipboard" })
