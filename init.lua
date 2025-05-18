
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
local function lsp_binds(bufnr)
    -- stolen from https://www.reddit.com/r/neovim/comments/uh4qss/how_to_enable_specific_keymaps_only_if_lsp_is/i74tvlh/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
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

local function lsp_cmp_binds(cmp)

    local luasnip = require('luasnip')

    return cmp.mapping.preset.insert({
        -- Trackpad-optimised scroll speed
        ['<C-b>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs( 1),
        ['<C-Enter>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Select the current choice on enter
        ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        -- Scrolling options
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    })
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
			ensure_installed = lsp_server_names
		}
	},
	{
		'neovim/nvim-lspconfig',

		dependencies = { 'williamboman/mason-lspconfig.nvim' },

		config = function()
			vim.diagnostic.config({
				update_in_insert = true
			})
		end

	},
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'saadparwaiz1/cmp_luasnip',
			{
				'L3MON4D3/LuaSnip',

				dependencies = {
					'saadparwaiz1/cmp_luasnip',
				},

				config = function()
					local luasnip = require('luasnip')

					require('luasnip.loaders.from_vscode').lazy_load({
						paths = {
							vim.fn.stdpath('config') .. '/snippets',
						}
					})

					luasnip.config.setup {}
				end
			},
			'onsails/lspkind.nvim'
		},

		config = function()

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require('lspconfig')
			local cmp = require('cmp')
			local lspkind = require('lspkind')
			local luasnip = require('luasnip')

			local function on_attach(client, bufnr)
				lsp_binds(bufnr)
			end

			-- Init servers
			for server, config in pairs(lsp_servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end

			cmp.setup({
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'path' },
					{ name = 'luasnip' }
				},

				formatting = {
					format = lspkind.cmp_format {
						mode = 'symbol',
						maxwidth = 50,
						ellipsis_char = '...'
					}
				},

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},

				mapping = lsp_cmp_binds(cmp)
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources(
				{
					{ name = 'path' }
				},
				{
					{ name = 'cmdline' }
				})
			})
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
vim.opt.termguicolors = true

-- Enable line numbers.
vim.wo.number = true

-- Relative line numbers.
vim.wo.rnu = true

-- Autoscroll editor with margin.
vim.go.scrolloff = 4

-- Scroll 1 line at a time.
vim.go.mousescroll = 'ver:1,hor:1'

-- Tab = 4 chars.
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Disable text wrap.
vim.wo.wrap = false

-- MacOS clipboard.
vim.go.clipboard = 'unnamedplus'

vim.o.guifont = 'Monaco:h12'

-- Disable mouse (for now)
vim.o.mouse = ''

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


