local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = "qic", name = "Import IceCream-Go", desc = "Import IceCream-Go" }, {
    t({ 'import . "github.com/WAY29/icecream-go/icecream" // XXX: DEBUG', "" }),
  }),
}
