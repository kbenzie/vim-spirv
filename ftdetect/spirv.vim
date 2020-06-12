" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Detect filetype for the vim-spirv plugin.
" Last Modified: September 04, 2016

autocmd BufRead,BufNewFile *.spvasm,*.spvasm32,*.spvasm64 setfiletype spirv
