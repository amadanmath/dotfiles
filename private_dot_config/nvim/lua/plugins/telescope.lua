return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { '<leader>sh', desc = '[S]earch [H]elp' },
    { '<leader>sk', desc = '[S]earch [K]eymaps' },
    { '<leader>sf', desc = '[S]earch [F]iles' },
    { '<leader>st', desc = '[S]earch [T]elescope' },
    { '<leader>sw', desc = '[S]earch current [W]ord' },
    { '<leader>sg', desc = '[S]earch by [G]rep' },
    { '<leader>sd', desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', desc = '[S]earch [R]esume' },
    { '<leader>s.', desc = '[S]earch Recent Files' },
    { '<leader><leader>', desc = '[ ] Find existing buffers' },
    { '<leader>/', desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', desc = '[S]earch [/] in Open Files' },
    { '<leader>sn', desc = '[S]earch [N]eovim files' },
    { '<leader>sF', desc = 'Project [S]earch [F]iles' },
    { '<leader>sG', desc = 'Project [S]earch by [G]rep' },
  },
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
    },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font,
    },
    {
      'benfowler/telescope-luasnip.nvim',
      keys = {
        { '<leader>sp', function()
          require('telescope').load_extension 'luasnip'
          require('telescope').extensions.luasnip.luasnip()
        end, desc = '[S]earch sni[P]pets' },
      },
    },
    -- {
    --   'nvim-telescope/telescope-frecency.nvim',
    --   keys = {
    --     { '<leader>ss', '<cmd>Telescope frecency<cr>', desc = '[S]earch by frecency' },
    --   },
    --   config = function()
    --     require('telescope').load_extension 'frecency'
    --   end,
    -- },
    {
      'debugloop/telescope-undo.nvim',
      keys = {
        { '<leader>su', function()
          require('telescope').load_extension 'undo'
          require('telescope').extensions.undo.undo()
        end, desc = '[S]earch [U]ndo tree' },
      },
    },
    -- 'mfussenegger/nvim-dap', -- Removed to prevent eager loading
  },
  opts = {
    defaults = {
      mappings = {
        i = {},
        n = {},
      },
    },
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  },
  config = function(_, opts)
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- Add trouble integration if available
    local trouble_ok, trouble = pcall(require, 'trouble.sources.telescope')
    if trouble_ok then
      opts.defaults.mappings.i["<C-t>"] = trouble.open
      opts.defaults.mappings.n["<C-t>"] = trouble.open
    end

    -- integrate flash.nvim
    local flash_ok, flash = pcall(require, 'flash')
    if flash_ok then
      local function flash_jump(prompt_bufnr)
        flash.jump {
          pattern = '^',
          label = { after = { 0, 0 } },
          search = {
            mode = 'search',
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
              end,
            },
          },
          action = function(match)
            local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        }
      end
      opts.defaults.mappings.n.s = flash_jump
      opts.defaults.mappings.i['<c-s>'] = flash_jump
    end
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local telescope = require 'telescope'
    telescope.setup(opts)

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    -- Load other extensions lazily when needed
    -- pcall(telescope.load_extension, 'dap')
    -- pcall(telescope.load_extension, 'refactoring')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    -- Load refactoring extension lazily
    vim.keymap.set({ 'n', 'x' }, '<leader>cf', function()
      pcall(telescope.load_extension, 'refactoring')
      telescope.extensions.refactoring.refactors()
    end, { desc = '[C]ode re[F]actor' })
    -- TODO: use `cwd = require('project').get_project_root()`

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    local project_ok, project = pcall(require, 'project_nvim.project')
    if project_ok then
      vim.keymap.set('n', '<leader>sF', function()
        local root, _ = require('project_nvim.project').get_project_root()
        builtin.find_files { cwd = root }
      end, { desc = 'Project [S]earch [F]iles' })

      vim.keymap.set('n', '<leader>sG', function()
        local root, _ = require('project_nvim.project').get_project_root()
        builtin.live_grep { cwd = root }
      end, { desc = 'Project [S]earch by [G]rep' })
    end
  end,
}
