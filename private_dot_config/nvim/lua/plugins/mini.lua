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

    -- -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- --
    -- -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- -- - sd'   - [S]urround [D]elete [']quotes
    -- -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup()

    -- -- Simple and easy statusline.
    -- --  You could remove this setup call if you don't like it,
    -- --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
