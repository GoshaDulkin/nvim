vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>e", ":e", opts)

keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

