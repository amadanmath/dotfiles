return {
  -- Detect project root
  'ahmedkhalf/project.nvim',
  lazy = false,
  opts = {
    manual_mode = true,
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.project' },
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end,
}
