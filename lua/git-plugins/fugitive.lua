return {
    'tpope/vim-fugitive',
    cmd = { "G", "Git", "Gvdiffsplit" },
    keys = {
        { 'gR', ':Git rebase --interactive -i HEAD~' },
        { 'gC', ':Git rebase --continue<CR>' },
        { 'gP', ':Git checkout --patch <branch> <filename>' },
        { 'dl', ':diffget //3<CR>' },
        { 'dh', ':diffget //2<CR>' },
        { 'gD', ':Gvdiffsplit!<CR>' },
    },
}
