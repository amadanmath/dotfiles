-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local my_group = vim.api.nvim_create_augroup("my_group", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "catppuccin", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" },
  group = my_group,
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#666666" })
    vim.api.nvim_set_hl(0, "LuasnipInsertNodeUnvisited", { bg = "#440000" })
    vim.api.nvim_set_hl(0, "LuasnipInsertNodeVisited", { bg = "#000066" })
    vim.api.nvim_set_hl(0, "LuasnipChoiceNodeUnvisited", { bg = "#440000" })
    vim.api.nvim_set_hl(0, "LuasnipChoiceNodeVisited", { bg = "#000066" })
  end,
})
