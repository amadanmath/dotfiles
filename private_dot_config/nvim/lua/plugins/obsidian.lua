--[[

Installing Obsidian on WSL:
https://forum.obsidian.md/t/support-for-vaults-in-windows-subsystem-for-linux-wsl/8580/50

version="1.5.11"
wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v$version/obsidian_$version_amd64.deb"
sudo apt-get install -y "./obsidian_$version_amd64.deb"
sudo apt-get update
sudo apt-get install -y libgbm1 libasound2
curl -o ~/.local/bin/wsl-open https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh

Restart WSL: wsl --shutdown

Use "Obsidian (Ubuntu)" from Start Menu, or `/opt/Obsidian/obsidian`

]]

local workspaces = {
  {
    name = "personal",
    path = "~/obsidian/home",
  },
  {
    name = "aist",
    path = "~/obsidian/aist",
  },
}

-- make the workspaces if they do not exist
for _, workspace in ipairs(workspaces) do
  vim.fn.mkdir(vim.fn.expand(workspace.path), "p")
end

local no_vault = {
  name = "no-vault",
  path = function()
    -- alternatively use the CWD:
    -- return assert(vim.fn.getcwd())
    return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
  end,
  overrides = {
    notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
    new_notes_location = "current_dir",
    templates = {
      subdir = vim.NIL,
    },
    disable_frontmatter = true,
  },
}

table.insert(workspaces, no_vault)

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
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
        if vim.fn.has('macunix') then
          vim.fn.jobstart({ "open", url })     -- Mac OS
        elseif vim.fn.has('linux') then
          vim.fn.jobstart({ "xdg-open", url }) -- linux
        end
      end,
      ui = {
        checkboxes = {
          -- https://minimal.guide/checklists
          -- Basics
          [" "] = { char = "", hl_group = "ObsidianTodo" },
          ["x"] = { char = "󰄳", hl_group = "ObsidianDone" },
          ["/"] = { char = "", hl_group = "ObsidianProgress" },
          [">"] = { char = "", hl_group = "ObsidianForwarded" },
          ["<"] = { char = "", hl_group = "ObsidianScheduled" },
          ["-"] = { char = "󰰱", hl_group = "ObsidianCanceled" },
          -- Extras
          ["?"] = { char = "", hl_group = "ObsidianQuestion" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          ["*"] = { char = "", hl_group = "ObsidianStar" },
          ['"'] = { char = "󱀡", hl_group = "ObsidianQuote" },
          ["l"] = { char = "", hl_group = "ObsidianLocation" },
          ["b"] = { char = "", hl_group = "ObsidianBookmark" },
          ["i"] = { char = "", hl_group = "ObsidianInformation" },
          ["S"] = { char = "", hl_group = "ObsidianSavings" },
          ["I"] = { char = "󰛨", hl_group = "ObsidianIdea" },
          ["p"] = { char = "", hl_group = "ObsidianPros" },
          ["c"] = { char = "", hl_group = "ObsidianCons" },
          ["f"] = { char = "󰈸", hl_group = "ObsidianFire" },
          ["k"] = { char = "󰌋", hl_group = "ObsidianKey" },
          ["w"] = { char = "󰃪", hl_group = "ObsidianWin" },
          ["u"] = { char = "󰔵", hl_group = "ObsidianUp" },
          ["d"] = { char = "󰔳", hl_group = "ObsidianDown" },
        },
        hl_groups = {
          -- basics
          ObsidianTodo = { bold = true, fg = "#89ddff" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianProgress = { bold = true, fg = "#89ddff" },
          ObsidianForwarded = { bold = true, fg = "#f78c6c" },
          ObsidianScheduled = { bold = true, fg = "#f78c6c" },
          ObsidianCanceled = { bold = true, fg = "#ff5370" },
          -- extras
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
          -- rest
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
    },
  },
}
