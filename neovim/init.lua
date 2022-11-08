vim.opt.number = true
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("morhetz/gruvbox")
  vim.cmd([[colorscheme gruvbox]])
  use("nvim-treesitter/nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "rust" },
    highlight = {
      enable = true,
    },
  })
  use("nvim-lualine/lualine.nvim")
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
    },
  })
  use("junegunn/fzf")
  use("junegunn/fzf.vim")
end)
vim.opt.list = true
vim.opt.listchars:append("tab:> ")
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.swapfile = false
