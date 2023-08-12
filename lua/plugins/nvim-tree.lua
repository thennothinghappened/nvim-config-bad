return {
    'nvim-tree/nvim-tree.lua',
    opts = {
        diagnostics = {
            enable = true,
            show_on_dirs = false
        }
    },
    lazy = true,
    cmd = { 'NvimTreeToggle' },
}
