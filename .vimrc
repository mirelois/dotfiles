set relativenumber

set number

set nowrap

set tabstop=4
set softtabstop=4
set shiftwidth=4

set noswapfile
set nobackup

set nohlsearch
set incsearch

set termguicolors

set scrolloff=8

let leader = " " 
let mapleader = " " 

nnoremap - :Ex<CR>

nnoremap <C-w>- :split<CR>
nnoremap <C-w>\| :vsplit<CR>

vnoremap J :m +1<CR>gv=gv
vnoremap K :m -2<CR>gv=gv

vnoremap > >gv
vnoremap < <gv

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

xnoremap <leader>p "_dP

" isto probs not funfa depende se tens clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <C-L> <C-w>l
nnoremap <C-H> <C-w>h

"inoremap {<CR> {<CR>}<Esc>ko

xnoremap <C-v> C-V



