return {
    'latex-lsp/texlab',
    enabled = function()
        return vim.fn.executable("cargo")
    end,
    build = "cargo build --release --color=never && cp ./target/release/texlab $HOME/.local/bin"
}
