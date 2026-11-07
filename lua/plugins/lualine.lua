return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- already installed for nvim-tree
  opts = {
    options = {
      theme = "vscode",    -- matches the vscode.nvim colorscheme
      globalstatus = true, -- one bar across all windows/splits
    },
    sections = {
      lualine_a = { "mode" },                  -- NORMAL/INSERT/…
      lualine_b = { "branch", "diagnostics" }, -- git branch + E/W counts from LSP
      lualine_c = { "filename" },              -- path + modified flag
      lualine_x = { "filetype" },              -- detected filetype (with icon)
      lualine_y = { "progress" },
      lualine_z = { "location" },              -- line:col
    },
  },
}
