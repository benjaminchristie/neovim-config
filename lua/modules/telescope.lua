require('telescope').setup({
    defaults = {
	layout_strategy = "bottom_pane",
	layout_config = {
	    height = 0.95,
	    prompt_position = "bottom"
	}
    }
})
require('telescope').load_extension("fzf")
require('telescope').load_extension("refactoring")
require('telescope').load_extension('media_files')
require('telescope').load_extension('perfanno')
vim.keymap.set('n', '<C-p><C-p>', function() return require('telescope.builtin').find_files() end )
vim.keymap.set('n', '<C-p><C-f>', function() return require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<C-p><C-d>', function() return require('telescope.builtin').lsp_document_symbols() end)
vim.keymap.set('n', '<C-p><C-b>', function() return require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<C-p><C-c>', function() return require('telescope.builtin').git_commits() end)
-- vim.keymap.set('n', '<C-p><C-c>', function() return require('telescope.builtin').git_bcommits() end)
vim.keymap.set('n', '<C-p><C-q>', function() return require('telescope.builtin').current_buffer_fuzzy_find() end)
vim.keymap.set('n', '<C-p><C-i>', function() return require('telescope.builtin').lsp_dynamic_workspace_symbols() end)
vim.keymap.set('n', '<C-p><C-u>', function() return require('telescope').extensions.undo.undo() end)
vim.keymap.set('n', '<C-p><C-g>', function() return require'telescope'.extensions.repo.cached_list{file_ignore_patterns={"/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"}} end)
vim.keymap.set('n', '<C-p><C-1>', function() return require('telescope').extensions.perfanno.actions.hottest_callers() end)
vim.keymap.set('n', '<C-p><C-0>', function() return require('telescope').extensions.perfanno.actions.hottest_callees() end)
vim.cmd([[
    autocmd User TelescopePreviewerLoaded setlocal wrap
]])

-- refactoring, tmp
--
-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap(
    "v",
    "<C-p><C-r>",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-p><C-r>",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false }
)
