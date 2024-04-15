return {
  {
    "Exafunction/codeium.nvim",
    event = 'BufEnter',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- patch to allow enable/disable per buffer
      -- see https://github.com/Exafunction/codeium.nvim/issues/136#issuecomment-2056619763
      local Source = require("codeium.source")

      local function is_codeium_enabled()
        local enabled = vim.b["codeium_enabled"]
        if enabled == nil then
          enabled = vim.g["codeium_enabled"]
          if enabled == nil then
            enabled = true -- enable by default
          end
        end
        return enabled
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      function Source:is_available()
        local enabled = is_codeium_enabled()
        ---@diagnostic disable-next-line: undefined-field
        return enabled and self.server.is_healthy()
      end

      vim.api.nvim_set_keymap('n', '<leader>nc', '', {
        callback = function()
          local new_enabled = not is_codeium_enabled()
          vim.b["codeium_enabled"] = new_enabled
          if new_enabled then
            vim.notify("Codeium enabled for buffer")
          else
            vim.notify("Codeium disabled for buffer")
          end
        end,
        noremap = true,
        desc = "Toggle Codeium",
      })

      vim.g.codeium_enabled = false

      require("codeium").setup({
      })
    end,
  },
}
