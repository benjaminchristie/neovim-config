  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', '<space>', require("nabla").popup, bufopts)
    vim.keymap.set('n', '<space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-h><C-g>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<C-h>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<C-h>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<C-h>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<C-h><C-d>', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<C-h><C-r><C-m>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<C-h><C-e>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<C-h><C-/>', vim.diagnostic.open_float, bufopts)
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
    on_attach = on_attach,
    flags = lsp_flags,
    -- capabilities = capabilities, -- i only want constructive feedback from pylsp
    settings = {
	pylsp = {
	    plugins = {
		pycodestyle = {
		    ignore = {'W391', 'E231', 'E203', 'E731',
		    'E126', 'E131', 'E128', 'E101', 'W191', 'E502'},
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
        -- '--clang-tidy-checks="clang-diagnostic-*,clang-analyzer-*,modernize*,performance*,readability*"',
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
    },
}
require('lspconfig').marksman.setup{
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
