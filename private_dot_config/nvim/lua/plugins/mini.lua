return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
      custom_textobjects = {
        z = function()
          vim.api.nvim_echo({ { "Word with character:" } }, false, {})
          local char = vim.pesc(vim.fn.nr2char(vim.fn.getchar()))
          return { "()()%f[%w_" .. char .. "][%w_" .. char .. "]+()[ \t]*()" }
        end,
        Z = function()
          local char = vim.pesc(vim.fn.input("Word with characters: "))
          return { "()()%f[%w_" .. char .. "][%w_" .. char .. "]+()[ \t]*()" }
        end,
      },
    })

    require("mini.bracketed").setup({
      quickfix = { suffix = "" },
    })

    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
