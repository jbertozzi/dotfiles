require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}
if vim.fn.exists("+winbar") == 1 then
  vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
end

