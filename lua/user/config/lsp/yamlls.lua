local utils = require "user.utils"
local status_ok, schemastore = utils.vprequire("schemastore", "yamlls")
if not status_ok then
  return
end

local M = {}

M.options = {
  filetypes = {"yaml", "yml"},
  settings = {
    yaml = {
      schemas = schemastore.json.schemas(),
      -- aws cloudformation tags
      customTags = {
        "!And scalar",
        "!And mapping",
        "!And sequence",
        "!If scalar",
        "!If mapping",
        "!If sequence",
        "!Not scalar",
        "!Not mapping",
        "!Not sequence",
        "!Equals scalar",
        "!Equals mapping",
        "!Equals sequence",
        "!Or scalar",
        "!Or mapping",
        "!Or sequence",
        "!FindInMap scalar",
        "!FindInMap mappping",
        "!FindInMap sequence",
        "!Base64 scalar",
        "!Base64 mapping",
        "!Base64 sequence",
        "!Cidr scalar",
        "!Cidr mapping",
        "!Cidr sequence",
        "!Ref scalar",
        "!Ref mapping",
        "!Ref sequence",
        "!Sub scalar",
        "!Sub mapping",
        "!Sub sequence",
        "!GetAtt scalar",
        "!GetAtt mapping",
        "!GetAtt sequence",
        "!GetAZs scalar",
        "!GetAZs mapping",
        "!GetAZs sequence",
        "!ImportValue scalar",
        "!ImportValue mapping",
        "!ImportValue sequence",
        "!Select scalar",
        "!Select mapping",
        "!Select sequence",
        "!Split scalar",
        "!Split mapping",
        "!Split sequence",
        "!Join scalar",
        "!Join mapping",
        "!Join sequence",
      }
    }
  }
}

return M
