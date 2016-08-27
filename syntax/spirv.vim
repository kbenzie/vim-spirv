" Don't load the sytnax multiple times
if exists("b:current_syntax")
  finish
endif

" Define ID highlight group
if exists('g:spirv_highlight_ids') && g:spirv_highlight_ids
  execute 'hi SpirvID '.g:spirv_highlight_group
endif

syn match Comment ";.*$"
syn match Statement "Op\w\+"
syn match Constant "OpConstant\(True\|False\|Composite\|Sampler\|Null\)\=\|OpSpecConstant\(True\|False\|Composite\|Op\)\="
syn region String start=+"+ end=+"+
syn match	Number "\s\d\+"
" syn match Boolean "OpConstant\(True\|False\)\|OpSpecConstant\(True\|False\)\="
syn match	Float "\s\d\+\.\=\d*"
syn match Identifier "%\w\+"
syn match Function "OpFunction\(Parameter\|End\|Call\)*"
syn match Repeat "OpLoopMerge"
syn match Label "OpLabel"
syn match Operator "Op\([SF]Negate\|[IF]Add\|[IF]Sub\|[IF]Mul\|[USF]Div\|[USF]Mod\|[SF]Rem\|VectorTimesScalar\|MatrixTimesScalar\|VectorTimesMatrix\|MatrixTimesVector\|MatrixTimesMatrix\|OuterProduct\|Dot\|IAddCarry\|ISubBorrow\|[US]MulExtended\|ShiftRight\(Logical\|Arithmetic\)\|ShiftLeftLogical\|Bitwise\(Or\|Xor\|And\)\|Not\|BitField\(Insert\|[SU]Extract\)\|Bit\(Reverse\|Count\)\|Any\|All\|Is\(Nan\|Inf\|Finite\|Normal\)\|SignBitSet\|LessOrGreater\|Ordered\|Unordered\|Logical\(Equal\|NotEqual\|Or\|And\|Not\)\|Select\|IEqual\|INotEqual\|[US]GreaterThan\(Equal\)\=\|FOrd\(Not\)\=Equal\|FUnordNotEqual\|FUnordEqual\|FOrdLessThan\|FUnordLessThan\|FOrdGreaterThan\|FOrdGreaterThanEqual\|FUnordGraterThan\|FUnordGraterThanEqual\|DPdx\|DPdy\|Fwidth\|DPdxFine\|DPdyFine\|FwidthFine\|DPdxCoarse\|DPdyCoarse\|FwidthCoarse\)"
syn match Conditional "OpPhi\|OpSelectionMerge\|OpBranch\(Conditional\)\=\|OpSwitch\|OpKill\|OpReturn\(Value\)\=\|OpUnreachable\|OpLifetime\(Start\|Stop\)"
syn match Define "OpMemoryModel\|OpEntryPoint\|OpExecutionMode\|OpCapability\|Op\(Member\|Group\|GroupMember\)\=Decorate\|OpDecorationGroup"
syn match Include "OpExtension\|OpExtInstImport\|OpExtInst"
syn match Type "OpType\w*"
syn match Debug "OpSource\(Continued\|Extension\)\=\|Op\(Member\)\=Name\|OpString\|Op\(No\)\=Line\|OpModuleProcessed"
