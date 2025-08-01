-- Helper functions for zoom functionality
local function restore_zoom()
  local onlywin = require('lib.onlywin')
  
  -- Save current cursor position and fold state BEFORE restoring
  local current_win = vim.api.nvim_get_current_win()
  local current_cursor = vim.api.nvim_win_get_cursor(current_win)
  local current_bufnr = vim.api.nvim_win_get_buf(current_win)
  
  -- Save current fold states
  local current_folds = {}
  local line_count = vim.api.nvim_buf_line_count(current_bufnr)
  for lnum = 1, line_count do
    local fold_level = vim.fn.foldlevel(lnum)
    if fold_level > 0 and vim.fn.foldclosed(lnum) == -1 then
      -- This line is in an open fold
      table.insert(current_folds, lnum)
    end
  end
  
  -- Restore layout
  onlywin.restore(vim.g.zoom_saved_layout)
  
  -- Restore active window by finding the window at saved coordinates
  vim.schedule(function()
    if vim.g.zoom_saved_win_pos then
      local saved_pos = vim.g.zoom_saved_win_pos
      
      -- Find window at the saved position (row, col)
      for _, winid in ipairs(vim.api.nvim_list_wins()) do
        local win_pos = vim.api.nvim_win_get_position(winid)
        if win_pos[1] == saved_pos.row and win_pos[2] == saved_pos.col then
          vim.api.nvim_set_current_win(winid)
          
          -- Restore cursor position (from zoomed state)
          local restored_buf = vim.api.nvim_win_get_buf(winid)
          if restored_buf == current_bufnr then
            vim.api.nvim_win_set_cursor(winid, current_cursor)
            
            -- Restore fold states (from zoomed state)
            if #current_folds > 0 then
              -- First close all folds
              vim.cmd('silent! %foldclose')
              -- Then open the current fold lines
              for _, lnum in ipairs(current_folds) do
                vim.fn.cursor(lnum, 1)
                vim.cmd('silent! foldopen')
              end
              -- Restore cursor position after fold operations
              vim.api.nvim_win_set_cursor(winid, current_cursor)
            end
          end
          
          -- Restore UI settings in the correct window
          if vim.g.zoom_saved_ui then
            vim.wo[winid].number = vim.g.zoom_saved_ui.number
            vim.wo[winid].relativenumber = vim.g.zoom_saved_ui.relativenumber
            vim.wo[winid].signcolumn = vim.g.zoom_saved_ui.signcolumn
            vim.g.zoom_saved_ui = nil
          end
          
          -- Restore hlchunk state if it was previously enabled
          if vim.g.zoom_saved_hlchunk_enabled ~= nil then
            local hlchunk_ok, hlchunk = pcall(require, 'hlchunk')
            if hlchunk_ok and vim.g.zoom_saved_hlchunk_enabled then
              hlchunk.enable()
            end
            vim.g.zoom_saved_hlchunk_enabled = nil
          end
          break
        end
      end
    end
    
    -- Clear saved state after scheduled function completes
    vim.g.zoom_saved_layout = nil
    vim.g.zoom_saved_win_pos = nil
  end)
end

local function clear_zoom_state()
  vim.g.zoom_saved_layout = nil
  vim.g.zoom_saved_ui = nil
  vim.g.zoom_saved_win_pos = nil
  vim.g.zoom_saved_hlchunk_enabled = nil
end

local function zoom_regular()
  local onlywin = require('lib.onlywin')
  
  clear_zoom_state()
  local current_win = vim.api.nvim_get_current_win()
  local win_pos = vim.api.nvim_win_get_position(current_win)
  
  -- Save only window position for finding the window later
  vim.g.zoom_saved_win_pos = { row = win_pos[1], col = win_pos[2] }
  vim.g.zoom_saved_layout = onlywin.save()
  onlywin.make_only(0)
end

local function zoom_copy_friendly()
  local onlywin = require('lib.onlywin')
  
  clear_zoom_state()
  local current_win = vim.api.nvim_get_current_win()
  local win_pos = vim.api.nvim_win_get_position(current_win)
  
  -- Save only window position for finding the window later
  vim.g.zoom_saved_win_pos = { row = win_pos[1], col = win_pos[2] }
  
  -- Save current UI settings
  vim.g.zoom_saved_ui = {
    number = vim.wo.number,
    relativenumber = vim.wo.relativenumber,
    signcolumn = vim.wo.signcolumn,
  }
  
  -- Save hlchunk state if plugin is loaded
  local hlchunk_ok, hlchunk = pcall(require, 'hlchunk')
  if hlchunk_ok then
    vim.g.zoom_saved_hlchunk_enabled = hlchunk.is_enabled()
  end
  
  -- Save layout and zoom
  vim.g.zoom_saved_layout = onlywin.save()
  onlywin.make_only(0)
  
  -- Hide UI elements for copying
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = 'no'
  
  -- Disable hlchunk if plugin is loaded
  if hlchunk_ok then
    hlchunk.disable()
  end
end

local function toggle_zoom(copy_friendly)
  if vim.g.zoom_saved_layout then
    restore_zoom()
  else
    if copy_friendly then
      zoom_copy_friendly()
    else
      zoom_regular()
    end
  end
end

return {
  dir = vim.fn.stdpath('config') .. '/lua/lib',
  name = 'zoomwin',
  keys = {
    { '<C-w>o', function() toggle_zoom(false) end, desc = 'Zoom window toggle' },
    { '<C-w><C-o>', function() toggle_zoom(true) end, desc = 'Zoom window toggle (copy-friendly)' },
  },
}