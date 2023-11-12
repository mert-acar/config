local status_ok, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if not status_ok then
  return
end
nvim_tmux_nav.setup()
