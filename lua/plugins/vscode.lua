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

      -- Boost the saturation of a #rrggbb by `f` (1 = fully saturated hue),
      -- keeping brightness the same: makes the git signs more vivid.
      local function saturate(hex, f)
        local r = tonumber(hex:sub(2, 3), 16) / 255
        local g = tonumber(hex:sub(4, 5), 16) / 255
        local b = tonumber(hex:sub(6, 7), 16) / 255
        local max, min = math.max(r, g, b), math.min(r, g, b)
        if max == 0 or max == min then return hex end
        local s = (max - min) / max
        local h
        if max == r then h = (g - b) / (max - min) % 6
        elseif max == g then h = (b - r) / (max - min) + 2
        else h = (r - g) / (max - min) + 4 end
        h = h * 60
        local c = max * math.min(s * (1 + f), 1)   -- chroma
        local x = c * (1 - math.abs((h / 60) % 2 - 1))
        local m = max - c
        local r2, g2, b2
        if h < 60 then r2, g2, b2 = c, x, 0
        elseif h < 120 then r2, g2, b2 = x, c, 0
        elseif h < 180 then r2, g2, b2 = 0, c, x
        elseif h < 240 then r2, g2, b2 = 0, x, c
        elseif h < 300 then r2, g2, b2 = x, 0, c
        else r2, g2, b2 = c, 0, x end
        return string.format("#%02x%02x%02x",
          math.floor((r2 + m) * 255 + 0.5),
          math.floor((g2 + m) * 255 + 0.5),
          math.floor((b2 + m) * 255 + 0.5))
      end

      -- Mix a #rrggbb toward a target colour: `f` is how much of the
      -- target to blend in (0 = pure hex, 1 = pure target).
      local BG = { 0x1e, 0x1e, 0x1e } -- VSCode dark editor background
      local function mix(hex, target, f)
        local out = {}
        for i = 0, 2 do
          local v = tonumber(hex:sub(2 + i * 2, 3 + i * 2), 16)
          out[i + 1] = math.floor(target[i + 1] + (v - target[i + 1]) * (1 - f))
        end
        return string.format("#%02x%02x%02x", out[1], out[2], out[3])
      end

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

          -- git sign glyphs (gitsigns): these link to Diff*, which only
          -- defines backgrounds (and transparent = true strips those), so
          -- without an explicit fg the ┃/_/~ marks render in plain text colour
          -- unstaged changes: theme git colours, saturation boosted for vividness
          GitSignsAdd          = { fg = saturate(c.vscGitAdded, 0.6) },
          GitSignsChange       = { fg = saturate(c.vscGitModified, 0.6) },
          GitSignsDelete       = { fg = saturate(c.vscGitDeleted, 0.6) },
          GitSignsUntracked    = { fg = saturate(c.vscGitUntracked, 0.6) },
          -- staged changes: same hues, dimmed toward the editor background
          -- (note gitsigns names these GitSignsStaged*, not GitSigns*Staged)
          GitSignsStagedAdd    = { fg = mix(c.vscGitAdded, BG, 0.45) },
          GitSignsStagedChange = { fg = mix(c.vscGitModified, BG, 0.45) },
          GitSignsStagedDelete = { fg = mix(c.vscGitDeleted, BG, 0.45) },
        }
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
}
