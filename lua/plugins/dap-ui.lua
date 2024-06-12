return {
	'rcarriga/nvim-dap-ui',
	dependencies = {
		'mfussenegger/nvim-dap',
		'nvim-neotest/nvim-nio',
	},
	event = "VeryLazy",
	opts = {
		controls = {
			element = "repl",
			enabled = true,
			icons = {
				disconnect = "",
				pause = "",
				play = "",
				run_last = "",
				step_back = "",
				step_into = "",
				step_out = "",
				step_over = "",
				terminate = ""
			}
		},
		element_mappings = {},
		expand_lines = false,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" }
			}
		},
		force_buffers = true,
		icons = {
			collapsed = "",
			current_frame = "",
			expanded = ""
		},
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
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t"
		},
		render = {
			indent = 1,
			max_value_lines = 100
		}
	},
	keys = {
		{ '<A-d><A-p>',
			function()
				return require("dapui").eval()
			end
		},
	}
}
