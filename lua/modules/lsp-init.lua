-- Setup lspconfig.
-- neodev must be called before lspconfig
require("neodev").setup({
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
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", {
        buffer = bufnr,
        callback = function() vim.lsp.inlay_hint(bufnr, true) end,
        group = "lsp_augroup",
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
        buffer = bufnr,
        callback = function() vim.lsp.inlay_hint(bufnr, false) end,
        group = "lsp_augroup",
    })
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
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
                undefined_global = false,
                missing_parameters = false,
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
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
        "--clang-tidy-checks='" .. table.concat(clang_tidy_checks, ",") .. "'",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--suggest-missing-includes",
        "--compile-commands-dir='.'"
    }
})
