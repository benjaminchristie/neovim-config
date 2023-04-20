local lsp = require('feline.providers.lsp')
require('gitsigns').setup()
local vi_mode_utils = require('feline.providers.vi_mode')
local nord0_gui = "#2E3440"
local nord1_gui = "#3B4252"
local nord2_gui = "#434C5E"
local nord3_gui = "#4C566A"
local nord3_gui_bright = "#616E88"
local nord4_gui = "#D8DEE9"
local nord5_gui = "#E5E9F0"
local nord6_gui = "#ECEFF4"
local nord7_gui = "#8FBCBB"
local nord8_gui = "#88C0D0"
local nord9_gui = "#81A1C1"
local nord10_gui = "#5E81AC"
local nord11_gui = "#BF616A"
local nord12_gui = "#D08770"
local nord13_gui = "#EBCB8B"
local nord14_gui = "#A3BE8C"
local nord15_gui = "#B48EAD"

local nordtheme = {
    fg = nord4_gui,
    bg = nord0_gui,
    white = nord6_gui,
    blue = nord8_gui,
    skyblue = nord9_gui,
    oceanblue = nord10_gui,
    black = nord4_gui,
    red = nord11_gui,
    orange = nord12_gui,
    yellow = nord13_gui,
    cyan = nord7_gui,
    green = nord14_gui,
    magenta = nord15_gui

}


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

local vi_mode_text = {
  NORMAL = 'N ',
  OP = 'N ',
  INSERT = 'I ',
  VISUAL = 'V ',
  LINES = 'V ',
  BLOCK = 'V ',
  REPLACE = 'R ',
  ['V-REPLACE'] = '<>',
  ENTER = '<> ',
  MORE = '<> ',
  SELECT = '<> ',
  COMMAND = 'C ',
  SHELL = 'T ',
  TERM = 'T ',
  NONE = '',
  CONFIRM = 'W '
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
  provider = 'file_type',
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

-- components.active[1][1] = {
--   provider = ' ',
--   hl = function()
--     local val = {}

--     val.bg = vi_mode_utils.get_mode_color()
--     val.fg = 'black'
--     val.style = 'bold'

--     return val
--   end,
--   right_sep = '',
--   left_sep = 'slant_left_2'
-- }
-- vi-symbol
components.active[1][1] = {
  provider = function()
    return vi_mode_text[vi_mode_utils.get_vim_mode()]
  end,
  hl = function()
    local val = {}
    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = 'slant_right',
  left_sep = 'block'
}
-- filename
components.active[1][2] = {
  provider = function()
    return vim.fn.pathshorten(vim.fn.expand('%:~:f'))
  end,
  hl = {
    fg = 'fg',
    bg = 'oceanblue',
    style = 'bold',
  },
  right_sep = 'slant_right',
  left_sep = 'left_filled'
}
-- MID

-- gitBranch
components.active[2][1] = {
  provider = 'git_branch',
  hl = {
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffAdd
components.active[2][2] = {
  provider = 'git_diff_added',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffModfified
components.active[2][3] = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffRemove
components.active[2][4] = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  },
}

-- RIGHT

-- fileIcon
-- components.active[3][1] = {
--   provider = function()
--     local filename = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
--     if icon == nil then
--       icon = ''
--     end
--     return icon
--   end,
--   hl = function()
--     local val = {}
--     local filename = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
--     if icon ~= nil then
--       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'black')
--     else
--       val.fg = 'black'
--     end
--     val.bg = 'oceanblue'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' ',
--   left_sep = 'slant_left'
-- }
-- fileType
-- components.active[3][1] = {
--   provider = 'file_type',
--   hl = function()
--     local val = {}
--     local filename = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
--     if icon ~= nil then
--       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'black')
--     else
--       val.fg = 'black'
--     end
--     val.bg = 'oceanblue'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' ',
--   left_sep = ' '
-- }
-- fileSize
components.active[3][1] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:F')) > 0 end,
  hl = {
    fg = 'bg',
    bg = 'oceanblue',
    style = 'bold'
  },
  right_sep = 'slant_right_2',
  left_sep = 'left_filled'
}
-- fileFormat
-- components.active[3][4] = {
--   provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
-- -- fileEncode
-- components.active[3][5] = {
--   provider = 'file_encoding',
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
components.active[3][2] = {
  provider = 'position',
  hl = {
    fg = 'bg',
    bg = 'oceanblue',
    style = 'bold'
  },
  right_sep = 'slant_right_2',
  left_sep = 'left_filled'
}

-- linePercent
components.active[3][3] = {
  provider = 'line_percentage',
  hl = {
    fg = 'bg',
    bg = 'oceanblue',
    style = 'bold'
  },
  right_sep = '',
  left_sep = 'left_filled'
}
-- -- scrollBar
-- components.active[3][6] = {
--   provider = 'scroll_bar',
--   hl = {
--     fg = 'skyblue',
--     bg = 'bg',
--   },
-- }
--
local colors = require("tokyonight.colors").setup({})
require('feline').setup({
    -- theme = nordtheme,
    theme = colors,
    default_bg = colors.bg,
    default_fg = colors.fg_sidebar,
    vi_mode_colors = vi_mode_colors,
    components = components,
    force_inactive = force_inactive
})
-- local winbar_components = {
--     active = {{}, {}, {}},
--     inactive = {{}, {}, {}}
-- }
-- winbar_components.active[3][1] = {
--   provider = function()
--     return vim.fn.pathshorten(vim.fn.expand('%:f'), 1)
--   end,
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold',
--   },
--   right_sep = 'slant_right',
--   left_sep = 'slant_left_2'
-- }
--require('feline').winbar.setup({
--    theme = nordtheme,
--    default_bg = nordtheme.bg,
 --   default_fg = nordtheme.fg,
  --  components = winbar_components,
--})
-- require('feline').add_theme('nord', nordtheme)
