return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  init = function()
    vim.g.mkdp_open_to_the_world = 1   -- сервер слушает не только localhost
    vim.g.mkdp_echo_preview_url = 1    -- показывает URL в командной строке
    vim.g.mkdp_browser = ''            -- не пытаться открыть браузер на сервере
    vim.g.mkdp_port = '8080'           -- фиксированный порт, чтобы не менять туннель
  end,
}
