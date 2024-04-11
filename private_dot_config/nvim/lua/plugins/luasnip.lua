return {
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    keys = function()
      return {}
    end,
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets" } })
    end,
  },
}
