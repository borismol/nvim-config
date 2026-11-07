return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy load the configurations
    config = function()
      -- 1. Setup a global autocommand for keymaps (Triggers when any LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          nmap("K", vim.lsp.buf.hover, "Hover Documentation")
          nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        end,
      })

      -- 2. Configure language servers using the modern Neovim API
      -- This modifies Neovim's internal data layer without hitting the deprecated wrapper

      -- C/C++: clangd
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      })

      -- Python: basedpyright (type checking, completion, navigation)
      -- Requires: uv tool install basedpyright
      vim.lsp.config("basedpyright", {
        cmd = { "basedpyright-langserver", "--stdio" },
        settings = {
          basedpyright = {
            analysis = {
              -- basedpyright defaults to "recommended" which is quite strict;
              -- "standard" matches pyright's noise level. Raise if you want more.
              typeCheckingMode = "standard",
              -- Report hint-level diagnostics (unresolved imports, etc.) below code
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- 3. Actively turn on the servers for their supported file types
      vim.lsp.enable({ "clangd", "basedpyright" })
    end,
  },
}
