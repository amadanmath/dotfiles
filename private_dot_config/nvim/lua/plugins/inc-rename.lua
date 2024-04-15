return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function(_, opts)
      require("inc_rename").setup(opts)
    end,
  },
}
