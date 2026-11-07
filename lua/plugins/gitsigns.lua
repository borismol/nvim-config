-- Inline git change indicators: sign-column marks on every added,
-- changed or removed line (vs the git index), plus hunk navigation,
-- per-hunk staging and a full diff of the uncommitted changes.
-- Active only in git repos; mappings are buffer-local via on_attach.
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_", show_count = true },
      topdelete    = { text = "‾", show_count = true },
      changedelete = { text = "~", show_count = true },
      untracked    = { text = "┆" },
    },
    -- dimmer bars for changes already staged (shown alongside unstaged ones)
    signs_staged = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_", show_count = true },
      topdelete    = { text = "‾", show_count = true },
      changedelete = { text = "~", show_count = true },
    },
    -- superscript digits for the deletion counts (default is plain 1-9)
    count_chars = {
      [1]  = "¹",
      [2]  = "²",
      [3]  = "³",
      [4]  = "⁴",
      [5]  = "⁵",
      [6]  = "⁶",
      [7]  = "⁷",
      [8]  = "⁸",
      [9]  = "⁹",
      ["+"] = "⁺", -- fallback for 10+ deleted lines
    },
    -- signs only; no whole-line background tint
    linehl = false,
    numhl  = false,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- hunk navigation (falls back to vim diff ]c/[c in diff mode)
      map("n", "]h", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Next git hunk" })

      map("n", "[h", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous git hunk" })

      -- show the changed lines of the hunk under the cursor
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview git hunk" })

      -- full diff of uncommitted changes (this buffer vs HEAD)
      map("n", "<leader>gd", gs.diffthis, { desc = "Diff buffer vs HEAD" })

      -- who changed this line, when and why
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Git blame line" })

      -- stage / revert the hunk under the cursor
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage git hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset git hunk" })
    end,
  },
}
