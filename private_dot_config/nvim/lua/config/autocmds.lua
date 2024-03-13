-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local my_group = vim.api.nvim_create_augroup("my_group", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "catppuccin",
  group = mygroup,
  command = "highlight WinSeparator guifg=#666666",
})
