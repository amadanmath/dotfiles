return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      ensure_installed = {
        "comment",
        "lua",
        "javascript",
        "jsdoc",
        "typescript",
        "tsx",
        "bash",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "vue",
        "svelte",
        "markdown",
        "markdown_inline",
        "ruby",
        "python",
        "diff",
      },
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
      dependencies = {
        -- https://github.com/windwp/nvim-ts-autotag
        {
          "windwp/nvim-ts-autotag",
          opts = {
            enable_close_on_slash = false, -- disable case: `<div /` become `<div /div>`
            filetypes = {
              "html",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "xml",
            },
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
