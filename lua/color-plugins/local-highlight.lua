return {
    'tzachar/local-highlight.nvim',
    opts = {
        disable_file_types = { 'tex' },
        hlgroup = 'LocalHighlight',
        cw_hlgroup = nil,
    },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "folke/tokyonight.nvim" }
}
