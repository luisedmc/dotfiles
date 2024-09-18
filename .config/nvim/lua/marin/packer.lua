vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
 
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Themes
  use 'datsfilipe/vesper.nvim'

  -- Treesitter
  use ( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'} )

  -- Toggleterm
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	  require("toggleterm").setup()
  end}

  -- Undotree
  use 'mbbill/undotree'

  -- Vim Fugitive
  use 'tpope/vim-fugitive'

  use 'NvChad/nvim-colorizer.lua'

  use {
	  "windwp/nvim-autopairs",
	  event = "InsertEnter",
	  config = function()
		  require("nvim-autopairs").setup {}
	  end
  }

  -- LSP
  use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
  use({'neovim/nvim-lspconfig'})
  use({'hrsh7th/nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp'})

end)
