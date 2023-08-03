local dap = require("dap")
local dapui = require("dapui")

dap.configurations = {
    cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            local status, inf = pcall(vim.fn.input, 'Path to executable [<C-c> to use nonfile] : ', vim.fn.getcwd() .. '/', 'file')
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
             description =  'enable pretty printing',
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
            local status, inf = pcall(vim.fn.input, 'Path to executable [<C-c> to use nonfile] : ', vim.fn.getcwd() .. '/', 'file')
            if status then
                return inf
            else
                return vim.fn.input("Program to run : ")
            end
        end,
        setupCommands = {
          {
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false
          },
        },
      },
    },
    c = dap.configurations.cpp,
    python = {
        {
            type = 'python';
            repl_lang = "python";
            request = 'launch';
            name = 'Launch file';
            program = "${file}";
            pythonPath = function()
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                    return cwd .. '/venv/bin/python'
                elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                    return cwd .. '/.venv/bin/python'
                else
                    return '/usr/bin/python'
                end
            end;
        }
    },
}
dap.adapters = {
    cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/home/benjamin/.config/nvim/bin/vscode-cpptools/OpenDebugAD7'
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
          command = '/home/benjamin/.pyenv/versions/dbg/bin/python',
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end
}
local dap_python = require('dap-python').setup('/home/benjamin/.pyenv/versions/dbg/bin/python')
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


