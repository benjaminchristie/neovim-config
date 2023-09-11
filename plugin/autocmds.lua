--- menus
vim.cmd([[
aunmenu PopUp
vnoremenu PopUp.Cut                         "+x
vnoremenu PopUp.Copy                        "+y
vnoremenu PopUp.Paste                       "+P
nnoremenu PopUp.Go\ To\ Definition          <Cmd>lua vim.fn.feedkeys("gd")<CR>
nnoremenu PopUp.Go\ To\ References          <Cmd>lua vim.fn.feedkeys("gr")<CR>
nnoremenu PopUp.Toggle\ Breakpoint          <Cmd>lua vim.fn.feedkeys("<A-d><A-b>")<CR>
nnoremenu PopUp.Open\ Debugger              <Cmd>lua require("dap").continue()<CR>
nnoremenu PopUp.Peek\ Value                 <Cmd>lua require("dapui").eval(nil, {enter = true})<CR>
anoremenu PopUp.-1-                         <Nop>
anoremenu PopUp.Exit                        <Nop>
]])

local augroup = require("custom-utils").augroup
local autocmd = vim.api.nvim_create_autocmd

local function create_skeleton(ext)
    return autocmd({ "BufNewFile" }, {
        pattern = "*." .. ext,
        group = augroup("skeletons-" .. ext),
        command = "0r " .. vim.fn.stdpath("config") .. "/skeletons/skeleton." .. ext
    })
end

local function filetype_detection(pattern, desired_filetype)
    return autocmd({ "BufRead", "BufNewFile" }, {
        group = augroup("filetype-detection-for-" .. desired_filetype),
        pattern = pattern,
        callback = function()
            vim.opt_local.filetype = desired_filetype
        end,
    })
end

autocmd({ "BufEnter" }, {
    group = augroup("FormatGroup"),
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
        if vim.o.filetype ~= "oil" and vim.o.filetype ~= "starter" and vim.o.filetype ~= "lazy" then
            vim.wo[0][0].number = true
            vim.wo[0][0].relativenumber = true
        end
    end
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime-autoread"),
    pattern = "*",
    command = "checktime"
})

autocmd("TextYankPost", {
    group = augroup("highlight-yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "HighlightUndo" })
    end,
})

autocmd("User", {
    pattern = { "MiniStarterOpened" },
    callback = function()
        vim.api.nvim_buf_set_keymap(vim.fn.bufnr(), "n", "<tab>",
            ('<Cmd>lua %s<CR>'):format([[require("mini.starter").update_current_item('next')]]),
            {}
        )
        vim.api.nvim_buf_set_keymap(vim.fn.bufnr(), "n", '<s-tab>',
            ('<Cmd>lua %s<CR>'):format([[require("mini.starter").update_current_item('prev')]]),
            {}
        )
    end
}
)


autocmd({ "FileType" }, {
    pattern = { "oil", "starter", "lazy" },
    group = augroup("number-formatting"),
    callback = function()
        vim.wo[0][0].number = false
        vim.wo[0][0].relativenumber = false
    end
})

filetype_detection({ "*.launch", "*.urdf", "*.xacro", "*.xml" }, "html")
filetype_detection({ "*.gitignore" }, "gitignore")

create_skeleton("c")
create_skeleton("cpp")
create_skeleton("py")
create_skeleton("sh")
create_skeleton("gitignore")
