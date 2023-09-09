-- Setup lspconfig.
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
    -- disable lsp watcher. Too slow on linux
    wf._watchfunc = function()
        return function() end
    end
end
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
vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- TODO: make this better. since some filetypes define their own A-f formatting call, this needs to be improved
vim.keymap.set('n', '<A-f>', function()
    print("Calling LSP buf format...")
    vim.lsp.buf.format()
end, { desc = "calls lsp buf format" })
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.keymap.set('n', '<C-h><C-q>', vim.diagnostic.open_float, { desc = "diagnostics assistance" })
    vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, { desc = "diagnostics assistance" })
    vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, { desc = "diagnostics assistance" })
    vim.keymap.set('n', 'gh', vim.diagnostic.setloclist, { desc = "diagnostics assistance" })
    vim.keymap.set('n', 'gH', vim.diagnostic.setqflist, { desc = "diagnostics assistance" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', '<space>', vim.lsp.buf.hover)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    vim.keymap.set('n', '<C-h><C-g>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<C-h><C-d>', vim.lsp.buf.type_definition)
    vim.keymap.set('n', '<C-h><C-r><C-m>', vim.lsp.buf.rename)
    vim.keymap.set('n', '<C-h><C-e>', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
end
Lsp_inlay_hints_enabled = false
local on_attach_with_inlay_hints = function(client, bufnr)
    vim.lsp.inlay_hint(bufnr, Lsp_inlay_hints_enabled)
    return on_attach(client, bufnr)
end

vim.keymap.set('n', '<A-i>', function()
    Lsp_inlay_hints_enabled = not Lsp_inlay_hints_enabled
    print("Setting inlay hints to " .. tostring(Lsp_inlay_hints_enabled) .. "...")
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        pcall(vim.lsp.inlay_hint, bufnr, Lsp_inlay_hints_enabled)
    end
end)

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
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
            }
        }
    },
    root_dir = require('lspconfig/util').root_pattern('.git'),
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
    on_attach = function(client, buffer)
        on_attach(client, buffer)
        client.server_capabilities.semanticTokensProvider = nil
        vim.treesitter.stop()
        vim.cmd('call TexNewMathZone("D","align",1)')
    end,
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
    on_attach = on_attach_with_inlay_hints,
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
            hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = false,
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
        '--tsProbeLocations',
        default_probe_dir,
        '--ngProbeLocations',
        default_probe_dir
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
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.rs",
    callback = function()
        require("rust-tools").setup({
            server = {
                on_attach = on_attach_with_inlay_hints,
                flags = lsp_flags,
                capabilities = capabilities,
                autostart = true,
            }
        })
    end
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
    on_attach = on_attach_with_inlay_hints,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
    cmd = {
        "clangd",
        "-j=2",
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
        "--compile-commands-dir='.'",
        "--inlay-hints=true"
    }
})
