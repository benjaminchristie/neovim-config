--- menus
vim.cmd([[
autocmd TermOpen * setlocal nonu
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

local augroup = require("utils").augroup
local buf_keymap = require("utils").buf_keymap
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
		callback = function(event)
			vim.bo[event.buf].filetype = desired_filetype
		end,
	})
end

autocmd({ "BufEnter" }, {
	group = augroup("FormatGroup"),
	pattern = "*",
	callback = function()
		if string.find(vim.bo.filetype, "dap-") or string.find(vim.bo.filetype, "lsp") then
			return
		end
		vim.schedule(function()
			vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
			vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
			if vim.bo.filetype ~= "oil" and
				vim.bo.filetype ~= "starter" and
				vim.bo.filetype ~= "" and
				vim.bo.filetype ~= "toggleterm" and
				vim.bo.filetype ~= "aerial" and
				vim.bo.filetype ~= "lazy" and
				vim.bo.filetype ~= "trouble" and
				vim.bo.filetype ~= "Trouble" then
				if not require("functions").zen_enabled() then
					vim.wo[0][0].number = true
					vim.wo[0][0].relativenumber = true
				end
			end
		end)
	end
})

autocmd({ "BufHidden" }, {
	group = augroup("DeleteHiddenNoNameBuffers"),
	callback = function(event)
		if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
			vim.schedule(function()
				pcall(vim.api.nvim_buf_delete, event.buf, {})
			end)
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


autocmd({ "RecordingEnter" }, {
	group = augroup("cmdheight0recenter"),
	callback = function()
		if vim.o.cmdheight == 0 then
			vim.o.cmdheight = 1
			-- only create this autocmd if cmdheight == 0 to begin with
			autocmd({ "RecordingLeave" }, {
				group = augroup("cmdheight0recexit"),
				callback = function()
					if vim.o.cmdheight == 1 then
						vim.o.cmdheight = 0
					end
					return true
				end,
			})
		end
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
	pattern = { "oil", "starter", "lspinfo", "aerial" },
	group = augroup("number-formatting"),
	callback = function()
		vim.wo[0][0].number = false
		vim.wo[0][0].relativenumber = false
	end
})

autocmd({ "TermClose" }, {
	pattern = "term://*",
	group = augroup("AutoTermClose"),
	callback = function()
		if vim.v.event_status == 0 then
			vim.schedule(function() vim.api.nvim_buf_delete(0, { unload = true }) end)
		end
	end
})
autocmd({ "TermOpen" }, {
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
create_skeleton("sty")
create_skeleton("tex")
autocmd({ "BufWritePost" }, {
	pattern = "*.sh",
	group = augroup("chmod-shell"),
	callback = function()
		vim.schedule(function()
			---@diagnostic disable-next-line: param-type-mismatch
			pcall(vim.cmd, "Chmod +x", {})
		end)
	end
})
