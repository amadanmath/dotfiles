return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
