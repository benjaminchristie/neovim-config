return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end
        local ufo = require("ufo")
        ufo.setup({
            enable_get_fold_virt_text = true,
            fold_virt_text_handler = handler,
            provider_selector = function(_, _, _)
                return { 'treesitter', 'indent' }
            end
        })
    end,
    keys = {
        { "zR", function() return require("ufo").openAllFolds() end,         desc = "open all folds" },
        { "zM", function() return require("ufo").closeAllFolds() end,        desc = "open all folds" },
        { "zr", function() return require("ufo").openFoldsExceptKinds() end, desc = "open all folds" },
        { "zm", function() return require("ufo").closeFoldsWith() end,       desc = "open all folds" },
    },
    event = "VeryLazy",
	enabled = false,
}
