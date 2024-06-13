return {
  'gregorias/coerce.nvim',
  config = function(_, opts)
    local coerce = require 'coerce'
    local keymap = {
      '<leader>p',
      '<leader>P',
      '<leader>p',
    }
    for ix, mode in ipairs(coerce.default_modes) do
      mode.keymap_prefix = keymap[ix]
    end
    coerce.setup(opts)
  end,
}
