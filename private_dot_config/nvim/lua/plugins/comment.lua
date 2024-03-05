return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "x" }, desc = "Comment (linewise)" },
      { "gb", mode = { "n", "x" }, desc = "Comment (block)" },
    },
    opts = {
      padding = true, -- Add a space b/w comment and the line
      sticky = true, -- Whether the cursor should stay at its position
      mappings = {
        basic = true, -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        extra = true, -- Includes `gco`, `gcO`, `gcA`
      },
      toggler = {
        line = "gcc", -- Line-comment toggle keymap
        block = "gbc", -- Block-comment toggle keymap
      },
      opleader = {
        line = "gc", -- Line-comment keymap
        block = "gb", -- Block-comment keymap
      },
      config = function()
        -- TODO: check if this is correct
        require("Comment").setup({
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
      end,
    },
  },
}
