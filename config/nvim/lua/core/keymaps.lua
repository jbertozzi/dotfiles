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
  if not has_terminal() then
    _G.previous_buffer = vim.api.nvim_get_current_buf()
    local buf = vim.api.nvim_create_buf(true, true)
    _G.terminal = buf
    vim.api.nvim_set_current_buf(buf)
    vim.cmd("terminal")
    vim.api.nvim_feedkeys('i', 'n', false)
  else
    if vim.api.nvim_get_current_buf() == _G.terminal then
      vim.api.nvim_set_current_buf(_G.previous_buffer)
    else
      _G.previous_buffer = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_current_buf(_G.terminal)
      vim.api.nvim_feedkeys('i', 'n', false)
    end
  end
end

local function execute_selection()
  -- fetch start/end position of visual selection
  local v_start = vim.fn.getpos("v")
  local v_end = vim.fn.getpos(".")
  if v_start[2] == v_end[2] then
    local n = v_start[2]
    local line = vim.fn.getline(n)
    local selection = string.sub(line, v_start[3], v_end[3])
    local result = vim.fn.system(selection)
    if vim.v.shell_error ~= 0 then
      print("Error while executing command: " .. result)
    else
      vim.fn.setreg('"', result)
      -- leave visual mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      -- go back to inital position
      vim.fn.setpos('.', v_start)
    end
  end
end

local mappings = {
  {"<s-tab>", ":bprevious<cr>", mode = "n", opt = { desc = "cycle buffers (previous)"} },
  {"<tab>", ":bnext<cr>",mode = "n", "<tab>", opt = { desc = "cycle buffers (next)" } },
  {"<leader>d", ":bd<cr>",mode = "n", opt = { desc = "close current buffer"} },
  {"<c-q>", toggle_qf,mode = "n", opt = { desc = "toggle quickfixlist"}},
  {"<c-j>", ":cnext<cr>",mode = "n", { desc = "cycle qfix (next)"} },
  {"<c-k>", ":cprevious<cr>",mode = "n", { desc = "cycle qfix (previous)"} },
  {"]q", ":cnext<cr>",mode = "n", { desc = "cycle qfix (next)"} },
  {"[q", ":cprevious<cr>",mode = "n", { desc = "cycle qfix (previous)"} },
  {"gf", ":e <cfile><cr>",mode = "n", { desc = "cycle qfix (previous)"} },
  {"<esc>", "<C-\\><C-n>",mode = "t", { desc = "leave insert mode" }},
  {"<leader>e", ":lua vim.diagnostic.setqflist()<cr>",mode = "n", opt = { desc = "diagnostic to qfixlist" }},
  {"<leader>h", ":0Gclog!<cr>",mode = "n", opt = { desc = "git commit history for % in qfixlist" }},
  {"<leader>g", ":Gclog<cr>",mode = "n", opt = { desc = "commit history in qfixlist" }},
  {"<leader>?", ":WhichKey<cr>",mode = "n", opt = { desc = "display WhichKey" }},
  {"<c-t>", toggle_term,mode = {"n", "v", "t", "i"}, opt = { desc = "display WhichKey" }},
  {"<c-x>", execute_selection,mode = { "v" }, opt = { desc = "execute visually selected text" }},
  {"p", require('pasta.mapping').p, mode = {'n', 'x'}, opt = { desc = "smarter p"} },
  {"P", require('pasta.mapping').P, mode = {'n', 'x'}, opt = { desc = "smarter P"} },
  {"<leader>k", ":lua require('kubectl').toggle()<cr>", mode ='n', opt = { desc = "kubectl"} },
}

for _, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, mapping[1], mapping[2], opt)
end

-- keymap("n", "fff", ":lua vim.lsp.buf.format { async = false }<cr>", opts)
-- keymap("n", "<leader>e", ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR })<cr>", opts)

-- vim.keymap.set("n", "<c-j>", function()
--   vim.fn.setreg("+", require("jsonpath").get())
-- end, { desc = "copy json path", buffer = true })
--
