return {
  -- explorer replacement
  'stevearc/oil.nvim',
  keys = {
    { '<leader>e', '<Cmd>Oil<CR>', desc = '[E]xplore with Oil' },
  },
  cmd = 'Oil',
  lazy = false,
  opts = {
    columns = {
      'icon',
      'permissions',
    },
    win_options = {
      signcolumn = 'yes:2',
    },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function(_, opts)
    require('oil').setup(opts)
  end,
}
