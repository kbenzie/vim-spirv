" Comments begin with ;
setlocal comments=s1:;
setlocal commentstring=;%s

" Include % in words for easier navigation of ID's
setlocal iskeyword+=%

" Enable highlighting of all ID's matching ID at cursor
if g:spirv_highlight_ids
  autocmd CursorMoved,CursorMovedi * call spirv#highlight_ids()
endif
