return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "pyright",
          "ruff",
          "bashls",
        },
      },
    },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local builtin = require("telescope.builtin")
        map("gd", builtin.lsp_definitions, "Goto Definition")
        map("gr", builtin.lsp_references, "Goto References")
        map("gI", builtin.lsp_implementations, "Goto Implementation")
        map("<leader>D", builtin.lsp_type_definitions, "Type Definition")
        map("<leader>ds", builtin.lsp_document_symbols, "Document Symbols")
        map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
        vim.keymap.set("n", "<leader>cR", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { buffer = event.buf, expr = true, desc = "LSP: Incremental Rename" })
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>xx", vim.diagnostic.open_float, "Show line diagnostics")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle Inlay Hints")
        end
      end,
    })

    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("pyright", {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })

    vim.lsp.config("ruff", {
      init_options = {
        settings = { args = {} },
      },
    })

    vim.lsp.config("ts_ls", {
      root_dir = function(fname)
        return vim.fs.root(fname, { ".git" })
      end,
      single_file_support = false,
      settings = {
        typescript = {
          includeInlayParameterNameHints = "literal",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        javascript = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    })

    vim.lsp.config("tailwindcss", {
      root_dir = function(fname)
        return vim.fs.root(fname, { ".git" })
      end,
    })
  end,
}
