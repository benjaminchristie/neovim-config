--- set options --- 
vim.o.cursorline = true
vim.o.conceallevel = 0
vim.o.hlsearch = true
vim.o.incsearch = true
vim.cmd([[syntax on]])
vim.o.showcmd = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.foldenable = false
vim.o.backup = false
vim.o.signcolumn = "number"
vim.o.undofile = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.path = vim.o.path .. "**"
vim.o.wrap = true
vim.o.wildmenu = true
vim.o.sol = false
vim.o.foldmethod = "marker"
vim.o.foldmarker = "{{{,}}}"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.g.syntastic_auto_jump = 1
vim.g.term_buf = 0
vim.g.term_win = 0
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1

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

-- require('telescope').setup({})

vim.keymap.set('n', '<C-p><C-p>', function() return require('telescope.builtin').find_files() end )
vim.keymap.set('n', '<C-p><C-q>', function() return require('telescope.builtin').lsp_document_symbols() end )
vim.keymap.set('n', '<C-p><C-f>', function() return require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<C-p><C-b>', function() return require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<C-p><C-g>', function() return require('telescope.builtin').git_bcommits() end)
vim.keymap.set('n', '<C-p><C-a>', function() return require('telescope.builtin').git_commits() end)
vim.keymap.set('n', '<C-p><C-u>', function() return require('telescope').extensions.undo.undo() end)

vim.cmd([[
    autocmd User TelescopePreviewerLoaded setlocal wrap
]])


local search_github = function ()
    local csgithub = require("csgithub")
    local url = csgithub.search({
	includeFilename=false,
	includeExtension=true,
    })
    csgithub.open(url)
end
vim.keymap.set('n', '<A-g>', function() return search_github() end)
vim.keymap.set('v', '<A-g>', function() return search_github() end)
-- command Lex NvimTreeFindFile
-- command Ex NvimTreeFocus


--- Set Helpful functions --- 

vim.api.nvim_create_user_command("Lex", "NvimTreeFindFile", {})
vim.api.nvim_create_user_command("Ex", "NvimTreeFocus", {})

-- local user = vim.api.nvim_create_augroup('User', {clear = false})
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopePreviewerLoaded",
--     group = user,
--     command = "setlocal wrap",
-- })

vim.cmd([[ 
    hi VertSplit cterm=none
    hi Folded ctermbg=black

    if &t_Co > 2 || has("gui_running")
        " Switch on highlighting the last used search pattern.
        set hlsearch
    endif

]])
vim.cmd([[

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

]])



-- vim.keymap.set('n', '<A-t>', vim.call("TermToggle(12)"))
-- vim.keymap.set('i', '<A-t>', vim.call("TermToggle(12)"))
-- vim.keymap.set('t', '<A-t>', vim.call("TermToggle(12)"))
vim.keymap.set('t', '<Esc', '<C-\\><C-n>')
vim.keymap.set('t', ':q', '<C-\\><C-n>:q!<CR>')

-- done with loading vim.cmd config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.cmd([[
    colorscheme tokyonight-night
]])

vim.g.indent_line_enabled = false


