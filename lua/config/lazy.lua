-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Keep the cursor line vertically centred while moving (typewriter mode);
-- clamps at file top/bottom, so gg/G still behave normally
vim.opt.scrolloff = 999

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Python uses 4-space indentation (PEP 8); everything else keeps the global 2
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Make sure ~/.local/bin (uv tools: ruff, basedpyright) is on PATH even when
-- nvim is launched from a GUI that doesn't source the shell profile
vim.env.PATH = vim.env.HOME .. "/.local/bin:" .. (vim.env.PATH or "")

vim.diagnostic.config({
  virtual_text = true,          -- текст ошибки рядом со строкой
  signs = true,                 -- значки слева (в gutter)
  underline = true,             -- подчёркивание ошибок
  update_in_insert = false,     -- обновлять диагностику в insert mode (можно true, если удобно)
  severity_sort = true,         -- сортировать по важности
})

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Imports everything from the lua/plugins/ directory
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    frequency = 604800, -- ⏱️ Check once every 7 days (in seconds)
    notify = true,      -- Keep notifications active
  },
})
