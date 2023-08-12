return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    opts = {
        ensure_installed = {
            'lua', 'javascript', 'html', 'css', 'c', 'rust'
        },
        highlight = { enable = true },
        indent = { enable = true },
    }
}
