return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  "gbprod/yanky.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",    -- The completion plugin
  "hrsh7th/cmp-buffer",  -- buffer completions
  "hrsh7th/cmp-path",    -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "L3MON4D3/LuaSnip",
  "arouene/vim-ansible-vault",
  "ahmedkhalf/project.nvim",
  "ThePrimeagen/harpoon",
  "jamessan/vim-gnupg",
  "vimwiki/vimwiki",
  "karb94/neoscroll.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  "phelipetls/jsonpath.nvim",
  "sindrets/diffview.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  "natecraddock/workspaces.nvim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "lewis6991/gitsigns.nvim"
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
}
