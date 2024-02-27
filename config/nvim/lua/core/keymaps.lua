local default_opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- remap , as leader key
keymap("", ",", "<Nop>", default_opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- toggle the quickfixlist
local toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

local mappings = {
  ["<s-tab>"] = { mode = "n", key = ":bprevious<cr>", opt = { desc = "cycle buffers (previous)"} },
  ["<tab>"] = { mode = "n", "<tab>", key = ":bnext<cr>", opt = { desc = "cycle buffers (next)" } },
  ["<leader>d"] = { mode = "n", key = ":bd<cr>", opt = { desc = "close current buffer"} },
  ["<c-q>"] = { mode = "n", key = toggle_qf, opt = { desc = "toggle quickfixlist"}},
  ["<c-j>"] = { mode = "n", key = ":cnext<cr>", { desc = "cycle qfix (next)"} },
  ["<c-k>"] = { mode = "n", key = ":cprevious<cr>", { desc = "cycle qfix (previous)"} },
  ["]q"] = { mode = "n", key = ":cnext<cr>", { desc = "cycle qfix (next)"} },
  ["[q"] = { mode = "n", key = ":cprevious<cr>", { desc = "cycle qfix (previous)"} },
  ["gf"] = { mode = "n", key = ":e <cfile><cr>", { desc = "cycle qfix (previous)"} },
  ["<esc>"] = { mode = "t", key = "<C-\\><C-n>", { desc = "leave insert mode" }},
  ["<leader>e"] = { mode = "n", key = ":lua vim.diagnostic.setqflist()<cr>", opt = { desc = "diagnostic to qfixlist" }}
}

for key, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, key, mapping.key, opt)
end

-- load history of a file in location list
-- keymap("n", "<leader>h", ":0Gllog!<cr>", opts)

-- keymap("n", "fff", ":lua vim.lsp.buf.format { async = false }<cr>", opts)

-- keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", opts)
-- keymap("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
-- keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<cr>", opts)
-- keymap("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<cr>", opts)



-- keymap("n", "<leader>e", ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR })<cr>", opts)

-- vim.keymap.set("n", "<c-j>", function()
--   vim.fn.setreg("+", require("jsonpath").get())
-- end, { desc = "copy json path", buffer = true })
