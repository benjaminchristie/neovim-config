return {
    'latex-lsp/texlab',
    enabled = function()
        return vim.fn.executable("cargo") == 1
    end,
    build = "cargo build --release --color=never && cp ./target/release/texlab $HOME/.local/bin"
}
