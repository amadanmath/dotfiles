local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local n = extras.nonempty

return {
  s({ trig = "fn", name = "Function", desc = "Insert a function" }, {
    t("def "),
    i(1, "name"),
    t("("),
    i(2, "params"),
    t({ "):", "\t" }),
    i(3, "body"),
  }),

  s({ trig = "nier", name = "raise NotImplementedError", desc = "raise NotImplementedError" }, {
    t("raise NotImplementedError("),
    i(1, "explanation"),
    t(") # TODO: implement this"),
  }),
}
