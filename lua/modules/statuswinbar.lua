local lsp = require('feline.providers.lsp')
require('gitsigns').setup()
local vi_mode_utils = require('feline.providers.vi_mode')

local vi_mode_colors = {
  NORMAL = 'oceanblue',
  OP = 'green',
  INSERT = 'red',
  CONFIRM = 'red',
  VISUAL = 'magenta',
  LINES = 'magenta',
  BLOCK = 'magenta',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}
local components = {
    active = {{}, {}, {}},
    inactive = {{}, {}, {}}
}
local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}
force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}
components.inactive[1][1] = {
  provider = function()
    -- return vi_mode_text[vi_mode_utils.get_vim_mode()]
    return vim.fn.pathshorten(vim.fn.expand('%:~:f'))
  end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = {
    str = '',
    hl = {
      fg = 'NONE',
      bg = 'bg'
    }
  },
  right_sep = {
    {
      str = '',
      hl = {
        fg = 'NONE',
        bg = 'bg'
      }
    },
  }
}

components.active[1][1] = {
  provider = function()
    -- return vi_mode_text[vi_mode_utils.get_vim_mode()]
    return vim.fn.pathshorten(vim.fn.expand('%:~:f'))
  end,
  hl = function()
    local val = {}
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = 'block',
  left_sep = 'block'
}

local colors = require("tokyonight.colors").setup({})
require('feline').setup({theme=colors, vi_mode_colors=vi_mode_colors, components={}})
require('feline').winbar.setup({
    -- theme = nordtheme,
    colors = colors,
    -- default_bg = colors.bg,
    -- default_fg = colors.fg_sidebar,
    components = components,
    force_inactive = force_inactive
})
