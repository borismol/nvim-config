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
      lualine_c = {
        -- built-in filename everywhere except the nvim-tree window (it would
        -- show the useless buffer name "NvimTree_1" there)
        { "filename", cond = function() return vim.bo.filetype ~= "NvimTree" end },
        -- in the tree window, show the root dir instead (respect_buf_cwd
        -- makes cwd the tree root)
        {
          function()
            return vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.getcwd(), ":~"))
          end,
          cond = function() return vim.bo.filetype == "NvimTree" end,
        },
      },
      lualine_x = { "filetype" },              -- detected filetype (with icon)
      lualine_y = { "progress" },
      lualine_z = { "location" },              -- line:col
    },
  },
}
