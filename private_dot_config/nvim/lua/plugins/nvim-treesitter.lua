return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { -- {{{
    -- https://github.com/windwp/nvim-ts-autotag
    { -- nvim-ts-autotag {{{
      'windwp/nvim-ts-autotag',
      opts = {
        enable_close_on_slash = false, -- disable case: `<div /` become `<div /div>`
        filetypes = {
          'html',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'xml',
        },
      },
    }, -- }}}
    { -- nvim-treesitter-context {{{
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        max_lines = 3,
      },
    }, -- }}}
    { -- nvim-treesitter-textobjects {{{
      'nvim-treesitter/nvim-treesitter-textobjects',
      opts = {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              -- You can also use captures from other query groups like `locals.scm`
              ['ak'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              -- ['@parameter.outer'] = 'v', -- charwise
              -- ['@function.outer'] = 'V', -- linewise
              -- ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      },
      config = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
      end,
    }, -- }}}
  }, -- }}}
  opts = { -- {{{
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'vim',
      'vimdoc',

      'javascript',
      'typescript',
      'css',
      'gitignore',
      'http',
      'json',
      'scss',
      'sql',
    },
    -- Autoinstall languages that are not installed (disabled for faster startup)
    auto_install = false,
    highlight = {
      -- enable = true,
      -- https://github.com/alker0/chezmoi.vim?tab=readme-ov-file#-can-i-use-nvim-treesitter-for-my-chezmoi-template
      highlight = {
        disable = function()
          -- check if 'filetype' option includes 'chezmoitmpl'
          -- chezmoi.vim handles it without treesitter
          if string.find(vim.bo.filetype, 'chezmoitmpl') then
            return true
          end
        end,
      },
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  }, -- }}}
  config = function(_, opts) -- {{{
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end, -- }}}
}

-- vim: ts=2 sts=2 sw=2 et fdm=marker
