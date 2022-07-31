require('iron').core.setup {
  config = {
    -- If iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      },
      python = {
        command = {"ipython"}
      }
    },
    -- repl_open_cmd =crequire('iron.view').curry.bottom(40),
    repl_open_cmd ="vertical 60 split",
  -- how the REPL window will be opened, the default is opening
  -- a float window of height 40 at the bottom.
  },
  -- Iron doesn't set keymaps by default anymore. Set them here
  -- or use `should_map_plug = true` and map from you vim files
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  }
}

-- document mappings for iron
local wk = require "which-key"
wk.register(
  {
    ["<space>sc"] = {"Iron: send line"},
    ["<space>sf"] = {"Iron: send a file"},
    ["<space>sl"] = {"Iron: send a line"},
    ["<space>sm"] = {"Iron: send a mark"},
    ["<space>mc"] = {"Iron: mark a motion"},
    ["<space>md"] = {"Iron: remove mark"},
    ["<space>s<space>"] = {"Iron: interrupt"},
    ["<space>sq"] = {"Iron: exit"},
    ["<space>cl"] = {"Iron: clear"},
  }, {mode = "n"})
