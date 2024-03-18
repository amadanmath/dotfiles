return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      -- XXX: Why no completion for `:Telescope lazy_plugins`?
      "polirritmico/telescope-lazy-plugins.nvim",
      keys = {
        { "<leader>sl", "<cmd>Telescope lazy_plugins<cr>" },
      },
      cmd = "Telescope lazy_plugins",
    },
  },
}
