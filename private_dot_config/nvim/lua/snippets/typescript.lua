local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = "qic", name = "Require node-icecream", desc = "Require node-icecream" }, {
    t({
      "// NOTE: DEBUG: npm install node-icecream",
      "import ice from 'node-icecream'",
      "const ic = ice({})",
      "",
    }),
  }),
}
