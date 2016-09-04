" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Auto load functions for the vim-spirv plugin.
" Last Modified: September 04, 2016

" Early exit if plugin is not loaded or compatible is set
if !exists('g:spirv_loaded') || &cp
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
python << endpython
def find_group_names():
  ext_names = []
  for line in vim.current.buffer:
    if 'OpExtInstImport' in line:
      semicolonpos = line.find(';')
      if semicolonpos >= 0 and semicolonpos < line.find('OpExtInstImport'):
        continue
      begin = line.find('"')
      end = line.rfind('"')
      if begin == -1 or begin == -1:
        continue
      name = line[begin+1:end].split('.')
      ext_names.append('Spirv' + ''.join(part.capitalize() for part in name))
  return ext_names
endpython
  let l:group_names = pyeval('find_group_names()')

  " No OpExtInstImport instruction set names found, nothing to do
  let l:len_group_names = len(l:group_names)
  if l:len_group_names == 0 && !exists('b:spirv_ext_group_names')
    return
  endif

  " Remove all previous group names
  if exists('b:spirv_ext_group_names')
    for l:group_name in b:spirv_ext_group_names
      exec 'hi link '.l:group_name.' SpirvError'
    endfor
  endif

  " Check if the buffer variable is still required
  if l:len_group_names == 0
    unlet b:spirv_ext_group_names
    return
  endif

  " Highlight all found group names
  for l:group_name in l:group_names
    exec 'hi link '.l:group_name.' SpirvInstruction'
  endfor

  " Store current group names in buffer variable
  let b:spirv_ext_group_names = copy(l:group_names)
endfunction
