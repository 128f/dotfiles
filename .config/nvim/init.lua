
require('opts')
require('plugins')
require('feline').setup()
require('snippets')
require('keymap')

--- Set our current base16 theme from env
nvim = require 'nvim'
local base16 = require 'base16'
base16(base16.themes[nvim.env.BASE16_THEME or "3024"], true)

--- Show a dot character at the end of every line
vim.opt.list = true
vim.opt.listchars:append("eol:·")
require("indent_blankline").setup {
	show_end_of_line = true,
	char = "",
	show_trailing_blankline_indent = false,
}
