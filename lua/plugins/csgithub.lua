return {
    'benjaminchristie/csgithub.nvim',
    event = "VeryLazy",
    keys = {
        { '<A-g>',
            function()
                local csgithub = require("csgithub")
                local url = csgithub.search({
                    includeFilename = false,
                    includeExtension = true,
                })
                if url == nil then
                    return
                end
                csgithub.open(url)
            end
        },
    },

}
