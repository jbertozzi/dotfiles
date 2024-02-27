local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local default_opts = { noremap = true, silent = true }

local mappings = {
  ["<leader>ff"] = { mode = "n", key = builtin.find_files, opt = { desc = "find files"} },
  ["<leader>fg"] = { mode = "n", key = builtin.live_grep, opt = { desc = "grep files"} },
  ["<leader>fb"] = { mode = "n", key = builtin.live_grep, opt = { desc = "find buffers"} },
  ["<leader>fh"] = { mode = "n", key = builtin.help_tags, opt = { desc = "help tags"} },
  ["<c-p>"] = { mode = "n", key = "<cmd>Telescope workspaces<cr>", opt = { desc = "help tags"} },
}

for key, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, key, mapping.key, opt)
end

telescope.load_extension('fzf')

telescope.setup {
  extensions = {
    workspaces = {
      keep_insert = true,
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },

  pickers = {
    find_files = {
      find_command = {
        'fd',
        '--type',
        'f',
        '--color=never',
        '--hidden',
        '--follow',
        '-E',
        '.git/*'
      },
    },
  },

  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '-u'
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-a>"] = actions.select_all,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },
    },
  },
}

