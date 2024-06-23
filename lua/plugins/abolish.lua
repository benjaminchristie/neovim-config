return {
	"tpope/vim-abolish",
	config = function()
		vim.cmd("Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}")
	end,
	lazy = false,
	enabled = true,
}
