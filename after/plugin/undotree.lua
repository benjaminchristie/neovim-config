vim.g.undotree_DiffpanelHeight = 17
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_DiffCommand = "git diff -p"
vim.keymap.set('n', "U", vim.cmd.UndotreeToggle)
