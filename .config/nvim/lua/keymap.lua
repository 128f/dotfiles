local map = vim.api.nvim_set_keymap

options = { noremap = true }
--- CTRL+T for new tab
map('', '<C-t>', ':tabnew<CR>', options)
--- escape removes selections
map('n', '<esc>', ':noh<return><esc>', options)
--- look for stuff
map('n', '<C-p>', ':Telescope find_files<cr>', options)
map('n', '<S-f>', ':Telescope live_grep<cr>', options)

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', options)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

--- completion commands
-- map('n', '<silent>', '<M-CR> :call CocActionAsync(\'doQuickfix\')<cr>', options)
-- map('n', '<silent>gd', '<Plug>(coc-definition)', options)
-- map('n', '<silent>gy', '<Plug>(coc-type-definition)', options)
-- map('n', '<silent>gi', '<Plug>(coc-implementation)', options)
-- map('n', '<silent>gr', '<Plug>(coc-references)', options)


