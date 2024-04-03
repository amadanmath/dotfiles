return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("hlchunk").setup({
        ---@diagnostic disable-next-line: missing-fields
        chunk = {
          enable = true,
          use_treesitter = true,
          -- chars = {
          --   horizontal_line = "━",
          --   vertical_line = "┃",
          --   left_top = "┏",
          --   left_bottom = "┗",
          --   right_arrow = "━",
          -- },
        },
        ---@diagnostic disable-next-line: missing-fields
        blank = { enable = false },
        line_num = {
          enable = true,
          use_treesitter = true,
        },
      })
    end,
  },
}
