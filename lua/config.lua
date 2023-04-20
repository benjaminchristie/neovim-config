--- Set keymappings --- 
vim.keymap.set('n', '<Up>', '<C-b>')
vim.keymap.set('n', '<Down>', '<C-f>')
vim.keymap.set('n', '<Left>', 'gT')
vim.keymap.set('n', '<Right>', 'gt')

vim.keymap.set('i', '<C-b>', '\\textbf{}<C-O>F{<C-O>l')
vim.keymap.set('i', '<C-l>', '\\textit{}<C-O>F{<C-O>l')
vim.keymap.set('i', '<C-e>', '\\emph{}<C-O>F{<C-O>l')
vim.keymap.set('i', '<C-u>', '\\underline{}<C-O>F{<C-O>l')

vim.keymap.set('n', '`1', ':5winc<<CR>')
vim.keymap.set('n', '`4', ':5winc><CR>')
vim.keymap.set('n', '`2', ':3winc+<CR>')
vim.keymap.set('n', '`3', ':3winc-<CR>')

vim.keymap.set('n', ',t', ':tabnew<CR>')

vim.keymap.set('n', 'zs', 'zMzO')

--- cool block commands
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')


-- cd to current working file
vim.keymap.set('n', '<A-c>', function ()
    local cwd = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cwd)
    print("Changed cwd to " .. cwd)
end)

--- toggle term
require("toggleterm").setup{
    size = 40,
    open_mapping = [[<A-t>]],
    direction = 'float',
    shade_terminals = false,
    persist_size = false,
}

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
local Terminal = require('toggleterm.terminal').Terminal
local pyterm = Terminal:new({cmd = "python", hidden = true})
function _PYTHON_TOGGLE()
    pyterm:toggle()
end
vim.keymap.set('n', [[<A-p>]], _PYTHON_TOGGLE)
--- telescope
vim.keymap.set('n', '<C-p><C-p>', function() return require('telescope.builtin').find_files() end )
vim.keymap.set('n', '<C-p><C-t>', function() return require('telescope-toggleterm').open() end)
vim.keymap.set('n', '<C-p><C-f>', function() return require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<C-p><C-d>', function() return require('telescope.builtin').lsp_document_symbols() end)
vim.keymap.set('n', '<C-p><C-b>', function() return require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<C-p><C-a>', function() return require('telescope.builtin').git_commits() end)
vim.keymap.set('n', '<C-p><C-c>', function() return require('telescope.builtin').git_bcommits() end)
vim.keymap.set('n', '<C-p><C-q>', function() return require('telescope.builtin').current_buffer_fuzzy_find() end)
vim.keymap.set('n', '<C-p><C-i>', function() return require('telescope.builtin').lsp_dynamic_workspace_symbols() end)
vim.keymap.set('n', '<C-p><C-u>', function() return require('telescope').extensions.undo.undo() end)
vim.keymap.set('n', '<C-p><C-g>', function() return require'telescope'.extensions.repo.cached_list{file_ignore_patterns={"/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"}} end)


local search_github = function ()
    local csgithub = require("csgithub")
    local url = csgithub.search({
	includeFilename=false,
	includeExtension=true,
    })
    if url == nil then
    	return
    end
    csgithub.open(url)
end
vim.keymap.set('n', '<A-g>', function() return search_github() end)
vim.keymap.set('v', '<A-g>', function() return search_github() end)

vim.cmd([[
    autocmd User TelescopePreviewerLoaded setlocal wrap
]])

--- UndoTree
--
vim.keymap.set('n', "U", vim.cmd.UndotreeToggle)

vim.api.nvim_create_user_command("Lex", "NvimTreeFindFile", {})
vim.api.nvim_create_user_command("Ex", "NvimTreeFocus", {})

vim.cmd([[ 
    hi VertSplit cterm=none
    hi Folded ctermbg=black

    if &t_Co > 2 || has("gui_running")
        " Switch on highlighting the last used search pattern.
        set hlsearch
    endif

]])
vim.keymap.set('t', '<Esc', '<C-\\><C-n>')
vim.keymap.set('t', ':q', '<C-\\><C-n>:q!<CR>')
vim.keymap.set('t', '<C-w>', "<C-\\><C-n>")


-- handle harpoon

for i = 0, 9, 1 do
   vim.keymap.set('n', '<A-'..i..">", function() return require("harpoon.ui").nav_file(i) end)
end
vim.keymap.set('n', "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', "<A-m>", function() return require("harpoon.mark").add_file() end)
vim.keymap.set('n', "<A-k>", function() return require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', "<A-j>", function() return require("harpoon.ui").nav_next() end)
