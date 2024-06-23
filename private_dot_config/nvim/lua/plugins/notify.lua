return {
  'rcarriga/nvim-notify',
  opts = {
    timeout = 5000,
  },
  config = function(_, opts)
    vim.notify = require 'notify'
    vim.notify.setup(opts)
  end,
}
