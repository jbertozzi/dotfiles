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

-- check if terminal already exists
local function has_terminal()
  for _, buf in ipairs(vim.fn.getbufinfo({buflisted = 1})) do
    if vim.fn.getbufvar(buf.bufnr, "&buftype") == "terminal" then
      return true
    end
  end
  return false
end

local function toggle_term()
  vim.print("toggle_term")
  if not has_terminal() then
    local buf = vim.api.nvim_create_buf(true, true)
    _G.terminal = buf
    vim.api.nvim_set_current_buf(buf)
    vim.cmd("terminal")
    vim.api.nvim_feedkeys('i', 'n', false)
  else
    vim.api.nvim_set_current_buf(_G.terminal)
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
  ["<leader>e"] = { mode = "n", key = ":lua vim.diagnostic.setqflist()<cr>", opt = { desc = "diagnostic to qfixlist" }},
  ["<leader>h"] = { mode = "n", key = ":0Gclog!<cr>", opt = { desc = "current buffer git history in qfixlist" }},
  ["<leader>g"] = { mode = "n", key = ":Gclog<cr>", opt = { desc = "commit history in qfixlist" }},
  ["<leader>?"] = { mode = "n", key = ":WhichKey<cr>", opt = { desc = "display WhichKey" }},
  ["<c-t>"] = { mode = {"n", "v", "t", "i"}, key = toggle_term, opt = { desc = "display WhichKey" }},
  ["<a-h>"] = {mode = {"t", "i"}, key = "<c-\\><c-n><c-w>h", opt = { desc = "navigate window left"}},
  ["<a-j>"] = {mode = {"t", "i"}, key = "<c-\\><c-n><c-w>j", opt = { desc = "navigate window down"}},
  ["<a-k>"] = {mode = {"t", "i"}, key = "<c-\\><c-n><c-w>k", opt = { desc = "navigate window up"}},
  ["<a-l>"] = {mode = {"t", "i"}, key = "<c-\\><c-n><c-w>l", opt = { desc = "navigate window right"}},
  ["<a-h>"] = {mode = {"n"}, key = "<c-w>h", opt = { desc = "navigate window left"}},
  ["<a-j>"] = {mode = {"n"}, key = "<c-w>j", opt = { desc = "navigate window down"}},
  ["<a-k>"] = {mode = {"n"}, key = "<c-w>k", opt = { desc = "navigate window up"}},
  ["<a-l>"] = {mode = {"n"}, key = "<c-w>l", opt = { desc = "navigate window right"}}
}

for key, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, key, mapping.key, opt)
end

-- keymap("n", "fff", ":lua vim.lsp.buf.format { async = false }<cr>", opts)

-- keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", opts)
-- keymap("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
-- keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<cr>", opts)
-- keymap("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<cr>", opts)

-- keymap("n", "<leader>e", ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR })<cr>", opts)

-- vim.keymap.set("n", "<c-j>", function()
--   vim.fn.setreg("+", require("jsonpath").get())
-- end, { desc = "copy json path", buffer = true })
