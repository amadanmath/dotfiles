return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    -- Keep LuaSnip for existing snippets
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/lua/snippets' } }
        -- Keep the snippet editing keymap
        vim.keymap.set('n', '<leader>xs', function()
          require('luasnip.loaders').edit_snippet_files()
        end, { desc = 'Edit [S]nippets' })
      end,
    },
  },
  version = '*',
  opts = {
    -- Use LuaSnip for snippet support
    snippets = {
      preset = 'luasnip',
    },
    
    -- Default completion sources
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    
    -- Supertab keymap configuration with Ctrl-Y instead of Ctrl-Space
    keymap = { 
      preset = 'super-tab',
      ['<C-y>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-Space>'] = {},  -- Disable Ctrl-Space
    },
    
    -- Appearance configuration
    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    
    -- Completion menu configuration
    completion = {
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    
    -- Enable signature help
    signature = {
      enabled = true,
    },
  },
}
