local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({ trig = "td", name = "Todo checkbox", desc = "Insert a Todo checkbox" }, {
    t("- [ ] "),
    i(0),
  }),
}
