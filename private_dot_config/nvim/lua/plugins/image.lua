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

local backend

if vim.env.TERM == 'xterm-kitty' then
  backend = 'kitty'
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
