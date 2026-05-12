return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  main = "project_nvim",
  opts = {
    manual_mode = true,
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".project", ".direnv" },
  },
}
