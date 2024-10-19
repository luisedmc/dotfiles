vim.loader.enable()
require("core")
require("plugs")

-- Lazy.nvim setup
require("lazy").setup({
	{
		'goolord/alpha-nvim',
		dependencies = {
			'echasnovski/mini.icons',
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require 'alpha'.setup(require 'alpha.themes.theta'.config)
		end
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		priority = 999,
	},
	{
		"kdheepak/monochrome.nvim",
		priority = 1000,
	},
	{
		"sxhk0/zhxo.nvim"
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ mode = "n", "<C-/>", "<Plug>(comment_toggle_linewise_current)",      desc = "Toggle Comment" },
			{ mode = "i", "<C-/>", "<esc><Plug>(comment_toggle_linewise_current)", desc = "Toggle Comment(Insert)" },
			{ mode = "v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)",       desc = "Toggle Comment(Visual)" },
		},
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require('nvim-treesitter').setup({
				ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", },
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = { { mode = { "n", "v" }, "<C-e>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{
				mode = { "n", "t", "v" },
				[[<C-`>]],
				"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
				{ desc = "Toggle Terminal" },
			},
		},
		version = "*",
		opts = {
			shading_factor = 0.2,
			highlights = { NormalFloat = { link = "NormalFloat" } },
			float_opts = { border = "none" },
		},
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {
				options = {
					close_command = "bp|sp|bn|bd! %d",
					right_mouse_command = "bp|sp|bn|bd! %d",
					left_mouse_command = "buffer %d",
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "󰅖",
					show_close_icon = false,
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 14,
					max_prefix_length = 13,
					tab_size = 10,
					show_tab_indicators = true,
					indicator = {
						style = "underline",
					},
					enforce_regular_tabs = false,
					view = "multiwindow",
					show_buffer_close_icons = true,
					separator_style = "thin",
					always_show_bufferline = true,
					diagnostics = false,
					themable = true,
				},
			}

			-- Buffers belong to tabs
			local cache = {}
			local last_tab = 0

			local utils = {}

			utils.is_valid = function(buf_num)
				if not buf_num or buf_num < 1 then return false end
				local exists = vim.api.nvim_buf_is_valid(buf_num)
				return vim.bo[buf_num].buflisted and exists
			end

			utils.get_valid_buffers = function()
				local buf_nums = vim.api.nvim_list_bufs()
				local ids = {}
				for _, buf in ipairs(buf_nums) do
					if utils.is_valid(buf) then ids[#ids + 1] = buf end
				end
				return ids
			end

			local autocmd = vim.api.nvim_create_autocmd

			autocmd("TabEnter", {
				callback = function()
					local tab = vim.api.nvim_get_current_tabpage()
					local buf_nums = cache[tab]
					if buf_nums then
						for _, k in pairs(buf_nums) do
							vim.api.nvim_buf_set_option(k, "buflisted", true)
						end
					end
				end,
			})
			autocmd("TabLeave", {
				callback = function()
					local tab = vim.api.nvim_get_current_tabpage()
					local buf_nums = utils.get_valid_buffers()
					cache[tab] = buf_nums
					for _, k in pairs(buf_nums) do
						vim.api.nvim_buf_set_option(k, "buflisted", false)
					end
					last_tab = tab
				end,
			})
			autocmd("TabClosed", { callback = function() cache[last_tab] = nil end })
			autocmd("TabNewEntered", { callback = function() vim.api.nvim_buf_set_option(0, "buflisted", true) end })
		end,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp"
	},
	{
		"hrsh7th/nvim-cmp",
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' }, -- LSP source
			{ 'hrsh7th/cmp-buffer' }, -- Buffer source
			{ 'hrsh7th/cmp-path' },  -- Path source
			{ 'L3MON4D3/LuaSnip' },  -- luasnip
		},
		config = function()
			require('cmp').setup({
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'cmp_snippet' },
					{ name = 'cmp_treesitter' },
					{ name = 'luasnip' },
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = require('cmp').mapping.preset.insert({
					['<C-b>'] = require('cmp').mapping.scroll_docs(-4),
					['<C-f>'] = require('cmp').mapping.scroll_docs(4),
					['<C-Space>'] = require('cmp').mapping.complete(),
					['<C-e>'] = require('cmp').mapping.abort(),
					['<CR>'] = require('cmp').mapping.confirm({ select = true }),
				})
			})
		end,
	},
	{
		'neovim/nvim-lspconfig',
		requires = {
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
		},
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		requires = {
			{ 'hrsh7th/nvim-cmp' },
		},
	},
})

-- Colorscheme
vim.cmd.colorscheme("zhxo")
-- vim.cmd.colorscheme("monochrome")

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {}
	end,
}

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Automatically show diagnostics when in normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { 'n:*', '*:n' },
	callback = function()
		if vim.fn.mode() == "n" then
			vim.diagnostic.show()
		end
	end,
})

-- Setup language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Apply transparent settings
require("transparent").setup({
	groups = {
		"Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
		"Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
		"Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
		"SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
		"EndOfBuffer",
	},
	extra_groups = { "NormalFloat", "NvimTreeNormal" },
	exclude_groups = {},
})
require("transparent").clear_prefix("NvimTreeNormal")

require('lualine').setup()

require('illuminate').configure({
	providers = {
		'lsp',
		'treesitter',
		'regex',
	},
	delay = 100,
	filetype_overrides = {},
	filetypes_denylist = {
		'dirbuf',
		'dirvish',
		'fugitive',
	},
	filetypes_allowlist = {},
	modes_denylist = {},
	modes_allowlist = {},
	providers_regex_syntax_denylist = {},
	providers_regex_syntax_allowlist = {},
	under_cursor = true,
	large_file_cutoff = nil,
	large_file_overrides = nil,
	min_count_to_highlight = 1,
	should_enable = function(bufnr) return true end,
	case_insensitive_regex = false,
})

-- Telescope:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
