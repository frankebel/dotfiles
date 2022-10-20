syntax on
set ignorecase
set number relativenumber
set clipboard=unnamedplus
set ttyfast

" syntax highlighting
au BufNewFile,BufRead /*.rasi setf css

" vim-plug
call plug#begin()
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()
