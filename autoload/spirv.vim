" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Auto load functions for the vim-spirv plugin.
" Last Modified: September 04, 2016

" Early exit if plugin is not loaded or compatible is set
if !exists('g:spirv_loaded') || &compatible
  finish
endif

" Highlight ID's upon cursor move events
function! spirv#highlight_ids()
  " Early exit, option not enabled
  if !exists('g:spirv_enable_current_id') || !g:spirv_enable_current_id
    return
  endif

  " Check for an existing match
  if (exists('b:spirv_match_id') && b:spirv_match_id != 0)
    try
      " Delete existing match
      call matchdelete(b:spirv_match_id)
    catch " Do nothing
    endtry
    let b:spirv_match_id = 0
  endif

  " Store current cursor position
  let l:cursor = getpos('.')[1:2]

  " Search backwards for match position
  let l:match = searchpos('\<%\w\+\>', 'bcnW')

  " TODO: Search forwards if backward search was unsuccessful

  " Avoid erroneous matches
  if(l:match[0] != l:cursor[0])
    let l:match[1] = 0
  endif

  " Store the content of the current line
  let l:line = getbufline(bufnr('%'), line('.'))

  " Find the end of the current match
  let l:end = match(l:line[0], '\s', l:match[1]) + 1
  if((l:end > l:match[1]) && (l:end < l:cursor[1]))
    return
  endif

  " Don't miss matches at the end of a line
  if(l:end == 0)
    let l:end = strlen(l:line[0]) + 1
  endif

  " Construct the match string
  let l:str = '\<'.strpart(l:line[0], l:match[1] - 1, (l:end - l:match[1])).'\>'

  " Highlight all occurrences of the match
  try
    let b:spirv_match_id = matchadd('SpirvCurrentID', l:str)
  catch " Do nothing
  endtry
endfunction

" Highlight extended instructions
function! spirv#highlight_extinst()
  " Early exit, option not enabled
  if !exists('g:spirv_enable_extinst_error') || !g:spirv_enable_extinst_error
    return
  endif

  " Search for OpExtInstImport instruction set name
  let l:group_names = []
  for l:line in getline(1, line('$'))
    if l:line =~# '^\s*;\@!%\w\+\s\+=\s\+OpExtInstImport.*$'
      let l:name = matchstr(l:line, '"\zs.*\ze"')
      let l:group_name = ''
      for l:part in split(l:name, '\.')
        let l:part = substitute(tolower(l:part), '^\zs\(\w\)\ze.*', '\U\1', '')
        let l:group_name = l:group_name.l:part
      endfor
      if l:group_name ==# 'OpenclStd'
        " 'OpenclStd' will not match the highlight group 'SpirvOpenclStd100'
        " so append '100' to fix highlighting
        let l:group_name = l:group_name.'100'
      endif
      call add(l:group_names, 'Spirv'.l:group_name)
    endif
  endfor

  " No OpExtInstImport instruction set names found, nothing to do
  if len(l:group_names) == 0 && !exists('b:spirv_ext_group_names')
    return
  endif

  " Remove all previous group names
  if exists('b:spirv_ext_group_names')
    for l:group_name in b:spirv_ext_group_names
      exec 'hi link '.l:group_name.' SpirvError'
    endfor
  endif

  " Check if the buffer variable is still required
  if len(l:group_names) == 0
    unlet b:spirv_ext_group_names
    return
  endif

  " Highlight all found group names
  for l:group_name in l:group_names
    if l:group_name ==# 'SpirvDebugInfo100'
      exec 'hi link '.l:group_name.' SpirvDebug'
    else
      exec 'hi link '.l:group_name.' SpirvInstruction'
    endif
  endfor

  " Store current group names in buffer variable
  let b:spirv_ext_group_names = copy(l:group_names)
endfunction

" Disassemble a SPIR-V binary file, called from autocmd.
function! spirv#disassemble()
  let l:empty = line("'['") == 1 && line("']'") == line('$')
  let l:temp1 = tempname()
  let l:temp2 = tempname()
  execute "silent '[,']w " . l:temp1
  call system(printf(g:spirv_dis_path.' "%s" -o "%s"', l:temp1, l:temp2))
  if v:shell_error
    echohl ErrorMsg
    echo 'spirv-dis failed'
  endif
  let l:line = line("'[") - 1
  '[,']d _
  setlocal binary
  execute 'silent '.l:line.'r '.l:temp2
  if l:empty
    silent $delete _
    1
  endif
  call delete(l:temp2)
  call delete(l:temp1)
  silent! execute 'bwipe '.l:temp2
  silent! execute 'bwipe '.l:temp1
  setfiletype spirv
endfunction

" Assemble a SPIR-V binary file, called from autocmd.
function! spirv#assemble()
  let l:afile = expand('<afile>')
  let l:temp1 = tempname()
  let l:temp2 = tempname()
  execute 'noautocmd w '.l:temp1
  call system(printf(g:spirv_as_path.' "%s" -o "%s"', l:temp1, l:temp2))
  if !v:shell_error
    call rename(l:temp2, l:afile)
    setlocal nomodified
  else
    call delete(l:temp2)
    echohl ErrorMsg
    echo 'spirv-as failed'
    echohl None
  endif
  call delete(l:temp1)
endfunction
