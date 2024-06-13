return {
  'sindrets/diffview.nvim',
  lazy = true,
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewLog',
    'DiffviewRefresh',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewFileHistory',
  },
  opts = function()
    local keymap_q_close = { 'n', 'q', ':DiffviewClose<cr>', { desc = 'Diffview Close' } }

    return {
      enhanced_diff_hl = true,
      keymaps = {
        view = {
          keymap_q_close,
        },
        file_panel = {
          keymap_q_close,
        },
        file_history_panel = {
          keymap_q_close,
        },
      },
    }
  end,
}
