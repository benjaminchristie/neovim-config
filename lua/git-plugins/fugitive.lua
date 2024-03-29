return {
    'tpope/vim-fugitive',
    cmd = { "G", "Git", "Gvdiffsplit", "Gread" },
    keys = {
        { 'gR', ':Git rebase --interactive -i HEAD~' },
        { 'gC', ':Git rebase --continue<CR>' },
        { 'gP', ':Git checkout --patch <branch> <filename>' },
        { 'gD', ':Gvdiffsplit!<CR>' },
    },
}
