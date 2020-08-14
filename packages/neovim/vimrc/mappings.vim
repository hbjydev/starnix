" I like space. Give me space. I will press space.
let mapleader = " "

" Window movements
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Shortcut to quit
nnoremap <leader>q :q<CR>

" Quick resizing
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" Move a line up or down a la VSCode
nnoremap <M-Up> :move -2<CR>
nnoremap <M-Down> :move +1<CR>

" Navigation changes
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >>
vnoremap <S-Tab> <<

map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>

noremap K     {
noremap J     }
noremap H     ^
noremap L     $

inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" Jump to first non-whitespace
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>

