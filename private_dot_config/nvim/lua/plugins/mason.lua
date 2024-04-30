return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "basedpyright",
        -- "flake8",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
        },
        bashls = {
        },
        tsserver = {
        },
      },
    },
  },
}
