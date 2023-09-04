local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

local plugins = {

  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins

  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter

  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",

  -- colorscheme
--  'sainnhe/everforest'
  "EdenEast/nightfox.nvim",

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Treesitter
  'nvim-treesitter/nvim-treesitter'
  'nvim-treesitter/nvim-treesitter-context'

  -- Telescope
  'nvim-telescope/telescope.nvim'
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP
  "neovim/nvim-lspconfig",
  'williamboman/mason.nvim'
  'williamboman/mason-lspconfig.nvim'

  -- vimwikki
  'vimwiki/vimwiki'

  -- vim-fugitive
  'tpope/vim-fugitive'

  -- vim-go
  'fatih/vim-go'

  -- git
  "lewis6991/gitsigns.nvim",

  -- quick-scope
  'unblevable/quick-scope',

  -- which-key
  'folke/which-key.nvim',

  -- null-ls
  "jose-elias-alvarez/null-ls.nvim",

  -- ansible-vault helper
  'arouene/vim-ansible-vault',

  -- decrypt gpg encrytped file on the fly
  'jamessan/vim-gnupg',
  'gbprod/yanky.nvim'
}
