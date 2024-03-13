return {
  {
    "benfowler/telescope-luasnip.nvim",
    keys = {
      { "<leader>fs", "<cmd>Telescope luasnip<cr>", desc = "LuaSnip" },
    },
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
}
