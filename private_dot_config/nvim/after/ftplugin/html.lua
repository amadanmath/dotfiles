vim.bo.shiftwidth = 2

local has_mini_ai, mini_ai = pcall(require, 'mini.ai')
local has_nvim_treesitter, _ = pcall(require, 'nvim-treesitter')
if has_mini_ai and has_nvim_treesitter then
  local spec_treesitter = mini_ai.gen_spec.treesitter
  vim.b.miniai_config = {
    custom_textobjects = {
      t = spec_treesitter { a = '@function.outer', i = '@function.inner' },
    },
  }
end
