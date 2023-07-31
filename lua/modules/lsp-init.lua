  -- Setup lspconfig.
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
local on_attach = function(_, bufnr)
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
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
lspconfig.cmake.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
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
lspconfig['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['texlab'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.bashls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.lua_ls.setup {
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
lspconfig.html.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.cssls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.dockerls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.marksman.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
local function get_probe_dir(root_dir)
  local project_root = require('lspconfig/util').find_node_modules_ancestor(root_dir)

  return project_root and (project_root .. '/node_modules') or ''
end
local default_probe_dir = get_probe_dir(vim.fn.getcwd())
lspconfig.angularls.setup{
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
lspconfig.asm_lsp.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require("rust-tools").setup({
  server = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
  }
})
local function find_cc_json(fn)
    local _, e = string.find(fn, "_ws/src/[^/]*/")
    local project_path = string.sub(fn, 0, e)
    local project_build_path = string.gsub(project_path, "src", "build", 1)
    return project_build_path, vim.fn.filereadable(project_build_path .. "compile_commands.json")
end

vim.api.nvim_create_autocmd({"BufAdd"}, {
    pattern = {"*.cpp", "*.h", "*.hpp", "*.c"},
    callback = function ()
        local fn = vim.api.nvim_buf_get_name(0)
        local active_clangd_clients = vim.lsp.get_active_clients({name="clangd"})
        if string.find(fn, "_ws/src/") and (#active_clangd_clients == 0) then
            -- possibly in catkin_ws
            local pbp, pbp_exists = find_cc_json(fn)
            local use_generated_json = "n"
            if pbp_exists then
                use_generated_json = vim.fn.input("Use " .. pbp .. " as project build path? [Y/n] : ")
            end
            if string.lower(use_generated_json) ~= "n" then
                lspconfig['clangd'].setup{
                    on_attach = on_attach,
                    flags = lsp_flags,
                    capabilities = capabilities,
                    autostart = true,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--clang-tidy-checks='clang-analyzer-core*,clang-analyzer-unix*,bugprone*,modernize*'",
                        "--cross-file-rename",
                        "--header-insertion=iwyu",
                        "--suggest-missing-includes",
                        "--compile-commands-dir='"..pbp.."'",
                    }
                }
                return
            end
        end
        lspconfig['clangd'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
            autostart = true,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--clang-tidy-checks='clang-analyzer-core*,clang-analyzer-unix*,bugprone*,modernize*'",
                "--cross-file-rename",
                "--header-insertion=iwyu",
                "--suggest-missing-includes",
            }
        }
    end
})
