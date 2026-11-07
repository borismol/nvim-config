return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- 1. Set the background mode (dark or light)
      vim.o.background = 'dark'  -- Change to 'light' if you prefer light mode

      -- 2. Fetch the colors table for your manual overrides
      local c = require('vscode.colors').get_colors()

      -- 3. Execute the custom setup block exactly as you want it
      require('vscode').setup({
        transparent = true,             -- Transparent background enabled
        italic_comments = true,         -- Italic comments enabled
        italic_inlayhints = true,       -- Italic inlay hints enabled
        underline_links = true,         -- Underline links enabled
        disable_nvimtree_bg = true,     -- Clean up NvimTree's background
        terminal_colors = true,         -- Apply theme to terminal windows

        color_overrides = {
          vscLineNumber = '#FFFFFF',    -- Pure white line numbers
        },

        group_overrides = {
          -- Custom neon green cursor block using fetched colors
          Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        }
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
}
