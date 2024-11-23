
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
---   Setup Plugins   ---
-------------------------
require('lazy').setup({
    
    --- Themes ---
    {
        'rebelot/kanagawa.nvim',
    
        opts = {
            background = {
                dark = 'wave'
            },
            dimInactive = false
        }
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
vim.cmd.colorscheme('kanagawa')

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

