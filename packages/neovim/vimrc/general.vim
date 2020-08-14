" Enable syntax highlighting
syntax on

" Some sensible defaults (thanks ThePrimeagen)
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.local/share/nvim/undodir
set undofile
set incsearch
set nocompatible
set termguicolors
filetype plugin on
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=yes
endif

" Setting up relative line numbers
set relativenumber

