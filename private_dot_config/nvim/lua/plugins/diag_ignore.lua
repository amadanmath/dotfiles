return {
  {
    "amadanmath/diag_ignore.nvim",
    keys = '<leader>ci',
    config = function(_, opts)
      require('diag_ignore').setup(opts)
    end,
  },
}
