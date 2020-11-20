" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Filetype options for the vim-spirv plugin.
" Last Modified: September 04, 2016

" Comments begin with ;
setlocal comments=s1:;
setlocal commentstring=;%s

" Include % in words for easier navigation of ID's
setlocal iskeyword+=%

" Enable highlighting of all ID's matching ID at cursor
if g:spirv_enable_current_id
  autocmd CursorMoved,CursorMovedI *.spvasm,*.spvasm32,*.spvasm64 call spirv#highlight_ids()
  if g:spirv_enable_autodisassemble
    autocmd CursorMoved,CursorMovedI *.spv,*.spv32,*.spv64 call spirv#highlight_ids()
  endif
endif

" Enable error extended instruction error highlighing
if g:spirv_enable_extinst_error
  autocmd CursorMoved,CursorMovedI *.spvasm,*.spvasm32,*.spvasm64 call spirv#highlight_extinst()
  if g:spirv_enable_autodisassemble
    autocmd CursorMoved,CursorMovedI *.spv,*.spv32,*.spv64 call spirv#highlight_extinst()
  endif
endif
