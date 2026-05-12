return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  keys = {
    { "<leader>sh", desc = "Search Help" },
    { "<leader>sk", desc = "Search Keymaps" },
    { "<leader>sf", desc = "Search Files" },
    { "<leader>st", desc = "Search Telescope" },
    { "<leader>sw", desc = "Search current Word" },
    { "<leader>sg", desc = "Search by Grep" },
    { "<leader>sd", desc = "Search Diagnostics" },
    { "<leader>sr", desc = "Search Resume" },
    { "<leader>s.", desc = "Search Recent Files" },
    { "<leader><leader>", desc = "Find existing buffers" },
    { "<leader>/", desc = "Fuzzily search in current buffer" },
    { "<leader>s/", desc = "Search in Open Files" },
    { "<leader>sn", desc = "Search Neovim files" },
    { "<leader>sF", desc = "Project Search Files" },
    { "<leader>sG", desc = "Project Search by Grep" },
    { "<leader>cf", mode = { "n", "x" }, desc = "Code reFactor" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    {
      "benfowler/telescope-luasnip.nvim",
      keys = {
        {
          "<leader>sp",
          function()
            require("telescope").load_extension("luasnip")
            require("telescope").extensions.luasnip.luasnip()
          end,
          desc = "Search sniPpets",
        },
      },
    },
    {
      "debugloop/telescope-undo.nvim",
      keys = {
        {
          "<leader>su",
          function()
            require("telescope").load_extension("undo")
            require("telescope").extensions.undo.undo()
          end,
          desc = "Search Undo tree",
        },
      },
    },
  },
  opts = {},
  config = function(_, opts)
    opts.extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    }
    local telescope = require("telescope")
    telescope.setup(opts)

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
    vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "Search Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search Recent Files" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

    vim.keymap.set({ "n", "x" }, "<leader>cf", function()
      pcall(telescope.load_extension, "refactoring")
      telescope.extensions.refactoring.refactors()
    end, { desc = "Code reFactor" })

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "Search in Open Files" })

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Search Neovim files" })

    local project_ok, _ = pcall(require, "project_nvim.project")
    if project_ok then
      vim.keymap.set("n", "<leader>sF", function()
        local root, _ = require("project_nvim.project").get_project_root()
        builtin.find_files({ cwd = root })
      end, { desc = "Project Search Files" })

      vim.keymap.set("n", "<leader>sG", function()
        local root, _ = require("project_nvim.project").get_project_root()
        builtin.live_grep({ cwd = root })
      end, { desc = "Project Search by Grep" })
    end
  end,
}
