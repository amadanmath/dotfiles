-- Remember to install for libmagickwand-dev and ueberzugpp unless on kitty


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
  enabled = enabled,
  dependencies = {
    'leafo/magick',
  },
  opts = {
    backend = backend,
  },
}
