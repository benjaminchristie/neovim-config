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

local function augroup(group) return vim.api.nvim_create_augroup(group, { clear = true }) end

local function create_skeleton(ext)
    return vim.api.nvim_create_autocmd({ "BufNewFile" }, {
        pattern = "*." .. ext,
        group = augroup("skeletons-" .. ext),
        command = "0r " .. vim.fn.stdpath("config") .. "/skeletons/skeleton." .. ext
    })
end

local function filetype_detection(pattern, desired_filetype)
    return vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        group = augroup("filetype-detection-for-" .. desired_filetype),
        pattern = pattern,
        callback = function()
            vim.opt_local.filetype = desired_filetype
        end,
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

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime-autoread"),
    pattern = "*",
    command = "checktime"
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight-yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "HighlightUndo" })
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "oil", "starter", "lazy" },
    group = augroup("number-formatting"),
    callback = function()
        vim.wo[0][0].number = false
        vim.wo[0][0].relativenumber = false
    end
})

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"oil"},
    group = augroup("oil-ft-detection-and-numbering-on-exit"),
    callback = function ()
        local bufnr = vim.fn.bufnr()
        vim.api.nvim_create_autocmd({"BufHidden"}, {
            buffer = bufnr,
            -- NOTE: FileType is triggered AFTER BufHidden per 
            -- https://github.com/lervag/dotvim/blob/
            -- 3aa56d621423540bfa26b330182b3e97ed4ee5e8/personal/plugin/log-autocmds.vim
            callback = function()
                vim.wo[0][0].number = true
                vim.wo[0][0].relativenumber = true
                return true -- returning true deletes the autocmd
            end
        })
    end
})

filetype_detection({"*.launch", "*.urdf", "*.xacro", "*.xml"}, "html")
filetype_detection({"*.gitignore"}, "gitignore")

create_skeleton("c")
create_skeleton("cpp")
create_skeleton("py")
create_skeleton("sh")
create_skeleton("gitignore")
