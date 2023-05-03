--- set options --- 
vim.o.cursorline = true
vim.o.conceallevel = 0
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ch = 1
vim.cmd([[syntax on]])
vim.cmd([[hi SpellBad guibg=#ff2929 ctermbg=224]])
vim.o.spell = false
vim.o.showcmd = true
vim.o.relativenumber = true
vim.o.number = true
-- folds
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end
vim.o.foldenable = true
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
require('ufo').setup({
    fold_virt_text_handler = handler,
    provider_selector = function(_, _, _)
        return {'treesitter', 'indent'}
    end
})
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)
-- end folds
vim.o.backup = false
vim.o.signcolumn = "yes:1"
vim.o.undofile = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.path = vim.o.path .. "**"
vim.o.wrap = true
vim.o.wildmenu = true
vim.o.sol = false
vim.o.tabstop = 8
vim.o.softtabstop = 8
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.ls = 0
vim.o.autoindent = true
vim.o.mouse = "nv"
vim.o.splitkeep = "screen"

-- vim.opt.listchars = { eol="", tab = '' }
-- vim.opt.list = true

vim.g.syntastic_auto_jump = 1
vim.g.term_buf = 0
vim.g.term_win = 0
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1 -- vim.g.tex_conceal = "admgs"
-- vim.g.loaded_nvimgdb = 1
-- vim.g.nvimgdb_disable_start_keymaps = true
-- disables autocomment on o, O
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
