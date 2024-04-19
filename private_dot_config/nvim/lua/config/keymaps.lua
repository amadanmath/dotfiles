-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Avoiding Meta bindings to prevent messing up Esc
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

-- LazyVim binds to next/prev buffer, but I need my H/L
vim.keymap.del("n", "<S-h>") -- originally cursor high, LazyVim binds to prev buffer
vim.keymap.del("n", "<S-l>") -- originally cursor low, LazyVim binds to next buffer

-- LazyVim binds to last buffer, but it also gives <leader>bb, so it is redundant
vim.keymap.del("n", "<leader>`")

-- LazyVim invokes nohl on <Esc>, but I prefer that on the default <C-l>
vim.keymap.del({ "i", "n" }, "<esc>")
vim.keymap.set(
  "n",
  "<C-l>",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw, clearing search" }
)

-- LazyVim thinks this is saner n/N but I am used to Vim
vim.keymap.del({ "n", "x", "o" }, "n")
vim.keymap.del({ "n", "x", "o" }, "N")

-- do not add random insert-mode breakpoints
vim.keymap.del("i", ",")
vim.keymap.del("i", ".")
vim.keymap.del("i", ";")

-- I know how to save files
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")

-- LazyVim keeps visual mode; I can use "." and "u"
vim.keymap.del("v", "<")
vim.keymap.del("v", ">")

-- TODO "<leader>uc" that doesn't globally remember 'conceallevel'

-- I know how to quit Vim
vim.keymap.del("n", "<leader>qq")

-- I know how use windows
vim.keymap.del("n", "<leader>ww") -- previous
vim.keymap.del("n", "<leader>wd") -- close
vim.keymap.del("n", "<leader>w-") -- split
vim.keymap.del("n", "<leader>w|") -- vertical
vim.keymap.del("n", "<leader>-")  -- split
vim.keymap.del("n", "<leader>|")  -- vertical

-- I don't use tabs, and I don't like <leader><tab> being taken for it
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")

----------

-- Edit snippets for current filetype
vim.keymap.set("n", "<leader>ne", function()
  require("luasnip.loaders").edit_snippet_files({
    ft_filter = function(ft)
      return ft == vim.bo.filetype
    end,
  })
end, { desc = "Edit ft snippets" })

-- Fix backspace: https://github.com/L3MON4D3/LuaSnip/issues/622#issuecomment-1275350599
vim.keymap.set("s", "<bs>", "<C-o>s", { desc = "Backspace (fixed)" })


-- Ignore diagnostics
-- TODO: pluginify
local function diag_ignore()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if diags then
    vim.ui.select(
      diags,
      {
        prompt = "Diagnostic to ignore:",
        format_item = function(diag)
          return diag.message .. " [" .. diag.code .. "]"
        end,
      },
      function(choice)
        if not choice then
          return
        end
        local where, prefix, suffix, joiner = unpack(vim.g.diag_ignore[vim.bo.filetype])
        if not joiner then
          joiner = ', '
        end
        local pto, col, line
        if where == 'prevline' then
          if lnum > 0 then
            line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
            _, pto = string.find(line, prefix, 1, true)
          end
          if pto then
            lnum = lnum - 1
          else
            line = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1]
            _, col = string.find(line, '^ *')
            local indent = string.sub(line, 1, col)
            line = indent .. prefix .. suffix
            vim.api.nvim_buf_set_lines(0, lnum, lnum, true, { line })
          end
        elseif where == 'endline' then
          line = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1]
          _, pto = string.find(line, prefix, 1, true)
          if not pto then
            col = string.len(line)
            vim.api.nvim_buf_set_text(0, lnum, col, lnum, col, { prefix .. suffix })
            line = line .. prefix .. suffix
          end
        else
          vim.notify('Invalid option: `' .. where .. '` (allowed: `prevline`, `endline`)', vim.log.levels.ERROR)
          return
        end
        if not pto then
          pto = col + string.len(prefix)
        end
        local endcol = string.len(line) - string.len(suffix)
        local ignorestr = string.sub(line, pto + 1, endcol)
        local types = ignorestr == "" and {} or vim.split(ignorestr, joiner)
        table.insert(types, choice.code)
        ignorestr = table.concat(types, joiner)
        vim.api.nvim_buf_set_text(0, lnum, pto, lnum, endcol, { ignorestr })
      end
    )
  end
end

vim.g.diag_ignore = {
  python = { 'endline', ' # type: ignore[', ']' },
  lua = { 'prevline', '---@diagnostic disable-next-line: ', '' },
}

vim.keymap.set("n", "<leader>ci", '', {
  desc = "Ignore a diagnostic",

  callback = diag_ignore,
})
