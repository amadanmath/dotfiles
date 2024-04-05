-- [" "] = { char = "", hl_group = "ObsidianTodo" },
-- ["x"] = { char = "󰄳", hl_group = "ObsidianDone" },
-- ["/"] = { char = "", hl_group = "ObsidianProgress" },
-- [">"] = { char = "", hl_group = "ObsidianForwarded" },
-- ["<"] = { char = "", hl_group = "ObsidianScheduled" },
-- ["-"] = { char = "󰰱", hl_group = "ObsidianCanceled" },

local todos = { " ", "x", "/", ">", "<", "-" }

for _, todo in ipairs(todos) do
  vim.keymap.set("n", "<leader>t" .. todo, function()
    require("mkdnflow").lists.toggleToDo(false, todo)
  end, { buffer = true, desc = 'Set ToDo to "' .. todo .. '"' })
end

vim.keymap.set("n", "<leader>tt", function()
  require("mkdnflow").lists.toggleToDo()
end, { buffer = true, desc = "Cycle ToDo" })
