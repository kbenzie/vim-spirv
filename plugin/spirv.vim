" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Settings for the vim-spirv plugin.
" Last Modified: September 04, 2016

" Don't load plugin multiple times
if exists('g:spirv_loaded') && g:spirv_loaded
  finish
endif
let g:spirv_loaded = 1

" Enable automatic highlighting of ID's
let g:spirv_enable_current_id = get(g:, 'spirv_enable_current_id', 1)

" Highlight color of automatically highlighted ID's
let g:spirv_current_id_highlight = get(g:, 'spirv_current_id_highlight',
      \ 'term=inverse cterm=inverse gui=inverse')

" Enable extended instruction error highlighting
if has('python')
  let g:spirv_enable_extinst_error = get(g:, 'spirv_enable_extinst_error', 1)
else
  let g:spirv_enable_extinst_error = get(g:, 'spirv_enable_extinst_error', 0)
  if g:spirv_enable_extinst_error
    echoerr 'Python support required for g:spirv_enable_extinst_error'
    let g:spirv_enable_extinst_error = 0
  endif
endif
