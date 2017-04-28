" File: spirv.vim
" Author: Kenneth Benzie (Benie) <k.benzie83@gmail.com>
" Description: Vim syntax file for the Khronos Group's SPIR-V standard.
" Last Modified: April 28, 2017

" Don't load the sytnax multiple times
if exists('b:current_syntax')
  finish
endif

" Generic matches
syn match SpirvSpecialComment contained
\ "\(SPIR-V\|\(Version\|Generator\|Bound\|Schema\):\)"
syn match SpirvComment ";.*$" contains=SpirvSpecialComment
syn match SpirvError "\w\+"
syn match SpirvID "%\w\+"
syn region SpirvString start=+"+ end=+"+
syn match SpirvNumber "\s\zs\d\+"
syn match SpirvFloat "\s\zs\d\+\.\d\+"

" Enumerant keywords
syn keyword SpirvEnumerant None Bias Lod Grad ConstOffset Offset ConstOffsets
\ Sample MinLod NotNaN NotInf NSZ AllowRecip Fast Flatten DontFlatten Unroll
\ DontUnroll DependencyInfinite DependencyLength Inline DontInline Pure Const
\ Relaxed Acquire Release AcquireRelease SequentiallyConsistent UniformMemory
\ SubgroupMemory WorkgroupMemory CrossWorkgroupMemory AtomicCounterMemory
\ ImageMemory Volatile Aligned Nontemporal CmdExecTime Unknown ESSL GLSL
\ OpenCL_C OpenCL_CPP HLSL Vertex TessellationControl TessellationEvaluation
\ Geometry Fragment GLCompute Kernel Logical Physical32 Physical64 Simple
\ GLSL450 OpenCL Invocations SpacingEqual SpacingFractionalEven
\ SpacingFractionalOdd VertexOrderCw VertexOrderCcw PixelCenterInteger
\ OriginUpperLeft OriginLowerLeft EarlyFragmentTests PointMode Xfb
\ DepthReplacing DepthGreater DepthLess DepthUnchanged LocalSize LocalSizeHint
\ InputPoints InputLines InputLinesAdjacency Triangles InputTrianglesAdjacency
\ Quads Isolines OutputVertices OutputPoints OutputLineStrip OutputTriangleStrip
\ VecTypeHint ContractionOff Initializer Finalizer SubgroupSize
\ SubgroupsPerWorkgroup UniformConstant Input Uniform Output Workgroup
\ CrossWorkgroup Private Function Generic PushConstant AtomicCounter Image
\ StorageBuffer 1D 2D 3D Cube Rect Buffer SubpassData ClampToEdge Clamp Repeat
\ RepeatMirrored Nearest Linear Rgba32f Rgba16f R32f Rgba8 Rgba8Snorm Rg32f
\ Rg16f R11fG11fB10f R16f Rgba16 Rgb10A2 Rg16 Rg8 R16 R8 Rgba16Snorm Rg16Snorm
\ Rg8Snorm R16Snorm R8Snorm Rgba32i Rgba16i Rgba8i R32i Rg32i Rg16i Rg8i R16i
\ R8i Rgba32ui Rgba16ui Rgba8ui R32ui Rgb10a2ui Rg32ui Rg16ui Rg8ui R16ui R8ui R
\ A RG RA RGB RGBA BGRA ARGB Intensity Luminance Rx RGx RGBx Depth DepthStencil
\ sRGB sRGBx sRGBA sBGRA ABGR SnormInt8 SnormInt16 UnormInt8 UnormInt16
\ UnormShort565 UnormShort555 UnormInt101010 SignedInt8 SignedInt16 SignedInt32
\ UnsignedInt8 UnsignedInt16 UnsignedInt32 HalfFloat Float UnormInt24
\ UnormInt101010_2 RTE RTZ RTP RTN Export Import ReadOnly WriteOnly ReadWrite
\ Zext Sext ByVal Sret NoAlias NoCapture NoWrite NoReadWrite RelaxedPrecision
\ SpecId Block BufferBlock RowMajor ColMajor ArrayStride MatrixStride GLSLShared
\ GLSLPacked CPacked BuiltIn NoPerspective Flat Patch Centroid Invariant
\ Restrict Aliased Constant Coherent NonWritable NonReadable SaturatedConversion
\ Stream Location Component Index Binding DescriptorSet XfbBuffer XfbStride
\ FuncParamAttr FPRoundingMode FPFastMathMode LinkageAttributes NoContraction
\ InputAttachmentIndex Alignment MaxByteOffset OverrideCoverageNV PassthroughNV
\ ViewportRelativeNV SecondaryViewportRelativeNV Position PointSize ClipDistance
\ CullDistance VertexId InstanceId PrimitiveId InvocationId Layer ViewportIndex
\ TessLevelOuter TessLevelInner TessCoord PatchVertices FragCoord PointCoord
\ FrontFacing SampleId SamplePosition SampleMask FragDepth HelperInvocation
\ NumWorkgroups WorkgroupSize WorkgroupId LocalInvocationId GlobalInvocationId
\ LocalInvocationIndex WorkDim GlobalSize EnqueuedWorkgroupSize GlobalOffset
\ GlobalLinearId SubgroupMaxSize NumSubgroups NumEnqueuedSubgroups SubgroupId
\ SubgroupLocalInvocationId VertexIndex InstanceIndex SubgroupEqMaskKHR
\ SubgroupGeMaskKHR SubgroupGtMaskKHR SubgroupLeMaskKHR SubgroupLtMaskKHR
\ BaseVertex BaseInstance DrawIndex DeviceIndex ViewIndex ViewportMaskNV
\ SecondaryPositionNV SecondaryViewportMaskNV PositionPerViewNV
\ ViewportMaskPerViewNV CrossDevice Device Subgroup Invocation Reduce
\ InclusiveScan ExclusiveScan NoWait WaitKernel WaitWorkGroup Matrix Shader
\ Tessellation Addresses Linkage Vector16 Float16Buffer Float16 Float64 Int64
\ Int64Atomics ImageBasic ImageReadWrite ImageMipmap Pipes Groups DeviceEnqueue
\ LiteralSampler AtomicStorage Int16 TessellationPointSize GeometryPointSize
\ ImageGatherExtended StorageImageMultisample UniformBufferArrayDynamicIndexing
\ SampledImageArrayDynamicIndexing StorageBufferArrayDynamicIndexing
\ StorageImageArrayDynamicIndexing ImageCubeArray SampleRateShading ImageRect
\ SampledRect GenericPointer Int8 InputAttachment SparseResidency Sampled1D
\ Image1D SampledCubeArray SampledBuffer ImageBuffer ImageMSArray
\ StorageImageExtendedFormats ImageQuery DerivativeControl InterpolationFunction
\ TransformFeedback GeometryStreams StorageImageReadWithoutFormat
\ StorageImageWriteWithoutFormat MultiViewport SubgroupDispatch NamedBarrier
\ PipeStorage SubgroupBallotKHR DrawParameters SubgroupVoteKHR
\ StorageBuffer16BitAccess StorageUniformBufferBlock16
\ UniformAndStorageBuffer16BitAccess StorageUniform16 StoragePushConstant16
\ StorageInputOutput16 DeviceGroup MultiView VariablePointersStorageBuffer
\ VariablePointers SampleMaskOverrideCoverageNV GeometryShaderPassthroughNV
\ ShaderViewportIndexLayerNV ShaderViewportMaskNV ShaderStereoViewNV
\ PerViewAttributesNV

" Extension keywords
syn keyword SpirvExtension OpExtension OpExtInstImport OpExtInst

" Instruction keywords
syn keyword SpirvInstruction OpNop OpUndef OpTypeReserveId OpConstantTrue
\ OpConstantFalse OpConstant OpConstantComposite OpConstantSampler
\ OpConstantNull OpSpecConstantTrue OpSpecConstantFalse OpSpecConstant
\ OpSpecConstantComposite OpSpecConstantOp OpVariable OpImageTexelPointer OpLoad
\ OpStore OpCopyMemory OpCopyMemorySized OpAccessChain OpInBoundsAccessChain
\ OpPtrAccessChain OpArrayLength OpGenericPtrMemSemantics
\ OpInBoundsPtrAccessChain OpVectorExtractDynamic OpVectorInsertDynamic
\ OpVectorShuffle OpCompositeConstruct OpCompositeExtract OpCompositeInsert
\ OpCopyObject OpTranspose OpSampledImage OpImageSampleImplicitLod
\ OpImageSampleExplicitLod OpImageSampleDrefImplicitLod
\ OpImageSampleDrefExplicitLod OpImageSampleProjImplicitLod
\ OpImageSampleProjExplicitLod OpImageSampleProjDrefImplicitLod
\ OpImageSampleProjDrefExplicitLod OpImageFetch OpImageGather OpImageDrefGather
\ OpImageRead OpImageWrite OpImage OpImageQueryFormat OpImageQueryOrder
\ OpImageQuerySizeLod OpImageQuerySize OpImageQueryLod OpImageQueryLevels
\ OpImageQuerySamples OpConvertFToU OpConvertFToS OpConvertSToF OpConvertUToF
\ OpUConvert OpSConvert OpFConvert OpQuantizeToF16 OpConvertPtrToU
\ OpSatConvertSToU OpSatConvertUToS OpConvertUToPtr OpPtrCastToGeneric
\ OpGenericCastToPtr OpGenericCastToPtrExplicit OpBitcast OpISub OpSRem
\ OpULessThan OpSLessThan OpULessThanEqual OpSLessThanEqual OpFUnordGreaterThan
\ OpFOrdLessThanEqual OpFUnordLessThanEqual OpFUnordGreaterThanEqual
\ OpEmitVertex OpEndPrimitive OpEmitStreamVertex OpEndStreamPrimitive
\ OpControlBarrier OpMemoryBarrier OpAtomicLoad OpAtomicStore OpAtomicExchange
\ OpAtomicCompareExchange OpAtomicCompareExchangeWeak OpAtomicIIncrement
\ OpAtomicIDecrement OpAtomicIAdd OpAtomicISub OpAtomicSMin OpAtomicUMin
\ OpAtomicSMax OpAtomicUMax OpAtomicAnd OpAtomicOr OpAtomicXor OpGroupAsyncCopy
\ OpGroupWaitEvents OpGroupAll OpGroupAny OpGroupBroadcast OpGroupIAdd
\ OpGroupFAdd OpGroupFMin OpGroupUMin OpGroupSMin OpGroupFMax OpGroupUMax
\ OpGroupSMax OpReadPipe OpWritePipe OpReservedReadPipe OpReservedWritePipe
\ OpReserveReadPipePackets OpReserveWritePipePackets OpCommitReadPipe
\ OpCommitWritePipe OpIsValidReserveId OpGetNumPipePackets OpGetMaxPipePackets
\ OpGroupReserveReadPipePackets OpGroupReserveWritePipePackets
\ OpGroupCommitReadPipe OpGroupCommitWritePipe OpEnqueueMarker OpEnqueueKernel
\ OpGetKernelNDrangeSubGroupCount OpGetKernelNDrangeMaxSubGroupSize
\ OpGetKernelWorkGroupSize OpGetKernelPreferredWorkGroupSizeMultiple
\ OpRetainEvent OpReleaseEvent OpCreateUserEvent OpIsValidEvent
\ OpSetUserEventStatus OpCaptureEventProfilingInfo OpGetDefaultQueue
\ OpBuildNDRange OpImageSparseSampleImplicitLod OpImageSparseSampleExplicitLod
\ OpImageSparseSampleDrefImplicitLod OpImageSparseSampleDrefExplicitLod
\ OpImageSparseSampleProjImplicitLod OpImageSparseSampleProjExplicitLod
\ OpImageSparseSampleProjDrefImplicitLod OpImageSparseSampleProjDrefExplicitLod
\ OpImageSparseFetch OpImageSparseGather OpImageSparseDrefGather
\ OpImageSparseTexelsResident OpAtomicFlagTestAndSet OpAtomicFlagClear
\ OpImageSparseRead OpSizeOf OpConstantPipeStorage OpCreatePipeFromPipeStorage
\ OpGetKernelLocalSizeForSubgroupCount OpGetKernelMaxNumSubgroups
\ OpNamedBarrierInitialize OpMemoryNamedBarrier OpSubgroupBallotKHR
\ OpSubgroupFirstInvocationKHR OpSubgroupAllKHR OpSubgroupAnyKHR
\ OpSubgroupAllEqualKHR OpSubgroupReadInvocationKHR

" Label keywords
syn keyword SpirvLabel OpLabel

" Mode keywords
syn keyword SpirvMode OpMemoryModel OpEntryPoint OpExecutionMode OpCapability
\ OpDecorate OpMemberDecorate OpGroupDecorate OpGroupMemberDecorate
\ OpDecorationGroup

" Debug keywords
syn keyword SpirvDebug OpSource OpSourceContinued OpSourceExtension OpName
\ OpMemberName OpString OpLine OpNoLine OpModuleProcessed

" Type keywords
syn keyword SpirvType OpTypeVoid OpTypeBool OpTypeInt OpTypeFloat OpTypeVector
\ OpTypeMatrix OpTypeImage OpTypeSampler OpTypeSampledImage OpTypeArray
\ OpTypeRuntimeArray OpTypeStruct OpTypeOpaque OpTypePointer OpTypeFunction
\ OpTypeEvent OpTypeDeviceEvent OpTypeReservedId OpTypeQueue OpTypePipe
\ OpTypeForwardPointer OpTypePipeStorage OpTypeNamedBarrier

" Loop keywords
syn keyword SpirvLoop OpLoopMerge

" Function keywords
syn keyword SpirvFunction OpFunction OpFunctionParameter OpFunctionEnd
\ OpFunctionCall

" OpenclStd100 keywords
syn keyword SpirvOpenclStd100 acos acosh acospi asin asinh asinpi atan atan2
\ atanh atanpi atan2pi cbrt ceil copysign cos cosh cospi erfc erf exp exp2 exp10
\ expm1 fabs fdim floor fma fmax fmin fmod fract frexp hypot ilogb ldexp lgamma
\ lgamma_r log log2 log10 log1p logb mad maxmag minmag modf nan nextafter pow
\ pown powr remainder remquo rint rootn round rsqrt sin sincos sinh sinpi sqrt
\ tan tanh tanpi tgamma trunc half_cos half_divide half_exp half_exp2 half_exp10
\ half_log half_log2 half_log10 half_powr half_recip half_rsqrt half_sin
\ half_sqrt half_tan native_cos native_divide native_exp native_exp2
\ native_exp10 native_log native_log2 native_log10 native_powr native_recip
\ native_rsqrt native_sin native_sqrt native_tan s_abs s_abs_diff s_add_sat
\ u_add_sat s_hadd u_hadd s_rhadd u_rhadd s_clamp u_clamp clz ctz s_mad_hi
\ u_mad_sat s_mad_sat s_max u_max s_min u_min s_mul_hi rotate s_sub_sat
\ u_sub_sat u_upsample s_upsample popcount s_mad24 u_mad24 s_mul24 u_mul24 u_abs
\ u_abs_diff u_mul_hi u_mad_hi fclamp degrees fmax_common fmin_common mix
\ radians step smoothstep sign cross distance length normalize fast_distance
\ fast_length fast_normalize bitselect select vloadn vstoren vload_half
\ vload_halfn vstore_half vstore_half_r vstore_halfn vstore_halfn_r vloada_halfn
\ vstorea_halfn vstorea_halfn_r shuffle shuffle2 printf prefetch

" Conditional keywords
syn keyword SpirvConditional OpPhi OpSelectionMerge OpBranch OpBranchConditional
\ OpSwitch OpKill OpReturn OpReturnValue OpUnreachable OpLifetimeStart
\ OpLifetimeStop

" GlslStd450 keywords
syn keyword SpirvGlslStd450 Round RoundEven Trunc FAbs SAbs FSign SSign Floor
\ Ceil Fract Radians Degrees Sin Cos Tan Asin Acos Atan Sinh Cosh Tanh Asinh
\ Acosh Atanh Atan2 Pow Exp Log Exp2 Log2 Sqrt InverseSqrt Determinant
\ MatrixInverse Modf ModfStruct FMin UMin SMin FMax UMax SMax FClamp UClamp
\ SClamp FMix IMix Step SmoothStep Fma Frexp FrexpStruct Ldexp PackSnorm4x8
\ PackUnorm4x8 PackSnorm2x16 PackUnorm2x16 PackHalf2x16 PackDouble2x32
\ UnpackSnorm2x16 UnpackUnorm2x16 UnpackHalf2x16 UnpackSnorm4x8 UnpackUnorm4x8
\ UnpackDouble2x32 Length Distance Cross Normalize FaceForward Reflect Refract
\ FindILsb FindSMsb FindUMsb InterpolateAtCentroid InterpolateAtSample
\ InterpolateAtOffset NMin NMax NClamp

" Operation keywords
syn keyword SpirvOperation OpSNegate OpFNegate OpIAdd OpFAdd OpFSub OpFSub
\ OpIMul OpFMul OpUDiv OpSDiv OpFDiv OpUMod OpSMod OpFMod OpFRem OpFRem
\ OpVectorTimesScalar OpMatrixTimesScalar OpVectorTimesMatrix
\ OpMatrixTimesVector OpMatrixTimesMatrix OpOuterProduct OpDot OpIAddCarry
\ OpISubBorrow OpUMulExtended OpSMulExtended OpShiftRight OpShiftRightLogical
\ OpShiftRightArithmetic OpShiftLeftLogical OpBitwiseOr OpBitwiseXor
\ OpBitwiseAnd OpNot OpBitFieldInsert OpBitFieldSExtract OpBitFieldUExtract
\ OpBitReverse OpBitCount OpAny OpAll OpIsNan OpIsInf OpIsFinite OpIsNormal
\ OpSignBitSet OpLessOrGreater OpOrdered OpUnordered OpLogicalEqual
\ OpLogicalNotEqual OpLogicalOr OpLogicalAnd OpLogicalNot OpSelect OpIEqual
\ OpINotEqual OpUGreaterThan OpUGreaterThanEqual OpSGreaterThan
\ OpSGreaterThanEqual OpFOrdEqual OpFOrdNotEqual OpFUnordNotEqual OpFUnordEqual
\ OpFOrdLessThan OpFUnordLessThan OpFOrdGreaterThan OpFOrdGreaterThanEqual
\ OpFUnordGraterThan OpFUnordGraterThanEqual OpDPdx OpDPdy OpFwidth OpDPdxFine
\ OpDPdyFine OpFwidthFine OpDPdxCoarse OpDPdyCoarse OpFwidthCoarse

" Define highlight groups
hi default link SpirvComment Comment
hi default link SpirvConditional Conditional
hi default link SpirvDebug Debug
hi default link SpirvEnumerant Constant
hi default link SpirvError Error
hi default link SpirvExtension Include
hi default link SpirvFloat Float
hi default link SpirvFunction Function
hi default link SpirvID Identifier
hi default link SpirvInstruction Statement
hi default link SpirvLabel Label
hi default link SpirvLoop Repeat
hi default link SpirvMode StorageClass
hi default link SpirvNumber Number
hi default link SpirvOperation Operator
hi default link SpirvSpecialComment SpecialComment
hi default link SpirvString String
hi default link SpirvType Type

" Define current ID highlight group
if exists('g:spirv_enable_current_id') && g:spirv_enable_current_id
  execute 'hi SpirvCurrentID '.g:spirv_current_id_highlight
endif

" Define extended instruction highlight groups
if exists('g:spirv_enable_extinst_error') && g:spirv_enable_extinst_error
  hi default link SpirvGlslStd450 SpirvError
  hi default link SpirvOpenclStd100 SpirvError
else
  hi default link SpirvGlslStd450 SpirvInstruction
  hi default link SpirvOpenclStd100 SpirvInstruction
endif
