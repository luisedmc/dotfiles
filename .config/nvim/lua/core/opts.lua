vim.loader.enable()
local options = {
	number = true,
	relativenumber = false,
	ruler = false,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	smartindent = true,
	smartcase = true,
	ignorecase = true,
	clipboard = "unnamedplus",
	undofile = true,
	swapfile = false,
	mouse = "a",
	cursorline = true,
	showmode = false,
	laststatus = 3,
	showtabline = 2,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 300,
	updatetime = 200,
	fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " },
	listchars = "tab:  ",
	background = "dark",
}

local globals = {
	mapleader = " ",
	maplocalleader = " ",
}

local builtins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"logipat",
	"matchit",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
	"archlinux",
	"fzf",
	"tutor_mode_plugin",
	"sleuth",
	"vimgrep",
}

-- Additional highlight settings
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- Buffer switching
for i = 1, 9 do
	vim.keymap.set('n', string.format('<C-%s>', i), function()
		require("bufferline").go_to_buffer(i, true)
	end, { desc = string.format("Go to buffer %d", i) })
end

-- Switch to last buffer
vim.keymap.set('n', '<C-0>', function()
	require("bufferline").go_to_buffer(-1, true)
end, { desc = "Go to last buffer" })

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
