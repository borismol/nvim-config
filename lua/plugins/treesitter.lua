return {
  "nvim-treesitter/nvim-treesitter",
  -- The "main" branch rewrite does not support lazy-loading
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install parsers for Python dev + the user's own config languages.
    -- Async and a no-op for parsers that are already installed.
    -- Note: these parsers ship pre-generated C sources, so tree-sitter-cli
    -- is not required; only a C compiler is (already present).
    require("nvim-treesitter").install({
      "python",
      "bash",
      "json",
      "toml",
      "yaml",
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
    })

    -- Enable treesitter highlighting for every buffer whose parser is installed
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Treesitter indentation for Python (experimental upstream feature)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function(args)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
