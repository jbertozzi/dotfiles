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
-- keymap("n", "yy", '"+yy', opts)
-- keymap("v", "yy", '"+yy', opts)

-- populacte loclist from diagnostics
keymap("n", "<leader>?", ":lua vim.diagnostic.setloclist()<cr>", opts)

-- populate quickfix list from gitsigns
-- keymap("n", "<leader>q", gs.setqflist(target=0, opts = {open = false}<cr>, opts)
keymap("n", "<leader>q", ":lopen<cr>", opts)
keymap("n", "<leader>Q", ":lclose<cr>", opts)
keymap("n", "<c-n>", ":lnext<cr>", opts)
keymap("n", "<c-p>", ":lprevious<cr>", opts)

-- load history of a file in location list
keymap("n", "<leader>h", ":0Gllog!<cr>", opts)

-- gf create the file under the cursor if it doesn't exist
keymap("n", "gf", ":e <cfile><cr>", opts)

-- format file using null-ls
-- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, { desc = "Format file with LSP" })
keymap("n", "fff", ":lua vim.lsp.buf.format { async = false }<cr>", opts)