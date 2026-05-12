-- Leader must be set before lazy.nvim loads plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.mouse          = "a"
vim.opt.showmode       = false  -- shown by statusline
vim.opt.clipboard      = "unnamedplus"
vim.opt.breakindent    = true
vim.opt.undofile       = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.signcolumn     = "yes"
vim.opt.updatetime     = 250
vim.opt.timeoutlen     = 300
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.cursorline     = true
vim.opt.scrolloff      = 10
vim.opt.termguicolors  = true
vim.opt.list           = true
vim.opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand     = "split"
vim.opt.shiftwidth     = 0
vim.opt.softtabstop    = -1
vim.opt.expandtab      = true
vim.opt.smarttab       = true
vim.opt.backspace      = { "start", "eol", "indent" }
vim.opt.splitkeep      = "cursor"
vim.opt.showbreak      = "+ "
vim.opt.linebreak      = true
vim.opt.winaltkeys     = "no"
vim.opt.foldopen:append({ "jump" })
vim.opt.wildignore:append({ "tags", "*.pyc", "__pycache__", "*/node_modules/*" })

-- In SSH sessions, forward clipboard via OSC 52 back to the local terminal.
if vim.env.SSH_TTY and vim.env.TERM == "xterm-kitty" then
  vim.g.clipboard = {
    name  = "OSC 52",
    copy  = { ["+"] = require("vim.ui.clipboard.osc52").copy("+"),  ["*"] = require("vim.ui.clipboard.osc52").copy("*") },
    paste = { ["+"] = require("vim.ui.clipboard.osc52").paste("+"), ["*"] = require("vim.ui.clipboard.osc52").paste("*") },
  }
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" }, {
  change_detection = { notify = false },
})

-- Keymaps
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  if package.loaded["notify"] then
    require("notify").dismiss()
  end
end)

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
