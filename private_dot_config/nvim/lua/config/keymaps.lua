-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
vim.keymap.del("n", "<leader>-") -- split
vim.keymap.del("n", "<leader>|") -- vertical

-- I don't use tabs, and I don't like <leader><tab> being taken for it
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
