#!/usr/bin/env python
"""Generate vim-spirv sources from SPIRV-Headers."""

import argparse
import datetime
import difflib
import json
import os
import sys

DIRECTORY = os.path.relpath(os.path.dirname(__file__))

KEYWORDS = {
    'Conditional': [
        'OpPhi',
        'OpSelectionMerge',
        'OpBranch',
        'OpBranchConditional',
        'OpSwitch',
        'OpKill',
        'OpReturn',
        'OpReturnValue',
        'OpUnreachable',
        'OpLifetimeStart',
        'OpLifetimeStop',
    ],
    'Debug': [
        'OpSource',
        'OpSourceContinued',
        'OpSourceExtension',
        'OpName',
        'OpMemberName',
        'OpString',
        'OpLine',
        'OpNoLine',
        'OpModuleProcessed',
    ],
    'Enumerant': [],
    'Extension': [
        'OpExtension',
        'OpExtInstImport',
        'OpExtInst',
    ],
    'Function': [
        'OpFunction',
        'OpFunctionParameter',
        'OpFunctionEnd',
        'OpFunctionCall',
    ],
    'Instruction': [],
    'Label': [
        'OpLabel',
    ],
    'Loop': [
        'OpLoopMerge',
    ],
    'Mode': [
        'OpMemoryModel',
        'OpEntryPoint',
        'OpExecutionMode',
        'OpCapability',
        'OpDecorate',
        'OpMemberDecorate',
        'OpGroupDecorate',
        'OpGroupMemberDecorate',
        'OpDecorationGroup',
    ],
    'Operation': [
        'OpSNegate',
        'OpFNegate',
        'OpIAdd',
        'OpFAdd',
        'OpFSub',
        'OpFSub',
        'OpIMul',
        'OpFMul',
        'OpUDiv',
        'OpSDiv',
        'OpFDiv',
        'OpUMod',
        'OpSMod',
        'OpFMod',
        'OpFRem',
        'OpFRem',
        'OpVectorTimesScalar',
        'OpMatrixTimesScalar',
        'OpVectorTimesMatrix',
        'OpMatrixTimesVector',
        'OpMatrixTimesMatrix',
        'OpOuterProduct',
        'OpDot',
        'OpIAddCarry',
        'OpISubBorrow',
        'OpUMulExtended',
        'OpSMulExtended',
        'OpShiftRight',
        'OpShiftRightLogical',
        'OpShiftRightArithmetic',
        'OpShiftLeftLogical',
        'OpBitwiseOr',
        'OpBitwiseXor',
        'OpBitwiseAnd',
        'OpNot',
        'OpBitFieldInsert',
        'OpBitFieldSExtract',
        'OpBitFieldUExtract',
        'OpBitReverse',
        'OpBitCount',
        'OpAny',
        'OpAll',
        'OpIsNan',
        'OpIsInf',
        'OpIsFinite',
        'OpIsNormal',
        'OpSignBitSet',
        'OpLessOrGreater',
        'OpOrdered',
        'OpUnordered',
        'OpLogicalEqual',
        'OpLogicalNotEqual',
        'OpLogicalOr',
        'OpLogicalAnd',
        'OpLogicalNot',
        'OpSelect',
        'OpIEqual',
        'OpINotEqual',
        'OpUGreaterThan',
        'OpUGreaterThanEqual',
        'OpSGreaterThan',
        'OpSGreaterThanEqual',
        'OpFOrdEqual',
        'OpFOrdNotEqual',
        'OpFUnordNotEqual',
        'OpFUnordEqual',
        'OpFOrdLessThan',
        'OpFUnordLessThan',
        'OpFOrdGreaterThan',
        'OpFOrdGreaterThanEqual',
        'OpFUnordGraterThan',
        'OpFUnordGraterThanEqual',
        'OpDPdx',
        'OpDPdy',
        'OpFwidth',
        'OpDPdxFine',
        'OpDPdyFine',
        'OpFwidthFine',
        'OpDPdxCoarse',
        'OpDPdyCoarse',
        'OpFwidthCoarse',
    ],
    'Type': [
        'OpTypeVoid',
        'OpTypeBool',
        'OpTypeInt',
        'OpTypeFloat',
        'OpTypeVector',
        'OpTypeMatrix',
        'OpTypeImage',
        'OpTypeSampler',
        'OpTypeSampledImage',
        'OpTypeArray',
        'OpTypeRuntimeArray',
        'OpTypeStruct',
        'OpTypeOpaque',
        'OpTypePointer',
        'OpTypeFunction',
        'OpTypeEvent',
        'OpTypeDeviceEvent',
        'OpTypeReservedId',
        'OpTypeQueue',
        'OpTypePipe',
        'OpTypeForwardPointer',
        'OpTypePipeStorage',
        'OpTypeNamedBarrier',
    ],
    'DebugInfo100': [
        'DebugInfoNone',
        'DebugCompilationUnit',
        'DebugTypeBasic',
        'DebugTypePointer',
        'DebugTypeQualifier',
        'DebugTypeArray',
        'DebugTypeVector',
        'DebugTypedef',
        'DebugTypeFunction',
        'DebugTypeEnum',
        'DebugTypeComposite',
        'DebugTypeMember',
        'DebugTypeInheritance',
        'DebugTypePtrToMember',
        'DebugTypeTemplate',
        'DebugTypeTemplateParameter',
        'DebugTypeTemplateTemplateParameter',
        'DebugTypeTemplateParameterPack',
        'DebugGlobalVariable',
        'DebugFunctionDeclaration',
        'DebugFunction',
        'DebugLexicalBlock',
        'DebugLexicalBlockDiscriminator',
        'DebugScope',
        'DebugNoScope',
        'DebugInlinedAt',
        'DebugLocalVariable',
        'DebugInlinedVariable',
        'DebugDeclare',
        'DebugValue',
        'DebugOperation',
        'DebugExpression',
        'DebugMacroDef',
        'DebugMacroUndef',
        'FlagIsProtected',
        'FlagIsPrivate',
        'FlagIsPublic',
        'FlagIsLocal',
        'FlagIsDefinition',
        'FlagFwdDecl',
        'FlagArtificial',
        'FlagExplicit',
        'FlagPrototyped',
        'FlagObjectPointer',
        'FlagStaticMember',
        'FlagIndirectVariable',
        'FlagLValueReference',
        'FlagRValueReference',
        'FlagIsOptimized',
        'Unspecified',
        'Address',
        'Boolean',
        'Float',
        'Signed',
        'SignedChar',
        'Unsigned',
        'UnsignedChar',
        'Class',
        'Structure',
        'Union',
        'ConstType',
        'VolatileType',
        'RestrictType',
        'Deref',
        'Plus',
        'Minus',
        'PlusUconst',
        'BitPiece',
        'Swap',
        'Xderef',
        'StackValue',
        'Constu',
    ],
}

GROUP_NAMES = [
    ('SpirvComment', 'Comment'),
    ('SpirvConditional', 'Conditional'),
    ('SpirvDebug', 'Debug'),
    ('SpirvEnumerant', 'Constant'),
    ('SpirvError', 'Error'),
    ('SpirvExtension', 'Include'),
    ('SpirvFloat', 'Float'),
    ('SpirvFunction', 'Function'),
    ('SpirvID', 'Identifier'),
    ('SpirvInstruction', 'Statement'),
    ('SpirvLabel', 'Label'),
    ('SpirvLoop', 'Repeat'),
    ('SpirvMode', 'StorageClass'),
    ('SpirvNumber', 'Number'),
    ('SpirvOperation', 'Operator'),
    ('SpirvSpecialComment', 'SpecialComment'),
    ('SpirvString', 'String'),
    ('SpirvType', 'Type'),
]


def generate_syntax(core_grammar_path, extension_grammar_paths):
    """Generate vim syntax content."""
    def load_keywords(core_grammar_path, extension_grammar_paths, keywords):
        """Load JSON arammers."""
        def instruction_exists(instruction):
            """Returns True if instruction does, False otherwise."""
            for names in keywords.values():
                for inst in names:
                    if inst == instruction:
                        return True
            return False

        with open(core_grammar_path) as grammar_file:
            grammar = json.loads(grammar_file.read())

        if 'instructions' in grammar:
            for instruction in grammar['instructions']:
                opname = instruction['opname']
                if not instruction_exists(opname):
                    keywords['Instruction'].append(opname)

        if 'operand_kinds' in grammar:
            for operand_kind in grammar['operand_kinds']:
                if 'enumerants' in operand_kind:
                    for enumerant in operand_kind['enumerants']:
                        enumname = enumerant['enumerant']
                        if enumname not in keywords['Enumerant']:
                            keywords['Enumerant'].append(enumname)

        extinst_group_names = []
        for grammar_path in extension_grammar_paths:
            with open(grammar_path) as grammar_file:
                grammar = json.loads(grammar_file.read())
            grammar_name = ''.join(
                word.capitalize()
                for word in os.path.basename(grammar_path).lstrip(
                    'extinst.').rstrip('.grammer.json').split('.'))

            if 'instructions' in grammar:
                keywords[grammar_name] = []
                for instruction in grammar['instructions']:
                    opname = instruction['opname']
                    if not instruction_exists(opname):
                        keywords[grammar_name].append(opname)

            extinst_group_names.append('Spirv{0}'.format(grammar_name))

        return keywords, extinst_group_names

    def write(string):
        """Append to the content string."""
        write.content += string

    write.content = ''

    keywords, extinst_group_names = load_keywords(core_grammar_path,
                                                  extension_grammar_paths,
                                                  KEYWORDS)

    write('''" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Vim syntax file for the Khronos Group's SPIR-V standard.
" Last Modified: {0}

" Don't load the sytnax multiple times
if exists('b:current_syntax')
  finish
endif

'''.format(datetime.datetime.now().strftime('%B %d, %Y')))

    write(r'''" Generic matches
syn match SpirvSpecialComment contained
\ "\(SPIR-V\|\(Version\|Generator\|Bound\|Schema\):\)"
syn match SpirvComment ";.*$" contains=SpirvSpecialComment
syn match SpirvError "\w\+"
syn match SpirvID "%\w\+"
syn region SpirvString start=+"+ end=+"+
syn match SpirvNumber "\s\zs\d\+"
syn match SpirvFloat "\s\zs\d\+\.\d\+"
''')

    for group, group_keywords in keywords.items():
        if len(group_keywords) == 0:
            continue
        write('\n" %s keywords\n' % group)
        syn_keyword = 'syn keyword Spirv%s' % group
        write(syn_keyword)

        length = len(syn_keyword)
        for keyword in group_keywords:
            opname = ' ' + keyword
            keyword_length = len(opname)

            if length + keyword_length > 80:
                write('\n\\')
                length = 1

            write(opname)
            length += keyword_length
        write('\n')

    write('\n" Define highlight groups\n')
    for group_name in GROUP_NAMES:
        write('hi default link {0} {1}\n'.format(group_name[0], group_name[1]))

    write('''
" Define current ID highlight group
if exists('g:spirv_enable_current_id') && g:spirv_enable_current_id
  execute 'hi SpirvCurrentID '.g:spirv_current_id_highlight
endif
''')

    if len(extinst_group_names):
        groups = ([], [])
        for group in extinst_group_names:
            groups[0].append('  hi default link {0} SpirvError'.format(group))
            groups[1].append(
                '  hi default link {0} SpirvInstruction'.format(group))
        groups[0].append('  hi default link SpirvDebugInfo100 SpirvError')
        groups[1].append('  hi default link SpirvDebugInfo100 SpirvDebug')

        write('''
" Define extended instruction highlight groups
if exists('g:spirv_enable_extinst_error') && g:spirv_enable_extinst_error
{0}
else
{1}
endif
'''.format('\n'.join(groups[0]), '\n'.join(groups[1])))

    return write.content


def main():
    """Main entry point to the script."""
    parser = argparse.ArgumentParser(
        description='Generate vim-spirv sources from SPIRV-Headers')

    parser.add_argument('-o',
                        '--output',
                        choices=['stdout', 'file'],
                        default='file',
                        help='output directory path')

    parser.add_argument('core', help='core SPIR-V grammar file')

    parser.add_argument('ext',
                        nargs='*',
                        help='extended SPIR-V grammar file, multiple accepted')

    args = parser.parse_args()

    syntax = generate_syntax(args.core, args.ext)

    def write_syntax(new_content):
        """Write syntax file."""
        syntax_directory = os.path.relpath(
            os.path.join(os.path.join(DIRECTORY, '..'), 'syntax'))
        filename = os.path.abspath(os.path.join(syntax_directory, 'spirv.vim'))

        with open(filename, 'r') as syntax_file:
            old_content = syntax_file.read()

        differ = difflib.Differ()
        difflines = differ.compare(old_content.splitlines(), new_content.splitlines())
        diffs = []
        for diff in difflines:
            if diff.startswith('+') or diff.startswith('-'):
                diffs.append(diff)
        if len(diffs) == 2 and all([' " Last Modified: ' in diff for diff in diffs]):
            return  # Don't write changes since only the date changed
        with open(filename, 'w') as syntax_file:
            syntax_file.write(new_content)

    {'stdout': sys.stdout.write, 'file': write_syntax}[args.output](syntax)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
