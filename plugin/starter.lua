local starter = require('mini.starter')

local function cached_repos()
    return require("telescope").extensions.repo.cached_list { file_ignore_patterns = {
        "/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"
    } }
end

local function statustool()
    if not pcall(function() vim.cmd('tab G') end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local function difftool()
    local branch = vim.fn.input("Perform difftool on : ")
    vim.cmd("echon ' '")
    if not pcall(function() vim.cmd("Git difftool -y " .. branch) end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local function mergetool()
    vim.cmd("echon ' '")
    if not pcall(function() vim.cmd("Git mergetool -y ") end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local function ws_files()
    -- if vim.b.gitsigns_head ~= nil then
    --     vim.cmd("FzfLua git_files")
    -- else
    --     vim.cmd("FzfLua files")
    -- end
    vim.cmd("FzfLua git_files")
end

local extra_items = function()
    return function()
        return {
            { action = 'FzfLua live_grep', name = 'Grep',            section = 'Actions' },
            { action = 'FzfLua help_tags', name = 'Help',            section = 'Actions' },
            { action = 'FzfLua oldfiles',  name = 'History',         section = 'Actions' },
            { action = cached_repos,       name = 'Projects',        section = 'Actions' },
            { action = ws_files,           name = 'Workspace files', section = 'Actions' },
            { action = difftool,           name = 'Diff tool',       section = 'Actions' },
            { action = mergetool,          name = 'Merge tool',      section = 'Actions' },
            { action = statustool,         name = 'Status',          section = 'Actions' },
        }
    end
end

local function ascii_headers(rand)
    if rand < 1 then
        return [[
           __________
         .'----------`.
         | .--------. |
         | |########| |       __________
         | |########| |      /__________\
.--------| `--------' |------|    --=-- |------.
|        `----,-.-----'      |o ======  |      |
|       ______|_|_______     |__________|      |
|      /  %%%%%%%%%%%%  \                      |
|     /  %%%%%%%%%%%%%%  \                     |
|     ^^^^^^^^^^^^^^^^^^^^                     |
+----------------------------------------------+
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ]]
    elseif rand < 2 then
        return [[
                            )      ((     (
                           (        ))     )
                    )       )      //     (
               _   (        __    (     ~->>
        ,-----' |__,_~~___<\'__`)-~__--__-~->> <
        | //  : | -__   ~__ o)____)),__ - \'> >-  >
        | //  : |- \_ \ -\_\ -\ \ \ ~\_  \ ->> - ,  >>
        | //  : |_~_\ -\__\ \~'\ \ \, \__ . -<-  >>
        `-----._| `  -__`-- - ~~ -- ` --~> >
         _/___\_    //)_`//  | ||]
   _____[_______]_[~~-_ (.L_/  ||
  [____________________]' `\_,/'/
    ||| /          |||  ,___,'./
    ||| \          |||,'______|
    ||| /          /|| I==||
    ||| \       __/_||  __||__
-----||-/------`-._/||-o--o---o---
        ]]
    elseif rand < 3 then
        return [[
,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
| ~ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | [ | ] | <-    |
|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
| ->| | " | , | . | P | Y | F | G | C | R | L | / | = |  \  |
|-----',--',--',--',--',--',--',--',--',--',--',--',--'-----|
| Caps | A | O | E | U | I | D | H | T | N | S | - |  Enter |
|------'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--------|
|        | ; | Q | J | K | X | B | M | W | V | Z |          |
|------,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
| ctrl |  | alt |                          | alt  |  | ctrl |
'------'  '-----'--------------------------'------'  '------'
    ]]
    elseif rand < 4 then
        return [[
    .---.
   /     \
   \.@-@./
   /`\_/`\
  //  _  \\
 | \     )|_
/`\_`>  <_/ \
\__/'---'\__/
    ]]
    elseif rand < 5 then
        return [[
    (\____/)
     (_oo_)
       (O)
     __||__    \)
  []/______\[] /
  / \______/ \/
 /    /__\
(\   /____\
    ]]
    elseif rand < 6 then
        return [[
       _______
     _/       \_
    / |       | \
   /  |__   __|  \
  |__/((o| |o))\__|
  |      | |      |
  |\     |_|     /|
  | \           / |
   \| /  ___  \ |/
    \ | / _ \ | /
     \_________/
      _|_____|_
 ____|_________|____
/                   \
    ]]
    elseif rand < 7 then
        return [[
          0 _____
           X_____\
   .-^-.  ||_| |_||  .-^-.
  /_\_/_\_|  |_|  |_/_\_/_\
  ||(_)| __\_____/__ |(_)||
  \/| | |::|\```/|::| | |\/
  /`---_|::|-+-+-|::|_---'\
 / /  \ |::|-|-|-|::| /  \ \
/_/   /|`--'-+-+-`--'|\   \_\
| \  / |===/_\ /_\===| \  / |
|  \/  /---/-/-\-\  o\  \/  |
| ||| | O / /   \ \   | ||| |
| ||| ||-------------|o|||| |
      ]]
    elseif rand < 8 then
        return [[
   *  .  . *       *    .        .        .   *    ..
 .    *        .   ###     .      .        .            *
    *.   *        #####   .     *      *        *    .
  ____       *  ######### *    .  *      .        .  *   .
 /   /\  .     ###\#|#/###   ..    *    .      *  .  ..  *
/___/  ^8/      ###\|/###  *    *            .      *   *
|   ||%%(        # }|{  #
|___|,  \\         }|{
    ]]
    elseif rand < 9 then
        local username = os.getenv("USER")
        username = string.gsub(username, "^%l", string.upper)
        return string.format([[
   .   ,- To the Moon %s !
  .'.            .       .
  |o|      .  *      .        .  *   .
 .'o'.       * .        .   *    ..
 |.-.|       .        .            *
 '   '     *      *        *    .
  ( )     .  *      .        .  *   .
   )    ..    *    .      *  .  ..  *
  ( )      *            .      *   *
    ]], username)
    end
end

local function ascii_main()
    math.randomseed(os.time())
    local NUM_ARTWORK = 9
    local rand = math.random(0, NUM_ARTWORK)
    local str = ascii_headers(rand)
    return str, rand
end
local ascii_art = ascii_headers(8.5)

-- local function path_modifier(str, max_count)
--     -- can use vim.regex() for this...
--     local tail = vim.fn.fnamemodify(str, ":t")
--     local head = vim.fn.fnamemodify(str, ":h")
--     local new_str = ""
--     local count = 0
--     if head == nil or #head <= max_count then
--         return str
--     else
--         for c in string.gmatch(head, '.') do
--             if c == "/" then
--                 count = 0
--             end
--             if count < max_count then
--                 new_str = new_str .. c
--                 count = count + 1
--             end
--         end
--     end
--     new_str = new_str .. "/"
--     return new_str .. tail
-- end
starter.setup({
    evaluate_single = false,
    header = ascii_art,
    items = {
        starter.sections.recent_files(7, false, true, function(x) return vim.fn.pathshorten(x, 3) end),
        extra_items(),
    },
    content_hooks = {
        starter.gen_hook.aligning("center", "center"),
        starter.gen_hook.padding(0, 0),
    },
    footer = "",
})