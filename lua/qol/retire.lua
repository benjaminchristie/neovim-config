return {
    'chrisgrieser/nvim-early-retirement',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        retirementAgeMins = 10,
        ignoreVisibileBufs = false,
        notificationOnAutoClose = false,
    }
}
