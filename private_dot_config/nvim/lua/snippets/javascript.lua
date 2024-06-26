local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local n = extras.nonempty

return {
  s({ trig = "fn", name = "Function" }, {
    t("function"),
    n(1, " ", ""),
    i(1, "name"),
    t("("),
    i(2, "params"),
    t({ ") {", "\t" }),
    i(3, "body"),
    t({ "", "}" }),
  }),

  s({ trig = "qs", name = "querySelector" }, {
    t("querySelector("),
    i(1, "selector"),
    t(")"),
  }),

  s({ trig = "qsa", name = "querySelectorAll" }, {
    t("querySelectorAll("),
    i(1, "selector"),
    t(")"),
  }),

  s({ trig = "doc", name = "document" }, {
    t("document"),
  }),

  s({ trig = "ael", name = "addEventListener" }, {
    t("addEventListener("),
    i(1, "event"),
    t({ ", evt => {", "\t" }),
    i(2, "body"),
    t({ "", "}" }),
  }),

  s({ trig = "qic", name = "Require node-icecream", desc = "Require node-icecream" }, {
    t({ "const ic = require('node-icecream')({}) // NOTE: DEBUG: npm install node-icecream", "" }),
  }),
}
