" Don't load plugin multiple times
if exists('g:spirv_loaded') && g:spirv_loaded
  finish
endif
let g:spirv_loaded = 1

" Enable automatic highlighting of ID's
let g:spirv_highlight_ids =
      \ get(g:, 'spirv_highlight_ids', 1)

" Highlight color of automatically highlighted ID's
let g:spirv_highlight_color =
      \ get(g:, 'spirv_highlight_color',
      \     'ctermfg=red ctermbg=black guifg=#ff0000 guibg=#000000')

" Highlight ID's upon cursor move events
function! s:spirv_highlight_ids()
  " Check for an existing match
  if (exists('w:spirv_match_id') && w:spirv_match_id != 0)
    try
      " Delete existing match
      call matchdelete(w:spirv_match_id)
    catch " Do nothing
    endtry
    let w:spirv_match_id = 0
  endif

  " Store current cursor position
  let s:cursor = getpos('.')[1:2]

  " Search backwards for match position
  let s:match = searchpos('%\w\+', 'bcnW')

  " Avoid erroneous matches
  if(s:match[0] != s:cursor[0])
    let s:match[1] = 0
  endif

  " Store the content of the current line
  let s:line = getbufline(bufnr('%'), line('.'))

  " Find the end of the current match
  let s:end = match(s:line[0], '%\w\+\|\s', s:match[1]) + 1
  if((s:end > s:match[1]) && (s:end < s:cursor[1]))
    return
  endif

  " Don't miss matches at the end of a line
  if(s:end == 0)
    let s:end = strlen(s:line[0]) + 1
  endif

  " Construct the match string
  let s:str = strpart(s:line[0], s:match[1] - 1, (s:end - s:match[1]))

  " Highlight all occurrences of the match
  try
    let w:spirv_match_id = matchadd('SpirVID', s:str)
  catch " Do nothing
  endtry
endfunction

" Check automatic highlighting is enabled
if g:spirv_highlight_ids
  augroup spirv_augroup
    autocmd!
    " Register commands for automatically highlighting ID's
    au CursorMoved,CursorMovedi *.spvasm call <sid>spirv_highlight_ids()
  augroup END
endif
