return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>cp', mode = 'n', desc = 'Refactoring: print' },
    { '<leader>cv', mode = { 'x', 'n' }, desc = 'Refactoring: print var' },
    { '<leader>cP', mode = 'n', desc = 'Refactoring: remove prints' },
    { '<leader>cf', mode = { 'n', 'x' }, desc = '[C]ode re[F]actor' },
  },
  config = function(_, opts)
    local refactoring = require 'refactoring'
    vim.keymap.set('n', '<leader>cp', function()
      refactoring.debug.printf {
        below = false,
        show_success_message = false,
      }
    end, { desc = 'Refactoring: print' })

    vim.keymap.set({ 'x', 'n' }, '<leader>cv', function()
      ---@diagnostic disable-next-line: missing-parameter
      refactoring.debug.print_var()
    end, { desc = 'Refactoring: print var' })

    vim.keymap.set('n', '<leader>cP', function()
      refactoring.debug.cleanup {
        show_success_message = true,
      }
    end, { desc = 'Refactoring: remove prints' })

    refactoring.setup(opts)
  end,
}
