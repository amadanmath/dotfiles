local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local n = extras.nonempty

return {
  s({ trig = "fn", name = "Function", desc = "Insert a function" }, {
    t("function"),
    n(1, " ", ""),
    i(1, "name"),
    t("("),
    i(2, "params"),
    t({ ")", "\t" }),
    i(3, "body"),
    t({ "", "end" }),
    i(0),
  }),
}
