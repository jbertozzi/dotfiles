return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0" }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
    }
end)
