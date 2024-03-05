-- bootstrap lazy.nvim, LazyVim and your plugins
vim.loader.enable()

local check_neovim_version = function(expected_ver)
  local version = vim.version

  local ev = version.parse(expected_ver)
  local actual_ver = version()

  if version.cmp(ev, actual_ver) ~= 0 then
    local _ver = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)
    local msg = string.format("Expect nvim %s, but got %s instead. Use at your own risk!", expected_ver, _ver)
    vim.health.report_warn(msg)
  end
end

local ensure_python_provider = function()
  local HOME = vim.env.HOME
  local python = vim.fn.expand("$HOME/.venv/default/bin/python")

  if vim.fn.executable(python) == 0 then
    python = vim.fn.exepath("python3")
    if python ~= "" then
      vim.fn.system("mkdir -p " .. HOME .. "/.venv && " .. python .. " -m venv " .. HOME .. "/.venv/default")
    end
  end

  if python ~= "" then
    vim.fn.system(python .. ' -c "import pynvim"')
    if vim.v.shell_error ~= 0 then
      vim.fn.system(python .. " -m pip install pynvim")
    end
    vim.g.python3_host_prog = python
  end
end

ensure_python_provider()
check_neovim_version("0.9.5")

require("config.lazy")

pcall(vim.cmd, "colorscheme catppuccin")
