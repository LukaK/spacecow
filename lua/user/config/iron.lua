local status_ok, iron = pcall(require, "iron")
if not status_ok then
  return
end

iron.core.set_config({
  preferred = {
    python = "ipython",
  },
  repl_open_cmd = "vertical 60 split",
})
