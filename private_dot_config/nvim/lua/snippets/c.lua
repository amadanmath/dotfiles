local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = "qic", name = "Include IceCream-C", desc = "Include IceCream-C" }, {
    t({
      '/* wget https://raw.githubusercontent.com/chunqian/icecream-c/master/icecream.h */',
      '#include "icecream.h"',
      '',
    }),
  }),
}
