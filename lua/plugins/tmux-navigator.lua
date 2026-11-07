-- Seamless <C-h/j/k/l> navigation between nvim splits and tmux panes:
-- <C-h> moves to the left nvim split, and if there is none, hands over
-- to the neighbouring tmux pane. The tmux half of this setup lives in
-- ~/.tmux.conf ("smart pane switching" section).
--
-- Loaded eagerly on purpose: the plugin then defines its own default
-- <C-h/j/k/l/C-\> mappings (no custom rhs here, avoids keymap quirks).
-- The plugin is tiny, so eager load costs nothing.
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
}
