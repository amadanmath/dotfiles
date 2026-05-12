return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      config = function()
        require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
        vim.keymap.set("n", "<leader>xs", function()
          require("luasnip.loaders").edit_snippet_files()
        end, { desc = "Edit Snippets" })
      end,
    },
  },
  opts = {
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      preset = "super-tab",
      ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-Space>"] = {},
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    signature = {
      enabled = true,
    },
  },
}
