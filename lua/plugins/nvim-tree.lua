return {
    'nvim-tree/nvim-tree.lua',
    opts = {
        disable_netrw = true,
        -- open_on_setup = true,
        diagnostics = {
            enable = true,
            show_on_dirs = false
        },
        filters = {
            dotfiles = true
        }
    },
}
