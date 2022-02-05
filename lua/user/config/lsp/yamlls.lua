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
        "!And map",
        "!And sequence",
        "!If scalar",
        "!If map",
        "!If sequence",
        "!Not scalar",
        "!Not map",
        "!Not sequence",
        "!Equals scalar",
        "!Equals map",
        "!Equals sequence",
        "!Or scalar",
        "!Or map",
        "!Or sequence",
        "!FindInMap scalar",
        "!FindInMap mappping",
        "!FindInMap sequence",
        "!Base64 scalar",
        "!Base64 map",
        "!Base64 sequence",
        "!Cidr scalar",
        "!Cidr map",
        "!Cidr sequence",
        "!Ref scalar",
        "!Ref map",
        "!Ref sequence",
        "!Sub scalar",
        "!Sub map",
        "!Sub sequence",
        "!GetAtt scalar",
        "!GetAtt map",
        "!GetAtt sequence",
        "!GetAZs scalar",
        "!GetAZs map",
        "!GetAZs sequence",
        "!ImportValue scalar",
        "!ImportValue map",
        "!ImportValue sequence",
        "!Select scalar",
        "!Select map",
        "!Select sequence",
        "!Split scalar",
        "!Split map",
        "!Split sequence",
        "!Join scalar",
        "!Join map",
        "!Join sequence",
      },
    }
  }
}

return M
