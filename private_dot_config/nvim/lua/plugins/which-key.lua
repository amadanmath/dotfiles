return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    spec = {
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "DAP" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>h", group = "Git Hunk", mode = "v" },
      { "<leader>s", group = "Search" },
      { "<leader>w", group = "Workspace" },
      { "<leader>x", group = "Trouble" },
    },
  },
}
