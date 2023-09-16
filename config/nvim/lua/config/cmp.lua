local cmp = require("cmp")
local luasnip = require("luasnip")
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
    ['<C-k>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
    --["<C-k>"] = cmp.mapping.select_prev_item(),
    --["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
    --['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ['<Esc>'] =
    function(fallback)
      cmp.mapping.abort()
      fallback()
    end,
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
    --   -- they way you will only jump inside the snippet region
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    --['<CR>'] = cmp.mapping({
    --        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    --        c = function(fallback)
    --            if cmp.visible() then
    --                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    --            else
    --                fallback()
    --            end
    --        end
    --    }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline({ '/', '?' }, {
--  -- mapping = cmp.mapping.preset.cmdline(),
--  mapping = cmp.mapping.preset.insert({
--    ["<C-k>"] = cmp.mapping.select_prev_item(),
--    ["<C-j>"] = cmp.mapping.select_next_item(),
--    --['<CR>'] = cmp.mapping.confirm({ select = true }),
--    ['<Esc>'] =
--    function(fallback)
--      cmp.mapping.abort()
--      fallback()
--    end,
--  }),
--  sources = {
--    { name = 'buffer' }
--  }
--})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
 --cmp.setup.cmdline(':', {
 --  mapping = cmp.mapping.preset.insert({
 --    ["<C-k>"] = cmp.mapping.select_prev_item(),
 --    ["<C-j>"] = cmp.mapping.select_next_item(),
 --    ['<CR>'] = cmp.mapping.confirm({ select = true }),
 --  }),
 --  sources = cmp.config.sources({
 --    { name = 'path' }
 --  }, {
 --    { name = 'cmdline' }
 --  })
 --})
