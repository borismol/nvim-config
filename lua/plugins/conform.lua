return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      -- organize imports first, then format (runs sequentially)
      python = { "ruff_organize_imports", "ruff_format" },
    },
    format_on_save = {
      -- Only Python has formatters configured, so only Python formats on save
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
  init = function()
    -- Manual format keymap
    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format({ async = true, lsp_format = "fallback" })
    end, { desc = "[F]or[m]at buffer" })
  end,
}
