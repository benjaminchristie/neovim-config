local ts = require("telescope")
ts.setup({
    defaults = {
	layout_strategy = "bottom_pane",
	layout_config = {
	    height = 0.95,
	    prompt_position = "bottom" }
        }
})
local builtins = require("telescope.builtin")
local extensions = require("telescope").extensions
ts.load_extension("fzf")
ts.load_extension("refactoring")
ts.load_extension('media_files')
ts.load_extension('perfanno')
vim.keymap.set('n', '<C-p><C-p>', function() return builtins.find_files() end )
vim.keymap.set('n', '<C-p><C-f>', function() return builtins.live_grep() end)
vim.keymap.set('n', '#',          function() return builtins.grep_string() end)
vim.keymap.set('n', '<C-p><C-d>', function() return builtins.lsp_document_symbols() end)
vim.keymap.set('n', '<C-p><C-b>', function() return builtins.buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return builtins.help_tags() end)
-- vim.keymap.set('n', '<C-p><C-c>', function() return builtins.git_bcommits() end)
vim.keymap.set('n', '<C-p><C-q>', function() return builtins.current_buffer_fuzzy_find() end)
vim.keymap.set('n', '<C-p><C-i>', function() return builtins.lsp_dynamic_workspace_symbols() end)
vim.keymap.set('n', '<C-p><C-u>', function() return extensions.undo.undo() end)
vim.keymap.set('n', '<C-p><C-g><C-p>', function() return extensions.repo.cached_list{file_ignore_patterns={"/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"}} end)
vim.keymap.set('n', '<C-p><C-g><C-b>', function() return builtins.git_branches() end)
vim.keymap.set('n', '<C-p><C-g><C-g>', function() return builtins.commands() end)
vim.keymap.set('n', '<C-p><C-g><C-d>', function() return builtins.git_commits()  end)
vim.keymap.set('n', '<C-p><C-1>', function() return extensions.perfanno.actions.hottest_callers() end)
vim.keymap.set('n', '<C-p><C-0>', function() return extensions.perfanno.actions.hottest_callees() end)
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
