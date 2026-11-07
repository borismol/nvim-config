-- Exit insert mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true})

-- <C-g> as an alternative to <Esc> (insert + visual modes)
vim.keymap.set("i", "<C-g>", "<Esc>", { silent = true })
vim.keymap.set("x", "<C-g>", "<Esc>", { silent = true })

require("config.lazy")
