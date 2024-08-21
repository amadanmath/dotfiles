-- Remember to install for libmagickwand-dev and ueberzugpp unless on kitty

local backend = ''
local enabled = true

if vim.env.TERM == 'xterm-kitty' then
  backend = 'kitty'
elseif vim.fn.executable('ueberzug') then
  backend = 'ueberzug'
else
  enabled = false
end

return {
  '3rd/image.nvim',
  enabled = enabled,
  dependencies = {
    'leafo/magick',
  },
  opts = {
    backend = backend,
  },
}
