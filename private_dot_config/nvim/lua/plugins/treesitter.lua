return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- https://github.com/alker0/chezmoi.vim?tab=readme-ov-file#-can-i-use-nvim-treesitter-for-my-chezmoi-template
      highlight = {
        disable = function()
          -- check if 'filetype' option includes 'chezmoitmpl'
          -- chezmoi.vim handles it without treesitter
          if string.find(vim.bo.filetype, 'chezmoitmpl') then
            return true
          end
        end,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
