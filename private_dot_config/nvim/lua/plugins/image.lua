local backend

if vim.env.TERM == 'xterm-kitty' then
  backend = 'kitty'
end

return {
  '3rd/image.nvim',
  dependencies = {
    'leafo/magick',
  },
  opts = {
    backend = backend,
  },
}
