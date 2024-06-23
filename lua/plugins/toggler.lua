return {
    'nguyenvukhang/nvim-toggler',
    opts = {
        inverses = {
            ['false'] = 'true',
            ['False'] = 'True',
            ['=='] = '!=',
        },
        remove_default_keybinds = true,
        remove_default_inverses = true,
    },
    keys = {
        { "gtt", function() return require("nvim-toggler").toggle() end },
    }
}
