-- Leader must be set before plugins/keymaps load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load lazy.nvim plugin manager
require('bootstrap')

-- Set colorscheme with fallback
vim.cmd("colorscheme catppuccin")

vim.cmd('set bg=dark')

-- Load configuration modules
require('opts')
require('keymap')
require('lsp')
-- Show a dot character at the end of every line
vim.opt.list = true
vim.opt.listchars:append("eol:·")
