return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  init = function()
    vim.g.nvim_surround_no_normal_mappings = true
    vim.g.nvim_surround_no_insert_mappings = true
    vim.g.nvim_surround_no_visual_mappings = true
  end,
  opts = {},
  keys = {
    { "<C-g>m", "<Plug>(nvim-surround-insert)", mode = "i", desc = "Surround insert" },
    { "<C-g>M", "<Plug>(nvim-surround-insert-line)", mode = "i", desc = "Surround insert line" },
    { "ym", "<Plug>(nvim-surround-normal)", desc = "Surround add" },
    { "ymm", "<Plug>(nvim-surround-normal-cur)", desc = "Surround add (cur)" },
    { "yM", "<Plug>(nvim-surround-normal-line)", desc = "Surround add (line)" },
    { "yMM", "<Plug>(nvim-surround-normal-cur-line)", desc = "Surround add (cur line)" },
    { "M", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Surround visual" },
    { "gM", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Surround visual line" },
    { "dm", "<Plug>(nvim-surround-delete)", desc = "Surround delete" },
    { "cm", "<Plug>(nvim-surround-change)", desc = "Surround change" },
    { "cM", "<Plug>(nvim-surround-change-line)", desc = "Surround change (line)" },
  },
}
