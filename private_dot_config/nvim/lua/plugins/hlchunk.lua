return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    local hlchunk = require('hlchunk')
    hlchunk.mods = {}

    hlchunk.mods.chunk = require('hlchunk.mods.chunk')({
      use_treesitter = true,
    })
    hlchunk.mods.chunk:enable()

    function hlchunk:get_enabled()
      local enabled = {}
      for name, mod in pairs(self.mods) do
        enabled[name] = mod.conf and mod.conf.enable or false
      end
      return enabled
    end

    function hlchunk:set_enabled(enabled)
      for name, value in pairs(enabled) do
        local mod = self.mods[name]
        if mod and mod.conf then
          mod.conf.enable = enabled
          if value then
            mod:enable()
          else
            if mod.disable then
              mod:disable()
            end
          end
        end
      end
    end
  end,
}
