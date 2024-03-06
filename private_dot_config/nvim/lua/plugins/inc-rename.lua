return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      "<leader>cr",
    },
    config = function()
      require("inc_rename").setup()
    end,
  },
}
