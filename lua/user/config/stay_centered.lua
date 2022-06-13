local utils = require "user.utils"
local status_ok, stay_centered = utils.vprequire("stay-centered", "stay-centered")
if not status_ok then
  return
end
