local map = vim.api.nvim_set_keymap

options = { noremap = true }
--- CTRL+T for a new bufferline tab (new empty buffer)
map('n', '<C-t>', '<cmd>enew<CR>', options)
--- escape removes selections
map('n', '<esc>', ':noh<return><esc>', options)
--- look for stuff
map('n', '<C-p>', ':Telescope find_files<cr>', options)
map('n', '<S-f>', ':Telescope live_grep<cr>', options)

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', options)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

map('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', options)
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>', options)
map('n', '<leader>n', '<cmd>:NvimTreeFindFile<CR>', options)

--- bufferline (buffer tabs)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', options)
map('n', '<leader>bp', '<cmd>BufferLinePick<CR>', options)
map('n', '<leader>bc', '<cmd>bdelete<CR>', options)
map('n', '<C-w>x', '<cmd>bdelete<CR>', options)
--- jump to bufferline tab by its ordinal number
for i = 1, 9 do
	map('n', '<leader>' .. i, '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>', options)
end

--- pi (AI) on the visual selection -> replace selection with the output.
--- <Esc> first so the '< and '> marks reflect the current selection.
vim.keymap.set('x', '<leader>mq', "<Esc><Cmd>lua require('pi').run('qwen3-coder:30b')<CR>",
  { silent = true, noremap = true, desc = "pi: qwen3-coder:30b (replace selection)" })
vim.keymap.set('x', '<leader>mg', "<Esc><Cmd>lua require('pi').run('google/gemini-3.1-pro-preview')<CR>",
  { silent = true, noremap = true, desc = "pi: google/gemini-3.1-pro-preview (replace selection)" })

--- completion commands
-- map('n', '<silent>', '<M-CR> :call CocActionAsync(\'doQuickfix\')<cr>', options)
-- map('n', '<silent>gd', '<Plug>(coc-definition)', options)
-- map('n', '<silent>gy', '<Plug>(coc-type-definition)', options)
-- map('n', '<silent>gi', '<Plug>(coc-implementation)', options)
-- map('n', '<silent>gr', '<Plug>(coc-references)', options)


