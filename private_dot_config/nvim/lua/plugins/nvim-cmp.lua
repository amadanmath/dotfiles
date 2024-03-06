local cmp = require("cmp")

return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
    },
  },
}
