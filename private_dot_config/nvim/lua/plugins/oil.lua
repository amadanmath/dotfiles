return {
  -- explorer
  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>e", "<Cmd>Oil<CR>", desc = "Oil" },
    },
    cmd = "Oil",
    lazy = false,
    opts = {
      columns = {
        "icon",
        "permissions",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
