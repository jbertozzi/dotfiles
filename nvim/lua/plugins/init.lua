return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0" }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
    }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'neoclide/coc.nvim', branch = 'release'}
end)
