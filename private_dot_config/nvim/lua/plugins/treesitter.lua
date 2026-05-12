return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate", "TSUninstall", "TSLog" },
    main = "nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc",
        "javascript", "typescript", "css", "gitignore", "json", "scss", "sql",
        "python", "ruby",
      },
      auto_install = false,
      highlight = {
        enable = true,
        disable = function()
          return string.find(vim.bo.filetype, "chezmoitmpl") ~= nil
        end,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            ["ak"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          include_surrounding_whitespace = true,
        },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable_close_on_slash = false,
      filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "xml" },
    },
  },
}
