-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "+ "
vim.opt.foldopen:append({ "jump" })
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.wildignore:append({ "tags", "*.pyc", "__pycache__" })
vim.opt.winaltkeys = "no"
vim.opt.signcolumn = "number"
vim.opt.spelllang = { "en_US", "cjk" }
vim.opt.mouse = {}

vim.opt.listchars = {
  tab = "⇥ ",
  trail = "␣",
  extends = "⇉",
  precedes = "⇇",
  nbsp = "⚭",
}
