return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    -- Tried https://www.lazyvim.org/configuration/recipes#supertab
    -- but those settings don't seem to fit me well
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- Confirm with Tab
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select   = true,
            })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.config.disable,
      })
    end,
  },
}
