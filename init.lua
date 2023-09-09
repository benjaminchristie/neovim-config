local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("options")

local lsp_configured_filetypes = {
    "*.lua",
    "*.py",
    "CMakeLists.txt",
    "*.md",
    "*.tex",
    "*.go",
    "*.sh",
    "*.html",
    "*.css",
    "Dockerfile",
    "*.asm",
    "*.nasm",
    "*.h",
    "*.hpp",
    "*.c",
    "*.cpp",
}

require("lazy").setup({
        {
            'benjaminchristie/csgithub.nvim',
            event = "VeryLazy"
        },
        {
            'p00f/godbolt.nvim',
            cmd = "Godbolt",
            event = "VeryLazy"
        },
        { 'kevinhwang91/promise-async' },
        {
            "kevinhwang91/nvim-fundo",
            dependencies = { 'kevinhwang91/promise-async' },
            build = function()
                require("fundo").install()
            end,
            lazy = false,
        },
        {
            'tzachar/highlight-undo.nvim',
            opts = {
                duration = 300,
                undo = {
                    hlgroup = 'HighlightUndo',
                    mode = 'n',
                    lhs = 'u',
                    map = 'undo',
                    opts = {}
                },
                redo = {
                    hlgroup = 'HighlightUndo',
                    mode = 'n',
                    lhs = '<C-r>',
                    map = 'redo',
                    opts = {}
                },
                highlight_for_count = true,
            },
            lazy = false
        },

        {
            'tpope/vim-eunuch',
            event = "CmdlineEnter",
        },
        {
            'tpope/vim-repeat',
            event = "InsertEnter",
        },
        {
            'benjaminchristie/csgithub.nvim',
            event = "VeryLazy"
        },
        {
            'folke/tokyonight.nvim',
            lazy = false,
            priority = 1000,
            config = function()
                require("colors")
            end
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
        'nvim-lua/plenary.nvim',
        {
            "nvim-treesitter/nvim-treesitter",

            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
            config = function()
                require("nvim-treesitter.configs").setup({
                    auto_install = true,
                    highlight = {
                        enable = true,
                        disable = { "tex", "latex" },
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = 'gnn',
                            scope_incremental = '<CR>',
                            node_incremental = '<TAB>',
                            node_decremental = '<S-TAB>',
                        }
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                                ['al'] = '@loop.outer',
                                ['il'] = '@loop.inner',
                            }
                        },
                        move = {
                            enable = true,
                            set_jumps = true,
                            goto_next_start = {
                                [']f'] = '@function.outer',
                                [']if'] = '@function.inner',
                                [')'] = '@parameter.inner',
                                [']c'] = '@call.outer',
                                [']ic'] = '@call.inner',
                            },
                            goto_next_end = {
                                [']F'] = '@function.outer',
                                [']iF'] = '@function.inner',
                                ['g)'] = '@parameter.inner',
                                [']C'] = '@call.outer',
                                [']iC'] = '@call.inner',
                            },
                            goto_previous_start = {
                                ['[f'] = '@function.outer',
                                ['[if'] = '@function.inner',
                                ['('] = '@parameter.inner',
                                ['[c'] = '@call.outer',
                                ['[ic'] = '@call.inner',
                            },
                            goto_previous_end = {
                                ['[F'] = '@function.outer',
                                ['[iF'] = '@function.inner',
                                ['g('] = '@parameter.inner',
                                ['[C'] = '@call.outer',
                                ['[iC'] = '@call.inner',
                            },
                        }
                    }
                })
            end
        },
        {
            'folke/neodev.nvim',
            opts = {
                library = {
                    plugins =
                    { "nvim-dap-ui" },
                    types = true
                },
            }
        },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                {
                    'folke/neodev.nvim',
                    'j-hui/fidget.nvim',
                    'nvim-treesitter/nvim-treesitter',
                    'kosayoda/nvim-lightbulb',
                    'VidocqH/lsp-lens.nvim',
                },
            },
            config = function()
                require("lsp-init")
            end,
            event = { "BufReadPre", "BufNewFile" },
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            event = "VeryLazy"
        },
        {
            'L3MON4D3/LuaSnip',
            event = "VeryLazy"
        },
        {
            'hrsh7th/cmp-buffer',
            event = "VeryLazy"
        },
        {
            'hrsh7th/cmp-cmdline',
            event = "VeryLazy"
        },
        {
            'petertriho/cmp-git',
            event = "VeryLazy"
        },
        {
            'hrsh7th/cmp-path',
            event = "VeryLazy"
        },

        {
            'hrsh7th/nvim-cmp',
            commit = '969c5a',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-cmdline',
                'petertriho/cmp-git',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lsp',
            },
            config = function()
                require("cmp-init")
            end,
            event = { "InsertEnter", "CmdlineEnter" }
        },
        {
            'michaelb/sniprun',
            build = "sh install.sh",
            event = "VeryLazy",
            cmd = "SnipRun"
        },
        {
            'simrat39/rust-tools.nvim',
            ft = "rust",
        },
        {
            'windwp/nvim-autopairs',
            config = function() require("pairs-init") end,
            lazy = false,
        },
        {
            'windwp/nvim-ts-autotag',
            opts = { filetypes = { "html", "xml" } },
            ft = { "html", "xml" },
            event = "VeryLazy",
        },
        {
            'mfussenegger/nvim-dap',
            dependencies = {
                'Weissle/persistent-breakpoints.nvim',
            },
            config = function()
                require("dap-init")
            end,
            event = "VeryLazy"
        },
        {
            'mfussenegger/nvim-dap-python',
            dependencies = 'mfussenegger/nvim-dap',
            event = "VeryLazy",
            ft = "python"
        },
        {
            'Weissle/persistent-breakpoints.nvim',
            opts = { load_breakpoints_event = { "BufReadPost" } }
        },
        {
            'leoluz/nvim-dap-go',
            dependencies = 'mfussenegger/nvim-dap',
            event = "VeryLazy",
            ft = "go"
        },
        {
            'rcarriga/nvim-dap-ui',
            dependencies = 'mfussenegger/nvim-dap',
            event = "VeryLazy"
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            dependencies = 'mfussenegger/nvim-dap',
            event = "VeryLazy"
        },
        {
            'ThePrimeagen/harpoon',
            event = "VeryLazy",
        },
        {
            'lewis6991/gitsigns.nvim',
            lazy = false,
            priority = 1000,
            opts = {
                numhl = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    delay = 0,
                    virt_text_pos = "right_align",
                    ignore_whitespace = true,
                },
                current_line_blame_formatter = " <author>, <author_time> - <abbrev_sha> - <summary>  "
            },
        },
        {
            'tpope/vim-fugitive',
            lazy = false
        },
        {
            'ibhagwan/fzf-lua',
            opts = {
                "telescope",
                winopts = {
                    width = 0.95,
                    height = 0.95,
                    preview = {
                        border       = 'border', -- border|noborder, applies only to
                        wrap         = 'nowrap', -- wrap|nowrap
                        hidden       = 'nohidden', -- hidden|nohidden
                        vertical     = 'down:45%', -- up|down:size
                        horizontal   = 'right:60%', -- right|left:size
                        layout       = 'flex', -- horizontal|vertical|flex
                        flip_columns = 120, -- #cols to switch to horizontal on flex
                        title        = true, -- preview border title (file/buf)?
                        title_pos    = "center", -- left|center|right, title alignment
                        scrollbar    = 'float', -- `false` or string:'float|border'
                        scrolloff    = '-2', -- float scrollbar offset from right
                        scrollchars  = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
                        delay        = 100, -- delay(ms) displaying the preview
                        winopts      = { -- builtin previewer window options
                            number         = true,
                            relativenumber = false,
                            cursorline     = true,
                            cursorlineopt  = 'both',
                            signcolumn     = 'no',
                        },
                    },
                },
            },
            event = "VeryLazy",
            cmd = "FzfLua",
        },
        'kyazdani42/nvim-web-devicons',
        {
            'stevearc/oil.nvim',
            dependencies = 'kyazdani42/nvim-web-devicons',
            opts = {
                columns = {
                    "icon"
                },
                win_options = {
                    conceallevel = 3,
                },
                skip_confirm_for_simple_edits = true,
                prompt_save_on_select_new_entry = false,
                keymaps = {
                    ["<C-v>"] = "actions.select_vsplit",
                    ["<C-s>"] = "actions.select_split",
                    ["<C-h>"] = "actions.toggle_hidden",
                    ["<C-t>"] = "actions.select_tab",
                    ["<C-c>"] = "actions.close",
                    ["<C-l>"] = "actions.refresh",
                    ["<C-p>"] = "actions.preview",
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = "actions.tcd",
                },
                use_default_keymaps = false,
                view_options = {
                    is_hidden_file = function(name, _)
                        return vim.startswith(name, ".") and not vim.startswith(name, ".gitignore")
                    end
                }
            },
            cmd = "Oil"
        },
        {
            'IMOKURI/line-number-interval.nvim',
            dependencies = {
                'folke/tokyonight.nvim',
            },
            init = function()
                vim.api.nvim_set_var("line_number_interval#custom_interval", { 1, 2, 3, 4, 5 })
                vim.api.nvim_set_var("line_number_interval#use_custom", 1)
                vim.g.line_number_interval_enable_at_startup = 1
            end,
            lazy = false
        },
        {
            'akinsho/toggleterm.nvim',
            init = function()
                require("term-init")
            end,
        },
        {
            'chrisgrieser/nvim-early-retirement',
            lazy = false,
            opts = {
                retirementAgeMins = 10,
                ignoreVisibileBufs = false,
                notificationOnAutoClose = false,
            }
        },
        'itchyny/vim-qfedit',
        {
            'kevinhwang91/nvim-ufo',
            dependencies = 'kevinhwang91/promise-async',
            config = function()
                local handler = function(virtText, lnum, endLnum, width, truncate)
                    local newVirtText = {}
                    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                    local sufWidth = vim.fn.strdisplaywidth(suffix)
                    local targetWidth = width - sufWidth
                    local curWidth = 0
                    for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                            table.insert(newVirtText, chunk)
                        else
                            chunkText = truncate(chunkText, targetWidth - curWidth)
                            local hlGroup = chunk[2]
                            table.insert(newVirtText, { chunkText, hlGroup })
                            chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            -- str width returned from truncate() may less than 2nd argument, need padding
                            if curWidth + chunkWidth < targetWidth then
                                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                            end
                            break
                        end
                        curWidth = curWidth + chunkWidth
                    end
                    table.insert(newVirtText, { suffix, 'MoreMsg' })
                    return newVirtText
                end
                local ufo = require("ufo")
                ufo.setup({
                    enable_get_fold_virt_text = true,
                    fold_virt_text_handler = handler,
                    provider_selector = function(_, _, _)
                        return { 'treesitter', 'indent' }
                    end
                })
            end,
            keys = {
                {"zR", function() return require("ufo").openAllFolds() end, desc = "open all folds"},
                {"zM", function() return require("ufo").closeAllFolds() end, desc = "open all folds"},
                {"zr", function() return require("ufo").openFoldsExceptKinds() end, desc = "open all folds"},
                {"zm", function() return require("ufo").closeFoldsWith()() end, desc = "open all folds"},
            },
            event = "VeryLazy"
        },
        { 'kylechui/nvim-surround' },
        {
            'lukas-reineke/indent-blankline.nvim',
            init = function()
                require("ibl-init")
            end,
            branch = "v3",
        },
        {
            'mbbill/undotree',
            config = function()
                vim.g.undotree_DiffpanelHeight = 17
                vim.g.undotree_WindowLayout = 2
                vim.g.undotree_SetFocusWhenToggle = 1
                vim.g.undotree_ShortIndicators = 1
                vim.g.undotree_DiffCommand = "git diff -p"
            end,
            cmd = "UndotreeToggle",
            keys = {
                {'U', ':UndotreeToggle<CR>'}
            }
        },
        {
            'nguyenvukhang/nvim-toggler',
            opts = {
                inverses = {
                    ['false'] = 'true',
                    ['False'] = 'True',
                    ['=='] = '!=',
                },
                remove_default_keybinds = true,
                remove_default_inverses = true,
            }
        },
        {
            'sindrets/diffview.nvim',
            config = function() require("diffview-init") end,
        },
        {
            't-troebst/perfanno.nvim',
            config = function() require("perfanno-init") end,
        },
        { 'tpope/vim-commentary', event = "BufEnter" },
        { 'tpope/vim-dispatch',   event = "BufEnter" },
        { 'tpope/vim-eunuch',     event = "BufEnter" },
        {
            'tzachar/local-highlight.nvim',
            opts = {
                disable_file_types = { 'tex' },
                hlgroup = 'LocalHighlight',
                cw_hlgroup = nil,
            },
            lazy = false,
            dependencies = { "folke/tokyonight.nvim" }
        },
        {
            'vladdoster/remember.nvim', event = "BufEnter"
        },
        {
            'VidocqH/lsp-lens.nvim',
            opts = {
                enable = false,
                include_declaration = false, -- Reference include declaration
                sections = {                 -- Enable / Disable specific request
                    definition = true,
                    references = true,
                    implements = false,
                }
            },
        },
        {
            'benjaminchristie/mini.starter',
            config = function()
                require("starter-init")
            end,
            lazy = false,
        },
        {
            'benjaminchristie/nvim-colorizer.lua',
            cmd = "ColorizerToggle",
        },
        {
            'dstein64/vim-startuptime',
            lazy = true,
            enabled = false
        },
        {
            'kosayoda/nvim-lightbulb',
            opts = {
                hide_in_unfocused_buffer = false,
                sign = {
                    enabled = true,
                    text = "💡",
                    hl = "LightBulbSign",
                },
                autocmd = {
                    enabled = true,
                    updatetime = 10
                },
                ignore = {
                    ft = { "lua" }
                }
            }
        },
        {
            'j-hui/fidget.nvim',
            opts = {
                window = {
                    blend = 0,
                    relative = "editor"
                }
            },
            tag = "legacy"
        },
        {
            'nacro90/numb.nvim',
            event = "CmdlineEnter",
            opts = {
                show_numbers = true,
                hide_relativenumbers = false,
            }
        },


        -- externally managed plugins
        {
            'junegunn/fzf', build = "./install --all --no-fish", enabled = true, pin = true,
        },
        {
            'LuaLS/lua-language-server',
            commit = "d912dfc05636ca113eb074d637905f4b2514229d",
            build = table.concat({
                    "./make.sh",
                    "noglob echo \"" ..
                    vim.fn.stdpath("data") ..
                    "/lazy/lua-language-server/bin/lua-language-server \"\\$@\"\" > $HOME/.local/bin/lua-language-server",
                    "chmod +x $HOME/.local/bin/lua-language-server"
                },
                " && "
            ),
            pin = true,
        },
        {
            "tomblind/local-lua-debugger-vscode",
            enabled = function()
                return vim.fn.executable("npm")
            end,
            pin = true,
            build = "npm install && npm run build",
        },
        {
            "bash-lsp/bash-language-server",
            enabled = function()
                return vim.fn.executable("pnpm") and vim.fn.executable("npm")
            end,
            pin = true,
            build = table.concat({
                    "pnpm install",
                    "pnpm compile",
                    "npm i -g --prefix ./bin ./server",
                    "noglob echo \"" ..
                    vim.fn.stdpath("data") ..
                    "/lazy/bash-language-server/bin/bin/bash-language-server \"\\$@\"\" > $HOME/.local/bin/bash-language-server",
                    "chmod +x $HOME/.local/bin/bash-language-server",
                },
                " && "
            )
        },
        {
            'artempyanykh/marksman',
            build = 'make install',
            enabled = function()
                return vim.fn.executable("dotnet")
            end,
            pin = true,
        },
        {
            'regen100/cmake-language-server',
            enabled = function()
                return vim.fn.executable("pip")
            end,
            build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources cmake-language-server",
        },
        {
            'RobertCraigie/pyright-python',
            enabled = function()
                return vim.fn.executable("pip")
            end,
            build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources pyright",
        },
        {
            'wbolster/black-macchiato',
            enabled = function()
                return vim.fn.executable("pip")
            end,
            build = vim.fn.stdpath("config") .. "/bin/pip-script.sh black-macchiato",
        },
        {
            'latex-lsp/texlab',
            enabled = function()
                return vim.fn.executable("cargo")
            end,
            build = "cargo build --release --color=never && cp ./target/release/texlab $HOME/.local/bin"
        }

    },
    {
        defaults = {
            lazy = true
        },
        install = {
            colorscheme = { "torte" }
        },
        diff = {
            cmd = "diffview.nvim",
        }
    }
)

require("statuswinbar").setup()
require("config_functions")
require("config_autocmds")
require("config_keymaps")
