return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- The one module opencode.nvim needs: its floating ask input
    -- (highlighted @contexts, <Tab> completion) replaces vim.ui.input.
    input = {},
    -- snacks enables these by default; keep them off to avoid changing
    -- behavior beyond the input UI
    bigfile = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    dashboard = { enabled = false },
    indent = { enabled = false },
    scroll = { enabled = false },
  },
}
