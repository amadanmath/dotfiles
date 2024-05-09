local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = "qic", name = "Require Ricecream", desc = "Require Ricecream" }, {
    t({ 'require "ricecream" # NOTE: DEBUG: gem install ricecream', "" }),
  }),
}
