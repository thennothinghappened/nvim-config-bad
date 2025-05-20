
-------------------------
-- Bootstrap lazy.nvim --
-------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-------------------------
---    LSP Config     ---
-------------------------

--- Bindings when there's an LSP attached.
local function lsp_on_attach(bufnr)

	local hover = vim.lsp.buf.hover
	vim.lsp.buf.hover = function()
		--- @diagnostic disable-next-line: redundant-parameter
		return hover({ border = 'single' })
	end

    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to Definition' })
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to Implementation' })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { buffer = bufnr, desc = 'Symbol References' })
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover symbol info' })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
    vim.keymap.set('n', '<leader>c', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename under cursor' })
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>[', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'Go to Next Diagnostic' })
    vim.keymap.set('n', '<leader>p', vim.diagnostic.open_float, { buffer = bufnr, desc = 'Show diagnistics for this line' })
    vim.keymap.set('n', '<leader>]', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'Go to Previous Diagnostic' })

end

local lsp_servers = {
	lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
		}
	},
	clangd = {},
	asm_lsp = {
		filetypes = {
			"nasm"
		},
	},
	bashls = {},
	ts_ls = {
		javascript = {
			implicitProjectConfig = {
				checkJs = true
			}
		}
	},
	jsonls = {},
	cmake = {}
}

local lsp_server_names = {}

for server_name, _ in pairs(lsp_servers) do
	table.insert(lsp_server_names, server_name)
end

-------------------------
---   Setup Plugins   ---
-------------------------
require('lazy').setup({
	
	--- Themes ---
	{
		'drewtempelmeyer/palenight.vim'
	},

	--- Language Support ---
	{
		'nvim-treesitter/nvim-treesitter',

		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		cmd = { 'TSUpdateSync' },

		config = function()

			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'lua', 'javascript', 'html', 'css', 'c', 'php'
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
	
			-- Prioritise Treesitter highlighting over LSP.
			vim.highlight.priorities.semantic_tokens = 99

		end
	},
	{
		'williamboman/mason.nvim',
		opts = {}
	},
	{
		'williamboman/mason-lspconfig.nvim',

		dependencies = { 'williamboman/mason.nvim' },

		opts = {
			ensure_installed = lsp_server_names,
			automatic_enable = false
		}
	},
	{
		'neovim/nvim-lspconfig',

		opts = {
			servers = lsp_servers
		},

		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'Saghen/blink.cmp'
		},

		config = function(_, opts)

			vim.diagnostic.config({
				update_in_insert = true
			})

			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require('lspconfig')

			for server, config in pairs(opts.servers) do

				local original_on_attach = config.on_attach
				config.on_attach = function(_, bufnr)

					lsp_on_attach(bufnr)

					if original_on_attach ~= nil then
						original_on_attach(server, bufnr)
					end

				end

				config.capabilities = capabilities
				lspconfig[server].setup(config)

			end

		end

	},
	{
		'xzbdmw/colorful-menu.nvim',
		opts = {},
		config = function()
			
		end
	},
	{
		'Saghen/blink.cmp',
		version = '1.*',
		dependencies = { 'xzbdmw/colorful-menu.nvim' },

		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'enter'
			},
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0
				},
			},
			sources = {}
		},

		config = function(_, opts)

			local colorfulMenu = require('colorful-menu')

			opts.completion.menu = {
				draw = {
					columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            	    components = {
            	        label = {
            	            text = colorfulMenu.blink_components_text,
            	            highlight = colorfulMenu.blink_components_highlight
            	        },
            	    },
				}
			}

			local comment_types = {
				'comment',
				'line_comment',
				'block_comment'
			}

			opts.sources.default = function(_)

				local success, node = pcall(vim.treesitter.get_node)
				if success and node then
					if vim.tbl_contains(comment_types, node:type()) then
						return { 'lsp' }
					end
				end

				return { 'lsp', 'snippets', 'path' }

			end

			require('blink.cmp').setup(opts)

		end
	},
	--- General Plugins ---
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',

		dependencies = {
			'nvim-lua/plenary.nvim',
			'BurntSushi/ripgrep',
			'nvim-treesitter/nvim-treesitter'
		},

		opts = {

			defaults = {
				mappings = {

				}
			},

			pickers = {

			}

		}
	}

})

-------------------------
---      Options      ---
-------------------------

vim.opt.background = 'dark'
vim.cmd.colorscheme('palenight')
vim.opt.termguicolors = true		-- True-colour.
vim.wo.number = true				-- Line numbers.
vim.wo.rnu = true					-- Relative line numbers.
vim.opt.colorcolumn = '80'			-- 80 char margin.
vim.go.scrolloff = 4				-- Autoscroll 4 lines before edge.
vim.o.expandtab = false				-- Indent with tabs.
vim.o.tabstop = 4					-- Tab stops (aligning tabs) char distance.
vim.o.shiftwidth = 4				-- Tab size.
vim.wo.wrap = false					-- Word wrap.
vim.go.clipboard = 'unnamedplus'	-- Use the system clipboard for yank.
vim.o.mouse = ''					-- Disable the mouse.
-- vim.go.mousescroll = 'ver:1,hor:1'	-- Mouse scroll speed.

-------------------------
---     Keybinds      ---
-------------------------

-- Use space as the leader key.
vim.g.mapleader = ' '

--- telescope.nvim ---
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>g', telescope_builtin.live_grep, {})

-- Escape terminal with esc.
-- https://github.com/LunarVim/LunarVim/issues/4007#issuecomment-1501087398
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

