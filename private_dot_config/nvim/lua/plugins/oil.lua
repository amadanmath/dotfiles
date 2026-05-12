return {
  "stevearc/oil.nvim",
  main = "oil",
  cmd = "Oil",
  keys = {
    { "<leader>e", "<Cmd>Oil<CR>", desc = "Explore with Oil" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    columns = { "icon", "permissions" },
    win_options = {
      signcolumn = "yes:2",
    },
  },
}
