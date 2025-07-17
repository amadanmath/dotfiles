return {
  'rcarriga/nvim-notify',
  enabled = false, -- Disabled for testing vanilla experience
  opts = {
    timeout = 5000,
  },
  config = function(_, opts)
    vim.notify = require 'notify'
    vim.notify.setup(opts)
  end,
}
