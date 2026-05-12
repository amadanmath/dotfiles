return {
  "mfussenegger/nvim-dap",
  keys = {
    { "<space>db", desc = "Toggle breakpoint" },
    { "<space>dc", desc = "Conditional breakpoint" },
    { "<space>dX", desc = "Clear all breakpoints" },
    { "<space>dt", desc = "Go to cursor" },
    { "<space>dj", desc = "Frame down" },
    { "<space>dk", desc = "Frame up" },
    { "<space>dh", desc = "Hover variables" },
    { "<space>dd", desc = "Focus frame" },
    { "<space>dU", desc = "Toggle UI" },
    { "<space>dr", desc = "Toggle REPL" },
    { "<space>dw", desc = "Toggle watches" },
    { "<F1>", desc = "Continue" },
    { "<F2>", desc = "Step into" },
    { "<F3>", desc = "Step over" },
    { "<F4>", desc = "Step out" },
    { "<F5>", desc = "Step back" },
    { "<F10>", desc = "Terminate" },
    { "<F12>", desc = "Restart" },
    { "<leader>de", desc = "Eval var", mode = { "n", "v" } },
    { "<leader>dE", desc = "Eval var and enter", mode = { "n", "v" } },
    { "<leader>dss", desc = "DAP Commands" },
    { "<leader>dsc", desc = "DAP Configurations" },
    { "<leader>dsb", desc = "DAP Breakpoints" },
    { "<leader>dsv", desc = "DAP Variables" },
    { "<leader>dsf", desc = "DAP Frames" },
  },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    { "mason-org/mason.nvim", opts = {} },
    "nvim-telescope/telescope-dap.nvim",
    "0000marcell/nvim-dap-ruby",
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local telescope = require("telescope")
    local widgets = require("dap.ui.widgets")

    ui.setup()
    require("dap-go").setup()
    require("dap-python").setup("~/.venv/default/bin/python")
    require("dap-ruby").setup()

    require("nvim-dap-virtual-text").setup({
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
          return "*****"
        end
        if #variable.value > 15 then
          return " " .. string.sub(variable.value, 1, 15) .. "... "
        end
        return " " .. variable.value
      end,
    })

    local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
    if elixir_ls_debugger ~= "" then
      dap.adapters.mix_task = {
        type = "executable",
        command = elixir_ls_debugger,
      }
      dap.configurations.elixir = {
        {
          type = "mix_task",
          name = "phoenix server",
          task = "phx.server",
          request = "launch",
          projectDir = "${workspaceFolder}",
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
      }
    end

    vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<space>dc", function()
      local cond = vim.fn.input("Condition: ")
      if cond ~= "" then dap.set_breakpoint(cond) end
    end, { desc = "Conditional breakpoint" })
    vim.keymap.set("n", "<space>dX", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
    vim.keymap.set("n", "<space>dt", dap.run_to_cursor, { desc = "Go to cursor" })
    vim.keymap.set("n", "<space>dj", dap.down, { desc = "Frame down" })
    vim.keymap.set("n", "<space>dk", dap.up, { desc = "Frame up" })
    vim.keymap.set("n", "<space>dh", widgets.hover, { desc = "Hover variables" })
    vim.keymap.set("n", "<space>dd", dap.focus_frame, { desc = "Focus frame" })
    vim.keymap.set("n", "<space>dU", ui.toggle, { desc = "Toggle UI" })
    vim.keymap.set("n", "<space>dr", function()
      ---@diagnostic disable-next-line: missing-fields
      ui.float_element("repl", { width = 100, height = 20, enter = true, position = "center" })
    end, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<space>dw", function()
      ---@diagnostic disable-next-line: missing-fields
      ui.float_element("watches", { width = 100, height = 20, enter = true, position = "bottom" })
    end, { desc = "Toggle watches" })

    vim.keymap.set("n", "<F1>", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Step back" })
    vim.keymap.set("n", "<F10>", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<F12>", dap.restart, { desc = "Restart" })

    vim.keymap.set("n", "<leader>de", ui.eval, { desc = "Eval var" })
    vim.keymap.set("n", "<leader>dE", function()
      ---@diagnostic disable-next-line: missing-fields
      ui.eval(nil, { enter = true })
    end, { desc = "Eval var and enter" })
    vim.keymap.set("v", "<leader>de", ui.eval, { desc = "Eval selection" })
    vim.keymap.set("v", "<leader>dE", function()
      ---@diagnostic disable-next-line: missing-fields
      ui.eval(nil, { enter = true })
    end, { desc = "Eval selection and enter" })

    vim.keymap.set("n", "<leader>dss", function()
      require("telescope").load_extension("dap")
      telescope.extensions.dap.commands()
    end, { desc = "DAP Commands" })
    vim.keymap.set("n", "<leader>dsc", function()
      require("telescope").load_extension("dap")
      telescope.extensions.dap.configurations()
    end, { desc = "DAP Configurations" })
    vim.keymap.set("n", "<leader>dsb", function()
      require("telescope").load_extension("dap")
      telescope.extensions.dap.list_breakpoints()
    end, { desc = "DAP Breakpoints" })
    vim.keymap.set("n", "<leader>dsv", function()
      require("telescope").load_extension("dap")
      telescope.extensions.dap.variables()
    end, { desc = "DAP Variables" })
    vim.keymap.set("n", "<leader>dsf", function()
      require("telescope").load_extension("dap")
      telescope.extensions.dap.frames()
    end, { desc = "DAP Frames" })

    dap.listeners.before.attach.dapui_config = function() ui.open() end
    dap.listeners.before.launch.dapui_config = function() ui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
    dap.listeners.before.event_exited.dapui_config = function() ui.close() end
  end,
}
