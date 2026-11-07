-- Exit insert mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true})

require("config.lazy")
