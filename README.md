# My Neovim Configuration

Minimal lazy.nvim-based config targeted at **Python** and **C/C++** development, with
OpenCode AI integration. Requires **Neovim 0.12+**.

## Layout

```
init.lua                 # entry point: exit-mode keymaps, lazy bootstrap
lua/config/lazy.lua      # plugin manager, global options, diagnostics, PATH
lua/plugins/             # one file per plugin (auto-imported by lazy.nvim)
  lsp.lua                # LSP: clangd (C/C++), basedpyright (Python)
  blink.lua              # completion
  telescope.lua          # fuzzy finders
  nvim-tree.lua          # file explorer
  treesitter.lua         # parsers + highlighting
  conform.lua            # formatting
  lint.lua               # linting
  snacks.lua             # floating input UI (for opencode prompts)
  opencode.lua           # OpenCode AI integration
  preview-markdown.lua   # browser markdown preview
  render-markdown.lua    # in-editor markdown rendering
  vscode.lua             # colorscheme
lazy-lock.json           # pinned plugin versions (reproducible)
```

Leader key is **`<Space>`**, local leader is **`\`**.
Indentation: 2 spaces globally, **4 for Python** (PEP 8).
Plugin updates are checked weekly.

## Exit modes

| Key    | Modes        | Action                    |
|--------|--------------|---------------------------|
| `jk`   | insert       | back to normal            |
| `<C-g>`| insert, visual | same as `<Esc>`         |

Inside the OpenCode prompt `<C-g>` cancels the prompt instead (buffer-local).

## Completion (blink.cmp)

| Key         | Action                              |
|-------------|-------------------------------------|
| `<C-space>` | open completion menu                |
| `<Tab>` / `<S-Tab>` | next / previous item, snippet jump |
| `<CR>`      | accept                              |
| `<C-e>`     | cancel                              |

Signature help and documentation appear automatically while browsing completions.

## LSP (Python + C/C++)

| Key           | Action            |
|---------------|-------------------|
| `gd`          | go to definition  |
| `gr`          | references        |
| `gI`          | implementations   |
| `K`           | hover docs        |
| `<leader>rn`  | rename            |
| `<leader>ca`  | code action       |

Check status with `:checkhealth vim.lsp` (`:LspInfo` no longer exists).

## Find (telescope) and files (nvim-tree)

| Key          | Action                              |
|--------------|-------------------------------------|
| `<leader>ff` | find files                          |
| `<leader>fg` | live grep                           |
| `<leader>fb` | buffers                             |
| `<leader>fh` | help tags                           |
| `<leader>fe` | fuzzy find in current buffer        |
| `<leader>e`  | toggle file explorer                |
| `<leader>E`  | explorer at current file's dir      |

## Formatting and linting

- Python: **ruff** — organize imports + format **on save**; manual with `<leader>fm`
- Linting diagnostics refresh on open/save/leaving insert mode
- Markdown preview: `:MarkdownPreview` / `:MarkdownPreviewStop`

## OpenCode AI (`opencode.nvim`)

| Key          | Action                                                    |
|--------------|-----------------------------------------------------------|
| `<C-a>`      | ask OpenCode (whole file as `@this` context)              |
| `<C-x>`      | action menu (open split, send selection, paste reply, …)  |
| `go` + motion| send the motion range to OpenCode (e.g. `gap`, `ga{`)     |
| `goo`        | send current line                                         |

In the prompt: type your question after the `@this` context, `Enter` sends,
`<C-g>` or `q` cancels (closes without sending, lands in normal mode).

## Python tooling

External tools are installed with `uv` (see `~/.local/bin`, added to PATH in config):

```sh
uv tool install ruff basedpyright
```

- `basedpyright` type checking runs in `standard` mode; auto-detects a project `.venv`
- ruff line length falls back to **120** via `~/.config/ruff/ruff.toml` — project
  `pyproject.toml` settings always win over it
- treesitter parsers install automatically on first start (needs a C compiler;
  `tree-sitter` CLI is in `~/.local/bin`)
