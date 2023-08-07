-- Setup lspconfig.
-- neodev must be called before lspconfig
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
        vim.lsp.handlers.hover,
        {
            border = "single"
        }
    )

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "single"
        }
    )
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- client.server_capabilities.semanticTokensProvider = nil
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
lspconfig.cmake.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.pyright.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
-- lspconfig.pylsp.setup{
--     on_attach = function(client)
--       client.resolved_capabilities.document_formatting = false
--       client.resolved_capabilities.document_range_formatting = false
--       client.server_capabilities.completionProvider = false
--     end,
--     flags = lsp_flags,
--     capabilities = capabilities, -- i only want constructive feedback from pylsp
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     ignore = {
--                        'W391', 'E231', 'E203', 'E731',
--                        'E126', 'E131', 'E128', 'E101',
--                        'W191', 'E502', 'E226'
--                     },
--                     maxLineLength = 120
--                 }
--             }
--         }
--     }
-- }
lspconfig['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig['texlab'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.bashls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
                undefined_global = false,
                missing_parameters = false,
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
lspconfig.html.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.cssls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.dockerls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
lspconfig.marksman.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
local function get_probe_dir(root_dir)
    local project_root = require('lspconfig/util').find_node_modules_ancestor(root_dir)

    return project_root and (project_root .. '/node_modules') or ''
end
local default_probe_dir = get_probe_dir(vim.fn.getcwd())
lspconfig.angularls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = false,
    cmd = {
        'angularls',
        '--stdio',
        '--tsProbeLocations', default_probe_dir,
        '--ngProbeLocations', default_probe_dir
    },
    filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
    root_dir = require('lspconfig/util').root_pattern('angular.json', '.git'),
}
lspconfig.asm_lsp.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
}
require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        autostart = true,
    }
})

local clang_tidy_checks = {
    "clang-analyzer-core*",
    "clang-analyzer-unix*",
    "clang-analyzer-nullability*",
    "clang-analyzer-optin.cplusplus.UninitializedObject",
    "clang-analyzer-optin.cplusplus.VirtualCall",
    "bugprone*",
    "modernize*",
}

lspconfig['clangd'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--completion-style=bundled",
        "--pch-storage=memory",
        "--pretty",
        "--background-index",
        "--clang-tidy",
        "--clang-tidy-checks='"..table.concat(clang_tidy_checks, ",") .. "'",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--suggest-missing-includes",
        "--compile-commands-dir='.'"
    }
})
