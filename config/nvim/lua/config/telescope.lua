local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local default_opts = { noremap = true, silent = true }

local mappings = {
  {"<leader>ff", builtin.find_files, mode = "n", opt = { desc = "find files"} },
  {"<leader>fr", "<cmd>Telescope oldfiles<cr>", mode = "n", opt = { desc = "recent file" }},
  {"<leader>fg", builtin.live_grep, mode = "n", opt = { desc = "grep files"} },
  {"<leader>fb", builtin.live_grep, mode = "n", opt = { desc = "find buffers"} },
  {"<leader>fh", builtin.help_tags, mode = "n", opt = { desc = "help tags"} },
  {"<leader>fy", "<cmd>Telescope yaml_schema<cr>", mode = "n", opt = { desc = "set yaml schema"} },
  {"<c-p>", "<cmd>Telescope workspaces<cr>", mode = "n", opt = { desc = "help tags"} },
}

for _, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, mapping[1], mapping[2], opt)
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

