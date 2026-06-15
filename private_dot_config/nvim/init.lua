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

local function duplicate_and_comment_range(is_visual)
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()

    -- 1. Save original cursor position (1-indexed line, 0-indexed column)
    local orig_cursor = vim.api.nvim_win_get_cursor(win)

    -- 2. Identify line boundaries
    local start_line, end_line
    if is_visual then
        -- Read visual marks ('< and '>)
        start_line = vim.api.nvim_buf_get_mark(buf, '<')[1]
        end_line = vim.api.nvim_buf_get_mark(buf, '>')[1]
    else
        -- Normal mode: current single line
        start_line = orig_cursor[1]
        end_line = orig_cursor[1]
    end

    -- Safeguard for uninitialized marks
    if start_line == 0 or end_line == 0 then return end

    -- 3. Fetch the target lines (0-indexed API)
    local lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
    local count = #lines

    -- 4. Insert lines above selection (preserves all registers)
    vim.api.nvim_buf_set_lines(buf, start_line - 1, start_line - 1, false, lines)

    -- 5. Comment out the newly created top duplicate lines
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false) -- Exit visual mode cleanly if active

    -- Invoke built-in 'gc' mapping strictly on the top duplicate block
    local comment_cmd = string.format("%dGgc%dj", start_line, count - 1)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(comment_cmd, true, false, true), 'mx', true)

    -- 6. Restore cursor position relative to the uncommented block
    -- The original block is pushed down by exactly 'count' rows
    local final_line = orig_cursor[1] + count
    local final_col = orig_cursor[2]
    
    -- Fallback safety check: verify line still exists in buffer before moving
    local total_lines = vim.api.nvim_buf_line_count(buf)
    if final_line <= total_lines then
        vim.api.nvim_win_set_cursor(win, { final_line, final_col })
    end
end

-- Bindings setup
vim.keymap.set('n', 'gC', function() duplicate_and_comment_range(false) end, { desc = "Copy and comment" })
vim.keymap.set('x', 'gC', function() duplicate_and_comment_range(true) end, { desc = "Copy and comment" })

