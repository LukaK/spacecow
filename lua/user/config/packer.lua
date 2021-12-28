local status_ok, packer = pcall(require, "packer")
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
