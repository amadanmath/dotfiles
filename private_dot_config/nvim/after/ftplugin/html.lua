local Util = require("lazyvim.util")
if Util.has("mini.ai") and Util.has("nvim-treesitter") then
  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  vim.b.miniai_config = {
    custom_textobjects = {
      t = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
    },
  }
end
