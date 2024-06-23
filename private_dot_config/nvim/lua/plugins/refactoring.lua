return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function(_, opts)
    local refactoring = require 'refactoring'
    vim.keymap.set('n', '<leader>cp', function()
      refactoring.debug.printf {
        below = false,
        show_success_message = false,
      }
    end, { desc = 'Refactoring: printf' })

    vim.keymap.set({ 'x', 'n' }, '<leader>cv', function()
      ---@diagnostic disable-next-line: missing-parameter
      refactoring.debug.print_var()
    end, { desc = 'Refactoring: print var' })

    vim.keymap.set('n', '<leader>cP', function()
      refactoring.debug.cleanup {
        show_success_message = true,
      }
    end)

    refactoring.setup(opts)
  end,
}
