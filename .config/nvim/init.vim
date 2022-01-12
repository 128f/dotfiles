:call plug#begin('~/.config/nvim')
" The essentials - syntax checking, finding files, autocomplete, etc
    " Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf'
    " Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'Valloric/YouCompleteMe'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-rooter'
    Plug 'editorconfig/editorconfig-vim'
    " Plug 'Shougo/neosnippet.vim'
    " Plug 'Shougo/neosnippet-snippets'
" opengl shaders
    Plug 'tikhomirov/vim-glsl'
" nice rice
    Plug 'machakann/vim-highlightedyank'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
" javascript
    Plug 'yuezk/vim-js'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    " Plug 'kien/ctrlp.vim'
" themes
    Plug 'chriskempson/base16-vim'
    " Plug 'Soares/base16.nvim'
" godot
    Plug 'habamax/vim-godot'
" solidity
    Plug 'tomlion/vim-solidity'
:call plug#end()

" nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZF<CR>
nmap <C-t> :tabnew<CR>
nnoremap <esc> :noh<return><esc>
:set relativenumber
:set number
" install xclip before use
:set clipboard+=unnamedplus
:set mouse=n
" nnoremap <leader>. :CtrlPTag<cr>

" defunct color bullshit
" Fix highlighting for spell checks in terminal
" function! s:base16_customize() abort
"   " Colors: https://github.com/chriskempson/base16/blob/master/styling.md
"   " Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
"   :call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
"   :call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
"   :call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
"   :call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
" endfunction

" augroup on_change_colorschema
"   autocmd!
"   autocmd ColorScheme * call s:base16_customize()
" augroup END

let base16colorspace=256
" :colorscheme base16-material-palenight
:set background=dark
:set termguicolors&

"
" ale config
"
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'vue': ['eslint']
\}

"
"coc config
"

" some backspace thing when completing
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use coc for defintions and such
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" window popup color
:hi Pmenu ctermfg=1 ctermbg=0 guibg=Black;
:hi SpellBad ctermfg=0 ctermbg=9 gui=undercurl guisp=Red
:hi SpellCap ctermfg=0 ctermbg=4 gui=undercurl guisp=Green

let g:coc_node_path = '/home/cburke/.nvm/versions/node/v12.21.0/bin/node'
"
"end coc config
"

"
" Godot config
" disabled because there's no console gdscript runner
"
" setlocal foldmethod=expr
" setlocal tabstop=6
" nnoremap <buffer> <F4> :GodotRunLast<CR>
" nnoremap <buffer> <F5> :GodotRun<CR>
" nnoremap <buffer> <F6> :GodotRunCurrent<CR>
" nnoremap <buffer> <F7> :GodotRunFZF<CR>
