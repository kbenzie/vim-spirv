" Don't load plugin multiple times
if exists('g:spirv_loaded') && g:spirv_loaded
  finish
endif
let g:spirv_loaded = 1

" Enable automatic highlighting of ID's
let g:spirv_highlight_ids = get(g:, 'spirv_highlight_ids', 1)

" Highlight color of automatically highlighted ID's
let g:spirv_highlight_group = get(g:, 'spirv_highlight_group',
      \ 'term=inverse cterm=inverse gui=inverse')
