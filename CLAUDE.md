# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin Manager

**Packer** (`wbthomason/packer.nvim`) is the plugin manager. After adding or removing a plugin, run `:PackerSync` inside Neovim to install/remove and compile.

No build step or test runner exists outside of Neovim itself.

## Architecture

The config uses a split structure:

- **`init.lua`** — entry point. Declares all plugins via `use` blocks. Some plugins are configured inline here (treesitter, neoscroll, autopairs, harpoon, colorscheme, etc.) by calling `require("plugins.<name>")` immediately after the `use` call.
- **`lua/settings_only_nvim/init.lua`** — all vim options and global keymaps (window navigation, splits, resize, buffer close, diagnostics, leap, clipboard, imgcat, browser open, project thoughts).
- **`after/plugin/`** — plugin-specific config loaded automatically after startup. Each plugin with non-trivial setup has its own file here.
- **`after/lsp/`** — LSP server configs in the `after/lsp/<servername>.lua` format (returns a table with `cmd`, `filetypes`, `root_markers`; no manual `lspconfig.setup()` needed). Currently only `erlangls.lua`.
- **`lua/plugins/`** — config modules required inline from `init.lua` (catppuccin, cmp_snip, gitsigns, rainbow_delimiter, treesitter).
- **`vscode_snippets/`** — LuaSnip-compatible VSCode snippet files for Erlang and rebar, loaded by `cmp_snip.lua`.

## Adding a Plugin

1. Add `use 'author/repo'` in `init.lua` (inside the `packer.startup` block).
2. Create `after/plugin/pluginname.lua` for its setup/keymaps.
3. Run `:PackerSync`.

For plugins that need to be configured before others load (e.g. colorscheme dependencies), require them inline in `init.lua` after the `use` call, as done for treesitter, catppuccin, etc.

## LSP

LSP is configured with `neovim/nvim-lspconfig` directly — **no mason** (mason.lua exists but mason is disabled). Add new servers by creating `after/lsp/<servername>.lua` returning a table with `cmd`, `filetypes`, and `root_markers`.

The config targets **Erlang** development: `erlang_ls` is the primary LSP, with root markers `rebar.config`, `erlang.mk`, `.git`.

## Completion & Snippets

Configured in `lua/plugins/cmp_snip.lua`. Sources: `nvim_lsp` → `luasnip` → `buffer`. Snippets are loaded from `vscode_snippets/` (project-local) and `friendly-snippets` (global).

Completion keymaps:
- `<Tab>` / `<CR>` — confirm selection
- `<C-Space>` — trigger completion manually
- `<C-k>` — expand or jump snippet
- `<C-L>` / `<C-H>` — jump forward/backward through snippet nodes

## Startup Behavior

On launch with no file arguments, `after/plugin/neo_tree.lua` renders a colored ASCII art dashboard (scratch buffer) and opens Neo-tree on the right automatically.

## Key Keybinding Patterns

Leader is `<Space>`. All other keymaps follow an Alt-based chord system (`<A-x>y` or `<M-x>y`; both forms are mapped for most bindings).

**Terminals (`<A-t>`)**
- `<A-t>t` — float terminal (toggleterm default)
- `<A-t>s` — rebar3 shell (`main_node`)
- `<A-t>ns` — rebar3 shell (custom sname via input prompt)
- `<A-t>c` — rebar3 ct (common test suite)
- `<A-t>o` — rebar3 ct for test case under cursor (filename = suite, `<cword>` = case, sname `test_node`)
- `<A-t>no` — same but prompts for sname
- `<A-t>l` — lazygit
- `<A-t>a` — claude (Claude Code CLI)
- `<A-q>` — exit terminal to normal mode

**Telescope (`<M-f>`)**
- `<M-f>i` — find files
- `<M-f>s` — live grep
- `<M-f>f` — grep string (word under cursor)
- `<M-f>o` — LSP document symbols
- `<M-f>r` — LSP references
- `<M-f>d` — LSP definitions (opens in-place, never jumps)
- `<M-f>b` — buffers
- `<M-f>k` — keymaps
- `<M-f>t` — toggleterm manager

Inside Telescope: `<C-l>` open vertical split, `<C-j>` open horizontal split.

**Harpoon (`<leader>`)**
- `<leader>a` / `<leader>r` — add / remove current file
- `<M-o>` — toggle quick menu
- `<leader>j/k/l/;` — jump to slots 1–4
- `<leader>,` / `<leader>.` — prev / next in list
- `<M-i>h` — clear list

**Utilities (`<A-u>`, `<A-q>`)**
- `<A-u>e` — Neo-tree toggle (filesystem, right)
- `<A-u>w` — open work tasks file (`/mnt/f/repo/notes/work_tasks.md`)
- `<A-u>.` — open/create project thoughts (`_thoughts/proj_things.md`)
- `<A-u>q` — GraphvizCompile pdf
- `<A-q>i` — imgcat current file in a new wezterm pane
- `<A-q>.` — open current file in Vivaldi
- `<A-q>t` — open rebar3 CT log (`_build/test/logs/suite.log.latest.html`) in Vivaldi

**Window management**
- `<A-h/j/k/l>` — navigate windows
- `<A-w>l` / `<A-w>j` — vertical / horizontal split
- `<A-b>l/h/j/k>` — resize window (+/- 16 cols or 9 rows)
- `<A-i>w` — close window (`:q`)
- `<A-i>o` — close all other windows
- `<A-i>i` — close current buffer (`bdelete`)

**Diagnostics**
- `<A-n>d` / `<A-m>d` — next / prev diagnostic
- `<A-n>e` / `<A-m>e` — next / prev error
- `<A-n>w` / `<A-m>w` — next / prev warning

**Other**
- `jk` — exit insert mode
- `<A-s>` — save (all modes)
- `f` / `F` — leap.nvim forward / from-window motions (replaces default `f`)
- `<leader>y` / `<leader>p` — yank / paste to system clipboard
- `<leader>u` — undotree toggle
- `<leader>v` — enter visual block mode (`<C-v>`)

## Colorscheme

Uses a custom theme `itsdend/pastel_inu_nvim` aliased as `catppuccin`, configured in `lua/plugins/catppuccin.lua`. Color generation output lives in `generated.lua` and `colors/generated.lua`. Active variant: `catppuccin-mocha`.
