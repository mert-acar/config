local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

conform.setup {
  formatters_by_ft = {
    python = { "yapf" },
  },

  formatters = {
    yapf = {
      command = 'yapf',
      args = {"--style=~/.config/yapf/setup.cfg"},
    }
  }
}
