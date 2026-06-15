return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate", "TSUninstall", "TSLog" },
    main = "nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    -- No longer a nested dependency inside nvim-treesitter config blocks
    config = function()
      -- Modern standalone configuration layout
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- Configure your preferred text object motions cleanly
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ak"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
        },
      })
    end,
  },
}
