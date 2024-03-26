set relativenumber

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4

set noswapfile
set nobackup
set undodir=$HOME/.vim/undodir
set undofile

set nohlsearch
set incsearch

set notermguicolors

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

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

inoremap {<CR> {<CR>}<Esc>ko

xnoremap <C-v> C-V



