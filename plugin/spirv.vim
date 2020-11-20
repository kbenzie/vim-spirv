" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Settings for the vim-spirv plugin.
" Last Modified: November 20, 2020

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
let g:spirv_enable_extinst_error = get(g:, 'spirv_enable_extinst_error', 1)

" Enable automatic (dis)assmebly of SPIR-V binaries
let g:spirv_enable_autodisassemble = get(g:, 'spirv_enable_autodisassemble', 1)

" Paths to spirv-as and spirv-dis tools
let g:spirv_as_path = get(g:, 'spirv_as_path', 'spirv-as')
let g:spirv_dis_path = get(g:, 'spirv_dis_path', 'spirv-dis')

augroup spirv
  " Remove all autocmds from the spirv group
  autocmd!

  " Set autocommands to disassemble SPIR-V binaries on load
  autocmd BufReadPre,FileReadPre *.spv,*.spv32,*.spv64 setlocal bin
  autocmd BufReadPost,FileReadPost *.spv,*.spv32,*.spv64 call spirv#disassemble()

  " Set autocommands to assemble SPIR-V binaries on write
  autocmd BufWriteCmd,FileWriteCmd *.spv,*.spv32,*.spv64 call spirv#assemble()
augroup END
