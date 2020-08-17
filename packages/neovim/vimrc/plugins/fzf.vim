" If I have Ripgrep installed, derive the root? This isn't my line.
if executable('rg')
  let g:rg_derive_root='true'
endif

" Open fzf
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>s :Rg<CR>

" FZF fixes
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

