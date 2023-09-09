local binds = {
    normal = {
        line = 'gcc',
        block = 'gbc'
    },

    visual = {
        line = 'gc',
        block = 'gb'
    }
}

return {
    'numToStr/Comment.nvim',

    opts = {
        sticky = true,
        toggler = binds.normal,
        opleader = binds.visual,
    },

    binds = binds
}
