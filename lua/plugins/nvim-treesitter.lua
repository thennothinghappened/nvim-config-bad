return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'lua', 'javascript', 'html', 'css', 'c', 'rust'
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
