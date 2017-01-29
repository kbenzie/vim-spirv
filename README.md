# vim-spirv

A vim plugin for the [Khronos Group][khr]'s [SPIR-V][spirv] standard providing
rich syntax highlighting for disassembled [SPIR-V][spirv] assembly (`.spvasm`
files) and automatically disassembled binary [SPIR-V][spirv] modules (`.spv`
files) with interactive visualisation of the ID under the cursor to show, at a
glance, the source of opcode operands.

<p align="center"><img src="vim-spirv.gif" alt="vim-spirv"></p>

>   This plugin **does not** target the older [LLVM IR][llvm-ir] based [SPIR
>   1.2][spir] and [2.0][spir] specifications.

## Install

Using [vim-plug][vim-plug].

```vim
Plug 'kbenzie/vim-spirv'
```

Using [Vundle][vundle].

```vim
Plugin 'kbenzie/vim-spirv'
```

Using [vim-pathogen][vim-pathogen].

```
git clone https://github.com/kbenzie/vim-spirv.git ~/.vim/bundle/vim-spirv
```

## Options

### `g:spirv_enable_current_id`

Enable automatic highlighting of all occurrences of the ID under the cursor.
This is useful for highlighting where an opcode ID is defined and used at a
glance. See `g:spirv_current_id_highlight`. To disable this option.

```vim
let g:spirv_enable_current_id = 0
```

#### `g:spirv_current_id_highlight`

Specify the value of the `SpirvCurrentID` highlight group, this is only set when
the [`g:spirv_enable_current_id`](#gspirv_current_id_highlight) option is
enabled. To Customize the highlight group to, for example, make the current ID
bold.

```vim
let g:spirv_current_id_highlight = 'term=bold cterm=bold gui=bold'
```

### `g:spirv_enable_extinst_error`

Enable highlighting extended instruction error highlighting, enabling this
option will parse the file looking for an `OpExtInstImport` instruction,
determine the imported instruction set and set the value of that instruction
sets highlight group, E.G. `SpirvGlslStd450`, to linked to the
`SpirvInstruction` highlight group. If no `OpExtInstImport` instruction is
found, or it is commented out, the extended instruction set highlight group
will be linked to `SpirvError`. When this option is disabled the extended
instruction set highlight group is set to `SpirvInstruction`. To disable this
option.

```vim
let g:spirv_enable_extinst_error = 0
```

### `g:spirv_enable_autodisassemble`

Enable automatic disassembly of SPIR-V binary files on `:edit` and automatic
assembly on `:write` enabling ease of editing. This option depends on
[`spirv-as`][spirv-tools] and [`spirv-dis`][spirv-tools] being available on the
system `PATH`, to override this behavior see
[`g:spirv_as_path`](#gspirv_as_path) and [`g:spirv_dis_path`](#gspirv_dis_path).
To disable this option.

```vim
let g:spirv_enable_autoassemble = 1
```

#### `g:spirv_as_path`

Path to the `spirv-as` tool used automatically assemble SPIR-V assembly into a
binary when [`g:spirv_enable_autodisassemble`](#gspirv_enable_autodisassemble)
is enabled. If [`spirv-as`][spirv-tools] is on the system `PATH` this option
need not be set. Default setting.

```vim
let g:spirv_as_path = 'spirv-as'
```

#### `g:spirv_dis_path`

Path to the `spirv-dis` tool used automatically disassemble SPIR-V assembly into
a binary when [`g:spirv_enable_autodisassemble`](#gspirv_enable_autodisassemble)
is enabled. If [`spirv-dis`][spirv-tools] is on the system `PATH` this option
need not be set. Default setting.

```vim
let g:spirv_dis_path = 'spirv-dis'
```

# License (MIT)

See [license](LICENSE.md) file.

[khr]: https://www.khronos.org/
[spirv]: https://www.khronos.org/registry/spir-v/
[spirv-tools]: https://github.com/KhronosGroup/SPIRV-Tools
[llvm-ir]: http://llvm.org/docs/LangRef.html
[spir]: https://www.khronos.org/registry/spir/
[vim-plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/VundleVim/Vundle.vim
[vim-pathogen]: https://github.com/tpope/vim-pathogen
