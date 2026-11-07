return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false, -- This is the proper lazy.nvim way to say "don't lazy-load"
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- disable netrw at the very start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
  end,
  config = function()
    -- Set up devicons first
    require("nvim-web-devicons").setup({
      default = true, -- Ensures a fallback icon is always shown
    })
    require("nvim-tree").setup({
      respect_buf_cwd = true,
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        highlight_git = true, -- Optional: colors files based on Git status
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            folder = {
              arrow_closed = "⏵",
              arrow_open = "⏷",
              default = "📁",
              open = "📂",
              empty = "🗀",
              empty_open = "🗁",
              symlink = "🗂",
              symlink_open = "🗂",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })

    vim.api.nvim_create_user_command("NvimTreeOpenFileDir", function()
      require("nvim-tree.api").tree.find_file({
        open = true,       -- открыть дерево, если закрыто
        update_root = true, -- поменять корень на директорию файла, если файл вне текущего корня
        focus = true,
      })
    end, {})

    -- Map your toggle keybind
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeOpenFileDir<cr>", { desc = "Open nvim-tree in file's directory" })
  end,
}
