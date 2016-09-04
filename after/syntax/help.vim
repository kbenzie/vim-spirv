" File: help.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Extend help file syntax highlighting for spirv.txt
" Last Modified: September 04, 2016

syn region helpSpirvBold contained concealends matchgroup=None start='\*\*' end='\*\*'
syn match helpSpirvBold '\*\*\zsdoes not\ze\*\*' contains=helpSpirvNone
hi helpSpirvBold term=bold cterm=bold gui=bold

syn match SpirvComment "SpirvComment"
syn match SpirvConditional "SpirvConditional"
syn match SpirvConstant "SpirvConstant"
syn match SpirvDebug "SpirvDebug"
syn match SpirvEnumerant "SpirvEnumerant"
syn match SpirvError "SpirvError"
syn match SpirvExtension "SpirvExtension"
syn match SpirvFloat "SpirvFloat"
syn match SpirvFunction "SpirvFunction"
syn match SpirvID "SpirvID"
syn match SpirvInstruction "SpirvInstruction"
syn match SpirvLabel "SpirvLabel"
syn match SpirvLoop "SpirvLoop"
syn match SpirvMode "SpirvMode"
syn match SpirvNumber "SpirvNumber"
syn match SpirvOperation "SpirvOperation"
syn match SpirvSpecialComment "SpirvSpecialComment"
syn match SpirvString "SpirvString"
syn match SpirvType "SpirvType"
