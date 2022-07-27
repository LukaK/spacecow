-- configure packer to use floating window
require('packer').init {
  display = {
    open_fn = function ()
      return require('packer.util').float { border = "rounded"}
    end,
  },
}
