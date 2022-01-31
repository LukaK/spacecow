local utils = require "user.utils"
local status_ok, packer = utils.vprequire("packer", "packer")
if not status_ok then
  return
end

-- configure packer to use floating window
packer.init {
  display = {
    open_fn = function ()
      return require('packer.util').float { border = "rounded"}
    end,
  },
}
