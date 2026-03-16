-- Load lazy.nvim plugin manager
require('bootstrap')

-- Set colorscheme with fallback
vim.cmd("colorscheme jellybeans")

-- Time-based light/dark mode
local hour = tonumber(os.date('%H'))
if hour < 19 then
    vim.cmd('set bg=light')
else
    vim.cmd('set bg=dark')
end

-- Load configuration modules
require('opts')
require('keymap')
require('lsp')
-- Show a dot character at the end of every line
vim.opt.list = true
vim.opt.listchars:append("eol:·")
