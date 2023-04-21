vim.o.termguicolors = true
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
require("tokyonight").setup({
    transparent=true,
    style="night",
    styles = {
	sidebars="transparent",
	floats = "transparent",
    },
    sidebars = {"feline"},
    dim_inactive= true,
})
vim.cmd([[
    colorscheme tokyonight-night
]])
