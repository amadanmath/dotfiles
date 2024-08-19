return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.setup()

    -- Document existing key chains
    wk.add({
      { "<leader>c", group = "[C]ode" },
      { "<leader>c_", hidden = true },
      { "<leader>d", group = "[D]AP" },
      { "<leader>d_", hidden = true },
      { "<leader>ds", group = "[S]earch (Telescope)" },
      { "<leader>ds_", hidden = true },
      { "<leader>h", group = "Git [H]unk" },
      { "<leader>h_", hidden = true },
      { "<leader>o", group = "[O]bsidian" },
      { "<leader>o_", hidden = true },
      { "<leader>s", group = "[S]earch" },
      { "<leader>s_", hidden = true },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>w_", hidden = true },
      { "<leader>x", group = "Trouble" },
      { "<leader>x_", hidden = true },
    })
    -- visual mode
    wk.add({
      { "<leader>h", desc = "Git [H]unk", mode = "v" },
    })
  end,
}
