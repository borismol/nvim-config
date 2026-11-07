return {
  "saghen/blink.cmp",
  -- Pin to stable V1: V2 is under active development with breaking changes.
  -- Using a release tag also downloads prebuilt binaries (no cargo needed).
  version = "1.*",
  -- Load eagerly: it must register LSP capabilities before any LSP client starts.
  -- Startup cost is negligible (the fuzzy matcher is a prebuilt Rust binary).
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default", -- <C-space> to open, <C-n>/<C-p> to navigate, <C-e> to cancel
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      documentation = { auto_show = true }, -- show docs window while browsing completions
    },
    signature = { enabled = true }, -- show function signature while typing arguments
    -- Default sources are already: lsp, path, snippets, buffer
  },
}
