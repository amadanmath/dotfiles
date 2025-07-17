return {
  'gregorias/coerce.nvim',
  keys = {
    { '<leader>p', mode = { 'n', 'v' }, desc = 'Coerce' },
    { '<leader>P', mode = 'n', desc = 'Coerce (motion)' },
  },
  opts = {
    default_mode_keymap_prefixes = {
      normal_mode = '<leader>p',
      motion_mode = '<leader>P',
      visual_mode = '<leader>p',
    },
  },
}
