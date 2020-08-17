let g:lightline = {}
let g:lightline.colorscheme='starlight'
let g:lightline.active = {}
let g:lightline.active.left = [ [ 'mode' ], [], [ 'cocstatus' ] ]
let g:lightline.active.right = [ [ 'readonly', 'filename' ], [], [ 'gitbranch' ] ]
let g:lightline.component_function = {}
let g:lightline.component_function.gitbranch = 'FugitiveHead'

