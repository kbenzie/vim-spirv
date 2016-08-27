" Early exit if plugin is not loaded or compatible is set
if !exists('g:spirv_loaded') || &cp
  finish
endif

" Highlight ID's upon cursor move events
function! spirv#highlight_ids()
  " Early exit, filetype is not spir-v
  if !exists('g:spirv_highlight_ids') || g:spirv_highlight_ids != 1
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

  " TODO: Seach forwards if backward search was unsuccessful
  " echo l:match

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

  " echo '"'.l:str.'"'

  " Highlight all occurrences of the match
  try
    let b:spirv_match_id = matchadd('SpirVID', l:str)
  catch " Do nothing
  endtry
endfunction
