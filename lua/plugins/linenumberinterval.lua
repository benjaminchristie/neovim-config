return {
    'IMOKURI/line-number-interval.nvim',
    init = function()
        vim.api.nvim_set_var("line_number_interval#custom_interval", { 1, 2, 3, 4, 5 })
        vim.api.nvim_set_var("line_number_interval#use_custom", 1)
        vim.g.line_number_interval_enable_at_startup = 1
    end,
    lazy = false,
    enabled = false,
}
