-- Image display support for Neovim
-- Requires ImageMagick and luarocks with magick rock installed
--
-- Installation instructions:
--
-- macOS:
--   brew install imagemagick luarocks
--   luarocks --lua-version 5.1 install magick
--
-- Ubuntu/Debian:
--   sudo apt update
--   sudo apt install imagemagick libmagickwand-dev luarocks
--   sudo luarocks --lua-version 5.1 install magick
--
-- After installation, restart Neovim for the plugin to load automatically

local backend = ''
local enabled = true

if vim.env.TERM == 'xterm-kitty' then
  backend = 'kitty'
elseif vim.fn.executable('ueberzug') then
  backend = 'ueberzug'
  local uname = vim.fn.system('uname'):gsub('\n', '')
  if uname == 'Linux' then
    local lines = vim.fn.readfile('/proc/version')
    if string.find(lines[1]:lower(), 'microsoft') then
      enabled = false
    end
  end
else
  enabled = false
end

return {
  '3rd/image.nvim',
  enabled = function()
    -- Check if magick rock is available
    local ok, _ = pcall(require, 'magick')
    return ok
  end,
  dependencies = {
    'leafo/magick',
  },
  opts = {
    backend = backend,
  },
}
