return {
  "nickjvandyke/opencode.nvim",
  -- Defaults to "main", supporting OpenCode v2.
  -- Uncomment to pull the latest stable release, supporting OpenCode v1.
  -- version = "*",
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      ask = {
        snacks = {
          win = {
            keys = {
              -- Without this, ESC in normal mode cancels the prompt, and
              -- opencode's cancel handler runs `gv`, leaving you in Visual
              -- mode over a stale selection. Cancel deliberately with q/<C-g>.
              n_esc = false,
            },
          },
        },
      },
    }

    -- <C-g> cancels the prompt from both insert and normal mode.
    -- Keymap specs mix string and integer keys, which `vim.g` cannot hold
    -- (E5100), so set them directly on the config module — the approach
    -- opencode.nvim's docs recommend for snacks options (neovim #12544).
    local config = require("opencode.config")
    config.opts.ask.snacks.win.keys.c_g =
      { "<C-g>", "cancel", mode = { "i", "n" }, desc = "cancel" }

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>",   function() require("opencode").ask("@this: ") end,                    { desc = "Ask OpenCode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>",   function() require("opencode").select() end,                          { desc = "Select OpenCode…" })
    vim.keymap.set({ "n", "x" }, "go",      function() return require("opencode").operator("@this...") end,         { desc = "Send range to OpenCode", expr = true })
    vim.keymap.set({ "n" },      "goo",     function() return require("opencode").operator("@this...") .. "_" end,  { desc = "Send line to OpenCode", expr = true })
  end,
}
