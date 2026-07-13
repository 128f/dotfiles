# Neovim Configuration

This is a Neovim configuration using lazy.nvim plugin manager with the following key features:

## Plugin Structure
- Uses lazy.nvim as the plugin manager
- Configures various language-specific plugins including rust, nix, yuck, etc.
- LSP setup with rustaceanvim for Rust and several other language servers
- Completion system using nvim-cmp with various sources
- AI completion integration through minuet-ai.nvim using local Ollama models
- File explorer using nvim-tree
- Terminal integration with toggleterm.nvim

## Key Commands
- `<C-t>`: Open new empty buffer
- `<C-p>`: Search files with Telescope
- `<C-b>`: Toggle NvimTree file explorer
- `<leader>ff`: Find files with Telescope
- `<leader>fg`: Live grep with Telescope
- `<leader>fb`: Open buffers with Telescope
- `<leader>fh`: Open help tags
- `<leader>r`: Refresh NvimTree
- `<leader>n`: Find current file
- `<leader>bp`: Pick buffer
- `<leader>bc`: Close buffer
- `<C-w>x`: Close buffer
- `<leader>[number]`: Switch to buffer by number
- `<leader>mq`: AI completion with qwen3-coder:30b
- `<leader>mg`: AI completion with gemini-3.1-pro-preview
- `<C-g>`: Trigger on-demand AI completion (minuet)

## LSP Configuration
- Uses Neovim 0.11+ native `vim.lsp.config`/`vim.lsp.enable` API (no nvim-lspconfig)
- Generic LSP setup for: hls, html, jdtls, jsonls, sourcekit, ts_ls, yamlls
- Pyright has a separate full config (cmd, filetypes, root_markers) with auto-detection of `.venv` for uv/virtualenv projects
- Rust projects use rustaceanvim which manages rust-analyzer
- Diagnostics show inline errors and signs in the gutter
- Automatic formatting for Rust files on save

## AI Integration
- Local Ollama setup expected for AI completion
- Models: qwen2.5-coder:7b (fast insert endpoint)
- AI completion triggered manually with `<C-g>` or via `<leader>mq`/`<leader>mg`
- Uses minuet-ai.nvim plugin with specific configuration for Ollama

## Terminal Setup
- ToggleTerm for terminal integration
- `<leader>tf`: Open float terminal
- `<leader>th`: Open horizontal terminal (15 rows)
- `<leader>tv`: Open vertical terminal (80 columns)
- Double Esc to exit terminal mode to normal mode
- `<leader>gd` in terminal to jump to file:line:col under cursor

## Treesitter
- Enabled for multiple languages including nix, terraform, python, rust, c, go, typescript, javascript, yuck
- Language syntax highlighting and code navigation