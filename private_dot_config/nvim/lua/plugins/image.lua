local backend
if vim.env.TERM == "xterm-kitty" then
  backend = "kitty"
elseif vim.fn.executable("ueberzug") == 1 then
  backend = "ueberzug"
end

return {
  "3rd/image.nvim",
  enabled = function()
    if not backend then return false end
    local ok, _ = pcall(require, "magick")
    return ok
  end,
  dependencies = {
    "leafo/magick",
  },
  opts = {
    backend = backend,
  },
}
