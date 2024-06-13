local status, ts_integration = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
local pre_hook
if status then
  pre_hook = ts_integration.create_pre_hook()
end

return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  opts = {
    mappings = {
      extra = false,
    },
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    pre_hook = pre_hook,
  },
}
