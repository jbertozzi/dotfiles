local ls = require("luasnip")

vim.keymap.set({"i", "s"}, "<c-s>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
-- 
-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "# hell yeah")
  },
  python = {
    ls.parser.parse_snippet("expand", "# hell yeah")
  }
}
