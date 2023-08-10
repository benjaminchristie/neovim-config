-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require("luasnip")
local npairs = require('nvim-autopairs')
local Rule   = require('nvim-autopairs.rule')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
npairs.setup({
    ignored_next_char = "[%w%.]",
    enable_check_bracket_line = false,
    disable_in_visual_block = true,
    disable_in_macro = true,
})
-- require("cmp_git").setup()
-- local dict = require("cmp_dictionary")
-- dict.setup({
--     exact = 2,
--     first_case_insensitive = true,
--     document = true,
--     document_command = "wn %s -over",
--     async = true,
--     sqlite = false,
--     max_items = 10,
--     capacity = 50,
--     debug = true,
-- })
-- dict.switcher({
--     spelllang = {
--         en = "/home/benjamin/.config/nvim/bin/dictionary/my.dict"
--     },
-- })
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = {
            border = nil,
        },
        documentation = {
            border = nil,
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' },
    }, {
        { name = 'buffer' },
        -- {
        --     name = 'dictionary',
        --     keyword_length = 2,
        -- },
    }),
    matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
    },
    experimental = {
        ghost_text = {
            hl_group = "GhostText"
        }
    }
})
-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'cmp_git' },
--         { name = 'buffer' },
--     })
-- })

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    })
})
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

local get_closing_for_line = function (line)
  local i = -1
  local clo = ''

  while true do
    i, _= string.find(line, "[%(%)%{%}%[%]]", i + 1)
    if i == nil then break end
    local ch = string.sub(line, i, i)
    local st = string.sub(clo, 1, 1)

    if ch == '{' then
      clo = '}' .. clo
    elseif ch == '}' then
      if st ~= '}' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '(' then
      clo = ')' .. clo
    elseif ch == ')' then
      if st ~= ')' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '[' then
      clo = ']' .. clo
    elseif ch == ']' then
      if st ~= ']' then return '' end
      clo = string.sub(clo, 2)
    end
  end

  return clo
end

npairs.remove_rule('(')
npairs.remove_rule('{')
npairs.remove_rule('[')

npairs.add_rule(Rule("[%(%{%[]", "")
  :use_regex(true)
  :replace_endpair(function(opts)
    return get_closing_for_line(opts.line)
  end)
  :end_wise(function(opts)
    -- Do not endwise if there is no closing
    return get_closing_for_line(opts.line) ~= ""
  end))

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
        brackets[4][1]..brackets[4][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end
