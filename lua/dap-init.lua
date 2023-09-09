local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level("TRACE")

dap.configurations = {
    cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                local status, inf = pcall(vim.fn.input, 'Path to executable [<C-c> to use nonfile] : ',
                    vim.fn.getcwd() .. '/', 'file')
                if status then
                    return inf
                else
                    return vim.fn.input("Program to run : ")
                end
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            repl_lang = "cpp",
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            },
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            MIMode = 'gdb',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/gdb',
            cwd = '${workspaceFolder}',
            program = function()
                local status, inf = pcall(vim.fn.input, 'Path to executable [<C-c> to use nonfile] : ',
                    vim.fn.getcwd() .. '/', 'file')
                if status then
                    return inf
                else
                    return vim.fn.input("Program to run : ")
                end
            end,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            },
        },
    },
    c = dap.configurations.cpp,
    rust = dap.configurations.cpp,
    lua = {
        {
            name = 'Current file (local-lua-dbg, lua)',
            type = 'local_lua',
            request = 'launch',
            cwd = '${workspaceFolder}',
            program = {
                lua = 'nlua.lua',
                file = '${file}',
            },
            args = {},
        }
    },
}
dap.adapters = {
    cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = os.getenv("HOME") .. '/.config/nvim/bin/vscode-cpptools/OpenDebugAD7'
    },
    local_lua = {
        id = 'lldbg',
        type = "executable",
        command = "node",
        args = {
            os.getenv("HOME") .. "/.local/share/nvim/plugged/local-lua-debugger-vscode/extension/debugAdapter.js"
        },
        enrich_config = function(config, on_config)
            if not config["extensionPath"] then
                local c = vim.deepcopy(config)
                c.extensionPath = os.getenv("HOME") .. "/.local/share/nvim/plugged/local-lua-debugger-vscode/"
                on_config(c)
            else
                on_config(config)
            end
        end,
    },
    python = function(cb, config)
        if config.request == 'attach' then
            local port = (config.connect or config).port
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
                type = 'server',
                port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                host = host,
                options = {
                    source_filetype = 'python',
                },
            })
        else
            cb({
                type = 'executable',
                command = '/home/benjamin/.config/nvim/bin/virtualenvs/debugpy/bin/python',
                args = { '-m', 'debugpy.adapter' },
                options = {
                    source_filetype = 'python',
                },
            })
        end
    end
}
require('dap-python').setup('/home/benjamin/.config/nvim/bin/virtualenvs/debugpy/bin/python')
require('dap-go').setup()
require("nvim-dap-virtual-text").setup({
    enabled = false,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = false,
    only_first_definition = false,
    all_references = false,
    clear_on_continue = false,
    virt_text_pos = "eol",
})
dapui.setup({
    expand_lines = false,
    layouts = { {
        elements = { {
            id = "stacks",
            size = 0.10
        }, {
            id = "breakpoints",
            size = 0.10
        }, {
            id = "scopes",
            size = 0.40
        }, {
            id = "watches",
            size = 0.40
        } },
        position = "left",
        size = 60
    }, {
        elements = { {
            id = "repl",
            size = 0.5
        }, {
            id = "console",
            size = 0.5
        } },
        position = "bottom",
        size = 8
    },
    },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
-- local dap = require("dap")
-- dap.adapters["local-lua"] = {
--   type = "executable",
--   command = "node",
--   args = {
--     "/absolute/path/to/local-lua-debugger-vscode/extension/debugAdapter.js"
--   },
--   enrich_config = function(config, on_config)
--     if not config["extensionPath"] then
--       local c = vim.deepcopy(config)
--       -- 💀 If this is missing or wrong you'll see
--       -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
--       c.extensionPath = "/absolute/path/to/local-lua-debugger-vscode/"
--       on_config(c)
--     else
--       on_config(config)
--     end
--   end,
-- }
