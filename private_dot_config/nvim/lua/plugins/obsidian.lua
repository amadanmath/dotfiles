local workspaces = {
  {
    name = "personal",
    path = "~/obsidian/home",
  },
  {
    name = "work",
    path = "~/obsidian/work",
  },
}

for _, workspace in ipairs(workspaces) do
  vim.fn.mkdir(vim.fn.expand(workspace.path), "p")
end

local no_vault = {
  name = "no-vault",
  path = function()
    return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
  end,
  overrides = {
    notes_subdir = vim.NIL,
    new_notes_location = "current_dir",
    templates = {
      subdir = vim.NIL,
    },
    disable_frontmatter = true,
  },
}

table.insert(workspaces, no_vault)

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>ow", "<Cmd>ObsidianWorkspace<CR>", desc = "Obsidian Workspace" },
    { "<leader>oo", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick switch" },
    { "<leader>ot", "<Cmd>ObsidianTags<CR>", desc = "Obsidian Tags" },
    { "<leader>os", "<Cmd>ObsidianSearch<CR>", desc = "Obsidian Search" },
    { "<leader>ol", "<Cmd>ObsidianLinks<CR>", desc = "Obsidian Links" },
    { "<leader>ob", "<Cmd>ObsidianBacklinks<CR>", desc = "Obsidian Backlinks" },
    { "<leader>or", "<Cmd>ObsidianRename<CR>", desc = "Obsidian Rename" },
    { "<leader>oe", "<Cmd>ObsidianExtractNote<CR>", mode = "v", desc = "Obsidian Extract note" },
    { "<leader>ol", "<Cmd>ObsidianLink<CR>", mode = "v", desc = "Obsidian Link" },
    { "<leader>on", "<Cmd>ObsidianLinkNew<CR>", mode = "v", desc = "Obsidian New link" },
    { "<leader>o1", "<Cmd>ObsidianWorkspace personal<CR><Cmd>ObsidianSearch<CR>", desc = "Obsidian Search Personal" },
    { "<leader>o2", "<Cmd>ObsidianWorkspace work<CR><Cmd>ObsidianSearch<CR>", desc = "Obsidian Search Work" },
  },
  opts = {
    workspaces = workspaces,
    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
    follow_url_func = function(url)
      if vim.fn.has("macunix") == 1 then
        vim.fn.jobstart({ "open", url })
      elseif vim.fn.has("linux") == 1 then
        vim.fn.jobstart({ "xdg-open", url })
      end
    end,
    ui = {
      checkboxes = {
        [" "] = { char = "", hl_group = "ObsidianTodo" },
        ["x"] = { char = "󰄳", hl_group = "ObsidianDone" },
        ["/"] = { char = "", hl_group = "ObsidianProgress" },
        [">"] = { char = "", hl_group = "ObsidianForwarded" },
        ["<"] = { char = "", hl_group = "ObsidianScheduled" },
        ["-"] = { char = "󰰱", hl_group = "ObsidianCanceled" },
        ["?"] = { char = "", hl_group = "ObsidianQuestion" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
        ["*"] = { char = "", hl_group = "ObsidianStar" },
        ['"'] = { char = "󱀡", hl_group = "ObsidianQuote" },
        ["l"] = { char = "", hl_group = "ObsidianLocation" },
        ["b"] = { char = "", hl_group = "ObsidianBookmark" },
        ["i"] = { char = "", hl_group = "ObsidianInformation" },
        ["S"] = { char = "", hl_group = "ObsidianSavings" },
        ["I"] = { char = "󰛨", hl_group = "ObsidianIdea" },
        ["p"] = { char = "", hl_group = "ObsidianPros" },
        ["c"] = { char = "", hl_group = "ObsidianCons" },
        ["f"] = { char = "󰈸", hl_group = "ObsidianFire" },
        ["k"] = { char = "󰌋", hl_group = "ObsidianKey" },
        ["w"] = { char = "󰃪", hl_group = "ObsidianWin" },
        ["u"] = { char = "󰔵", hl_group = "ObsidianUp" },
        ["d"] = { char = "󰔳", hl_group = "ObsidianDown" },
      },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#89ddff" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianProgress = { bold = true, fg = "#89ddff" },
        ObsidianForwarded = { bold = true, fg = "#f78c6c" },
        ObsidianScheduled = { bold = true, fg = "#f78c6c" },
        ObsidianCanceled = { bold = true, fg = "#ff5370" },
        ObsidianQuestion = { bold = true, fg = "#e5c890" },
        ObsidianImportant = { bold = true, fg = "#fe640c" },
        ObsidianStar = { bold = true, fg = "#e5c890" },
        ObsidianQuote = { bold = true, fg = "#17929a" },
        ObsidianLocation = { bold = true, fg = "#eb999c" },
        ObsidianBookmark = { bold = true, fg = "#fe640c" },
        ObsidianInformation = { bold = true, fg = "#2166f6" },
        ObsidianSavings = { bold = true, fg = "#40a02b" },
        ObsidianIdea = { bold = true, fg = "#e5c890" },
        ObsidianPros = { bold = true, fg = "#40a02b" },
        ObsidianCons = { bold = true, fg = "#fe640c" },
        ObsidianFire = { bold = true, fg = "#eb999c" },
        ObsidianKey = { bold = true, fg = "#e5c890" },
        ObsidianWin = { bold = true, fg = "#8938ef" },
        ObsidianUp = { bold = true, fg = "#40a02b" },
        ObsidianDown = { bold = true, fg = "#eb999c" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
  },
}
