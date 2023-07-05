--- set keymappings --- 
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
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')


-- cd to current working file
vim.keymap.set('n', '<A-c>', function ()
    local cwd = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cwd)
    print("Changed cwd to " .. cwd)
end)

-- find and replace assistance

vim.keymap.set('n', '\\s', function ()
    local word = vim.fn.expand("<cword>")
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local change_to = vim.fn.input("Change " .. word .. " to : ")
    vim.cmd(':%s/' .. word .. "/" .. change_to .. "/g")
    vim.cmd(":" .. line_num)
    end
)

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

-- handle harpoon

for i = 0, 9, 1 do
   vim.keymap.set('n', '<A-'..i..">", function() return require("harpoon.ui").nav_file(i) end)
end
vim.keymap.set('n', "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', "<A-m>", function() return require("harpoon.mark").add_file() end)
vim.keymap.set('n', "<A-k>", function() return require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', "<A-j>", function() return require("harpoon.ui").nav_next() end)

-- fugitive stuff
vim.keymap.set('n', 'gM', ':Git mergetool -y<CR>')
vim.keymap.set('n', 'gV', ':Git difftool -y<CR>')
vim.keymap.set('n', 'gR', ':Git rebase --interactive ')
-- vim.keymap.set('n', 'gV', ':Gvdiffsplit<CR>')
vim.g.editorconfig_trim_trailing_whitespace = true

-- perfanno 
local perfanno = require("perfanno")
local util = require("perfanno.util")

perfanno.setup {
    -- Creates 10-step color gradient between pure black (#000000) and #CC3300
    line_highlights = util.make_bg_highlights("#1A1B26", "#CC3300", 10),
    vt_highlight = util.make_fg_highlight("#CC3300"),
    annotate_after_load = true,
    annotate_on_open = true,
    ts_function_patterns = {
        -- These should work for most languages (at least those used with perf)
        default = {
            "function",
            "method",
        },
    },
}


-- ROS config 

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"*.launch", ".urdf", "*.xacro"},
    callback = function()
        vim.opt_local.filetype = "html"
    end
})
