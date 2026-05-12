-- From: https://raw.githubusercontent.com/kndndrj/nvim-dbee/1c60754e3c0760a4f1afbdeb66ddfe49ff225857/lua/dbee/layouts/tools.lua
-- Licence: GPL

---@alias _layout { type: string, winid: integer, bufnr: integer, win_opts: { string: any}, children: _layout[] }
---@alias layout_egg { layout: _layout, restore: string }

local M = {}

local function list_non_floating_wins()
  return vim.fn.filter(vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage()), function(_, v)
    return vim.api.nvim_win_get_config(v).relative == ""
  end)
end

function M.make_only(winid)
  if not winid or winid == 0 then
    winid = vim.api.nvim_get_current_win()
  end
  for _, wid in ipairs(list_non_floating_wins()) do
    if wid ~= winid then
      local winnr = vim.fn.win_id2win(wid)
      vim.cmd(winnr .. "wincmd c")
    end
  end
end

local function winrestcmd()
  local cmd = ""
  for _ = 1, 2 do
    local winnr = 1
    for _, winid in ipairs(list_non_floating_wins()) do
      cmd = string.format("%s%dresize %d|", cmd, winnr, vim.api.nvim_win_get_height(winid))
      cmd = string.format("%svert %dresize %d|", cmd, winnr, vim.api.nvim_win_get_width(winid))
      winnr = winnr + 1
    end
  end
  return cmd
end

local function add_details(layout)
  if layout[1] == "leaf" then
    local win = layout[2]
    local all_options = vim.api.nvim_get_all_options_info()
    local v = vim.wo[win]
    local options = {}
    for key, val in pairs(all_options) do
      if val.global_local == false and val.scope == "win" then
        options[key] = v[key]
      end
    end
    ---@type _layout
    return {
      type = layout[1],
      winid = win,
      bufnr = vim.fn.winbufnr(win),
      win_opts = options,
    }
  else
    local children = {}
    for _, child_layout in ipairs(layout[2]) do
      table.insert(children, add_details(child_layout))
    end
    return { type = layout[1], children = children }
  end
end

---@return layout_egg
function M.save()
  local layout = vim.fn.winlayout()
  local restore_cmd = winrestcmd()
  layout = add_details(layout)
  return { layout = layout, restore = restore_cmd }
end

---@param layout _layout
local function apply_layout(layout)
  if layout.type == "leaf" then
    if vim.fn.bufexists(layout.bufnr) == 1 then
      vim.cmd("b " .. layout.bufnr)
    end
    for opt, val in pairs(layout.win_opts) do
      if val ~= nil then
        vim.wo[opt] = val
      end
    end
  else
    local split_method = layout.type == "col" and "rightbelow split" or "rightbelow vsplit"
    local wins = { vim.fn.win_getid() }
    for i in ipairs(layout.children) do
      if i ~= 1 then
        vim.cmd(split_method)
        table.insert(wins, vim.fn.win_getid())
      end
    end
    for index, win in ipairs(wins) do
      vim.fn.win_gotoid(win)
      apply_layout(layout.children[index])
    end
  end
end

---@param egg layout_egg
function M.restore(egg)
  egg = egg or {}
  if not egg.layout or not egg.restore then
    return
  end
  vim.cmd("new")
  M.make_only(0)
  local tmp_buf = vim.api.nvim_get_current_buf()
  apply_layout(egg.layout)
  vim.cmd(egg.restore)
  vim.cmd("bd " .. tmp_buf)
end

return M
