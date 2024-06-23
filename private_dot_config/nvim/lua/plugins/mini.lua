return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        -- yiz. - a word including dots
        z = function()
          vim.api.nvim_echo({ { 'Word with character:' } }, false, {})
          local char = vim.pesc(vim.fn.nr2char(vim.fn.getchar()))
          return { '()()%f[%w_' .. char .. '][%w_' .. char .. ']+()[ \t]*()' }
        end,
        -- yiZ./<CR> - a word including dots and slashes
        Z = function()
          local char = vim.pesc(vim.fn.input 'Word with characters: ')
          return { '()()%f[%w_' .. char .. '][%w_' .. char .. ']+()[ \t]*()' }
        end,
      },
    }

    require('mini.bracketed').setup {
      quickfix = { suffix = '' }, -- use Trouble instead
    }

    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
