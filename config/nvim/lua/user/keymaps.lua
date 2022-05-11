local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
-- remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- next buffer
keymap("n", "<tab>", ":bnext<cr>", opts) 
-- previous buffer
keymap("n", "<s-tab>", ":bprevious<cr>", opts)
-- close buffer
keymap("n", "<leader>d", ":bd<cr>", opts)
-- populate quickfix list from gitsigns
-- keymap("n", "<leader>q", gs.setqflist(target=0, opts = {open = false}<cr>, opts)
