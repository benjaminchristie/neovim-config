local starter = require('mini.starter')

local cached_repos = function ()
    return require("telescope").extensions.repo.cached_list{file_ignore_patterns={"/%.cache/", "/%.cargo/", "/%.local/share/", "/%.zsh/"}}
end

local telescope_items = function()
  return function()
    return {
      {action = 'Telescope find_files',      name = 'Workspace files',           section = 'Telescope'},
      {action = cached_repos,                name = 'Projects',           section = 'Telescope'},
      {action = 'Telescope command_history', name = 'Command history', section = 'Telescope'},
      {action = 'Telescope help_tags',       name = 'Help tags',       section = 'Telescope'},
      {action = 'Telescope live_grep',       name = 'Live grep',       section = 'Telescope'},
      {action = 'Telescope oldfiles',        name = 'Recent files',       section = 'Telescope'},
    }
  end
end
starter.setup({
    evaluate_single = false,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(5, false),
      telescope_items(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center")
      -- starter.gen_hook.padding(3, 2),
    },
})

