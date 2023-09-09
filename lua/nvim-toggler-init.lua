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
