return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<space>db', desc = 'Toggle [b]reakpoint' },
      { '<space>dc', desc = '[C]onditional breakpoint' },
      { '<space>dX', desc = 'Clear all breakpoints' },
      { '<space>dt', desc = 'Go [t]o cursor' },
      { '<space>dj', desc = 'Frame down' },
      { '<space>dk', desc = 'Frame up' },
      { '<space>dh', desc = '[H]over variables' },
      { '<space>dd', desc = 'Focus frame' },
      { '<space>dU', desc = 'Toggle [U]I' },
      { '<space>dr', desc = 'Toggle [R]EPL' },
      { '<space>dw', desc = 'Toggle [w]atches' },
      { '<F1>', desc = 'Continue' },
      { '<F2>', desc = 'Step into' },
      { '<F3>', desc = 'Step over' },
      { '<F4>', desc = 'Step out' },
      { '<F5>', desc = 'Step back' },
      { '<F10>', desc = 'Terminate' },
      { '<F12>', desc = 'Restart' },
      { '<leader>de', desc = '[E]val var', mode = { 'n', 'v' } },
      { '<leader>dE', desc = '[E]val var and enter', mode = { 'n', 'v' } },
      { '<leader>dss', desc = 'Commands' },
      { '<leader>dsc', desc = '[C]onfigurations' },
      { '<leader>dsb', desc = '[B]reakpoints' },
      { '<leader>dsv', desc = '[V]ariables' },
      { '<leader>dsf', desc = '[F]rames' },
    },
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'nvim-telescope/telescope-dap.nvim',
      '0000marcell/nvim-dap-ruby',
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local telescope = require 'telescope'
      local widgets = require 'dap.ui.widgets'

      ui.setup()

      require('dap-go').setup()
      -- NOTE: needs 'pydebug' package in the default venv
      require('dap-python').setup '~/.venv/default/bin/python'
      -- NOTE: needs `debugger` statement as a breakpoint
      require('dap-ruby').setup()

      require('nvim-dap-virtual-text').setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
            return '*****'
          end

          if #variable.value > 15 then
            return ' ' .. string.sub(variable.value, 1, 15) .. '... '
          end

          return ' ' .. variable.value
        end,
      }

      local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
      if elixir_ls_debugger ~= '' then
        dap.adapters.mix_task = {
          type = 'executable',
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = 'mix_task',
            name = 'phoenix server',
            task = 'phx.server',
            request = 'launch',
            projectDir = '${workspaceFolder}',
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
          },
        }
      end

      vim.keymap.set('n', '<space>db', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
      vim.keymap.set('n', '<space>dc', function()
        local cond = vim.fn.input 'Condition: '
        if cond ~= '' then
          dap.set_breakpoint(cond)
        end
      end, { desc = '[C]onditional breakpoint' })
      vim.keymap.set('n', '<space>dX', dap.clear_breakpoints, { desc = 'Clear all breakpoints' })
      vim.keymap.set('n', '<space>dt', dap.run_to_cursor, { desc = 'Go [t]o cursor' })
      vim.keymap.set('n', '<space>dj', dap.down, { desc = 'Frame down' })
      vim.keymap.set('n', '<space>dk', dap.up, { desc = 'Frame up' })
      vim.keymap.set('n', '<space>dh', widgets.hover, { desc = '[H]over variables' })
      vim.keymap.set('n', '<space>dd', dap.focus_frame, { desc = 'Focus frame' })
      vim.keymap.set('n', '<space>dU', ui.toggle, { desc = 'Toggle [U]I' })
      vim.keymap.set('n', '<space>dr', function()
        ---@diagnostic disable-next-line: missing-fields
        ui.float_element('repl', {
          width = 100,
          height = 20,
          enter = true,
          position = 'center',
        })
      end, { desc = 'Toggle [R]EPL' })
      vim.keymap.set('n', '<space>dw', function()
        ---@diagnostic disable-next-line: missing-fields
        ui.float_element('watches', {
          width = 100,
          height = 20,
          enter = true,
          position = 'bottom',
        })
      end, { desc = 'Toggle [w]atches' })

      vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Step into' })
      vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Step over' })
      vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Step out' })
      vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'Step back' })
      vim.keymap.set('n', '<F10>', dap.terminate, { desc = 'Terminate' })
      vim.keymap.set('n', '<F12>', dap.restart, { desc = 'Restart' })

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>de', ui.eval, { desc = '[E]val var' })
      vim.keymap.set('n', '<leader>dE', function()
        ---@diagnostic disable-next-line: missing-fields
        ui.eval(nil, { enter = true })
      end, { desc = '[E]val var and enter' })
      vim.keymap.set('v', '<leader>de', ui.eval, { desc = '[E]val selection' })
      vim.keymap.set('v', '<leader>dE', function()
        ---@diagnostic disable-next-line: missing-fields
        ui.eval(nil, { enter = true })
      end, { desc = '[E]val selection and enter' })

      -- Load DAP telescope extension lazily
      vim.keymap.set('n', '<leader>dss', function()
        require('telescope').load_extension 'dap'
        telescope.extensions.dap.commands()
      end, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>dsc', function()
        require('telescope').load_extension 'dap'
        telescope.extensions.dap.configurations()
      end, { desc = '[C]onfigurations' })
      vim.keymap.set('n', '<leader>dsb', function()
        require('telescope').load_extension 'dap'
        telescope.extensions.dap.list_breakpoints()
      end, { desc = '[B]reakpoints' })
      vim.keymap.set('n', '<leader>dsv', function()
        require('telescope').load_extension 'dap'
        telescope.extensions.dap.variables()
      end, { desc = '[V]ariables' })
      vim.keymap.set('n', '<leader>dsf', function()
        require('telescope').load_extension 'dap'
        telescope.extensions.dap.frames()
      end, { desc = '[F]rames' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
