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

      -- 2. Statically configure clangd using the modern Neovim API
      -- This modifies Neovim's internal data layer without hitting the deprecated wrapper
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

      -- 3. Actively turn on clangd for its supported file types (.cpp, .hpp, etc.)
      vim.lsp.enable("clangd")
    end,
  },
}
