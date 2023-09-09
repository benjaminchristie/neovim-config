require("lsp-lens").setup({
    enable = false,
    include_declaration = false, -- Reference include declaration
    sections = {               -- Enable / Disable specific request
        definition = true,
        references = true,
        implements = false,
    },
})
