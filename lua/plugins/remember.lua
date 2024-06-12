return {
    'vladdoster/remember.nvim',
    lazy = false,
    config = function()
        require("remember").setup({
            open_folds = true
        })
    end,
	enabled = false,
}
