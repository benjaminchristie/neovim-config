require("impatient")
-- require("plugins")
local async
async =
    vim.loop.new_async(
    vim.schedule_wrap(
        function()
            require("options")
            require("nvim-surround").setup()
            async:close()
        end
    )
)

async:send()
-- for some reason, some LSP servers do not attach to files properly if loaded asynchronously 
