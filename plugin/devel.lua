require("local-highlight").setup({
    disable_file_types = {'tex'},
    hlgroup = 'LocalHighlight',
    cw_hlgroup = nil,
})
require("ts-node-action").setup({}) -- default config
require'lsp-lens'.setup({
  enable = false,
  include_declaration = false,      -- Reference include declaration
  sections = {                      -- Enable / Disable specific request
    definition = true,
    references = true,
    implements = false,
  },
})
