-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    keywords = {
      DEBUG = {
        icon = ' ',
        color = 'warning',
      },
    },
  },
}

-- TODO:
-- keymaps, trouble/telescope
-- https://github.com/folke/todo-comments.nvim?tab=readme-ov-file#jumping
