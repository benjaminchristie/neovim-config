local starter = require('mini.starter')

local function cached_repos()
    return require("telescope").extensions.repo.cached_list{file_ignore_patterns={"/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"}}
end

local function difftool()
    local branch = vim.fn.input("Perform difftool on : ")
    vim.cmd("Git difftool -y " .. branch)
end

local function mergetool()
    local branch = vim.fn.input("Perform mergetool on : ")
    vim.cmd("Git mergetool -y " .. branch)
end

local extra_items = function()
  return function()
    return {
      {action = 'Telescope find_files',      name = 'Workspace files',           section = 'Telescope'},
      {action = cached_repos,                name = 'Projects',                  section = 'Telescope'},
      {action = 'Telescope help_tags',       name = 'Help',                      section = 'Telescope'},
      {action = 'Telescope oldfiles',        name = 'History',                   section = 'Telescope'},
      {action = 'tab G',                     name = 'Status',                    section = 'Fugitive'},
      {action = difftool,                    name = 'Diff tool',                 section = 'Fugitive'},
      {action = mergetool,                   name = 'Merge tool',                section = 'Fugitive'},
    }
  end
end

starter.setup({
    evaluate_single = false,
    items = {
      starter.sections.recent_files(7, false),
      extra_items(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center")
      -- starter.gen_hook.padding(3, 2),
    },
    footer = "",
})

