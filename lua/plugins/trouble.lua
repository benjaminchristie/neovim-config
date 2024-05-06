return {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
 },
 keys = {
	 {
	 'gh', function() require("trouble").toggle("workspace_diagnostics") end
	 },
	 {
	 'gH', function() require("trouble").toggle("document_diagnostics") end
	 },
	 {
	 'gco', function() require("trouble").toggle("quickfix") end
	 },
	 {
	 'glo', function() require("trouble").toggle("loclist") end
	 },
	 {
	 'go', function() require("trouble").toggle("lsp_references") end
	 },
 }
}
