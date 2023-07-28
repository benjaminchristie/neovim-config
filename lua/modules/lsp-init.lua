  -- Setup lspconfig.
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
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-h><C-q>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gh', vim.diagnostic.setloclist, opts)

local function pyright_order_imports()
    local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(0) },
    }
    vim.lsp.buf.execute_command(params)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', '<space>', require("nabla").popup, bufopts)
    vim.keymap.set('n', '<space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-h><C-g>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<C-h>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<C-h>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<C-h>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<C-h><C-d>', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<C-h><C-r><C-m>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<C-h><C-e>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<C-h><C-/>', vim.diagnostic.open_float, bufopts)
    if client.name == "pyright" then
        vim.api.nvim_create_augroup("Pyright", {clear = false})
        vim.api.nvim_create_autocmd({"BufWritePre"}, {
            group = "Pyright",
            pattern = "*.py",
            callback = pyright_order_imports,
        })
    end
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require('lspconfig').cmake.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').pylsp.setup{
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      client.server_capabilities.completionProvider = false
    end,
    flags = lsp_flags,
    capabilities = capabilities, -- i only want constructive feedback from pylsp
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {
                       'W391', 'E231', 'E203', 'E731',
                       'E126', 'E131', 'E128', 'E101',
                       'W191', 'E502', 'E226'
                    },
                    maxLineLength = 120
                }
            }
        }
    }
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig')['texlab'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').bashls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
        undefined_global = false,
        missing_parameters = false,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    autostart = true,
    cmd = {
        -- see clangd --help-hidden
        "clangd",
        "--background-index",
        -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
        -- to add more checks, create .clang-tidy file in the root directory
        -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
        "--clang-tidy",
        "--clang-tidy-checks='clang-analyzer-core*,clang-analyzer-unix*,bugprone*,modernize*'",
        -- '--clang-tidy-checks="clang-diagnostic-*,clang-analyzer-*,modernize*,performance*,readability*"',
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--suggest-missing-includes",
        -- "--compile-commands-dir='/home/benjamin/.config/nvim/lua/lsp-info/'",
    },
}
require('lspconfig').html.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').cssls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').dockerls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig').marksman.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
local function get_probe_dir(root_dir)
  local project_root = require('lspconfig/util').find_node_modules_ancestor(root_dir)

  return project_root and (project_root .. '/node_modules') or ''
end
local default_probe_dir = get_probe_dir(vim.fn.getcwd())
require('lspconfig').angularls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = {
        'angularls',
        '--stdio',
        '--tsProbeLocations', default_probe_dir,
        '--ngProbeLocations', default_probe_dir
    },
    filetypes = {'typescript', 'html', 'typescriptreact', 'typescript.tsx'},
    root_dir = require('lspconfig/util').root_pattern('angular.json', '.git'),
}
require('lspconfig').asm_lsp.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
local rt = require("rust-tools")

rt.setup({
  server = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
  }
})
