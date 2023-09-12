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
local buf_keymap = require("custom-utils").buf_keymap
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
            if not require("custom-functions").zen_enabled() then
                vim.wo[0][0].number = true
                vim.wo[0][0].relativenumber = true
            end
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
        buf_keymap("n", "<tab>",
            ('<Cmd>lua %s<CR>'):format([[require("mini.starter").update_current_item('next')]])
        )
        buf_keymap("n", '<s-tab>',
            ('<Cmd>lua %s<CR>'):format([[require("mini.starter").update_current_item('prev')]])
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

autocmd({"TermClose"}, {
    pattern = "term://*",
    group = augroup("AutoTermClose"),
    callback = function ()
        if vim.v.event_status == 0 then
            vim.api.nvim_buf_delete(0, {unload = true})
        end
    end
})
autocmd({ "TermOpen" }, {
    pattern = "term://*",
    group = augroup("AutoTermMappings"),
    callback = function()
        buf_keymap('t', '<esc>', [[<C-\><C-n>]], { noremap = true })
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})

filetype_detection({ "*.launch", "*.urdf", "*.xacro", "*.xml" }, "html")
filetype_detection({ "*.gitignore" }, "gitignore")
filetype_detection({ "*.tex" }, "tex")

create_skeleton("c")
create_skeleton("cpp")
create_skeleton("h")
create_skeleton("py")
create_skeleton("sh")
create_skeleton("gitignore")
