return {
  "jakewvincent/mkdnflow.nvim",
  ft = "markdown",
  config = function()
    require("mkdnflow").setup({
      modules = {
        bib = false,
        buffers = true,
        conceal = false,
        cursor = false,
        folds = true,
        links = false,
        lists = true,
        maps = true,
        paths = false,
        tables = true,
        yaml = false,
        completion = false, -- ✅ renamed from cmp
      },

      to_do = {
        -- ✅ new format (replaces: symbols, not_started, in_progress, complete)
        statuses = {
          not_started = { marker = " " },
          in_progress = { marker = "/" },
          complete = { marker = "x" },
        },

        -- ✅ required in new API
        status_order = {
          "not_started",
          "in_progress",
          "complete",
        },

        -- ✅ replaces update_parents
        status_propagation = {
          up = true,
        },
      },

      mappings = {
        MkdnEnter = false,
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = false,
        MkdnPrevLink = false,
        MkdnNextHeading = false,
        MkdnPrevHeading = false,
        MkdnGoBack = false,
        MkdnGoForward = false,
        MkdnCreateLink = false,
        MkdnCreateLinkFromClipboard = false,
        MkdnFollowLink = false,
        MkdnDestroyLink = false,
        MkdnTagSpan = false,
        MkdnMoveSource = false,
        MkdnYankAnchorLink = false,
        MkdnYankFileAnchorLink = false,
        MkdnIncreaseHeading = false,
        MkdnDecreaseHeading = false,
        MkdnToggleToDo = false,
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = false,
        MkdnNewListItemAboveInsert = false,
        MkdnExtendList = false,
        MkdnUpdateNumbering = { "n", "<leader>tr" },
        MkdnTableNextCell = false,
        MkdnTablePrevCell = false,
        MkdnTableNextRow = false,
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = false,
        MkdnTableNewRowAbove = false,
        MkdnTableNewColAfter = false,
        MkdnTableNewColBefore = false,
        MkdnFoldSection = { "n", "<leader>tf" },
        MkdnUnfoldSection = { "n", "<leader>tF" },
        MkdnTableFormat = { "n", "<leader>ta" },
      },
    })
  end,
}
