return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      '0000marcell/nvim-dap-ruby',
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'nvim-telescope/telescope-dap.nvim',
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
      -- NOTE: needs 'rdbg' gem, needs `debugger` statement as a breakpoint
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

      vim.keymap.set('n', '<leader>dss', telescope.extensions.dap.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>dsc', telescope.extensions.dap.configurations, { desc = '[C]onfigurations' })
      vim.keymap.set('n', '<leader>dsb', telescope.extensions.dap.list_breakpoints, { desc = '[B]reakpoints' })
      vim.keymap.set('n', '<leader>dsv', telescope.extensions.dap.variables, { desc = '[V]ariables' })
      vim.keymap.set('n', '<leader>dsf', telescope.extensions.dap.frames, { desc = '[F]rames' })

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
