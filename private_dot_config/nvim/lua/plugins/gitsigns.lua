-- See `:help gitsigns` to understand what the configuration keys do
return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Next hunk' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Previous hunk' })

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset hunk' })
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[S]tage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[R]eset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[U]ndo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review hunk' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = '[B]lame line' })
      map('n', '<leader>hB', gitsigns.toggle_current_line_blame, { desc = 'Toggle current line [B]lame' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff this' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '~'
      end, { desc = '[D]iff this harder' }) -- XXX: change description once you know what this does
      map('n', '<leader>hX', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', '<Cmd>Gitsigns select_hunk<CR>', { desc = '[H]unk' })
    end,
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
