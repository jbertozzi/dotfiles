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
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/nvim-pasta",
  "L3MON4D3/LuaSnip",
  "arouene/vim-ansible-vault",
  "ahmedkhalf/project.nvim",
  "jamessan/vim-gnupg",
  "vimwiki/vimwiki",
  "karb94/neoscroll.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "phelipetls/jsonpath.nvim",
  "sindrets/diffview.nvim",
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
  "ray-x/go.nvim",
  "theHamsta/nvim-dap-virtual-text",
  "ramilito/kubectl.nvim",
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
     "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
  },
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
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "serenevoid/kiwi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {
      {
        name = "doc",
        path = "~/doc"
      }
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "T", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
    },
    lazy = true
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  {
    "jbertozzi/neovault",
    branch = "master"
    -- cmd = "VaultExpolorer",
    -- dir = "~/dev/github.com/neovault",
    -- dev = true,
  }
}
