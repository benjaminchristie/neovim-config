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
local function augroup(group) return vim.api.nvim_create_augroup(group, {clear = true}) end

local function create_skeleton(ext)
    return vim.api.nvim_create_autocmd({"BufNewFile"}, {
        pattern = "*." .. ext,
        group = augroup("skeletons-" .. ext),
        command = "0r " .. vim.fn.stdpath("config") .. "/skeletons/skeleton." .. ext
    })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup("FormatGroup"),
    pattern = "*",
    callback = function()
        vim.cmd('set formatoptions-=cro')
        vim.cmd('setlocal formatoptions-=cro')
    end
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup("LaunchEnterGroup"),
    pattern = { "*.launch", ".urdf", "*.xacro", "*.xml" },
    callback = function()
        vim.opt_local.filetype = "html"
    end
})
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime-autoread"),
    pattern = "*",
    command = "checktime"
})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight-yank"),
  callback = function()
    vim.highlight.on_yank({higroup = "HighlightUndo"})
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {"oil", "starter", "lazy" },
    group = augroup("number-formatting"),
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end
})

create_skeleton("c")
create_skeleton("cpp")
create_skeleton("py")
create_skeleton("sh")
