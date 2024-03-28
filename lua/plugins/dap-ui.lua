return {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio',
    event = "VeryLazy",
    keys = {
        { '<A-d><A-p>',
            function()
                return require("dapui").eval(nil, {
                    enter = true
                })
            end
        },
    }
}
