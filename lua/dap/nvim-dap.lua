return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'Weissle/persistent-breakpoints.nvim',
    },
    config = function()
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
                command = vim.fn.stdpath("config") .. '/bin/vscode-cpptools/OpenDebugAD7'
            },
            local_lua = {
                id = 'lldbg',
                type = "executable",
                command = "node",
                args = {
                    vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/extension/debugAdapter.js"
                },
                enrich_config = function(config, on_config)
                    if not config["extensionPath"] then
                        local c = vim.deepcopy(config)
                        c.extensionPath = vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/"
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
                        command = vim.fn.stdpath("config") .. '/bin/virtualenvs/debugpy/bin/python',
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end
        }
        require('dap-python').setup(vim.fn.stdpath("config") .. '/bin/virtualenvs/debugpy/bin/python')
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
    end,
    event = "VeryLazy",
    cmd = "DapVirtualTextEnable",
    keys = {
        { "<A-d><A-v>", ":DapVirtualTextEnable<CR>" },
        { "<A-d><A-r>", function() return require("dap").restart() end },
        { "<A-d><A-t>", function() return require("dap").run_to_cursor() end },
        { "<A-d><A-d>", function() return require("dap").continue() end },
        { '<A-d><A-n>', function() return require("dap").step_over() end },
        { '<A-d><A-s>', function() return require("dap").step_over() end },
        {
            '<A-d><A-q>',
            function()
                require("dap").close()
                require("dapui").close()
            end
        },
        {
            '<A-d><A-l>',
            function()
                return require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log : "))
            end
        },
        {
            '<A-d><A-b>',
            function()
                return require('persistent-breakpoints.api').toggle_breakpoint(vim.fn.input("Condition : "))
            end
        },
    }
}
