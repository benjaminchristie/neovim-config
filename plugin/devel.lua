require("local-highlight").setup({
    disable_file_types = { 'tex', 'lua' },
    hlgroup = 'LocalHighlight',
    cw_hlgroup = nil,
})
require("ts-node-action").setup({}) -- default config
require("lsp-lens").setup({
    enable = false,
    include_declaration = false, -- Reference include declaration
    sections = {               -- Enable / Disable specific request
        definition = true,
        references = true,
        implements = false,
    },
})
require("diffview").setup({
    keymaps = {
        disable_defaults = true,
    }
})
require('nvim-toggler').setup({
  inverses = {
    ['false'] = 'true',
    ['False'] = 'True',
    ['=='] = '!=',
  },
  -- removes the default <leader>i keymap
  remove_default_keybinds = true,
  -- removes the default set of inverses
  remove_default_inverses = true,
})
