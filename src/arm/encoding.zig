const std = @import("std");

pub const Instruction = enum {
    @"BAD ",
    @"CBZ W",
    @"CBNZ W",
    @"CBZ X",
    @"CBNZ X",
    @"TBZ ",
    @"TBNZ ",
    @"B_cond ",
    @"SVC ",
    @"HVC ",
    @"SMC ",
    @"BRK arm64",
    @"HLT ",
    @"DCPS1 ",
    @"DCPS2 ",
    @"DCPS3 ",
    @"MSR imm",
    @"HINT ",
    @"CLREX ",
    @"DSB ",
    @"DMB ",
    @"ISB ",
    @"SYS ",
    @"MSR ",
    @"SYSL ",
    @"MRS ",
    @"BR ",
    @"BLR ",
    @"RET ",
    @"ERET ",
    @"DRPS ",
    @"B ",
    @"BL ",
    @"STXRB ",
    @"STLXRB ",
    @"LDXRB ",
    @"LDAXRB ",
    @"STLRB ",
    @"LDARB ",
    @"STXRH ",
    @"STLXRH ",
    @"LDXRH ",
    @"LDAXRH ",
    @"STLRH ",
    @"LDARH ",
    @"STXR W",
    @"STLXR W",
    @"STXP W",
    @"STLXP W",
    @"LDXR W",
    @"LDAXR W",
    @"LDXP W",
    @"LDAXP W",
    @"STLR W",
    @"LDAR W",
    @"STXR X",
    @"STLXR X",
    @"STXP X",
    @"STLXP X",
    @"LDXR X",
    @"LDAXR X",
    @"LDXP X",
    @"LDAXP X",
    @"STLR X",
    @"LDAR X",
    @"LDR W",
    @"VLDR S",
    @"LDR X",
    @"VLDR D",
    @"LDRSW ",
    @"VLDR Q",
    @"PRFM ",
    @"STNP W",
    @"LDNP W",
    @"VSTNP S",
    @"VLDNP S",
    @"VSTNP D",
    @"VLDNP D",
    @"STNP X",
    @"LDNP X",
    @"VSTNP Q",
    @"VLDNP Q",
    @"STP Wpost",
    @"LDP Wpost",
    @"VSTP Spost",
    @"VLDP Spost",
    @"LDPSW post",
    @"VSTP Dpost",
    @"VLDP Dpost",
    @"STP Xpost",
    @"LDP Xpost",
    @"VSTP Qpost",
    @"VLDP Qpost",
    @"STP Woff",
    @"LDP Woff",
    @"VSTP Soff",
    @"VLDP Soff",
    @"LDPSW off",
    @"VSTP Doff",
    @"VLDP Doff",
    @"STP Xoff",
    @"LDP Xoff",
    @"VSTP Qoff",
    @"VLDP Qoff",
    @"STP Wpre",
    @"LDP Wpre",
    @"VSTP Spre",
    @"VLDP Spre",
    @"LDPSW pre",
    @"VSTP Dpre",
    @"VLDP Dpre",
    @"STP Xpre",
    @"LDP Xpre",
    @"VSTP Qpre",
    @"VLDP Qpre",
    @"STURB ",
    @"LDURB ",
    @"LDURSB X",
    @"LDURSB W",
    @"VSTUR B",
    @"VLDUR B",
    @"VSTUR Q",
    @"VLDUR Q",
    @"STURH ",
    @"LDURH ",
    @"LDURSH X",
    @"LDURSH W",
    @"VSTUR H",
    @"VLDUR H",
    @"STUR W",
    @"LDUR W",
    @"LDURSW ",
    @"VSTUR S",
    @"VLDUR S",
    @"STUR X",
    @"LDUR X",
    @"PRFUM ",
    @"VSTUR D",
    @"VLDUR D",
    @"STRB post",
    @"LDRB post",
    @"LDRSB Xpost",
    @"LDRSB Wpost",
    @"VSTR Bpost",
    @"VLDR Bpost",
    @"VSTR Qpost",
    @"VLDR Qpost",
    @"STRH post",
    @"LDRH post",
    @"LDRSH Xpost",
    @"LDRSH Wpost",
    @"VSTR Hpost",
    @"VLDR Hpost",
    @"STR Wpost",
    @"LDR Wpost",
    @"LDRSW post",
    @"VSTR Spost",
    @"VLDR Spost",
    @"STR Xpost",
    @"LDR Xpost",
    @"VSTR Dpost",
    @"VLDR Dpost",
    @"STTRB ",
    @"LDTRB ",
    @"LDTRSB X",
    @"LDTRSB W",
    @"STTRH ",
    @"LDTRH ",
    @"LDTRSH X",
    @"LDTRSH W",
    @"STTR W",
    @"LDTR W",
    @"LDTRSW ",
    @"STTR X",
    @"LDTR X",
    @"STRB pre",
    @"LDRB pre",
    @"LDRSB Xpre",
    @"LDRSB Wpre",
    @"VSTR Bpre",
    @"VLDR Bpre",
    @"VSTR Qpre",
    @"VLDR Qpre",
    @"STRH pre",
    @"LDRH pre",
    @"LDRSH Xpre",
    @"LDRSH Wpre",
    @"VSTR Hpre",
    @"VLDR Hpre",
    @"STR Wpre",
    @"LDR Wpre",
    @"LDRSW pre",
    @"VSTR Spre",
    @"VLDR Spre",
    @"STR Xpre",
    @"LDR Xpre",
    @"VSTR Dpre",
    @"VLDR Dpre",
    @"STRB off",
    @"LDRB off",
    @"LDRSB Xoff",
    @"LDRSB Woff",
    @"VSTR Boff",
    @"VLDR Boff",
    @"VSTR Qoff",
    @"VLDR Qoff",
    @"STRH off",
    @"LDRH off",
    @"LDRSH Xoff",
    @"LDRSH Woff",
    @"VSTR Hoff",
    @"VLDR Hoff",
    @"STR Woff",
    @"LDR Woff",
    @"LDRSW off",
    @"VSTR Soff",
    @"VLDR Soff",
    @"STR Xoff",
    @"LDR Xoff",
    @"VSTR Doff",
    @"VLDR Doff",
    @"PRFM off",
    @"STRB imm",
    @"LDRB imm",
    @"LDRSB Ximm",
    @"LDRSB Wimm",
    @"VSTR Bimm",
    @"VLDR Bimm",
    @"VSTR Qimm",
    @"VLDR Qimm",
    @"STRH imm",
    @"LDRH imm",
    @"LDRSH Ximm",
    @"LDRSH Wimm",
    @"VSTR Himm",
    @"VLDR Himm",
    @"STR Wimm",
    @"LDR Wimm",
    @"LDRSW imm",
    @"VSTR Simm",
    @"VLDR Simm",
    @"STR Ximm",
    @"LDR Ximm",
    @"VSTR Dimm",
    @"VLDR Dimm",
    @"PRFM imm",
    @"ADR ",
    @"ADRP ",
    @"ADD Wimm",
    @"ADDS Wimm",
    @"SUB Wimm",
    @"SUBS Wimm",
    @"ADD Ximm",
    @"ADDS Ximm",
    @"SUB Ximm",
    @"SUBS Ximm",
    @"AND Wimm",
    @"ORR Wimm",
    @"EOR Wimm",
    @"ANDS Wimm",
    @"AND Ximm",
    @"ORR Ximm",
    @"EOR Ximm",
    @"ANDS Ximm",
    @"MOVN W",
    @"MOVZ W",
    @"MOVK W",
    @"MOVN X",
    @"MOVZ X",
    @"MOVK X",
    @"SBFM W",
    @"BFM W",
    @"UBFM W",
    @"SBFM X",
    @"BFM X",
    @"UBFM X",
    @"EXTR W",
    @"EXTR X",
    @"AND W",
    @"BIC W",
    @"ORR W",
    @"ORN W",
    @"EOR W",
    @"EON W",
    @"ANDS W",
    @"BICS W",
    @"AND X",
    @"BIC X",
    @"ORR X",
    @"ORN X",
    @"EOR X",
    @"EON X",
    @"ANDS X",
    @"BICS X",
    @"ADD W",
    @"ADDS W",
    @"SUB W",
    @"SUBS W",
    @"ADD X",
    @"ADDS X",
    @"SUB X",
    @"SUBS X",
    @"ADD Wext",
    @"ADDS Wext",
    @"SUB Wext",
    @"SUBS Wext",
    @"ADD Xext",
    @"ADDS Xext",
    @"SUB Xext",
    @"SUBS Xext",
    @"ADC W",
    @"ADCS W",
    @"SBC W",
    @"SBCS W",
    @"ADC X",
    @"ADCS X",
    @"SBC X",
    @"SBCS X",
    @"CCMN W",
    @"CCMN X",
    @"CCMP W",
    @"CCMP X",
    @"CCMN Wimm",
    @"CCMN Ximm",
    @"CCMP Wimm",
    @"CCMP Ximm",
    @"CSEL W",
    @"CSINC W",
    @"CSINV W",
    @"CSNEG W",
    @"CSEL X",
    @"CSINC X",
    @"CSINV X",
    @"CSNEG X",
    @"MADD W",
    @"MADD X",
    @"SMADDL ",
    @"UMADDL ",
    @"MSUB W",
    @"MSUB X",
    @"SMSUBL ",
    @"UMSUBL ",
    @"SMULH ",
    @"UMULH ",
    @"CRC32X ",
    @"CRC32CX ",
    @"CRC32B ",
    @"CRC32CB ",
    @"CRC32H ",
    @"CRC32CH ",
    @"CRC32W ",
    @"CRC32CW ",
    @"UDIV W",
    @"UDIV X",
    @"SDIV W",
    @"SDIV X",
    @"LSLV W",
    @"LSLV X",
    @"LSRV W",
    @"LSRV X",
    @"ASRV W",
    @"ASRV X",
    @"RORV W",
    @"RORV X",
    @"RBIT W",
    @"RBIT X",
    @"CLZ W",
    @"CLZ X",
    @"CLS W",
    @"CLS X",
    @"REV W",
    @"REV X",
    @"REV16 W",
    @"REV16 X",
    @"REV32 ",
    @"VSCVTF 32_bit_to_single_precisionscalar_fixed_point",
    @"VUCVTF 32_bit_to_single_precisionscalar_fixed_point",
    @"VFCVTZS Single_precision_to_32_bitscalar_fixed_point",
    @"VFCVTZU Single_precision_to_32_bitscalar_fixed_point",
    @"VSCVTF 32_bit_to_double_precisionscalar_fixed_point",
    @"VUCVTF 32_bit_to_double_precisionscalar_fixed_point",
    @"VFCVTZS Double_precision_to_32_bitscalar_fixed_point",
    @"VFCVTZU Double_precision_to_32_bitscalar_fixed_point",
    @"VSCVTF 64_bit_to_single_precisionscalar_fixed_point",
    @"VUCVTF 64_bit_to_single_precisionscalar_fixed_point",
    @"VFCVTZS Single_precision_to_64_bitscalar_fixed_point",
    @"VFCVTZU Single_precision_to_64_bitscalar_fixed_point",
    @"VSCVTF 64_bit_to_double_precisionscalar_fixed_point",
    @"VUCVTF 64_bit_to_double_precisionscalar_fixed_point",
    @"VFCVTZS Double_precision_to_64_bitscalar_fixed_point",
    @"VFCVTZU Double_precision_to_64_bitscalar_fixed_point",
    @"VFCCMP Single_precision",
    @"VFCCMPE Single_precision",
    @"VFCCMP Double_precision",
    @"VFCCMPE Double_precision",
    @"VFMUL Single_precisionscalar",
    @"VFDIV Single_precisionscalar",
    @"VFADD Single_precisionscalar",
    @"VFSUB Single_precisionscalar",
    @"VFMAX Single_precisionscalar",
    @"VFMIN Single_precisionscalar",
    @"VFMAXNM Single_precisionscalar",
    @"VFMINNM Single_precisionscalar",
    @"VFNMUL Single_precision",
    @"VFMUL Double_precisionscalar",
    @"VFDIV Double_precisionscalar",
    @"VFADD Double_precisionscalar",
    @"VFSUB Double_precisionscalar",
    @"VFMAX Double_precisionscalar",
    @"VFMIN Double_precisionscalar",
    @"VFMAXNM Double_precisionscalar",
    @"VFMINNM Double_precisionscalar",
    @"VFNMUL Double_precision",
    @"VFCSEL Single_precision",
    @"VFCSEL Double_precision",
    @"VFMOV Single_precisionscalar_immediate",
    @"VFMOV Double_precisionscalar_immediate",
    @"VFCMP Single_precision",
    @"VFCMP Single_precision_zero",
    @"VFCMPE Single_precision",
    @"VFCMPE Single_precision_zero",
    @"VFCMP Double_precision",
    @"VFCMP Double_precision_zero",
    @"VFCMPE Double_precision",
    @"VFCMPE Double_precision_zero",
    @"VFMOV Single_precisionregister",
    @"VFABS Single_precisionscalar",
    @"VFNEG Single_precisionscalar",
    @"VFSQRT Single_precisionscalar",
    @"VFCVT Single_precision_to_double_precision",
    @"VFCVT Single_precision_to_half_precision",
    @"VFRINTN Single_precisionscalar",
    @"VFRINTP Single_precisionscalar",
    @"VFRINTM Single_precisionscalar",
    @"VFRINTZ Single_precisionscalar",
    @"VFRINTA Single_precisionscalar",
    @"VFRINTX Single_precisionscalar",
    @"VFRINTI Single_precisionscalar",
    @"VFMOV Double_precisionregister",
    @"VFABS Double_precisionscalar",
    @"VFNEG Double_precisionscalar",
    @"VFSQRT Double_precisionscalar",
    @"VFCVT Double_precision_to_single_precision",
    @"VFCVT Double_precision_to_half_precision",
    @"VFRINTN Double_precisionscalar",
    @"VFRINTP Double_precisionscalar",
    @"VFRINTM Double_precisionscalar",
    @"VFRINTZ Double_precisionscalar",
    @"VFRINTA Double_precisionscalar",
    @"VFRINTX Double_precisionscalar",
    @"VFRINTI Double_precisionscalar",
    @"VFCVT Half_precision_to_single_precision",
    @"VFCVT Half_precision_to_double_precision",
    @"VFCVTNS Single_precision_to_32_bitscalar",
    @"VFCVTNU Single_precision_to_32_bitscalar",
    @"VSCVTF 32_bit_to_single_precisionscalar_integer",
    @"VUCVTF 32_bit_to_single_precisionscalar_integer",
    @"VFCVTAS Single_precision_to_32_bitscalar",
    @"VFCVTAU Single_precision_to_32_bitscalar",
    @"VFMOV Single_precision_to_32_bitgeneral",
    @"VFMOV 32_bit_to_single_precisiongeneral",
    @"VFCVTPS Single_precision_to_32_bitscalar",
    @"VFCVTPU Single_precision_to_32_bitscalar",
    @"VFCVTMS Single_precision_to_32_bitscalar",
    @"VFCVTMU Single_precision_to_32_bitscalar",
    @"VFCVTZS Single_precision_to_32_bitscalar_integer",
    @"VFCVTZU Single_precision_to_32_bitscalar_integer",
    @"VFCVTNS Double_precision_to_32_bitscalar",
    @"VFCVTNU Double_precision_to_32_bitscalar",
    @"VSCVTF 32_bit_to_double_precisionscalar_integer",
    @"VUCVTF 32_bit_to_double_precisionscalar_integer",
    @"VFCVTAS Double_precision_to_32_bitscalar",
    @"VFCVTAU Double_precision_to_32_bitscalar",
    @"VFCVTPS Double_precision_to_32_bitscalar",
    @"VFCVTPU Double_precision_to_32_bitscalar",
    @"VFCVTMS Double_precision_to_32_bitscalar",
    @"VFCVTMU Double_precision_to_32_bitscalar",
    @"VFCVTZS Double_precision_to_32_bitscalar_integer",
    @"VFCVTZU Double_precision_to_32_bitscalar_integer",
    @"VFCVTNS Single_precision_to_64_bitscalar",
    @"VFCVTNU Single_precision_to_64_bitscalar",
    @"VSCVTF 64_bit_to_single_precisionscalar_integer",
    @"VUCVTF 64_bit_to_single_precisionscalar_integer",
    @"VFCVTAS Single_precision_to_64_bitscalar",
    @"VFCVTAU Single_precision_to_64_bitscalar",
    @"VFCVTPS Single_precision_to_64_bitscalar",
    @"VFCVTPU Single_precision_to_64_bitscalar",
    @"VFCVTMS Single_precision_to_64_bitscalar",
    @"VFCVTMU Single_precision_to_64_bitscalar",
    @"VFCVTZS Single_precision_to_64_bitscalar_integer",
    @"VFCVTZU Single_precision_to_64_bitscalar_integer",
    @"VFCVTNS Double_precision_to_64_bitscalar",
    @"VFCVTNU Double_precision_to_64_bitscalar",
    @"VSCVTF 64_bit_to_double_precisionscalar_integer",
    @"VUCVTF 64_bit_to_double_precisionscalar_integer",
    @"VFCVTAS Double_precision_to_64_bitscalar",
    @"VFCVTAU Double_precision_to_64_bitscalar",
    @"VFMOV Double_precision_to_64_bitgeneral",
    @"VFMOV 64_bit_to_double_precisiongeneral",
    @"VFCVTPS Double_precision_to_64_bitscalar",
    @"VFCVTPU Double_precision_to_64_bitscalar",
    @"VFCVTMS Double_precision_to_64_bitscalar",
    @"VFCVTMU Double_precision_to_64_bitscalar",
    @"VFCVTZS Double_precision_to_64_bitscalar_integer",
    @"VFCVTZU Double_precision_to_64_bitscalar_integer",
    @"VFMOV Top_half_of_128_bit_to_64_bitgeneral",
    @"VFMOV 64_bit_to_top_half_of_128_bitgeneral",
    @"VFMADD Single_precision",
    @"VFMSUB Single_precision",
    @"VFNMADD Single_precision",
    @"VFNMSUB Single_precision",
    @"VFMADD Double_precision",
    @"VFMSUB Double_precision",
    @"VFNMADD Double_precision",
    @"VFNMSUB Double_precision",
    @"VSQADD Scalar",
    @"VSQSUB Scalar",
    @"VCMGT Scalarregister",
    @"VCMGE Scalarregister",
    @"VSSHL Scalar",
    @"VSQSHL Scalarregister",
    @"VSRSHL Scalar",
    @"VSQRSHL Scalar",
    @"VADD Scalarvector",
    @"VCMTST Scalar",
    @"VSQDMULH Scalarvector",
    @"VFMULX Scalar",
    @"VFCMEQ Scalarregister",
    @"VFRECPS Scalar",
    @"VFRSQRTS Scalar",
    @"VUQADD Scalar",
    @"VUQSUB Scalar",
    @"VCMHI Scalarregister",
    @"VCMHS Scalarregister",
    @"VUSHL Scalar",
    @"VUQSHL Scalarregister",
    @"VURSHL Scalar",
    @"VUQRSHL Scalar",
    @"VSUB Scalarvector",
    @"VCMEQ Scalarregister",
    @"VSQRDMULH Scalarvector",
    @"VFCMGE Scalarregister",
    @"VFACGE Scalar",
    @"VFABD Scalar",
    @"VFCMGT Scalarregister",
    @"VFACGT Scalar",
    @"VSQDMLAL Scalarvector",
    @"VSQDMLAL2 Scalarvector",
    @"VSQDMLSL Scalarvector",
    @"VSQDMLSL2 Scalarvector",
    @"VSQDMULL Scalarvector",
    @"VSQDMULL2 Scalarvector",
    @"VSUQADD Scalar",
    @"VSQABS Scalar",
    @"VCMGT Scalarzero",
    @"VCMEQ Scalarzero",
    @"VCMLT Scalarzero",
    @"VABS Scalar",
    @"VSQXTN Scalar",
    @"VSQXTN2 Scalar",
    @"VFCVTNS Scalarvector",
    @"VFCVTMS Scalarvector",
    @"VFCVTAS Scalarvector",
    @"VSCVTF Scalarvector_integer",
    @"VFCMGT Scalarzero",
    @"VFCMEQ Scalarzero",
    @"VFCMLT Scalarzero",
    @"VFCVTPS Scalarvector",
    @"VFCVTZS Scalarvector_integer",
    @"VFRECPE Scalar",
    @"FRECPX ",
    @"VUSQADD Scalar",
    @"VSQNEG Scalar",
    @"VCMGE Scalarzero",
    @"VCMLE Scalarzero",
    @"VNEG Scalarvector",
    @"VSQXTUN Scalar",
    @"VSQXTUN2 Scalar",
    @"VUQXTN Scalar",
    @"VUQXTN2 Scalar",
    @"VFCVTXN Scalar",
    @"VFCVTXN2 Scalar",
    @"VFCVTNU Scalarvector",
    @"VFCVTMU Scalarvector",
    @"VFCVTAU Scalarvector",
    @"VUCVTF Scalarvector_integer",
    @"VFCMGE Scalarzero",
    @"VFCMLE Scalarzero",
    @"VFCVTPU Scalarvector",
    @"VFCVTZU Scalarvector_integer",
    @"VFRSQRTE Scalar",
    @"ADDP scalar",
    @"FMAXNMP scalar",
    @"FADDP scalar",
    @"FMAXP scalar",
    @"FMINNMP scalar",
    @"FMINP scalar",
    @"VDUP Scalarelement",
    @"VSQDMLAL Scalarby_element",
    @"VSQDMLAL2 Scalarby_element",
    @"VSQDMLSL Scalarby_element",
    @"VSQDMLSL2 Scalarby_element",
    @"VSQDMULL Scalarby_element",
    @"VSQDMULL2 Scalarby_element",
    @"VSQDMULH Scalarby_element",
    @"VSQRDMULH Scalarby_element",
    @"VFMLA Scalarby_element",
    @"VFMLS Scalarby_element",
    @"VFMUL Scalarby_element",
    @"VFMULX Scalarby_element",
    @"VSSHR Scalar",
    @"VSSRA Scalar",
    @"VSRSHR Scalar",
    @"VSRSRA Scalar",
    @"VSHL Scalar",
    @"VSQSHL Scalarimmediate",
    @"VSQSHRN Scalar",
    @"VSQSHRN2 Scalar",
    @"VSQRSHRN Scalar",
    @"VSQRSHRN2 Scalar",
    @"VSCVTF Scalarvector_fixed_point",
    @"VFCVTZS Scalarvector_fixed_point",
    @"VUSHR Scalar",
    @"VUSRA Scalar",
    @"VURSHR Scalar",
    @"VURSRA Scalar",
    @"VSRI Scalar",
    @"VSLI Scalar",
    @"VSQSHLU Scalar",
    @"VUQSHL Scalarimmediate",
    @"VSQSHRUN Scalar",
    @"VSQSHRUN2 Scalar",
    @"VSQRSHRUN Scalar",
    @"VSQRSHRUN2 Scalar",
    @"VUQSHRN Scalar",
    @"VUQRSHRN Scalar",
    @"VUQRSHRN2 Scalar",
    @"VUCVTF Scalarvector_fixed_point",
    @"VFCVTZU Scalarvector_fixed_point",
    @"SHA1C ",
    @"SHA1P ",
    @"SHA1M ",
    @"SHA1SU0 ",
    @"SHA256H ",
    @"SHA256H2 ",
    @"SHA256SU1 ",
    @"SHA1H ",
    @"SHA1SU1 ",
    @"SHA256SU0 ",
    @"AESE ",
    @"AESD ",
    @"AESMC ",
    @"AESIMC ",
    @"SHADD ",
    @"VSQADD Vector",
    @"SRHADD ",
    @"SHSUB ",
    @"VSQSUB Vector",
    @"VCMGT Vectorregister",
    @"VCMGE Vectorregister",
    @"SSHL Vector ",
    @"VSQSHL Vectorregister",
    @"VSRSHL Vector",
    @"VSQRSHL Vector",
    @"SMAX ",
    @"SMIN ",
    @"SABD ",
    @"SABA ",
    @"VADD Vectorvector",
    @"VCMTST Vector",
    @"MLA vector",
    @"MUL vector",
    @"SMAXP ",
    @"SMINP ",
    @"VSQDMULH Vectorvector",
    @"ADDP vector",
    @"FMAXNM vector",
    @"FMLA vector",
    @"FADD vector",
    @"VFMULX Vector",
    @"VFCMEQ Vectorregister",
    @"FMAX vector",
    @"VFRECPS Vector",
    @"AND vector",
    @"BIC vector_register",
    @"FMINNM vector",
    @"FMLS vector",
    @"FSUB vector",
    @"FMIN vector",
    @"VFRSQRTS Vector",
    @"ORR vector_register",
    @"ORN vector",
    @"UHADD ",
    @"VUQADD Vector",
    @"URHADD ",
    @"UHSUB ",
    @"VUQSUB Vector",
    @"VCMHI Vectorregister",
    @"VCMHS Vectorregister",
    @"VUSHL Vector",
    @"VUQSHL Vectorregister",
    @"VURSHL Vector",
    @"VUQRSHL Vector",
    @"UMAX ",
    @"UMIN ",
    @"UABD ",
    @"UABA ",
    @"VSUB Vectorvector",
    @"VCMEQ Vectorregister",
    @"MLS vector",
    @"PMUL ",
    @"UMAXP ",
    @"UMINP ",
    @"VSQRDMULH Vectorvector",
    @"FMAXNMP vector",
    @"FADDP vector",
    @"FMUL vector",
    @"VFCMGE Vectorregister",
    @"VFACGE Vector",
    @"FMAXP vector",
    @"FDIV vector",
    @"EOR vector",
    @"BSL ",
    @"FMINNMP vector",
    @"VFABD Vector",
    @"VFCMGT Vectorregister",
    @"VFACGT Vector",
    @"FMINP vector",
    @"BIT ",
    @"BIF ",
    @"SADDL ",
    @"SADDL2 ",
    @"SADDW ",
    @"SADDW2 ",
    @"SSUBL ",
    @"SSUBL2 ",
    @"SSUBW ",
    @"SSUBW2 ",
    @"ADDHN ",
    @"ADDHN2 ",
    @"SABAL ",
    @"SABAL2 ",
    @"SUBHN ",
    @"SUBHN2 ",
    @"SABDL ",
    @"SABDL2 ",
    @"SMLAL vector",
    @"SMLAL2 vector",
    @"VSQDMLAL Vectorvector",
    @"VSQDMLAL2 Vectorvector",
    @"SMLSL vector",
    @"SMLSL2 vector",
    @"VSQDMLSL Vectorvector",
    @"VSQDMLSL2 Vectorvector",
    @"SMULL vector",
    @"SMULL2 vector",
    @"VSQDMULL Vectorvector",
    @"VSQDMULL2 Vectorvector",
    @"PMULL ",
    @"PMULL2 ",
    @"UADDL ",
    @"UADDL2 ",
    @"UADDW ",
    @"UADDW2 ",
    @"USUBL ",
    @"USUBL2 ",
    @"USUBW ",
    @"USUBW2 ",
    @"RADDHN ",
    @"RADDHN2 ",
    @"UABAL ",
    @"UABAL2 ",
    @"RSUBHN ",
    @"RSUBHN2 ",
    @"UABDL ",
    @"UABDL2 ",
    @"UMLAL vector",
    @"UMLAL2 vector",
    @"UMLSL vector",
    @"UMLSL2 vector",
    @"UMULL vector",
    @"UMULL2 vector",
    @"REV64 ",
    @"REV16 vector",
    @"SADDLP ",
    @"VSUQADD Vector",
    @"CLS vector",
    @"CNT ",
    @"SADALP ",
    @"VSQABS Vector",
    @"VCMGT Vectorzero",
    @"VCMEQ Vectorzero",
    @"VCMLT Vectorzero",
    @"VABS Vector",
    @"XTN ",
    @"XTN2 ",
    @"VSQXTN Vector",
    @"VSQXTN2 Vector",
    @"FCVTN ",
    @"FCVTN2 ",
    @"FCVTL ",
    @"FCVTL2 ",
    @"FRINTN vector",
    @"FRINTM vector",
    @"VFCVTNS Vectorvector",
    @"VFCVTMS Vectorvector",
    @"VFCVTAS Vectorvector",
    @"VSCVTF Vectorvector_integer",
    @"VFCMGT Vectorzero",
    @"VFCMEQ Vectorzero",
    @"VFCMLT Vectorzero",
    @"FABS vector",
    @"FRINTP vector",
    @"FRINTZ vector",
    @"VFCVTPS Vectorvector",
    @"VFCVTZS Vectorvector_integer",
    @"URECPE ",
    @"VFRECPE Vector",
    @"REV32 vector",
    @"UADDLP ",
    @"VUSQADD Vector",
    @"CLZ vector",
    @"UADALP ",
    @"VSQNEG Vector",
    @"VCMGE Vectorzero",
    @"VCMLE Vectorzero",
    @"VNEG Vectorvector",
    @"VSQXTUN Vector",
    @"VSQXTUN2 Vector",
    @"SHLL ",
    @"SHLL2 ",
    @"VUQXTN Vector",
    @"VUQXTN2 Vector",
    @"VFCVTXN Vector",
    @"VFCVTXN2 Vector",
    @"FRINTA vector",
    @"FRINTX vector",
    @"VFCVTNU Vectorvector",
    @"VFCVTMU Vectorvector",
    @"VFCVTAU Vectorvector",
    @"VUCVTF Vectorvector_integer",
    @"NOT ",
    @"RBIT vector",
    @"VFCMGE Vectorzero",
    @"VFCMLE Vectorzero",
    @"FNEG vector",
    @"FRINTI vector",
    @"VFCVTPU Vectorvector",
    @"VFCVTZU Vectorvector_integer",
    @"URSQRTE ",
    @"VFRSQRTE Vector",
    @"FSQRT vector",
    @"SADDLV ",
    @"SMAXV ",
    @"SMINV ",
    @"ADDV ",
    @"UADDLV ",
    @"UMAXV ",
    @"UMINV ",
    @"FMAXNMV ",
    @"FMAXV ",
    @"FMINNMV ",
    @"FMINV ",
    @"VDUP Vectorelement",
    @"DUP general",
    @"VSMOV 32_bit",
    @"VUMOV 32_bit",
    @"INS general",
    @"VSMOV 64_bit",
    @"VUMOV 64_bit",
    @"INS element",
    @"SMLAL by_element",
    @"SMLAL2 by_element",
    @"VSQDMLAL Vectorby_element",
    @"VSQDMLAL2 Vectorby_element",
    @"SMLSL by_element",
    @"SMLSL2 by_element",
    @"VSQDMLSL Vectorby_element",
    @"VSQDMLSL2 Vectorby_element",
    @"MUL by_element",
    @"SMULL by_element",
    @"SMULL2 by_element",
    @"VSQDMULL Vectorby_element",
    @"VSQDMULL2 Vectorby_element",
    @"VSQDMULH Vectorby_element",
    @"VSQRDMULH Vectorby_element",
    @"VFMLA Vectorby_element",
    @"VFMLS Vectorby_element",
    @"VFMUL Vectorby_element",
    @"MLA by_element",
    @"UMLAL by_element",
    @"UMLAL2 by_element",
    @"MLS by_element",
    @"UMLSL by_element",
    @"UMLSL2 by_element",
    @"UMULL by_element",
    @"UMULL2 by_element",
    @"VFMULX Vectorby_element",
    @"VMOVI 32_bit_shifted_immediate",
    @"VORR 32_bitvector_immediate",
    @"VMOVI 16_bit_shifted_immediate",
    @"VORR 16_bitvector_immediate",
    @"VMOVI 32_bit_shifting_ones",
    @"VMOVI 8_bit",
    @"VFMOV Single_precisionvector_immediate",
    @"VMVNI 32_bit_shifted_immediate",
    @"VBIC 32_bitvector_immediate",
    @"VMVNI 16_bit_shifted_immediate",
    @"VBIC 16_bitvector_immediate",
    @"VMVNI 32_bit_shifting_ones",
    @"VMOVI 64_bit_scalar",
    @"VMOVI 64_bit_vector",
    @"VFMOV Double_precisionvector_immediate",
    @"VSSHR Vector",
    @"VSSRA Vector",
    @"VSRSHR Vector",
    @"VSRSRA Vector",
    @"VSHL Vector",
    @"VSQSHL Vectorimmediate",
    @"SHRN ",
    @"SHRN2 ",
    @"RSHRN ",
    @"RSHRN2 ",
    @"VSQSHRN Vector",
    @"VSQSHRN2 Vector",
    @"VSQRSHRN Vector",
    @"VSQRSHRN2 Vector",
    @"SSHLL ",
    @"SSHLL2 ",
    @"VSCVTF Vectorvector_fixed_point",
    @"VFCVTZS Vectorvector_fixed_point",
    @"VUSHR Vector",
    @"VUSRA Vector",
    @"VURSHR Vector",
    @"VURSRA Vector",
    @"VSRI Vector",
    @"VSLI Vector",
    @"VSQSHLU Vector",
    @"VUQSHL Vectorimmediate",
    @"VSQSHRUN Vector",
    @"VSQSHRUN2 Vector",
    @"VSQRSHRUN Vector",
    @"VSQRSHRUN2 Vector",
    @"VUQSHRN Vector",
    @"VUQRSHRN Vector",
    @"VUQRSHRN2 Vector",
    @"USHLL ",
    @"USHLL2 ",
    @"VUCVTF Vectorvector_fixed_point",
    @"VFCVTZU Vectorvector_fixed_point",
    @"VTBL Single_register_table",
    @"VTBX Single_register_table",
    @"VTBL Two_register_table",
    @"VTBX Two_register_table",
    @"VTBL Three_register_table",
    @"VTBX Three_register_table",
    @"VTBL Four_register_table",
    @"VTBX Four_register_table",
    @"UZP1 ",
    @"TRN1 ",
    @"ZIP1 ",
    @"UZP2 ",
    @"TRN2 ",
    @"ZIP2 ",
    @"EXT ",
    @"VST4 No_offsetmultiple_structures",
    @"VST1 Four_registersmultiple_structures",
    @"VST3 No_offsetmultiple_structures",
    @"VST1 Three_registersmultiple_structures",
    @"VST1 One_registermultiple_structures",
    @"VST2 No_offsetmultiple_structures",
    @"VST1 Two_registersmultiple_structures",
    @"VLD4 No_offsetmultiple_structures",
    @"VLD1 Four_registersmultiple_structures",
    @"VLD3 No_offsetmultiple_structures",
    @"VLD1 Three_registersmultiple_structures",
    @"VLD1 One_registermultiple_structures",
    @"VLD2 No_offsetmultiple_structures",
    @"VLD1 Two_registersmultiple_structures",
    @"VST4 Register_offsetmultiple_structures",
    @"VST1 Four_registers_register_offsetmultiple_structures",
    @"VST3 Register_offsetmultiple_structures",
    @"VST1 Three_registers_register_offsetmultiple_structures",
    @"VST1 One_register_register_offsetmultiple_structures",
    @"VST2 Register_offsetmultiple_structures",
    @"VST1 Two_registers_register_offsetmultiple_structures",
    @"VST4 Immediate_offsetmultiple_structures",
    @"VST1 Four_registers_immediate_offsetmultiple_structures",
    @"VST3 Immediate_offsetmultiple_structures",
    @"VST1 Three_registers_immediate_offsetmultiple_structures",
    @"VST1 One_register_immediate_offsetmultiple_structures",
    @"VST2 Immediate_offsetmultiple_structures",
    @"VST1 Two_registers_immediate_offsetmultiple_structures",
    @"VLD4 Register_offsetmultiple_structures",
    @"VLD1 Four_registers_register_offsetmultiple_structures",
    @"VLD3 Register_offsetmultiple_structures",
    @"VLD1 Three_registers_register_offsetmultiple_structures",
    @"VLD1 One_register_register_offsetmultiple_structures",
    @"VLD2 Register_offsetmultiple_structures",
    @"VLD1 Two_registers_register_offsetmultiple_structures",
    @"VLD4 Immediate_offsetmultiple_structures",
    @"VLD1 Four_registers_immediate_offsetmultiple_structures",
    @"VLD3 Immediate_offsetmultiple_structures",
    @"VLD1 Three_registers_immediate_offsetmultiple_structures",
    @"VLD1 One_register_immediate_offsetmultiple_structures",
    @"VLD2 Immediate_offsetmultiple_structures",
    @"VLD1 Two_registers_immediate_offsetmultiple_structures",
    @"VST1 8_bitsingle_structure",
    @"VST3 8_bitsingle_structure",
    @"VST1 16_bitsingle_structure",
    @"VST3 16_bitsingle_structure",
    @"VST1 32_bitsingle_structure",
    @"VST1 64_bitsingle_structure",
    @"VST3 32_bitsingle_structure",
    @"VST3 64_bitsingle_structure",
    @"VST2 8_bitsingle_structure",
    @"VST4 8_bitsingle_structure",
    @"VST2 16_bitsingle_structure",
    @"VST4 16_bitsingle_structure",
    @"VST2 32_bitsingle_structure",
    @"VST2 64_bitsingle_structure",
    @"VST4 32_bitsingle_structure",
    @"VST4 64_bitsingle_structure",
    @"VLD1 8_bitsingle_structure",
    @"VLD3 8_bitsingle_structure",
    @"VLD1 16_bitsingle_structure",
    @"VLD3 16_bitsingle_structure",
    @"VLD1 32_bitsingle_structure",
    @"VLD1 64_bitsingle_structure",
    @"VLD3 32_bitsingle_structure",
    @"VLD3 64_bitsingle_structure",
    @"VLD1R No_offset",
    @"VLD3R No_offset",
    @"VLD2 8_bitsingle_structure",
    @"VLD4 8_bitsingle_structure",
    @"VLD2 16_bitsingle_structure",
    @"VLD4 16_bitsingle_structure",
    @"VLD2 32_bitsingle_structure",
    @"VLD2 64_bitsingle_structure",
    @"VLD4 32_bitsingle_structure",
    @"VLD4 64_bitsingle_structure",
    @"VLD2R No_offset",
    @"VLD4R No_offset",
    @"VST1 8_bit_register_offsetsingle_structure",
    @"VST3 8_bit_register_offsetsingle_structure",
    @"VST1 16_bit_register_offsetsingle_structure",
    @"VST3 16_bit_register_offsetsingle_structure",
    @"VST1 32_bit_register_offsetsingle_structure",
    @"VST1 64_bit_register_offsetsingle_structure",
    @"VST3 32_bit_register_offsetsingle_structure",
    @"VST3 64_bit_register_offsetsingle_structure",
    @"VST1 8_bit_immediate_offsetsingle_structure",
    @"VST3 8_bit_immediate_offsetsingle_structure",
    @"VST1 16_bit_immediate_offsetsingle_structure",
    @"VST3 16_bit_immediate_offsetsingle_structure",
    @"VST1 32_bit_immediate_offsetsingle_structure",
    @"VST1 64_bit_immediate_offsetsingle_structure",
    @"VST3 32_bit_immediate_offsetsingle_structure",
    @"VST3 64_bit_immediate_offsetsingle_structure",
    @"VST2 8_bit_register_offsetsingle_structure",
    @"VST4 8_bit_register_offsetsingle_structure",
    @"VST2 16_bit_register_offsetsingle_structure",
    @"VST4 16_bit_register_offsetsingle_structure",
    @"VST2 32_bit_register_offsetsingle_structure",
    @"VST2 64_bit_register_offsetsingle_structure",
    @"VST4 32_bit_register_offsetsingle_structure",
    @"VST4 64_bit_register_offsetsingle_structure",
    @"VST2 8_bit_immediate_offsetsingle_structure",
    @"VST4 8_bit_immediate_offsetsingle_structure",
    @"VST2 16_bit_immediate_offsetsingle_structure",
    @"VST4 16_bit_immediate_offsetsingle_structure",
    @"VST2 32_bit_immediate_offsetsingle_structure",
    @"VST2 64_bit_immediate_offsetsingle_structure",
    @"VST4 32_bit_immediate_offsetsingle_structure",
    @"VST4 64_bit_immediate_offsetsingle_structure",
    @"VLD1 8_bit_register_offsetsingle_structure",
    @"VLD3 8_bit_register_offsetsingle_structure",
    @"VLD1 16_bit_register_offsetsingle_structure",
    @"VLD3 16_bit_register_offsetsingle_structure",
    @"VLD1 32_bit_register_offsetsingle_structure",
    @"VLD1 64_bit_register_offsetsingle_structure",
    @"VLD3 32_bit_register_offsetsingle_structure",
    @"VLD3 64_bit_register_offsetsingle_structure",
    @"VLD1R Register_offset",
    @"VLD3R Register_offset",
    @"VLD1 8_bit_immediate_offsetsingle_structure",
    @"VLD3 8_bit_immediate_offsetsingle_structure",
    @"VLD1 16_bit_immediate_offsetsingle_structure",
    @"VLD3 16_bit_immediate_offsetsingle_structure",
    @"VLD1 32_bit_immediate_offsetsingle_structure",
    @"VLD1 64_bit_immediate_offsetsingle_structure",
    @"VLD3 32_bit_immediate_offsetsingle_structure",
    @"VLD3 64_bit_immediate_offsetsingle_structure",
    @"VLD1R Immediate_offset",
    @"VLD3R Immediate_offset",
    @"VLD2 8_bit_register_offsetsingle_structure",
    @"VLD4 8_bit_register_offsetsingle_structure",
    @"VLD2 16_bit_register_offsetsingle_structure",
    @"VLD4 16_bit_register_offsetsingle_structure",
    @"VLD2 32_bit_register_offsetsingle_structure",
    @"VLD2 64_bit_register_offsetsingle_structure",
    @"VLD4 32_bit_register_offsetsingle_structure",
    @"VLD4 64_bit_register_offsetsingle_structure",
    @"VLD2R Register_offset",
    @"VLD4R Register_offset",
    @"VLD2 8_bit_immediate_offsetsingle_structure",
    @"VLD4 8_bit_immediate_offsetsingle_structure",
    @"VLD2 16_bit_immediate_offsetsingle_structure",
    @"VLD4 16_bit_immediate_offsetsingle_structure",
    @"VLD2 32_bit_immediate_offsetsingle_structure",
    @"VLD2 64_bit_immediate_offsetsingle_structure",
    @"VLD4 32_bit_immediate_offsetsingle_structure",
    @"VLD4 64_bit_immediate_offsetsingle_structure",
    @"VLD2R Immediate_offset",
    @"VLD4R Immediate_offset",
};
pub const Encoding = struct {
    fields: []const EncodingField
};

pub const EncodingField = struct {
    shift: u5,
    mask: u32,
    immType: enum { Immediate, Register, RelAddress } = .Immediate
};

pub const encoding = blk: {
    @setEvalBranchQuota(10000);
    break :blk std.enums.directEnumArray(Instruction, Encoding, 0, .{
    .@"BAD " = .{
        .fields = &[_]EncodingField {
        }
    },
    .@"CBZ W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"CBNZ W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"CBZ X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"CBNZ X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"TBZ " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111111111111},
            .{ .shift = 19, .mask = 0b11111},
            .{ .shift = 31, .mask = 0b1},
        }
    },
    .@"TBNZ " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111111111111},
            .{ .shift = 19, .mask = 0b11111},
            .{ .shift = 31, .mask = 0b1},
        }
    },
    .@"B_cond " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111, .immType = .RelAddress },
            .{ .shift = 5, .mask = 0b1111111111111111111, .immType = .RelAddress },
        }
    },
    .@"SVC " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"HVC " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"SMC " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"BRK arm64" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111, .immType = .RelAddress },
        }
    },
    .@"HLT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"DCPS1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"DCPS2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"DCPS3 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MSR imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b111},
        }
    },
    .@"HINT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
        }
    },
    .@"CLREX " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 8, .mask = 0b1111},
        }
    },
    .@"DSB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 8, .mask = 0b1111},
        }
    },
    .@"DMB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 8, .mask = 0b1111},
        }
    },
    .@"ISB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 8, .mask = 0b1111},
        }
    },
    .@"SYS " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b111},
        }
    },
    .@"MSR " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b111},
        }
    },
    .@"SYSL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b111},
        }
    },
    .@"MRS " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b111},
            .{ .shift = 8, .mask = 0b1111},
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b111},
        }
    },
    .@"BR " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"BLR " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RET " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ERET " = .{
        .fields = &[_]EncodingField {
        }
    },
    .@"DRPS " = .{
        .fields = &[_]EncodingField {
        }
    },
    .@"B " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111111111111111111111111, .immType = .RelAddress },
        }
    },
    .@"BL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111111111111111111111111, .immType = .RelAddress },
        }
    },
    .@"STXRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDARB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STXRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDARH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STXR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STXP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STXR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STXP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLXP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDXP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAXP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STLR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDAR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"VLDR S" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"LDR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"VLDR D" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"LDRSW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"VLDR Q" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"PRFM " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
        }
    },
    .@"STNP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDNP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTNP S" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDNP S" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTNP D" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDNP D" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STNP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDNP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTNP Q" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDNP Q" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Spost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Spost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDPSW post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Dpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Dpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Qpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Qpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Soff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Soff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDPSW off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Doff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Doff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Qoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Qoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Spre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Spre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDPSW pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Dpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Dpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STP Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"LDP Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VSTP Qpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"VLDP Qpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 15, .mask = 0b1111111},
        }
    },
    .@"STURB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURSB X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURSB W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTUR B" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDUR B" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTUR Q" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDUR Q" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STURH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURSH X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURSH W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTUR H" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDUR H" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STUR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDUR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDURSW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTUR S" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDUR S" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STUR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDUR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"PRFUM " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTUR D" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDUR D" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STRB post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRB post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSB Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSB Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Bpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Bpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Qpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Qpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STRH post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRH post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSH Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSH Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Hpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Hpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STR Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDR Wpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSW post" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Spost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Spost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STR Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDR Xpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Dpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Dpost" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STTRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRSB X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRSB W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STTRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRSH X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRSH W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STTR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTRSW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STTR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDTR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STRB pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRB pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSB Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSB Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Bpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Bpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Qpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Qpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STRH pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRH pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSH Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSH Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Hpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Hpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STR Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDR Wpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDRSW pre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Spre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Spre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STR Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"LDR Xpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VSTR Dpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"VLDR Dpre" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b111111111},
        }
    },
    .@"STRB off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRB off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRSB Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRSB Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSTR Boff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLDR Boff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSTR Qoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLDR Qoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STRH off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRH off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRSH Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRSH Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSTR Hoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLDR Hoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STR Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDR Woff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDRSW off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSTR Soff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLDR Soff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STR Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LDR Xoff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSTR Doff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLDR Doff" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"PRFM off" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"STRB imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRB imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRSB Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRSB Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VSTR Bimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VLDR Bimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VSTR Qimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VLDR Qimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"STRH imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRH imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRSH Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRSH Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VSTR Himm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VLDR Himm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"STR Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDR Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDRSW imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VSTR Simm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VLDR Simm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"STR Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"LDR Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VSTR Dimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"VLDR Dimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"PRFM imm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"ADR " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
            .{ .shift = 29, .mask = 0b11},
        }
    },
    .@"ADRP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111111},
            .{ .shift = 29, .mask = 0b11},
        }
    },
    .@"ADD Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"ADDS Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"SUB Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"SUBS Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"ADD Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"ADDS Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"SUB Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"SUBS Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111111111},
        }
    },
    .@"AND Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"ORR Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"EOR Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"ANDS Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"AND Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"ORR Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"EOR Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"ANDS Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"MOVN W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MOVZ W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MOVK W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MOVN X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MOVZ X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"MOVK X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b1111111111111111},
        }
    },
    .@"SBFM W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"BFM W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111, .immType = .RelAddress },
            .{ .shift = 16, .mask = 0b111111, .immType = .RelAddress },
        }
    },
    .@"UBFM W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"SBFM X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"BFM X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111, .immType = .RelAddress },
            .{ .shift = 16, .mask = 0b111111, .immType = .RelAddress },
        }
    },
    .@"UBFM X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b111111},
            .{ .shift = 16, .mask = 0b111111},
        }
    },
    .@"EXTR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"EXTR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AND W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"BIC W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11, .immType = .RelAddress },
        }
    },
    .@"ORR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ORN W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"EOR W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"EON W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ANDS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"BICS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11, .immType = .RelAddress },
        }
    },
    .@"AND X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"BIC X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11, .immType = .RelAddress },
        }
    },
    .@"ORR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ORN X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"EOR X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"EON X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ANDS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"BICS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11, .immType = .RelAddress },
        }
    },
    .@"ADD W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUB W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUBS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADD X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUB X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUBS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADD Wext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDS Wext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUB Wext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUBS Wext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADD Xext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDS Xext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUB Xext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SUBS Xext" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADC W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADCS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SBC W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SBCS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADC X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADCS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SBC X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SBCS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CCMN W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMN X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMP W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMP X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMN Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMN Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMP Wimm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CCMP Ximm" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111},
        }
    },
    .@"CSEL W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSINC W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSINV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSNEG W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSEL X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSINC X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSINV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CSNEG X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MADD W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MADD X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMADDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMADDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MSUB W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MSUB X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMSUBL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMSUBL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMULH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMULH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32X " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32CX " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32B " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32CB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32H " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32CH " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32W " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CRC32CW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UDIV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UDIV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SDIV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SDIV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LSLV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LSLV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LSRV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"LSRV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ASRV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ASRV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RORV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RORV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RBIT W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RBIT X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLZ W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLZ X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLS W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLS X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV16 W" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV16 X" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV32 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 32_bit_to_single_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 32_bit_to_single_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Single_precision_to_32_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Single_precision_to_32_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 32_bit_to_double_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 32_bit_to_double_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Double_precision_to_32_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Double_precision_to_32_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 64_bit_to_single_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 64_bit_to_single_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Single_precision_to_64_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Single_precision_to_64_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 64_bit_to_double_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 64_bit_to_double_precisionscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Double_precision_to_64_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Double_precision_to_64_bitscalar_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCCMP Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCCMPE Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCCMP Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCCMPE Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b1111},
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMUL Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFDIV Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFADD Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFSUB Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMAX Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMIN Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMAXNM Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMINNM Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMUL Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMUL Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFDIV Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFADD Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFSUB Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMAX Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMIN Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMAXNM Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMINNM Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMUL Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCSEL Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCSEL Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 12, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Single_precisionscalar_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b11111111},
        }
    },
    .@"VFMOV Double_precisionscalar_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 13, .mask = 0b11111111},
        }
    },
    .@"VFCMP Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMP Single_precision_zero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMPE Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMPE Single_precision_zero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMP Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMP Double_precision_zero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMPE Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMPE Double_precision_zero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Single_precisionregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFABS Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNEG Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFSQRT Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Single_precision_to_double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Single_precision_to_half_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTN Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTP Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTM Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTZ Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTA Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTX Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTI Single_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Double_precisionregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFABS Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNEG Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFSQRT Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Double_precision_to_single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Double_precision_to_half_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTN Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTP Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTM Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTZ Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTA Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTX Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRINTI Double_precisionscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Half_precision_to_single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVT Half_precision_to_double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 32_bit_to_single_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 32_bit_to_single_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Single_precision_to_32_bitgeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV 32_bit_to_single_precisiongeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Single_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Single_precision_to_32_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Single_precision_to_32_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 32_bit_to_double_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 32_bit_to_double_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Double_precision_to_32_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Double_precision_to_32_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Double_precision_to_32_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 64_bit_to_single_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 64_bit_to_single_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Single_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Single_precision_to_64_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Single_precision_to_64_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF 64_bit_to_double_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF 64_bit_to_double_precisionscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Double_precision_to_64_bitgeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV 64_bit_to_double_precisiongeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Double_precision_to_64_bitscalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Double_precision_to_64_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Double_precision_to_64_bitscalar_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Top_half_of_128_bit_to_64_bitgeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV 64_bit_to_top_half_of_128_bitgeneral" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMADD Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMSUB Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMADD Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMSUB Single_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMADD Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMSUB Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMADD Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFNMSUB Double_precision" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQADD Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQSUB Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGT Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGE Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQSHL Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSRSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQRSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VADD Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMTST Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQDMULH Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMULX Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMEQ Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRECPS Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRSQRTS Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQADD Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQSUB Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMHI Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMHS Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQSHL Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VURSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQRSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSUB Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMEQ Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQRDMULH Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGE Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFACGE Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFABD Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGT Scalarregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFACGT Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQDMLAL Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLAL2 Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLSL Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLSL2 Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMULL Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMULL2 Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSUQADD Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQABS Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGT Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMEQ Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMLT Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VABS Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF Scalarvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGT Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMEQ Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMLT Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Scalarvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRECPE Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRECPX " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUSQADD Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQNEG Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGE Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMLE Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VNEG Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTUN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTUN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQXTN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQXTN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTXN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTXN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF Scalarvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGE Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMLE Scalarzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Scalarvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Scalarvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRSQRTE Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXNMP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FADDP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINNMP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINP scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VDUP Scalarelement" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQDMLAL Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLAL2 Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLSL Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLSL2 Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULL Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULL2 Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULH Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQRDMULH Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMLA Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMLS Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMUL Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMULX Scalarby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSSHR Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSSRA Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRSHR Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRSRA Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSHL Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHL Scalarimmediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSCVTF Scalarvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VFCVTZS Scalarvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUSHR Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUSRA Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VURSHR Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VURSRA Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRI Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSLI Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHLU Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQSHL Scalarimmediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRUN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRUN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRUN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRUN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQSHRN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQRSHRN Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQRSHRN2 Scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUCVTF Scalarvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VFCVTZU Scalarvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"SHA1C " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA1P " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA1M " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA1SU0 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA256H " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA256H2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA256SU1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA1H " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA1SU1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHA256SU0 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AESE " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AESD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AESMC " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AESIMC " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHADD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQADD Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SRHADD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHSUB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQSUB Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGT Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGE Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SSHL Vector " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQSHL Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSRSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQRSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMAX " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMIN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SABD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SABA " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VADD Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMTST Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MLA vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MUL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMAXP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMINP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQDMULH Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXNM vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMLA vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FADD vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMULX Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMEQ Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAX vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRECPS Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"AND vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"BIC vector_register" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINNM vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMLS vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FSUB vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMIN vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRSQRTS Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ORR vector_register" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ORN vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UHADD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQADD Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"URHADD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UHSUB " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQSUB Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMHI Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMHS Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQSHL Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VURSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQRSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMAX " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMIN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UABD " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UABA " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSUB Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMEQ Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"MLS vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"PMUL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMAXP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMINP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQRDMULH Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXNMP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FADDP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMUL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGE Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFACGE Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FDIV vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"EOR vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"BSL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINNMP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFABD Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGT Vectorregister" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFACGT Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"BIT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"BIF " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SADDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SADDL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SADDW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SADDW2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SSUBL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SSUBL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SSUBW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SSUBW2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ADDHN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ADDHN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SABAL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SABAL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SUBHN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SUBHN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SABDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SABDL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMLAL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMLAL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLAL Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLAL2 Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMLSL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMLSL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLSL Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMLSL2 Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMULL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"SMULL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMULL Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"VSQDMULL2 Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"PMULL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"PMULL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UADDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UADDL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UADDW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UADDW2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"USUBL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"USUBL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"USUBW " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"USUBW2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"RADDHN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"RADDHN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UABAL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UABAL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"RSUBHN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"RSUBHN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UABDL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UABDL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMLAL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMLAL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMLSL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMLSL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMULL vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UMULL2 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"REV64 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV16 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SADDLP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSUQADD Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLS vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CNT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SADALP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQABS Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGT Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMEQ Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMLT Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VABS Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"XTN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"XTN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FCVTN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FCVTN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FCVTL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FCVTL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTN vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTM vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNS Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMS Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAS Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSCVTF Vectorvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGT Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMEQ Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMLT Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FABS vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTP vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTZ vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPS Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZS Vectorvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"URECPE " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRECPE Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"REV32 vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UADDLP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUSQADD Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"CLZ vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UADALP " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQNEG Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMGE Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VCMLE Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VNEG Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTUN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSQXTUN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHLL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SHLL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQXTN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUQXTN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTXN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTXN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTA vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTX vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTNU Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTMU Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTAU Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUCVTF Vectorvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"NOT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"RBIT vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMGE Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCMLE Vectorzero" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FNEG vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FRINTI vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTPU Vectorvector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFCVTZU Vectorvector_integer" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"URSQRTE " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFRSQRTE Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FSQRT vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SADDLV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMAXV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMINV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"ADDV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UADDLV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMAXV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UMINV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXNMV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMAXV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINNMV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"FMINV " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VDUP Vectorelement" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"DUP general" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSMOV 32_bit" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUMOV 32_bit" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"INS general" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSMOV 64_bit" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VUMOV 64_bit" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"INS element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"SMLAL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"SMLAL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLAL Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLAL2 Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"SMLSL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"SMLSL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLSL Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMLSL2 Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"MUL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"SMULL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"SMULL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULL Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULL2 Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQDMULH Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VSQRDMULH Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMLA Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMLS Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMUL Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"MLA by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMLAL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMLAL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"MLS by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMLSL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMLSL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMULL by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"UMULL2 by_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VFMULX Vectorby_element" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b1111, .immType = .Register },
        }
    },
    .@"VMOVI 32_bit_shifted_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VORR 32_bitvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMOVI 16_bit_shifted_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VORR 16_bitvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMOVI 32_bit_shifting_ones" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMOVI 8_bit" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Single_precisionvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMVNI 32_bit_shifted_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VBIC 32_bitvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMVNI 16_bit_shifted_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VBIC 16_bitvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMVNI 32_bit_shifting_ones" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMOVI 64_bit_scalar" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VMOVI 64_bit_vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VFMOV Double_precisionvector_immediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VSSHR Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSSRA Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRSHR Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRSRA Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSHL Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHL Vectorimmediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"SHRN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"SHRN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"RSHRN " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"RSHRN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"SSHLL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"SSHLL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSCVTF Vectorvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VFCVTZS Vectorvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUSHR Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUSRA Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VURSHR Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VURSRA Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSRI Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSLI Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHLU Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQSHL Vectorimmediate" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRUN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQSHRUN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRUN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VSQRSHRUN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQSHRN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQRSHRN Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUQRSHRN2 Vector" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"USHLL " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"USHLL2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VUCVTF Vectorvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VFCVTZU Vectorvector_fixed_point" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b111},
            .{ .shift = 19, .mask = 0b1111},
        }
    },
    .@"VTBL Single_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBX Single_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBL Two_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBX Two_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBL Three_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBX Three_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBL Four_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VTBX Four_register_table" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"UZP1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"TRN1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ZIP1 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"UZP2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"TRN2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"ZIP2 " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
            .{ .shift = 22, .mask = 0b11},
        }
    },
    .@"EXT " = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 11, .mask = 0b1111},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Four_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST3 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Three_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 One_registermultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST2 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Two_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD4 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Four_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD3 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Three_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 One_registermultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD2 No_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Two_registersmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST4 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 Four_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 Three_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 One_register_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 Two_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Four_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST3 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Three_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 One_register_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST2 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 Two_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD4 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 Four_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 Three_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 One_register_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 Register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 Two_registers_register_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Four_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD3 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Three_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 One_register_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD2 Immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VLD1 Two_registers_immediate_offsetmultiple_structures" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 10, .mask = 0b11},
        }
    },
    .@"VST1 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1R No_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3R No_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 8_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 16_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 32_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 64_bitsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2R No_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4R No_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST1 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST3 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST2 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VST4 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1R Register_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3R Register_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD1R Immediate_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD3R Immediate_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 8_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 16_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 32_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 64_bit_register_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2R Register_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4R Register_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
            .{ .shift = 16, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 8_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 16_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 32_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4 64_bit_immediate_offsetsingle_structure" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD2R Immediate_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    .@"VLD4R Immediate_offset" = .{
        .fields = &[_]EncodingField {
            .{ .shift = 0, .mask = 0b11111, .immType = .Register },
            .{ .shift = 5, .mask = 0b11111, .immType = .Register },
        }
    },
    });
};

pub fn decode(opcode: u32) Instruction {
    // BAD ()
    if ((opcode & 0b11111111111111111111111111111111) == 0b00000000000000000000000000000000) {
        return Instruction.@"BAD ";
    }
    // CBZW ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b00110100000000000000000000000000) {
        return Instruction.@"CBZ W";
    }
    // CBNZW ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b00110101000000000000000000000000) {
        return Instruction.@"CBNZ W";
    }
    // CBZX ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b10110100000000000000000000000000) {
        return Instruction.@"CBZ X";
    }
    // CBNZX ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b10110101000000000000000000000000) {
        return Instruction.@"CBNZ X";
    }
    // TBZ ()
    if ((opcode & 0b01111111000000000000000000000000) == 0b00110110000000000000000000000000) {
        return Instruction.@"TBZ ";
    }
    // TBNZ ()
    if ((opcode & 0b01111111000000000000000000000000) == 0b00110111000000000000000000000000) {
        return Instruction.@"TBNZ ";
    }
    // B_cond ()
    if ((opcode & 0b11111111000000000000000000010000) == 0b01010100000000000000000000000000) {
        return Instruction.@"B_cond ";
    }
    // SVC ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100000000000000000000000001) {
        return Instruction.@"SVC ";
    }
    // HVC ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100000000000000000000000010) {
        return Instruction.@"HVC ";
    }
    // SMC ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100000000000000000000000011) {
        return Instruction.@"SMC ";
    }
    // BRK (arm64)
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100001000000000000000000000) {
        return Instruction.@"BRK arm64";
    }
    // HLT ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100010000000000000000000000) {
        return Instruction.@"HLT ";
    }
    // DCPS1 ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100101000000000000000000001) {
        return Instruction.@"DCPS1 ";
    }
    // DCPS2 ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100101000000000000000000010) {
        return Instruction.@"DCPS2 ";
    }
    // DCPS3 ()
    if ((opcode & 0b11111111111000000000000000011111) == 0b11010100101000000000000000000011) {
        return Instruction.@"DCPS3 ";
    }
    // MSR (imm)
    if ((opcode & 0b11111111111110001111000000011111) == 0b11010101000000000100000000011111) {
        return Instruction.@"MSR imm";
    }
    // HINT ()
    if ((opcode & 0b11111111111111111111000000011111) == 0b11010101000000110010000000011111) {
        return Instruction.@"HINT ";
    }
    // CLREX ()
    if ((opcode & 0b11111111111111111111000011111111) == 0b11010101000000110011000001011111) {
        return Instruction.@"CLREX ";
    }
    // DSB ()
    if ((opcode & 0b11111111111111111111000011111111) == 0b11010101000000110011000010011111) {
        return Instruction.@"DSB ";
    }
    // DMB ()
    if ((opcode & 0b11111111111111111111000011111111) == 0b11010101000000110011000010111111) {
        return Instruction.@"DMB ";
    }
    // ISB ()
    if ((opcode & 0b11111111111111111111000011111111) == 0b11010101000000110011000011011111) {
        return Instruction.@"ISB ";
    }
    // SYS ()
    if ((opcode & 0b11111111111110000000000000000000) == 0b11010101000010000000000000000000) {
        return Instruction.@"SYS ";
    }
    // MSR ()
    if ((opcode & 0b11111111111100000000000000000000) == 0b11010101000100000000000000000000) {
        return Instruction.@"MSR ";
    }
    // SYSL ()
    if ((opcode & 0b11111111111110000000000000000000) == 0b11010101001010000000000000000000) {
        return Instruction.@"SYSL ";
    }
    // MRS ()
    if ((opcode & 0b11111111111100000000000000000000) == 0b11010101001100000000000000000000) {
        return Instruction.@"MRS ";
    }
    // BR ()
    if ((opcode & 0b11111111111111111111110000011111) == 0b11010110000111110000000000000000) {
        return Instruction.@"BR ";
    }
    // BLR ()
    if ((opcode & 0b11111111111111111111110000011111) == 0b11010110001111110000000000000000) {
        return Instruction.@"BLR ";
    }
    // RET ()
    if ((opcode & 0b11111111111111111111110000011111) == 0b11010110010111110000000000000000) {
        return Instruction.@"RET ";
    }
    // ERET ()
    if ((opcode & 0b11111111111111111111111111111111) == 0b11010110100111110000001111100000) {
        return Instruction.@"ERET ";
    }
    // DRPS ()
    if ((opcode & 0b11111111111111111111111111111111) == 0b11010110101111110000001111100000) {
        return Instruction.@"DRPS ";
    }
    // B ()
    if ((opcode & 0b11111100000000000000000000000000) == 0b00010100000000000000000000000000) {
        return Instruction.@"B ";
    }
    // BL ()
    if ((opcode & 0b11111100000000000000000000000000) == 0b10010100000000000000000000000000) {
        return Instruction.@"BL ";
    }
    // STXRB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000000000000000000000000000) {
        return Instruction.@"STXRB ";
    }
    // STLXRB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000000000001000000000000000) {
        return Instruction.@"STLXRB ";
    }
    // LDXRB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000010000000000000000000000) {
        return Instruction.@"LDXRB ";
    }
    // LDAXRB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000010000001000000000000000) {
        return Instruction.@"LDAXRB ";
    }
    // STLRB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000100000001000000000000000) {
        return Instruction.@"STLRB ";
    }
    // LDARB ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00001000110000001000000000000000) {
        return Instruction.@"LDARB ";
    }
    // STXRH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000000000000000000000000000) {
        return Instruction.@"STXRH ";
    }
    // STLXRH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000000000001000000000000000) {
        return Instruction.@"STLXRH ";
    }
    // LDXRH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000010000000000000000000000) {
        return Instruction.@"LDXRH ";
    }
    // LDAXRH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000010000001000000000000000) {
        return Instruction.@"LDAXRH ";
    }
    // STLRH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000100000001000000000000000) {
        return Instruction.@"STLRH ";
    }
    // LDARH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b01001000110000001000000000000000) {
        return Instruction.@"LDARH ";
    }
    // STXRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000000000000000000000000000) {
        return Instruction.@"STXR W";
    }
    // STLXRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000000000001000000000000000) {
        return Instruction.@"STLXR W";
    }
    // STXPW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000001000000000000000000000) {
        return Instruction.@"STXP W";
    }
    // STLXPW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000001000001000000000000000) {
        return Instruction.@"STLXP W";
    }
    // LDXRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000010000000000000000000000) {
        return Instruction.@"LDXR W";
    }
    // LDAXRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000010000001000000000000000) {
        return Instruction.@"LDAXR W";
    }
    // LDXPW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000011000000000000000000000) {
        return Instruction.@"LDXP W";
    }
    // LDAXPW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000011000001000000000000000) {
        return Instruction.@"LDAXP W";
    }
    // STLRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000100000001000000000000000) {
        return Instruction.@"STLR W";
    }
    // LDARW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10001000110000001000000000000000) {
        return Instruction.@"LDAR W";
    }
    // STXRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000000000000000000000000000) {
        return Instruction.@"STXR X";
    }
    // STLXRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000000000001000000000000000) {
        return Instruction.@"STLXR X";
    }
    // STXPX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000001000000000000000000000) {
        return Instruction.@"STXP X";
    }
    // STLXPX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000001000001000000000000000) {
        return Instruction.@"STLXP X";
    }
    // LDXRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000010000000000000000000000) {
        return Instruction.@"LDXR X";
    }
    // LDAXRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000010000001000000000000000) {
        return Instruction.@"LDAXR X";
    }
    // LDXPX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000011000000000000000000000) {
        return Instruction.@"LDXP X";
    }
    // LDAXPX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000011000001000000000000000) {
        return Instruction.@"LDAXP X";
    }
    // STLRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000100000001000000000000000) {
        return Instruction.@"STLR X";
    }
    // LDARX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b11001000110000001000000000000000) {
        return Instruction.@"LDAR X";
    }
    // LDRW ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b00011000000000000000000000000000) {
        return Instruction.@"LDR W";
    }
    // VLDRS ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b00011100000000000000000000000000) {
        return Instruction.@"VLDR S";
    }
    // LDRX ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b01011000000000000000000000000000) {
        return Instruction.@"LDR X";
    }
    // VLDRD ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b01011100000000000000000000000000) {
        return Instruction.@"VLDR D";
    }
    // LDRSW ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b10011000000000000000000000000000) {
        return Instruction.@"LDRSW ";
    }
    // VLDRQ ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b10011100000000000000000000000000) {
        return Instruction.@"VLDR Q";
    }
    // PRFM ()
    if ((opcode & 0b11111111000000000000000000000000) == 0b11011000000000000000000000000000) {
        return Instruction.@"PRFM ";
    }
    // STNPW ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101000000000000000000000000000) {
        return Instruction.@"STNP W";
    }
    // LDNPW ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101000010000000000000000000000) {
        return Instruction.@"LDNP W";
    }
    // VSTNPS ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101100000000000000000000000000) {
        return Instruction.@"VSTNP S";
    }
    // VLDNPS ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101100010000000000000000000000) {
        return Instruction.@"VLDNP S";
    }
    // VSTNPD ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101100000000000000000000000000) {
        return Instruction.@"VSTNP D";
    }
    // VLDNPD ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101100010000000000000000000000) {
        return Instruction.@"VLDNP D";
    }
    // STNPX ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101000000000000000000000000000) {
        return Instruction.@"STNP X";
    }
    // LDNPX ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101000010000000000000000000000) {
        return Instruction.@"LDNP X";
    }
    // VSTNPQ ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101100000000000000000000000000) {
        return Instruction.@"VSTNP Q";
    }
    // VLDNPQ ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101100010000000000000000000000) {
        return Instruction.@"VLDNP Q";
    }
    // STPW (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101000100000000000000000000000) {
        return Instruction.@"STP Wpost";
    }
    // LDPW (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101000110000000000000000000000) {
        return Instruction.@"LDP Wpost";
    }
    // VSTPS (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101100100000000000000000000000) {
        return Instruction.@"VSTP Spost";
    }
    // VLDPS (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101100110000000000000000000000) {
        return Instruction.@"VLDP Spost";
    }
    // LDPSW (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101000110000000000000000000000) {
        return Instruction.@"LDPSW post";
    }
    // VSTPD (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101100100000000000000000000000) {
        return Instruction.@"VSTP Dpost";
    }
    // VLDPD (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101100110000000000000000000000) {
        return Instruction.@"VLDP Dpost";
    }
    // STPX (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101000100000000000000000000000) {
        return Instruction.@"STP Xpost";
    }
    // LDPX (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101000110000000000000000000000) {
        return Instruction.@"LDP Xpost";
    }
    // VSTPQ (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101100100000000000000000000000) {
        return Instruction.@"VSTP Qpost";
    }
    // VLDPQ (post)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101100110000000000000000000000) {
        return Instruction.@"VLDP Qpost";
    }
    // STPW (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101001000000000000000000000000) {
        return Instruction.@"STP Woff";
    }
    // LDPW (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101001010000000000000000000000) {
        return Instruction.@"LDP Woff";
    }
    // VSTPS (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101101000000000000000000000000) {
        return Instruction.@"VSTP Soff";
    }
    // VLDPS (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101101010000000000000000000000) {
        return Instruction.@"VLDP Soff";
    }
    // LDPSW (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101001010000000000000000000000) {
        return Instruction.@"LDPSW off";
    }
    // VSTPD (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101101000000000000000000000000) {
        return Instruction.@"VSTP Doff";
    }
    // VLDPD (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101101010000000000000000000000) {
        return Instruction.@"VLDP Doff";
    }
    // STPX (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101001000000000000000000000000) {
        return Instruction.@"STP Xoff";
    }
    // LDPX (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101001010000000000000000000000) {
        return Instruction.@"LDP Xoff";
    }
    // VSTPQ (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101101000000000000000000000000) {
        return Instruction.@"VSTP Qoff";
    }
    // VLDPQ (off)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101101010000000000000000000000) {
        return Instruction.@"VLDP Qoff";
    }
    // STPW (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101001100000000000000000000000) {
        return Instruction.@"STP Wpre";
    }
    // LDPW (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101001110000000000000000000000) {
        return Instruction.@"LDP Wpre";
    }
    // VSTPS (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101101100000000000000000000000) {
        return Instruction.@"VSTP Spre";
    }
    // VLDPS (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00101101110000000000000000000000) {
        return Instruction.@"VLDP Spre";
    }
    // LDPSW (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101001110000000000000000000000) {
        return Instruction.@"LDPSW pre";
    }
    // VSTPD (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101101100000000000000000000000) {
        return Instruction.@"VSTP Dpre";
    }
    // VLDPD (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01101101110000000000000000000000) {
        return Instruction.@"VLDP Dpre";
    }
    // STPX (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101001100000000000000000000000) {
        return Instruction.@"STP Xpre";
    }
    // LDPX (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101001110000000000000000000000) {
        return Instruction.@"LDP Xpre";
    }
    // VSTPQ (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101101100000000000000000000000) {
        return Instruction.@"VSTP Qpre";
    }
    // VLDPQ (pre)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10101101110000000000000000000000) {
        return Instruction.@"VLDP Qpre";
    }
    // STURB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000000000000000000000000000) {
        return Instruction.@"STURB ";
    }
    // LDURB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000010000000000000000000000) {
        return Instruction.@"LDURB ";
    }
    // LDURSBX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000100000000000000000000000) {
        return Instruction.@"LDURSB X";
    }
    // LDURSBW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000110000000000000000000000) {
        return Instruction.@"LDURSB W";
    }
    // VSTURB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100000000000000000000000000) {
        return Instruction.@"VSTUR B";
    }
    // VLDURB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100010000000000000000000000) {
        return Instruction.@"VLDUR B";
    }
    // VSTURQ ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100100000000000000000000000) {
        return Instruction.@"VSTUR Q";
    }
    // VLDURQ ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100110000000000000000000000) {
        return Instruction.@"VLDUR Q";
    }
    // STURH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000000000000000000000000000) {
        return Instruction.@"STURH ";
    }
    // LDURH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000010000000000000000000000) {
        return Instruction.@"LDURH ";
    }
    // LDURSHX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000100000000000000000000000) {
        return Instruction.@"LDURSH X";
    }
    // LDURSHW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000110000000000000000000000) {
        return Instruction.@"LDURSH W";
    }
    // VSTURH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100000000000000000000000000) {
        return Instruction.@"VSTUR H";
    }
    // VLDURH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100010000000000000000000000) {
        return Instruction.@"VLDUR H";
    }
    // STURW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000000000000000000000000000) {
        return Instruction.@"STUR W";
    }
    // LDURW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000010000000000000000000000) {
        return Instruction.@"LDUR W";
    }
    // LDURSW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000100000000000000000000000) {
        return Instruction.@"LDURSW ";
    }
    // VSTURS ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100000000000000000000000000) {
        return Instruction.@"VSTUR S";
    }
    // VLDURS ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100010000000000000000000000) {
        return Instruction.@"VLDUR S";
    }
    // STURX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000000000000000000000000000) {
        return Instruction.@"STUR X";
    }
    // LDURX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000010000000000000000000000) {
        return Instruction.@"LDUR X";
    }
    // PRFUM ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000100000000000000000000000) {
        return Instruction.@"PRFUM ";
    }
    // VSTURD ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100000000000000000000000000) {
        return Instruction.@"VSTUR D";
    }
    // VLDURD ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100010000000000000000000000) {
        return Instruction.@"VLDUR D";
    }
    // STRB (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000000000000000010000000000) {
        return Instruction.@"STRB post";
    }
    // LDRB (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000010000000000010000000000) {
        return Instruction.@"LDRB post";
    }
    // LDRSBX (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000100000000000010000000000) {
        return Instruction.@"LDRSB Xpost";
    }
    // LDRSBW (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000110000000000010000000000) {
        return Instruction.@"LDRSB Wpost";
    }
    // VSTRB (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100000000000000010000000000) {
        return Instruction.@"VSTR Bpost";
    }
    // VLDRB (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100010000000000010000000000) {
        return Instruction.@"VLDR Bpost";
    }
    // VSTRQ (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100100000000000010000000000) {
        return Instruction.@"VSTR Qpost";
    }
    // VLDRQ (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100110000000000010000000000) {
        return Instruction.@"VLDR Qpost";
    }
    // STRH (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000000000000000010000000000) {
        return Instruction.@"STRH post";
    }
    // LDRH (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000010000000000010000000000) {
        return Instruction.@"LDRH post";
    }
    // LDRSHX (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000100000000000010000000000) {
        return Instruction.@"LDRSH Xpost";
    }
    // LDRSHW (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000110000000000010000000000) {
        return Instruction.@"LDRSH Wpost";
    }
    // VSTRH (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100000000000000010000000000) {
        return Instruction.@"VSTR Hpost";
    }
    // VLDRH (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100010000000000010000000000) {
        return Instruction.@"VLDR Hpost";
    }
    // STRW (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000000000000000010000000000) {
        return Instruction.@"STR Wpost";
    }
    // LDRW (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000010000000000010000000000) {
        return Instruction.@"LDR Wpost";
    }
    // LDRSW (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000100000000000010000000000) {
        return Instruction.@"LDRSW post";
    }
    // VSTRS (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100000000000000010000000000) {
        return Instruction.@"VSTR Spost";
    }
    // VLDRS (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100010000000000010000000000) {
        return Instruction.@"VLDR Spost";
    }
    // STRX (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000000000000000010000000000) {
        return Instruction.@"STR Xpost";
    }
    // LDRX (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000010000000000010000000000) {
        return Instruction.@"LDR Xpost";
    }
    // VSTRD (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100000000000000010000000000) {
        return Instruction.@"VSTR Dpost";
    }
    // VLDRD (post)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100010000000000010000000000) {
        return Instruction.@"VLDR Dpost";
    }
    // STTRB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000000000000000100000000000) {
        return Instruction.@"STTRB ";
    }
    // LDTRB ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000010000000000100000000000) {
        return Instruction.@"LDTRB ";
    }
    // LDTRSBX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000100000000000100000000000) {
        return Instruction.@"LDTRSB X";
    }
    // LDTRSBW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000110000000000100000000000) {
        return Instruction.@"LDTRSB W";
    }
    // STTRH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000000000000000100000000000) {
        return Instruction.@"STTRH ";
    }
    // LDTRH ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000010000000000100000000000) {
        return Instruction.@"LDTRH ";
    }
    // LDTRSHX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000100000000000100000000000) {
        return Instruction.@"LDTRSH X";
    }
    // LDTRSHW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000110000000000100000000000) {
        return Instruction.@"LDTRSH W";
    }
    // STTRW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000000000000000100000000000) {
        return Instruction.@"STTR W";
    }
    // LDTRW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000010000000000100000000000) {
        return Instruction.@"LDTR W";
    }
    // LDTRSW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000100000000000100000000000) {
        return Instruction.@"LDTRSW ";
    }
    // STTRX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000000000000000100000000000) {
        return Instruction.@"STTR X";
    }
    // LDTRX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000010000000000100000000000) {
        return Instruction.@"LDTR X";
    }
    // STRB (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000000000000000110000000000) {
        return Instruction.@"STRB pre";
    }
    // LDRB (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000010000000000110000000000) {
        return Instruction.@"LDRB pre";
    }
    // LDRSBX (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000100000000000110000000000) {
        return Instruction.@"LDRSB Xpre";
    }
    // LDRSBW (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000110000000000110000000000) {
        return Instruction.@"LDRSB Wpre";
    }
    // VSTRB (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100000000000000110000000000) {
        return Instruction.@"VSTR Bpre";
    }
    // VLDRB (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100010000000000110000000000) {
        return Instruction.@"VLDR Bpre";
    }
    // VSTRQ (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100100000000000110000000000) {
        return Instruction.@"VSTR Qpre";
    }
    // VLDRQ (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100110000000000110000000000) {
        return Instruction.@"VLDR Qpre";
    }
    // STRH (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000000000000000110000000000) {
        return Instruction.@"STRH pre";
    }
    // LDRH (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000010000000000110000000000) {
        return Instruction.@"LDRH pre";
    }
    // LDRSHX (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000100000000000110000000000) {
        return Instruction.@"LDRSH Xpre";
    }
    // LDRSHW (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000110000000000110000000000) {
        return Instruction.@"LDRSH Wpre";
    }
    // VSTRH (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100000000000000110000000000) {
        return Instruction.@"VSTR Hpre";
    }
    // VLDRH (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100010000000000110000000000) {
        return Instruction.@"VLDR Hpre";
    }
    // STRW (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000000000000000110000000000) {
        return Instruction.@"STR Wpre";
    }
    // LDRW (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000010000000000110000000000) {
        return Instruction.@"LDR Wpre";
    }
    // LDRSW (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000100000000000110000000000) {
        return Instruction.@"LDRSW pre";
    }
    // VSTRS (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100000000000000110000000000) {
        return Instruction.@"VSTR Spre";
    }
    // VLDRS (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100010000000000110000000000) {
        return Instruction.@"VLDR Spre";
    }
    // STRX (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000000000000000110000000000) {
        return Instruction.@"STR Xpre";
    }
    // LDRX (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000010000000000110000000000) {
        return Instruction.@"LDR Xpre";
    }
    // VSTRD (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100000000000000110000000000) {
        return Instruction.@"VSTR Dpre";
    }
    // VLDRD (pre)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100010000000000110000000000) {
        return Instruction.@"VLDR Dpre";
    }
    // STRB (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000001000000000100000000000) {
        return Instruction.@"STRB off";
    }
    // LDRB (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000011000000000100000000000) {
        return Instruction.@"LDRB off";
    }
    // LDRSBX (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000101000000000100000000000) {
        return Instruction.@"LDRSB Xoff";
    }
    // LDRSBW (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111000111000000000100000000000) {
        return Instruction.@"LDRSB Woff";
    }
    // VSTRB (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100001000000000100000000000) {
        return Instruction.@"VSTR Boff";
    }
    // VLDRB (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100011000000000100000000000) {
        return Instruction.@"VLDR Boff";
    }
    // VSTRQ (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100101000000000100000000000) {
        return Instruction.@"VSTR Qoff";
    }
    // VLDRQ (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b00111100111000000000100000000000) {
        return Instruction.@"VLDR Qoff";
    }
    // STRH (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000001000000000100000000000) {
        return Instruction.@"STRH off";
    }
    // LDRH (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000011000000000100000000000) {
        return Instruction.@"LDRH off";
    }
    // LDRSHX (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000101000000000100000000000) {
        return Instruction.@"LDRSH Xoff";
    }
    // LDRSHW (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111000111000000000100000000000) {
        return Instruction.@"LDRSH Woff";
    }
    // VSTRH (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100001000000000100000000000) {
        return Instruction.@"VSTR Hoff";
    }
    // VLDRH (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b01111100011000000000100000000000) {
        return Instruction.@"VLDR Hoff";
    }
    // STRW (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000001000000000100000000000) {
        return Instruction.@"STR Woff";
    }
    // LDRW (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000011000000000100000000000) {
        return Instruction.@"LDR Woff";
    }
    // LDRSW (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111000101000000000100000000000) {
        return Instruction.@"LDRSW off";
    }
    // VSTRS (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100001000000000100000000000) {
        return Instruction.@"VSTR Soff";
    }
    // VLDRS (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b10111100011000000000100000000000) {
        return Instruction.@"VLDR Soff";
    }
    // STRX (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000001000000000100000000000) {
        return Instruction.@"STR Xoff";
    }
    // LDRX (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000011000000000100000000000) {
        return Instruction.@"LDR Xoff";
    }
    // VSTRD (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100001000000000100000000000) {
        return Instruction.@"VSTR Doff";
    }
    // VLDRD (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111100011000000000100000000000) {
        return Instruction.@"VLDR Doff";
    }
    // PRFM (off)
    if ((opcode & 0b11111111111000000000110000000000) == 0b11111000101000000000100000000000) {
        return Instruction.@"PRFM off";
    }
    // STRB (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111001000000000000000000000000) {
        return Instruction.@"STRB imm";
    }
    // LDRB (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111001010000000000000000000000) {
        return Instruction.@"LDRB imm";
    }
    // LDRSBX (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111001100000000000000000000000) {
        return Instruction.@"LDRSB Ximm";
    }
    // LDRSBW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111001110000000000000000000000) {
        return Instruction.@"LDRSB Wimm";
    }
    // VSTRB (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111101000000000000000000000000) {
        return Instruction.@"VSTR Bimm";
    }
    // VLDRB (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111101010000000000000000000000) {
        return Instruction.@"VLDR Bimm";
    }
    // VSTRQ (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111101100000000000000000000000) {
        return Instruction.@"VSTR Qimm";
    }
    // VLDRQ (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00111101110000000000000000000000) {
        return Instruction.@"VLDR Qimm";
    }
    // STRH (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111001000000000000000000000000) {
        return Instruction.@"STRH imm";
    }
    // LDRH (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111001010000000000000000000000) {
        return Instruction.@"LDRH imm";
    }
    // LDRSHX (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111001100000000000000000000000) {
        return Instruction.@"LDRSH Ximm";
    }
    // LDRSHW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111001110000000000000000000000) {
        return Instruction.@"LDRSH Wimm";
    }
    // VSTRH (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111101000000000000000000000000) {
        return Instruction.@"VSTR Himm";
    }
    // VLDRH (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01111101010000000000000000000000) {
        return Instruction.@"VLDR Himm";
    }
    // STRW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10111001000000000000000000000000) {
        return Instruction.@"STR Wimm";
    }
    // LDRW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10111001010000000000000000000000) {
        return Instruction.@"LDR Wimm";
    }
    // LDRSW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10111001100000000000000000000000) {
        return Instruction.@"LDRSW imm";
    }
    // VSTRS (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10111101000000000000000000000000) {
        return Instruction.@"VSTR Simm";
    }
    // VLDRS (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b10111101010000000000000000000000) {
        return Instruction.@"VLDR Simm";
    }
    // STRX (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b11111001000000000000000000000000) {
        return Instruction.@"STR Ximm";
    }
    // LDRX (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b11111001010000000000000000000000) {
        return Instruction.@"LDR Ximm";
    }
    // VSTRD (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b11111101000000000000000000000000) {
        return Instruction.@"VSTR Dimm";
    }
    // VLDRD (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b11111101010000000000000000000000) {
        return Instruction.@"VLDR Dimm";
    }
    // PRFM (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b11111001100000000000000000000000) {
        return Instruction.@"PRFM imm";
    }
    // ADR ()
    if ((opcode & 0b10011111000000000000000000000000) == 0b00010000000000000000000000000000) {
        return Instruction.@"ADR ";
    }
    // ADRP ()
    if ((opcode & 0b10011111000000000000000000000000) == 0b10010000000000000000000000000000) {
        return Instruction.@"ADRP ";
    }
    // ADDW (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b00010001000000000000000000000000) {
        return Instruction.@"ADD Wimm";
    }
    // ADDSW (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b00110001000000000000000000000000) {
        return Instruction.@"ADDS Wimm";
    }
    // SUBW (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b01010001000000000000000000000000) {
        return Instruction.@"SUB Wimm";
    }
    // SUBSW (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b01110001000000000000000000000000) {
        return Instruction.@"SUBS Wimm";
    }
    // ADDX (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b10010001000000000000000000000000) {
        return Instruction.@"ADD Ximm";
    }
    // ADDSX (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b10110001000000000000000000000000) {
        return Instruction.@"ADDS Ximm";
    }
    // SUBX (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b11010001000000000000000000000000) {
        return Instruction.@"SUB Ximm";
    }
    // SUBSX (imm)
    if ((opcode & 0b11111111000000000000000000000000) == 0b11110001000000000000000000000000) {
        return Instruction.@"SUBS Ximm";
    }
    // ANDW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00010010000000000000000000000000) {
        return Instruction.@"AND Wimm";
    }
    // ORRW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b00110010000000000000000000000000) {
        return Instruction.@"ORR Wimm";
    }
    // EORW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01010010000000000000000000000000) {
        return Instruction.@"EOR Wimm";
    }
    // ANDSW (imm)
    if ((opcode & 0b11111111110000000000000000000000) == 0b01110010000000000000000000000000) {
        return Instruction.@"ANDS Wimm";
    }
    // ANDX (imm)
    if ((opcode & 0b11111111100000000000000000000000) == 0b10010010000000000000000000000000) {
        return Instruction.@"AND Ximm";
    }
    // ORRX (imm)
    if ((opcode & 0b11111111100000000000000000000000) == 0b10110010000000000000000000000000) {
        return Instruction.@"ORR Ximm";
    }
    // EORX (imm)
    if ((opcode & 0b11111111100000000000000000000000) == 0b11010010000000000000000000000000) {
        return Instruction.@"EOR Ximm";
    }
    // ANDSX (imm)
    if ((opcode & 0b11111111100000000000000000000000) == 0b11110010000000000000000000000000) {
        return Instruction.@"ANDS Ximm";
    }
    // MOVNW ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b00010010100000000000000000000000) {
        return Instruction.@"MOVN W";
    }
    // MOVZW ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b01010010100000000000000000000000) {
        return Instruction.@"MOVZ W";
    }
    // MOVKW ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b01110010100000000000000000000000) {
        return Instruction.@"MOVK W";
    }
    // MOVNX ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b10010010100000000000000000000000) {
        return Instruction.@"MOVN X";
    }
    // MOVZX ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b11010010100000000000000000000000) {
        return Instruction.@"MOVZ X";
    }
    // MOVKX ()
    if ((opcode & 0b11111111100000000000000000000000) == 0b11110010100000000000000000000000) {
        return Instruction.@"MOVK X";
    }
    // SBFMW ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00010011000000000000000000000000) {
        return Instruction.@"SBFM W";
    }
    // BFMW ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b00110011000000000000000000000000) {
        return Instruction.@"BFM W";
    }
    // UBFMW ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b01010011000000000000000000000000) {
        return Instruction.@"UBFM W";
    }
    // SBFMX ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10010011010000000000000000000000) {
        return Instruction.@"SBFM X";
    }
    // BFMX ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b10110011010000000000000000000000) {
        return Instruction.@"BFM X";
    }
    // UBFMX ()
    if ((opcode & 0b11111111110000000000000000000000) == 0b11010011010000000000000000000000) {
        return Instruction.@"UBFM X";
    }
    // EXTRW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00010011100000000000000000000000) {
        return Instruction.@"EXTR W";
    }
    // EXTRX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10010011110000001000000000000000) {
        return Instruction.@"EXTR X";
    }
    // ANDW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00001010000000000000000000000000) {
        return Instruction.@"AND W";
    }
    // BICW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00001010001000000000000000000000) {
        return Instruction.@"BIC W";
    }
    // ORRW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00101010000000000000000000000000) {
        return Instruction.@"ORR W";
    }
    // ORNW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00101010001000000000000000000000) {
        return Instruction.@"ORN W";
    }
    // EORW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01001010000000000000000000000000) {
        return Instruction.@"EOR W";
    }
    // EONW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01001010001000000000000000000000) {
        return Instruction.@"EON W";
    }
    // ANDSW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01101010000000000000000000000000) {
        return Instruction.@"ANDS W";
    }
    // BICSW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01101010001000000000000000000000) {
        return Instruction.@"BICS W";
    }
    // ANDX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10001010000000000000000000000000) {
        return Instruction.@"AND X";
    }
    // BICX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10001010001000000000000000000000) {
        return Instruction.@"BIC X";
    }
    // ORRX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10101010000000000000000000000000) {
        return Instruction.@"ORR X";
    }
    // ORNX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10101010001000000000000000000000) {
        return Instruction.@"ORN X";
    }
    // EORX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11001010000000000000000000000000) {
        return Instruction.@"EOR X";
    }
    // EONX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11001010001000000000000000000000) {
        return Instruction.@"EON X";
    }
    // ANDSX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11101010000000000000000000000000) {
        return Instruction.@"ANDS X";
    }
    // BICSX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11101010001000000000000000000000) {
        return Instruction.@"BICS X";
    }
    // ADDW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00001011000000000000000000000000) {
        return Instruction.@"ADD W";
    }
    // ADDSW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b00101011000000000000000000000000) {
        return Instruction.@"ADDS W";
    }
    // SUBW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01001011000000000000000000000000) {
        return Instruction.@"SUB W";
    }
    // SUBSW ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b01101011000000000000000000000000) {
        return Instruction.@"SUBS W";
    }
    // ADDX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10001011000000000000000000000000) {
        return Instruction.@"ADD X";
    }
    // ADDSX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b10101011000000000000000000000000) {
        return Instruction.@"ADDS X";
    }
    // SUBX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11001011000000000000000000000000) {
        return Instruction.@"SUB X";
    }
    // SUBSX ()
    if ((opcode & 0b11111111001000000000000000000000) == 0b11101011000000000000000000000000) {
        return Instruction.@"SUBS X";
    }
    // ADDW (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b00001011001000000000000000000000) {
        return Instruction.@"ADD Wext";
    }
    // ADDSW (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b00101011001000000000000000000000) {
        return Instruction.@"ADDS Wext";
    }
    // SUBW (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b01001011001000000000000000000000) {
        return Instruction.@"SUB Wext";
    }
    // SUBSW (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b01101011001000000000000000000000) {
        return Instruction.@"SUBS Wext";
    }
    // ADDX (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b10001011001000000000000000000000) {
        return Instruction.@"ADD Xext";
    }
    // ADDSX (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b10101011001000000000000000000000) {
        return Instruction.@"ADDS Xext";
    }
    // SUBX (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b11001011001000000000000000000000) {
        return Instruction.@"SUB Xext";
    }
    // SUBSX (ext)
    if ((opcode & 0b11111111111000000000000000000000) == 0b11101011001000000000000000000000) {
        return Instruction.@"SUBS Xext";
    }
    // ADCW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010000000000000000000000000) {
        return Instruction.@"ADC W";
    }
    // ADCSW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00111010000000000000000000000000) {
        return Instruction.@"ADCS W";
    }
    // SBCW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011010000000000000000000000000) {
        return Instruction.@"SBC W";
    }
    // SBCSW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01111010000000000000000000000000) {
        return Instruction.@"SBCS W";
    }
    // ADCX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010000000000000000000000000) {
        return Instruction.@"ADC X";
    }
    // ADCSX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10111010000000000000000000000000) {
        return Instruction.@"ADCS X";
    }
    // SBCX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b11011010000000000000000000000000) {
        return Instruction.@"SBC X";
    }
    // SBCSX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b11111010000000000000000000000000) {
        return Instruction.@"SBCS X";
    }
    // CCMNW ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b00111010010000000000000000000000) {
        return Instruction.@"CCMN W";
    }
    // CCMNX ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b10111010010000000000000000000000) {
        return Instruction.@"CCMN X";
    }
    // CCMPW ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b01111010010000000000000000000000) {
        return Instruction.@"CCMP W";
    }
    // CCMPX ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b11111010010000000000000000000000) {
        return Instruction.@"CCMP X";
    }
    // CCMNW (imm)
    if ((opcode & 0b11111111111000000000110000010000) == 0b00111010010000000000100000000000) {
        return Instruction.@"CCMN Wimm";
    }
    // CCMNX (imm)
    if ((opcode & 0b11111111111000000000110000010000) == 0b10111010010000000000100000000000) {
        return Instruction.@"CCMN Ximm";
    }
    // CCMPW (imm)
    if ((opcode & 0b11111111111000000000110000010000) == 0b01111010010000000000100000000000) {
        return Instruction.@"CCMP Wimm";
    }
    // CCMPX (imm)
    if ((opcode & 0b11111111111000000000110000010000) == 0b11111010010000000000100000000000) {
        return Instruction.@"CCMP Ximm";
    }
    // CSELW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00011010100000000000000000000000) {
        return Instruction.@"CSEL W";
    }
    // CSINCW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00011010100000000000010000000000) {
        return Instruction.@"CSINC W";
    }
    // CSINVW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01011010100000000000000000000000) {
        return Instruction.@"CSINV W";
    }
    // CSNEGW ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b01011010100000000000010000000000) {
        return Instruction.@"CSNEG W";
    }
    // CSELX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10011010100000000000000000000000) {
        return Instruction.@"CSEL X";
    }
    // CSINCX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b10011010100000000000010000000000) {
        return Instruction.@"CSINC X";
    }
    // CSINVX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11011010100000000000000000000000) {
        return Instruction.@"CSINV X";
    }
    // CSNEGX ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b11011010100000000000010000000000) {
        return Instruction.@"CSNEG X";
    }
    // MADDW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011011000000000000000000000000) {
        return Instruction.@"MADD W";
    }
    // MADDX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011000000000000000000000000) {
        return Instruction.@"MADD X";
    }
    // SMADDL ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011001000000000000000000000) {
        return Instruction.@"SMADDL ";
    }
    // UMADDL ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011101000000000000000000000) {
        return Instruction.@"UMADDL ";
    }
    // MSUBW ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011011000000001000000000000000) {
        return Instruction.@"MSUB W";
    }
    // MSUBX ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011000000001000000000000000) {
        return Instruction.@"MSUB X";
    }
    // SMSUBL ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011001000001000000000000000) {
        return Instruction.@"SMSUBL ";
    }
    // UMSUBL ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011101000001000000000000000) {
        return Instruction.@"UMSUBL ";
    }
    // SMULH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011010000000000000000000000) {
        return Instruction.@"SMULH ";
    }
    // UMULH ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b10011011110000000000000000000000) {
        return Instruction.@"UMULH ";
    }
    // CRC32X ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000100110000000000) {
        return Instruction.@"CRC32X ";
    }
    // CRC32CX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000101110000000000) {
        return Instruction.@"CRC32CX ";
    }
    // CRC32B ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000100000000000000) {
        return Instruction.@"CRC32B ";
    }
    // CRC32CB ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000101000000000000) {
        return Instruction.@"CRC32CB ";
    }
    // CRC32H ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000100010000000000) {
        return Instruction.@"CRC32H ";
    }
    // CRC32CH ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000101010000000000) {
        return Instruction.@"CRC32CH ";
    }
    // CRC32W ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000100100000000000) {
        return Instruction.@"CRC32W ";
    }
    // CRC32CW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000101100000000000) {
        return Instruction.@"CRC32CW ";
    }
    // UDIVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000000100000000000) {
        return Instruction.@"UDIV W";
    }
    // UDIVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000000100000000000) {
        return Instruction.@"UDIV X";
    }
    // SDIVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000000110000000000) {
        return Instruction.@"SDIV W";
    }
    // SDIVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000000110000000000) {
        return Instruction.@"SDIV X";
    }
    // LSLVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000010000000000000) {
        return Instruction.@"LSLV W";
    }
    // LSLVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000010000000000000) {
        return Instruction.@"LSLV X";
    }
    // LSRVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000010010000000000) {
        return Instruction.@"LSRV W";
    }
    // LSRVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000010010000000000) {
        return Instruction.@"LSRV X";
    }
    // ASRVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000010100000000000) {
        return Instruction.@"ASRV W";
    }
    // ASRVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000010100000000000) {
        return Instruction.@"ASRV X";
    }
    // RORVW ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011010110000000010110000000000) {
        return Instruction.@"RORV W";
    }
    // RORVX ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b10011010110000000010110000000000) {
        return Instruction.@"RORV X";
    }
    // RBITW ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011010110000000000000000000000) {
        return Instruction.@"RBIT W";
    }
    // RBITX ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000000000000000000) {
        return Instruction.@"RBIT X";
    }
    // CLZW ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011010110000000001000000000000) {
        return Instruction.@"CLZ W";
    }
    // CLZX ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000001000000000000) {
        return Instruction.@"CLZ X";
    }
    // CLSW ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011010110000000001010000000000) {
        return Instruction.@"CLS W";
    }
    // CLSX ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000001010000000000) {
        return Instruction.@"CLS X";
    }
    // REVW ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011010110000000000100000000000) {
        return Instruction.@"REV W";
    }
    // REVX ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000000110000000000) {
        return Instruction.@"REV X";
    }
    // REV16W ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000000010000000000) {
        return Instruction.@"REV16 W";
    }
    // REV16X ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011010110000000000010000000000) {
        return Instruction.@"REV16 X";
    }
    // REV32 ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b11011010110000000000100000000000) {
        return Instruction.@"REV32 ";
    }
    // VSCVTF32_bit_to_single_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110000000100000000000000000) {
        return Instruction.@"VSCVTF 32_bit_to_single_precisionscalar_fixed_point";
    }
    // VUCVTF32_bit_to_single_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110000000110000000000000000) {
        return Instruction.@"VUCVTF 32_bit_to_single_precisionscalar_fixed_point";
    }
    // VFCVTZSSingle_precision_to_32_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110110110000000000000000000) {
        return Instruction.@"VFCVTZS Single_precision_to_32_bitscalar_fixed_point";
    }
    // VFCVTZUSingle_precision_to_32_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110110110010000000000000000) {
        return Instruction.@"VFCVTZU Single_precision_to_32_bitscalar_fixed_point";
    }
    // VSCVTF32_bit_to_double_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110000000100000000000000000) {
        return Instruction.@"VSCVTF 32_bit_to_double_precisionscalar_fixed_point";
    }
    // VUCVTF32_bit_to_double_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110000000110000000000000000) {
        return Instruction.@"VUCVTF 32_bit_to_double_precisionscalar_fixed_point";
    }
    // VFCVTZSDouble_precision_to_32_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110110110000000000000000000) {
        return Instruction.@"VFCVTZS Double_precision_to_32_bitscalar_fixed_point";
    }
    // VFCVTZUDouble_precision_to_32_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b00011110110110010000000000000000) {
        return Instruction.@"VFCVTZU Double_precision_to_32_bitscalar_fixed_point";
    }
    // VSCVTF64_bit_to_single_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110000000100000000000000000) {
        return Instruction.@"VSCVTF 64_bit_to_single_precisionscalar_fixed_point";
    }
    // VUCVTF64_bit_to_single_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110000000110000000000000000) {
        return Instruction.@"VUCVTF 64_bit_to_single_precisionscalar_fixed_point";
    }
    // VFCVTZSSingle_precision_to_64_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110110110000000000000000000) {
        return Instruction.@"VFCVTZS Single_precision_to_64_bitscalar_fixed_point";
    }
    // VFCVTZUSingle_precision_to_64_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110110110010000000000000000) {
        return Instruction.@"VFCVTZU Single_precision_to_64_bitscalar_fixed_point";
    }
    // VSCVTF64_bit_to_double_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110000000100000000000000000) {
        return Instruction.@"VSCVTF 64_bit_to_double_precisionscalar_fixed_point";
    }
    // VUCVTF64_bit_to_double_precision (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110000000110000000000000000) {
        return Instruction.@"VUCVTF 64_bit_to_double_precisionscalar_fixed_point";
    }
    // VFCVTZSDouble_precision_to_64_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110110110000000000000000000) {
        return Instruction.@"VFCVTZS Double_precision_to_64_bitscalar_fixed_point";
    }
    // VFCVTZUDouble_precision_to_64_bit (scalar_fixed_point)
    if ((opcode & 0b11111111111111110000000000000000) == 0b10011110110110010000000000000000) {
        return Instruction.@"VFCVTZU Double_precision_to_64_bitscalar_fixed_point";
    }
    // VFCCMPSingle_precision ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b00011110001000000000010000000000) {
        return Instruction.@"VFCCMP Single_precision";
    }
    // VFCCMPESingle_precision ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b00011110001000000000010000010000) {
        return Instruction.@"VFCCMPE Single_precision";
    }
    // VFCCMPDouble_precision ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b00011110011000000000010000000000) {
        return Instruction.@"VFCCMP Double_precision";
    }
    // VFCCMPEDouble_precision ()
    if ((opcode & 0b11111111111000000000110000010000) == 0b00011110011000000000010000010000) {
        return Instruction.@"VFCCMPE Double_precision";
    }
    // VFMULSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000000100000000000) {
        return Instruction.@"VFMUL Single_precisionscalar";
    }
    // VFDIVSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000001100000000000) {
        return Instruction.@"VFDIV Single_precisionscalar";
    }
    // VFADDSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000010100000000000) {
        return Instruction.@"VFADD Single_precisionscalar";
    }
    // VFSUBSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000011100000000000) {
        return Instruction.@"VFSUB Single_precisionscalar";
    }
    // VFMAXSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000100100000000000) {
        return Instruction.@"VFMAX Single_precisionscalar";
    }
    // VFMINSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000101100000000000) {
        return Instruction.@"VFMIN Single_precisionscalar";
    }
    // VFMAXNMSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000110100000000000) {
        return Instruction.@"VFMAXNM Single_precisionscalar";
    }
    // VFMINNMSingle_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000000111100000000000) {
        return Instruction.@"VFMINNM Single_precisionscalar";
    }
    // VFNMULSingle_precision ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110001000001000100000000000) {
        return Instruction.@"VFNMUL Single_precision";
    }
    // VFMULDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000000100000000000) {
        return Instruction.@"VFMUL Double_precisionscalar";
    }
    // VFDIVDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000001100000000000) {
        return Instruction.@"VFDIV Double_precisionscalar";
    }
    // VFADDDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000010100000000000) {
        return Instruction.@"VFADD Double_precisionscalar";
    }
    // VFSUBDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000011100000000000) {
        return Instruction.@"VFSUB Double_precisionscalar";
    }
    // VFMAXDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000100100000000000) {
        return Instruction.@"VFMAX Double_precisionscalar";
    }
    // VFMINDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000101100000000000) {
        return Instruction.@"VFMIN Double_precisionscalar";
    }
    // VFMAXNMDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000110100000000000) {
        return Instruction.@"VFMAXNM Double_precisionscalar";
    }
    // VFMINNMDouble_precision (scalar)
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000000111100000000000) {
        return Instruction.@"VFMINNM Double_precisionscalar";
    }
    // VFNMULDouble_precision ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00011110011000001000100000000000) {
        return Instruction.@"VFNMUL Double_precision";
    }
    // VFCSELSingle_precision ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00011110001000000000110000000000) {
        return Instruction.@"VFCSEL Single_precision";
    }
    // VFCSELDouble_precision ()
    if ((opcode & 0b11111111111000000000110000000000) == 0b00011110011000000000110000000000) {
        return Instruction.@"VFCSEL Double_precision";
    }
    // VFMOVSingle_precision (scalar_immediate)
    if ((opcode & 0b11111111111000000001111111100000) == 0b00011110001000000001000000000000) {
        return Instruction.@"VFMOV Single_precisionscalar_immediate";
    }
    // VFMOVDouble_precision (scalar_immediate)
    if ((opcode & 0b11111111111000000001111111100000) == 0b00011110011000000001000000000000) {
        return Instruction.@"VFMOV Double_precisionscalar_immediate";
    }
    // VFCMPSingle_precision ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110001000000010000000000000) {
        return Instruction.@"VFCMP Single_precision";
    }
    // VFCMPSingle_precision_zero ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110001000000010000000001000) {
        return Instruction.@"VFCMP Single_precision_zero";
    }
    // VFCMPESingle_precision ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110001000000010000000010000) {
        return Instruction.@"VFCMPE Single_precision";
    }
    // VFCMPESingle_precision_zero ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110001000000010000000011000) {
        return Instruction.@"VFCMPE Single_precision_zero";
    }
    // VFCMPDouble_precision ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110011000000010000000000000) {
        return Instruction.@"VFCMP Double_precision";
    }
    // VFCMPDouble_precision_zero ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110011000000010000000001000) {
        return Instruction.@"VFCMP Double_precision_zero";
    }
    // VFCMPEDouble_precision ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110011000000010000000010000) {
        return Instruction.@"VFCMPE Double_precision";
    }
    // VFCMPEDouble_precision_zero ()
    if ((opcode & 0b11111111111000001111110000011111) == 0b00011110011000000010000000011000) {
        return Instruction.@"VFCMPE Double_precision_zero";
    }
    // VFMOVSingle_precision (register)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000000100000000000000) {
        return Instruction.@"VFMOV Single_precisionregister";
    }
    // VFABSSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000001100000000000000) {
        return Instruction.@"VFABS Single_precisionscalar";
    }
    // VFNEGSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000010100000000000000) {
        return Instruction.@"VFNEG Single_precisionscalar";
    }
    // VFSQRTSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000011100000000000000) {
        return Instruction.@"VFSQRT Single_precisionscalar";
    }
    // VFCVTSingle_precision_to_double_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000101100000000000000) {
        return Instruction.@"VFCVT Single_precision_to_double_precision";
    }
    // VFCVTSingle_precision_to_half_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000111100000000000000) {
        return Instruction.@"VFCVT Single_precision_to_half_precision";
    }
    // VFRINTNSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001000100000000000000) {
        return Instruction.@"VFRINTN Single_precisionscalar";
    }
    // VFRINTPSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001001100000000000000) {
        return Instruction.@"VFRINTP Single_precisionscalar";
    }
    // VFRINTMSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001010100000000000000) {
        return Instruction.@"VFRINTM Single_precisionscalar";
    }
    // VFRINTZSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001011100000000000000) {
        return Instruction.@"VFRINTZ Single_precisionscalar";
    }
    // VFRINTASingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001100100000000000000) {
        return Instruction.@"VFRINTA Single_precisionscalar";
    }
    // VFRINTXSingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001110100000000000000) {
        return Instruction.@"VFRINTX Single_precisionscalar";
    }
    // VFRINTISingle_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001111100000000000000) {
        return Instruction.@"VFRINTI Single_precisionscalar";
    }
    // VFMOVDouble_precision (register)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000000100000000000000) {
        return Instruction.@"VFMOV Double_precisionregister";
    }
    // VFABSDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000001100000000000000) {
        return Instruction.@"VFABS Double_precisionscalar";
    }
    // VFNEGDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000010100000000000000) {
        return Instruction.@"VFNEG Double_precisionscalar";
    }
    // VFSQRTDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000011100000000000000) {
        return Instruction.@"VFSQRT Double_precisionscalar";
    }
    // VFCVTDouble_precision_to_single_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000100100000000000000) {
        return Instruction.@"VFCVT Double_precision_to_single_precision";
    }
    // VFCVTDouble_precision_to_half_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000111100000000000000) {
        return Instruction.@"VFCVT Double_precision_to_half_precision";
    }
    // VFRINTNDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001000100000000000000) {
        return Instruction.@"VFRINTN Double_precisionscalar";
    }
    // VFRINTPDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001001100000000000000) {
        return Instruction.@"VFRINTP Double_precisionscalar";
    }
    // VFRINTMDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001010100000000000000) {
        return Instruction.@"VFRINTM Double_precisionscalar";
    }
    // VFRINTZDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001011100000000000000) {
        return Instruction.@"VFRINTZ Double_precisionscalar";
    }
    // VFRINTADouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001100100000000000000) {
        return Instruction.@"VFRINTA Double_precisionscalar";
    }
    // VFRINTXDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001110100000000000000) {
        return Instruction.@"VFRINTX Double_precisionscalar";
    }
    // VFRINTIDouble_precision (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001111100000000000000) {
        return Instruction.@"VFRINTI Double_precisionscalar";
    }
    // VFCVTHalf_precision_to_single_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110111000100100000000000000) {
        return Instruction.@"VFCVT Half_precision_to_single_precision";
    }
    // VFCVTHalf_precision_to_double_precision ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110111000101100000000000000) {
        return Instruction.@"VFCVT Half_precision_to_double_precision";
    }
    // VFCVTNSSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000000000000000000000) {
        return Instruction.@"VFCVTNS Single_precision_to_32_bitscalar";
    }
    // VFCVTNUSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000010000000000000000) {
        return Instruction.@"VFCVTNU Single_precision_to_32_bitscalar";
    }
    // VSCVTF32_bit_to_single_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000100000000000000000) {
        return Instruction.@"VSCVTF 32_bit_to_single_precisionscalar_integer";
    }
    // VUCVTF32_bit_to_single_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001000110000000000000000) {
        return Instruction.@"VUCVTF 32_bit_to_single_precisionscalar_integer";
    }
    // VFCVTASSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001000000000000000000) {
        return Instruction.@"VFCVTAS Single_precision_to_32_bitscalar";
    }
    // VFCVTAUSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001010000000000000000) {
        return Instruction.@"VFCVTAU Single_precision_to_32_bitscalar";
    }
    // VFMOVSingle_precision_to_32_bit (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001100000000000000000) {
        return Instruction.@"VFMOV Single_precision_to_32_bitgeneral";
    }
    // VFMOV32_bit_to_single_precision (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001001110000000000000000) {
        return Instruction.@"VFMOV 32_bit_to_single_precisiongeneral";
    }
    // VFCVTPSSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001010000000000000000000) {
        return Instruction.@"VFCVTPS Single_precision_to_32_bitscalar";
    }
    // VFCVTPUSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001010010000000000000000) {
        return Instruction.@"VFCVTPU Single_precision_to_32_bitscalar";
    }
    // VFCVTMSSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001100000000000000000000) {
        return Instruction.@"VFCVTMS Single_precision_to_32_bitscalar";
    }
    // VFCVTMUSingle_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001100010000000000000000) {
        return Instruction.@"VFCVTMU Single_precision_to_32_bitscalar";
    }
    // VFCVTZSSingle_precision_to_32_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001110000000000000000000) {
        return Instruction.@"VFCVTZS Single_precision_to_32_bitscalar_integer";
    }
    // VFCVTZUSingle_precision_to_32_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110001110010000000000000000) {
        return Instruction.@"VFCVTZU Single_precision_to_32_bitscalar_integer";
    }
    // VFCVTNSDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000000000000000000000) {
        return Instruction.@"VFCVTNS Double_precision_to_32_bitscalar";
    }
    // VFCVTNUDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000010000000000000000) {
        return Instruction.@"VFCVTNU Double_precision_to_32_bitscalar";
    }
    // VSCVTF32_bit_to_double_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000100000000000000000) {
        return Instruction.@"VSCVTF 32_bit_to_double_precisionscalar_integer";
    }
    // VUCVTF32_bit_to_double_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011000110000000000000000) {
        return Instruction.@"VUCVTF 32_bit_to_double_precisionscalar_integer";
    }
    // VFCVTASDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001000000000000000000) {
        return Instruction.@"VFCVTAS Double_precision_to_32_bitscalar";
    }
    // VFCVTAUDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011001010000000000000000) {
        return Instruction.@"VFCVTAU Double_precision_to_32_bitscalar";
    }
    // VFCVTPSDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011010000000000000000000) {
        return Instruction.@"VFCVTPS Double_precision_to_32_bitscalar";
    }
    // VFCVTPUDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011010010000000000000000) {
        return Instruction.@"VFCVTPU Double_precision_to_32_bitscalar";
    }
    // VFCVTMSDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011100000000000000000000) {
        return Instruction.@"VFCVTMS Double_precision_to_32_bitscalar";
    }
    // VFCVTMUDouble_precision_to_32_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011100010000000000000000) {
        return Instruction.@"VFCVTMU Double_precision_to_32_bitscalar";
    }
    // VFCVTZSDouble_precision_to_32_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011110000000000000000000) {
        return Instruction.@"VFCVTZS Double_precision_to_32_bitscalar_integer";
    }
    // VFCVTZUDouble_precision_to_32_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b00011110011110010000000000000000) {
        return Instruction.@"VFCVTZU Double_precision_to_32_bitscalar_integer";
    }
    // VFCVTNSSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001000000000000000000000) {
        return Instruction.@"VFCVTNS Single_precision_to_64_bitscalar";
    }
    // VFCVTNUSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001000010000000000000000) {
        return Instruction.@"VFCVTNU Single_precision_to_64_bitscalar";
    }
    // VSCVTF64_bit_to_single_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001000100000000000000000) {
        return Instruction.@"VSCVTF 64_bit_to_single_precisionscalar_integer";
    }
    // VUCVTF64_bit_to_single_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001000110000000000000000) {
        return Instruction.@"VUCVTF 64_bit_to_single_precisionscalar_integer";
    }
    // VFCVTASSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001001000000000000000000) {
        return Instruction.@"VFCVTAS Single_precision_to_64_bitscalar";
    }
    // VFCVTAUSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001001010000000000000000) {
        return Instruction.@"VFCVTAU Single_precision_to_64_bitscalar";
    }
    // VFCVTPSSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001010000000000000000000) {
        return Instruction.@"VFCVTPS Single_precision_to_64_bitscalar";
    }
    // VFCVTPUSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001010010000000000000000) {
        return Instruction.@"VFCVTPU Single_precision_to_64_bitscalar";
    }
    // VFCVTMSSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001100000000000000000000) {
        return Instruction.@"VFCVTMS Single_precision_to_64_bitscalar";
    }
    // VFCVTMUSingle_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001100010000000000000000) {
        return Instruction.@"VFCVTMU Single_precision_to_64_bitscalar";
    }
    // VFCVTZSSingle_precision_to_64_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001110000000000000000000) {
        return Instruction.@"VFCVTZS Single_precision_to_64_bitscalar_integer";
    }
    // VFCVTZUSingle_precision_to_64_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110001110010000000000000000) {
        return Instruction.@"VFCVTZU Single_precision_to_64_bitscalar_integer";
    }
    // VFCVTNSDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011000000000000000000000) {
        return Instruction.@"VFCVTNS Double_precision_to_64_bitscalar";
    }
    // VFCVTNUDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011000010000000000000000) {
        return Instruction.@"VFCVTNU Double_precision_to_64_bitscalar";
    }
    // VSCVTF64_bit_to_double_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011000100000000000000000) {
        return Instruction.@"VSCVTF 64_bit_to_double_precisionscalar_integer";
    }
    // VUCVTF64_bit_to_double_precision (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011000110000000000000000) {
        return Instruction.@"VUCVTF 64_bit_to_double_precisionscalar_integer";
    }
    // VFCVTASDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011001000000000000000000) {
        return Instruction.@"VFCVTAS Double_precision_to_64_bitscalar";
    }
    // VFCVTAUDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011001010000000000000000) {
        return Instruction.@"VFCVTAU Double_precision_to_64_bitscalar";
    }
    // VFMOVDouble_precision_to_64_bit (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011001100000000000000000) {
        return Instruction.@"VFMOV Double_precision_to_64_bitgeneral";
    }
    // VFMOV64_bit_to_double_precision (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011001110000000000000000) {
        return Instruction.@"VFMOV 64_bit_to_double_precisiongeneral";
    }
    // VFCVTPSDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011010000000000000000000) {
        return Instruction.@"VFCVTPS Double_precision_to_64_bitscalar";
    }
    // VFCVTPUDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011010010000000000000000) {
        return Instruction.@"VFCVTPU Double_precision_to_64_bitscalar";
    }
    // VFCVTMSDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011100000000000000000000) {
        return Instruction.@"VFCVTMS Double_precision_to_64_bitscalar";
    }
    // VFCVTMUDouble_precision_to_64_bit (scalar)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011100010000000000000000) {
        return Instruction.@"VFCVTMU Double_precision_to_64_bitscalar";
    }
    // VFCVTZSDouble_precision_to_64_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011110000000000000000000) {
        return Instruction.@"VFCVTZS Double_precision_to_64_bitscalar_integer";
    }
    // VFCVTZUDouble_precision_to_64_bit (scalar_integer)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110011110010000000000000000) {
        return Instruction.@"VFCVTZU Double_precision_to_64_bitscalar_integer";
    }
    // VFMOVTop_half_of_128_bit_to_64_bit (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110101011100000000000000000) {
        return Instruction.@"VFMOV Top_half_of_128_bit_to_64_bitgeneral";
    }
    // VFMOV64_bit_to_top_half_of_128_bit (general)
    if ((opcode & 0b11111111111111111111110000000000) == 0b10011110101011110000000000000000) {
        return Instruction.@"VFMOV 64_bit_to_top_half_of_128_bitgeneral";
    }
    // VFMADDSingle_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111000000000000000000000000) {
        return Instruction.@"VFMADD Single_precision";
    }
    // VFMSUBSingle_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111000000001000000000000000) {
        return Instruction.@"VFMSUB Single_precision";
    }
    // VFNMADDSingle_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111001000000000000000000000) {
        return Instruction.@"VFNMADD Single_precision";
    }
    // VFNMSUBSingle_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111001000001000000000000000) {
        return Instruction.@"VFNMSUB Single_precision";
    }
    // VFMADDDouble_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111010000000000000000000000) {
        return Instruction.@"VFMADD Double_precision";
    }
    // VFMSUBDouble_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111010000001000000000000000) {
        return Instruction.@"VFMSUB Double_precision";
    }
    // VFNMADDDouble_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111011000000000000000000000) {
        return Instruction.@"VFNMADD Double_precision";
    }
    // VFNMSUBDouble_precision ()
    if ((opcode & 0b11111111111000001000000000000000) == 0b00011111011000001000000000000000) {
        return Instruction.@"VFNMSUB Double_precision";
    }
    // VSQADDScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000000110000000000) {
        return Instruction.@"VSQADD Scalar";
    }
    // VSQSUBScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000010110000000000) {
        return Instruction.@"VSQSUB Scalar";
    }
    // VCMGTScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000011010000000000) {
        return Instruction.@"VCMGT Scalarregister";
    }
    // VCMGEScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000011110000000000) {
        return Instruction.@"VCMGE Scalarregister";
    }
    // VSSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000100010000000000) {
        return Instruction.@"VSSHL Scalar";
    }
    // VSQSHLScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000100110000000000) {
        return Instruction.@"VSQSHL Scalarregister";
    }
    // VSRSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000101010000000000) {
        return Instruction.@"VSRSHL Scalar";
    }
    // VSQRSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000000101110000000000) {
        return Instruction.@"VSQRSHL Scalar";
    }
    // VADDScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001000010000000000) {
        return Instruction.@"VADD Scalarvector";
    }
    // VCMTSTScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001000110000000000) {
        return Instruction.@"VCMTST Scalar";
    }
    // VSQDMULHScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001011010000000000) {
        return Instruction.@"VSQDMULH Scalarvector";
    }
    // VFMULXScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01011110001000001101110000000000) {
        return Instruction.@"VFMULX Scalar";
    }
    // VFCMEQScalar (register)
    if ((opcode & 0b11111111101000001111110000000000) == 0b01011110001000001110010000000000) {
        return Instruction.@"VFCMEQ Scalarregister";
    }
    // VFRECPSScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01011110001000001111110000000000) {
        return Instruction.@"VFRECPS Scalar";
    }
    // VFRSQRTSScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01011110101000001111110000000000) {
        return Instruction.@"VFRSQRTS Scalar";
    }
    // VUQADDScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000000110000000000) {
        return Instruction.@"VUQADD Scalar";
    }
    // VUQSUBScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000010110000000000) {
        return Instruction.@"VUQSUB Scalar";
    }
    // VCMHIScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000011010000000000) {
        return Instruction.@"VCMHI Scalarregister";
    }
    // VCMHSScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000011110000000000) {
        return Instruction.@"VCMHS Scalarregister";
    }
    // VUSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000100010000000000) {
        return Instruction.@"VUSHL Scalar";
    }
    // VUQSHLScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000100110000000000) {
        return Instruction.@"VUQSHL Scalarregister";
    }
    // VURSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000101010000000000) {
        return Instruction.@"VURSHL Scalar";
    }
    // VUQRSHLScalar ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000000101110000000000) {
        return Instruction.@"VUQRSHL Scalar";
    }
    // VSUBScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000001000010000000000) {
        return Instruction.@"VSUB Scalarvector";
    }
    // VCMEQScalar (register)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000001000110000000000) {
        return Instruction.@"VCMEQ Scalarregister";
    }
    // VSQRDMULHScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01111110001000001011010000000000) {
        return Instruction.@"VSQRDMULH Scalarvector";
    }
    // VFCMGEScalar (register)
    if ((opcode & 0b11111111101000001111110000000000) == 0b01111110001000001110010000000000) {
        return Instruction.@"VFCMGE Scalarregister";
    }
    // VFACGEScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01111110001000001110110000000000) {
        return Instruction.@"VFACGE Scalar";
    }
    // VFABDScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01111110101000001101010000000000) {
        return Instruction.@"VFABD Scalar";
    }
    // VFCMGTScalar (register)
    if ((opcode & 0b11111111101000001111110000000000) == 0b01111110101000001110010000000000) {
        return Instruction.@"VFCMGT Scalarregister";
    }
    // VFACGTScalar ()
    if ((opcode & 0b11111111101000001111110000000000) == 0b01111110101000001110110000000000) {
        return Instruction.@"VFACGT Scalar";
    }
    // VSQDMLALScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001001000000000000) {
        return Instruction.@"VSQDMLAL Scalarvector";
    }
    // VSQDMLAL2Scalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001001000000000000) {
        return Instruction.@"VSQDMLAL2 Scalarvector";
    }
    // VSQDMLSLScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001011000000000000) {
        return Instruction.@"VSQDMLSL Scalarvector";
    }
    // VSQDMLSL2Scalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001011000000000000) {
        return Instruction.@"VSQDMLSL2 Scalarvector";
    }
    // VSQDMULLScalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001101000000000000) {
        return Instruction.@"VSQDMULL Scalarvector";
    }
    // VSQDMULL2Scalar (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01011110001000001101000000000000) {
        return Instruction.@"VSQDMULL2 Scalarvector";
    }
    // VSUQADDScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000000011100000000000) {
        return Instruction.@"VSUQADD Scalar";
    }
    // VSQABSScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000000111100000000000) {
        return Instruction.@"VSQABS Scalar";
    }
    // VCMGTScalar (zero)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000001000100000000000) {
        return Instruction.@"VCMGT Scalarzero";
    }
    // VCMEQScalar (zero)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000001001100000000000) {
        return Instruction.@"VCMEQ Scalarzero";
    }
    // VCMLTScalar (zero)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000001010100000000000) {
        return Instruction.@"VCMLT Scalarzero";
    }
    // VABSScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000001011100000000000) {
        return Instruction.@"VABS Scalar";
    }
    // VSQXTNScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000010100100000000000) {
        return Instruction.@"VSQXTN Scalar";
    }
    // VSQXTN2Scalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001000010100100000000000) {
        return Instruction.@"VSQXTN2 Scalar";
    }
    // VFCVTNSScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110001000011010100000000000) {
        return Instruction.@"VFCVTNS Scalarvector";
    }
    // VFCVTMSScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110001000011011100000000000) {
        return Instruction.@"VFCVTMS Scalarvector";
    }
    // VFCVTASScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110001000011100100000000000) {
        return Instruction.@"VFCVTAS Scalarvector";
    }
    // VSCVTFScalar (vector_integer)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110001000011101100000000000) {
        return Instruction.@"VSCVTF Scalarvector_integer";
    }
    // VFCMGTScalar (zero)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000001100100000000000) {
        return Instruction.@"VFCMGT Scalarzero";
    }
    // VFCMEQScalar (zero)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000001101100000000000) {
        return Instruction.@"VFCMEQ Scalarzero";
    }
    // VFCMLTScalar (zero)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000001110100000000000) {
        return Instruction.@"VFCMLT Scalarzero";
    }
    // VFCVTPSScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000011010100000000000) {
        return Instruction.@"VFCVTPS Scalarvector";
    }
    // VFCVTZSScalar (vector_integer)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000011011100000000000) {
        return Instruction.@"VFCVTZS Scalarvector_integer";
    }
    // VFRECPEScalar ()
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000011101100000000000) {
        return Instruction.@"VFRECPE Scalar";
    }
    // FRECPX ()
    if ((opcode & 0b11111111101111111111110000000000) == 0b01011110101000011111100000000000) {
        return Instruction.@"FRECPX ";
    }
    // VUSQADDScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000000011100000000000) {
        return Instruction.@"VUSQADD Scalar";
    }
    // VSQNEGScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000000111100000000000) {
        return Instruction.@"VSQNEG Scalar";
    }
    // VCMGEScalar (zero)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000001000100000000000) {
        return Instruction.@"VCMGE Scalarzero";
    }
    // VCMLEScalar (zero)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000001001100000000000) {
        return Instruction.@"VCMLE Scalarzero";
    }
    // VNEGScalar (vector)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000001011100000000000) {
        return Instruction.@"VNEG Scalarvector";
    }
    // VSQXTUNScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000010010100000000000) {
        return Instruction.@"VSQXTUN Scalar";
    }
    // VSQXTUN2Scalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000010010100000000000) {
        return Instruction.@"VSQXTUN2 Scalar";
    }
    // VUQXTNScalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000010100100000000000) {
        return Instruction.@"VUQXTN Scalar";
    }
    // VUQXTN2Scalar ()
    if ((opcode & 0b11111111001111111111110000000000) == 0b01111110001000010100100000000000) {
        return Instruction.@"VUQXTN2 Scalar";
    }
    // VFCVTXNScalar ()
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000010110100000000000) {
        return Instruction.@"VFCVTXN Scalar";
    }
    // VFCVTXN2Scalar ()
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000010110100000000000) {
        return Instruction.@"VFCVTXN2 Scalar";
    }
    // VFCVTNUScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000011010100000000000) {
        return Instruction.@"VFCVTNU Scalarvector";
    }
    // VFCVTMUScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000011011100000000000) {
        return Instruction.@"VFCVTMU Scalarvector";
    }
    // VFCVTAUScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000011100100000000000) {
        return Instruction.@"VFCVTAU Scalarvector";
    }
    // VUCVTFScalar (vector_integer)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001000011101100000000000) {
        return Instruction.@"VUCVTF Scalarvector_integer";
    }
    // VFCMGEScalar (zero)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101000001100100000000000) {
        return Instruction.@"VFCMGE Scalarzero";
    }
    // VFCMLEScalar (zero)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101000001101100000000000) {
        return Instruction.@"VFCMLE Scalarzero";
    }
    // VFCVTPUScalar (vector)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101000011010100000000000) {
        return Instruction.@"VFCVTPU Scalarvector";
    }
    // VFCVTZUScalar (vector_integer)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101000011011100000000000) {
        return Instruction.@"VFCVTZU Scalarvector_integer";
    }
    // VFRSQRTEScalar ()
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101000011101100000000000) {
        return Instruction.@"VFRSQRTE Scalar";
    }
    // ADDP (scalar)
    if ((opcode & 0b11111111001111111111110000000000) == 0b01011110001100011011100000000000) {
        return Instruction.@"ADDP scalar";
    }
    // FMAXNMP (scalar)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001100001100100000000000) {
        return Instruction.@"FMAXNMP scalar";
    }
    // FADDP (scalar)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001100001101100000000000) {
        return Instruction.@"FADDP scalar";
    }
    // FMAXP (scalar)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110001100001111100000000000) {
        return Instruction.@"FMAXP scalar";
    }
    // FMINNMP (scalar)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101100001100100000000000) {
        return Instruction.@"FMINNMP scalar";
    }
    // FMINP (scalar)
    if ((opcode & 0b11111111101111111111110000000000) == 0b01111110101100001111100000000000) {
        return Instruction.@"FMINP scalar";
    }
    // VDUPScalar (element)
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000000010000000000) {
        return Instruction.@"VDUP Scalarelement";
    }
    // VSQDMLALScalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000000011000000000000) {
        return Instruction.@"VSQDMLAL Scalarby_element";
    }
    // VSQDMLAL2Scalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000000011000000000000) {
        return Instruction.@"VSQDMLAL2 Scalarby_element";
    }
    // VSQDMLSLScalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000000111000000000000) {
        return Instruction.@"VSQDMLSL Scalarby_element";
    }
    // VSQDMLSL2Scalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000000111000000000000) {
        return Instruction.@"VSQDMLSL2 Scalarby_element";
    }
    // VSQDMULLScalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000001011000000000000) {
        return Instruction.@"VSQDMULL Scalarby_element";
    }
    // VSQDMULL2Scalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000001011000000000000) {
        return Instruction.@"VSQDMULL2 Scalarby_element";
    }
    // VSQDMULHScalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000001100000000000000) {
        return Instruction.@"VSQDMULH Scalarby_element";
    }
    // VSQRDMULHScalar (by_element)
    if ((opcode & 0b11111111000000001111010000000000) == 0b01011111000000001101000000000000) {
        return Instruction.@"VSQRDMULH Scalarby_element";
    }
    // VFMLAScalar (by_element)
    if ((opcode & 0b11111111100000001111010000000000) == 0b01011111100000000001000000000000) {
        return Instruction.@"VFMLA Scalarby_element";
    }
    // VFMLSScalar (by_element)
    if ((opcode & 0b11111111100000001111010000000000) == 0b01011111100000000101000000000000) {
        return Instruction.@"VFMLS Scalarby_element";
    }
    // VFMULScalar (by_element)
    if ((opcode & 0b11111111100000001111010000000000) == 0b01011111100000001001000000000000) {
        return Instruction.@"VFMUL Scalarby_element";
    }
    // VFMULXScalar (by_element)
    if ((opcode & 0b11111111100000001111010000000000) == 0b01111111100000001001000000000000) {
        return Instruction.@"VFMULX Scalarby_element";
    }
    // VSSHRScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000000010000000000) {
        return Instruction.@"VSSHR Scalar";
    }
    // VSSRAScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000001010000000000) {
        return Instruction.@"VSSRA Scalar";
    }
    // VSRSHRScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000010010000000000) {
        return Instruction.@"VSRSHR Scalar";
    }
    // VSRSRAScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000011010000000000) {
        return Instruction.@"VSRSRA Scalar";
    }
    // VSHLScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000101010000000000) {
        return Instruction.@"VSHL Scalar";
    }
    // VSQSHLScalar (immediate)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000000111010000000000) {
        return Instruction.@"VSQSHL Scalarimmediate";
    }
    // VSQSHRNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001001010000000000) {
        return Instruction.@"VSQSHRN Scalar";
    }
    // VSQSHRN2Scalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001001010000000000) {
        return Instruction.@"VSQSHRN2 Scalar";
    }
    // VSQRSHRNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001001110000000000) {
        return Instruction.@"VSQRSHRN Scalar";
    }
    // VSQRSHRN2Scalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001001110000000000) {
        return Instruction.@"VSQRSHRN2 Scalar";
    }
    // VSCVTFScalar (vector_fixed_point)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001110010000000000) {
        return Instruction.@"VSCVTF Scalarvector_fixed_point";
    }
    // VFCVTZSScalar (vector_fixed_point)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01011111000000001111110000000000) {
        return Instruction.@"VFCVTZS Scalarvector_fixed_point";
    }
    // VUSHRScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000000010000000000) {
        return Instruction.@"VUSHR Scalar";
    }
    // VUSRAScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000001010000000000) {
        return Instruction.@"VUSRA Scalar";
    }
    // VURSHRScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000010010000000000) {
        return Instruction.@"VURSHR Scalar";
    }
    // VURSRAScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000011010000000000) {
        return Instruction.@"VURSRA Scalar";
    }
    // VSRIScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000100010000000000) {
        return Instruction.@"VSRI Scalar";
    }
    // VSLIScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000101010000000000) {
        return Instruction.@"VSLI Scalar";
    }
    // VSQSHLUScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000110010000000000) {
        return Instruction.@"VSQSHLU Scalar";
    }
    // VUQSHLScalar (immediate)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000000111010000000000) {
        return Instruction.@"VUQSHL Scalarimmediate";
    }
    // VSQSHRUNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001000010000000000) {
        return Instruction.@"VSQSHRUN Scalar";
    }
    // VSQSHRUN2Scalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001000010000000000) {
        return Instruction.@"VSQSHRUN2 Scalar";
    }
    // VSQRSHRUNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001000110000000000) {
        return Instruction.@"VSQRSHRUN Scalar";
    }
    // VSQRSHRUN2Scalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001000110000000000) {
        return Instruction.@"VSQRSHRUN2 Scalar";
    }
    // VUQSHRNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001001010000000000) {
        return Instruction.@"VUQSHRN Scalar";
    }
    // VUQRSHRNScalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001001110000000000) {
        return Instruction.@"VUQRSHRN Scalar";
    }
    // VUQRSHRN2Scalar ()
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001001110000000000) {
        return Instruction.@"VUQRSHRN2 Scalar";
    }
    // VUCVTFScalar (vector_fixed_point)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001110010000000000) {
        return Instruction.@"VUCVTF Scalarvector_fixed_point";
    }
    // VFCVTZUScalar (vector_fixed_point)
    if ((opcode & 0b11111111100000001111110000000000) == 0b01111111000000001111110000000000) {
        return Instruction.@"VFCVTZU Scalarvector_fixed_point";
    }
    // SHA1C ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000000000000000000) {
        return Instruction.@"SHA1C ";
    }
    // SHA1P ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000001000000000000) {
        return Instruction.@"SHA1P ";
    }
    // SHA1M ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000010000000000000) {
        return Instruction.@"SHA1M ";
    }
    // SHA1SU0 ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000011000000000000) {
        return Instruction.@"SHA1SU0 ";
    }
    // SHA256H ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000100000000000000) {
        return Instruction.@"SHA256H ";
    }
    // SHA256H2 ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000101000000000000) {
        return Instruction.@"SHA256H2 ";
    }
    // SHA256SU1 ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01011110000000000110000000000000) {
        return Instruction.@"SHA256SU1 ";
    }
    // SHA1H ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011110001010000000100000000000) {
        return Instruction.@"SHA1H ";
    }
    // SHA1SU1 ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011110001010000001100000000000) {
        return Instruction.@"SHA1SU1 ";
    }
    // SHA256SU0 ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01011110001010000010100000000000) {
        return Instruction.@"SHA256SU0 ";
    }
    // AESE ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01001110001010000100100000000000) {
        return Instruction.@"AESE ";
    }
    // AESD ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01001110001010000101100000000000) {
        return Instruction.@"AESD ";
    }
    // AESMC ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01001110001010000110100000000000) {
        return Instruction.@"AESMC ";
    }
    // AESIMC ()
    if ((opcode & 0b11111111111111111111110000000000) == 0b01001110001010000111100000000000) {
        return Instruction.@"AESIMC ";
    }
    // SHADD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000000010000000000) {
        return Instruction.@"SHADD ";
    }
    // VSQADDVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000000110000000000) {
        return Instruction.@"VSQADD Vector";
    }
    // SRHADD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000001010000000000) {
        return Instruction.@"SRHADD ";
    }
    // SHSUB ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000010010000000000) {
        return Instruction.@"SHSUB ";
    }
    // VSQSUBVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000010110000000000) {
        return Instruction.@"VSQSUB Vector";
    }
    // VCMGTVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000011010000000000) {
        return Instruction.@"VCMGT Vectorregister";
    }
    // VCMGEVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000011110000000000) {
        return Instruction.@"VCMGE Vectorregister";
    }
    // SSHL Vector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000100010000000000) {
        return Instruction.@"SSHL Vector ";
    }
    // VSQSHLVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000100110000000000) {
        return Instruction.@"VSQSHL Vectorregister";
    }
    // VSRSHLVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000101010000000000) {
        return Instruction.@"VSRSHL Vector";
    }
    // VSQRSHLVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000101110000000000) {
        return Instruction.@"VSQRSHL Vector";
    }
    // SMAX ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000110010000000000) {
        return Instruction.@"SMAX ";
    }
    // SMIN ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000110110000000000) {
        return Instruction.@"SMIN ";
    }
    // SABD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000111010000000000) {
        return Instruction.@"SABD ";
    }
    // SABA ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000000111110000000000) {
        return Instruction.@"SABA ";
    }
    // VADDVector (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001000010000000000) {
        return Instruction.@"VADD Vectorvector";
    }
    // VCMTSTVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001000110000000000) {
        return Instruction.@"VCMTST Vector";
    }
    // MLA (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001001010000000000) {
        return Instruction.@"MLA vector";
    }
    // MUL (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001001110000000000) {
        return Instruction.@"MUL vector";
    }
    // SMAXP ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001010010000000000) {
        return Instruction.@"SMAXP ";
    }
    // SMINP ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001010110000000000) {
        return Instruction.@"SMINP ";
    }
    // VSQDMULHVector (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001011010000000000) {
        return Instruction.@"VSQDMULH Vectorvector";
    }
    // ADDP (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110001000001011110000000000) {
        return Instruction.@"ADDP vector";
    }
    // FMAXNM (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001100010000000000) {
        return Instruction.@"FMAXNM vector";
    }
    // FMLA (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001100110000000000) {
        return Instruction.@"FMLA vector";
    }
    // FADD (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001101010000000000) {
        return Instruction.@"FADD vector";
    }
    // VFMULXVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001101110000000000) {
        return Instruction.@"VFMULX Vector";
    }
    // VFCMEQVector (register)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001110010000000000) {
        return Instruction.@"VFCMEQ Vectorregister";
    }
    // FMAX (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001111010000000000) {
        return Instruction.@"FMAX vector";
    }
    // VFRECPSVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110001000001111110000000000) {
        return Instruction.@"VFRECPS Vector";
    }
    // AND (vector)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110001000000001110000000000) {
        return Instruction.@"AND vector";
    }
    // BIC (vector_register)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110011000000001110000000000) {
        return Instruction.@"BIC vector_register";
    }
    // FMINNM (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110101000001100010000000000) {
        return Instruction.@"FMINNM vector";
    }
    // FMLS (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110101000001100110000000000) {
        return Instruction.@"FMLS vector";
    }
    // FSUB (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110101000001101010000000000) {
        return Instruction.@"FSUB vector";
    }
    // FMIN (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110101000001111010000000000) {
        return Instruction.@"FMIN vector";
    }
    // VFRSQRTSVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00001110101000001111110000000000) {
        return Instruction.@"VFRSQRTS Vector";
    }
    // ORR (vector_register)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110101000000001110000000000) {
        return Instruction.@"ORR vector_register";
    }
    // ORN (vector)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110111000000001110000000000) {
        return Instruction.@"ORN vector";
    }
    // UHADD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000000010000000000) {
        return Instruction.@"UHADD ";
    }
    // VUQADDVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000000110000000000) {
        return Instruction.@"VUQADD Vector";
    }
    // URHADD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000001010000000000) {
        return Instruction.@"URHADD ";
    }
    // UHSUB ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000010010000000000) {
        return Instruction.@"UHSUB ";
    }
    // VUQSUBVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000010110000000000) {
        return Instruction.@"VUQSUB Vector";
    }
    // VCMHIVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000011010000000000) {
        return Instruction.@"VCMHI Vectorregister";
    }
    // VCMHSVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000011110000000000) {
        return Instruction.@"VCMHS Vectorregister";
    }
    // VUSHLVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000100010000000000) {
        return Instruction.@"VUSHL Vector";
    }
    // VUQSHLVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000100110000000000) {
        return Instruction.@"VUQSHL Vectorregister";
    }
    // VURSHLVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000101010000000000) {
        return Instruction.@"VURSHL Vector";
    }
    // VUQRSHLVector ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000101110000000000) {
        return Instruction.@"VUQRSHL Vector";
    }
    // UMAX ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000110010000000000) {
        return Instruction.@"UMAX ";
    }
    // UMIN ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000110110000000000) {
        return Instruction.@"UMIN ";
    }
    // UABD ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000111010000000000) {
        return Instruction.@"UABD ";
    }
    // UABA ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000000111110000000000) {
        return Instruction.@"UABA ";
    }
    // VSUBVector (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001000010000000000) {
        return Instruction.@"VSUB Vectorvector";
    }
    // VCMEQVector (register)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001000110000000000) {
        return Instruction.@"VCMEQ Vectorregister";
    }
    // MLS (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001001010000000000) {
        return Instruction.@"MLS vector";
    }
    // PMUL ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001001110000000000) {
        return Instruction.@"PMUL ";
    }
    // UMAXP ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001010010000000000) {
        return Instruction.@"UMAXP ";
    }
    // UMINP ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001010110000000000) {
        return Instruction.@"UMINP ";
    }
    // VSQRDMULHVector (vector)
    if ((opcode & 0b10111111001000001111110000000000) == 0b00101110001000001011010000000000) {
        return Instruction.@"VSQRDMULH Vectorvector";
    }
    // FMAXNMP (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001100010000000000) {
        return Instruction.@"FMAXNMP vector";
    }
    // FADDP (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001101010000000000) {
        return Instruction.@"FADDP vector";
    }
    // FMUL (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001101110000000000) {
        return Instruction.@"FMUL vector";
    }
    // VFCMGEVector (register)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001110010000000000) {
        return Instruction.@"VFCMGE Vectorregister";
    }
    // VFACGEVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001110110000000000) {
        return Instruction.@"VFACGE Vector";
    }
    // FMAXP (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001111010000000000) {
        return Instruction.@"FMAXP vector";
    }
    // FDIV (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110001000001111110000000000) {
        return Instruction.@"FDIV vector";
    }
    // EOR (vector)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00101110001000000001110000000000) {
        return Instruction.@"EOR vector";
    }
    // BSL ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00101110011000000001110000000000) {
        return Instruction.@"BSL ";
    }
    // FMINNMP (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110101000001100010000000000) {
        return Instruction.@"FMINNMP vector";
    }
    // VFABDVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110101000001101010000000000) {
        return Instruction.@"VFABD Vector";
    }
    // VFCMGTVector (register)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110101000001110010000000000) {
        return Instruction.@"VFCMGT Vectorregister";
    }
    // VFACGTVector ()
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110101000001110110000000000) {
        return Instruction.@"VFACGT Vector";
    }
    // FMINP (vector)
    if ((opcode & 0b10111111101000001111110000000000) == 0b00101110101000001111010000000000) {
        return Instruction.@"FMINP vector";
    }
    // BIT ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00101110101000000001110000000000) {
        return Instruction.@"BIT ";
    }
    // BIF ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00101110111000000001110000000000) {
        return Instruction.@"BIF ";
    }
    // SADDL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000000000000000000) {
        return Instruction.@"SADDL ";
    }
    // SADDL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000000000000000000) {
        return Instruction.@"SADDL2 ";
    }
    // SADDW ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000001000000000000) {
        return Instruction.@"SADDW ";
    }
    // SADDW2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000001000000000000) {
        return Instruction.@"SADDW2 ";
    }
    // SSUBL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000010000000000000) {
        return Instruction.@"SSUBL ";
    }
    // SSUBL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000010000000000000) {
        return Instruction.@"SSUBL2 ";
    }
    // SSUBW ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000011000000000000) {
        return Instruction.@"SSUBW ";
    }
    // SSUBW2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000011000000000000) {
        return Instruction.@"SSUBW2 ";
    }
    // ADDHN ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000100000000000000) {
        return Instruction.@"ADDHN ";
    }
    // ADDHN2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000100000000000000) {
        return Instruction.@"ADDHN2 ";
    }
    // SABAL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000101000000000000) {
        return Instruction.@"SABAL ";
    }
    // SABAL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000101000000000000) {
        return Instruction.@"SABAL2 ";
    }
    // SUBHN ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000110000000000000) {
        return Instruction.@"SUBHN ";
    }
    // SUBHN2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000110000000000000) {
        return Instruction.@"SUBHN2 ";
    }
    // SABDL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000000111000000000000) {
        return Instruction.@"SABDL ";
    }
    // SABDL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000000111000000000000) {
        return Instruction.@"SABDL2 ";
    }
    // SMLAL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001000000000000000) {
        return Instruction.@"SMLAL vector";
    }
    // SMLAL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001000000000000000) {
        return Instruction.@"SMLAL2 vector";
    }
    // VSQDMLALVector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001001000000000000) {
        return Instruction.@"VSQDMLAL Vectorvector";
    }
    // VSQDMLAL2Vector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001001000000000000) {
        return Instruction.@"VSQDMLAL2 Vectorvector";
    }
    // SMLSL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001010000000000000) {
        return Instruction.@"SMLSL vector";
    }
    // SMLSL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001010000000000000) {
        return Instruction.@"SMLSL2 vector";
    }
    // VSQDMLSLVector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001011000000000000) {
        return Instruction.@"VSQDMLSL Vectorvector";
    }
    // VSQDMLSL2Vector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001011000000000000) {
        return Instruction.@"VSQDMLSL2 Vectorvector";
    }
    // SMULL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001100000000000000) {
        return Instruction.@"SMULL vector";
    }
    // SMULL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001100000000000000) {
        return Instruction.@"SMULL2 vector";
    }
    // VSQDMULLVector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001101000000000000) {
        return Instruction.@"VSQDMULL Vectorvector";
    }
    // VSQDMULL2Vector (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001101000000000000) {
        return Instruction.@"VSQDMULL2 Vectorvector";
    }
    // PMULL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00001110001000001110000000000000) {
        return Instruction.@"PMULL ";
    }
    // PMULL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01001110001000001110000000000000) {
        return Instruction.@"PMULL2 ";
    }
    // UADDL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000000000000000000) {
        return Instruction.@"UADDL ";
    }
    // UADDL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000000000000000000) {
        return Instruction.@"UADDL2 ";
    }
    // UADDW ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000001000000000000) {
        return Instruction.@"UADDW ";
    }
    // UADDW2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000001000000000000) {
        return Instruction.@"UADDW2 ";
    }
    // USUBL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000010000000000000) {
        return Instruction.@"USUBL ";
    }
    // USUBL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000010000000000000) {
        return Instruction.@"USUBL2 ";
    }
    // USUBW ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000011000000000000) {
        return Instruction.@"USUBW ";
    }
    // USUBW2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000011000000000000) {
        return Instruction.@"USUBW2 ";
    }
    // RADDHN ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000100000000000000) {
        return Instruction.@"RADDHN ";
    }
    // RADDHN2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000100000000000000) {
        return Instruction.@"RADDHN2 ";
    }
    // UABAL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000101000000000000) {
        return Instruction.@"UABAL ";
    }
    // UABAL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000101000000000000) {
        return Instruction.@"UABAL2 ";
    }
    // RSUBHN ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000110000000000000) {
        return Instruction.@"RSUBHN ";
    }
    // RSUBHN2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000110000000000000) {
        return Instruction.@"RSUBHN2 ";
    }
    // UABDL ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000000111000000000000) {
        return Instruction.@"UABDL ";
    }
    // UABDL2 ()
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000000111000000000000) {
        return Instruction.@"UABDL2 ";
    }
    // UMLAL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000001000000000000000) {
        return Instruction.@"UMLAL vector";
    }
    // UMLAL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000001000000000000000) {
        return Instruction.@"UMLAL2 vector";
    }
    // UMLSL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000001010000000000000) {
        return Instruction.@"UMLSL vector";
    }
    // UMLSL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000001010000000000000) {
        return Instruction.@"UMLSL2 vector";
    }
    // UMULL (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b00101110001000001100000000000000) {
        return Instruction.@"UMULL vector";
    }
    // UMULL2 (vector)
    if ((opcode & 0b11111111001000001111110000000000) == 0b01101110001000001100000000000000) {
        return Instruction.@"UMULL2 vector";
    }
    // REV64 ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000000100000000000) {
        return Instruction.@"REV64 ";
    }
    // REV16 (vector)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000001100000000000) {
        return Instruction.@"REV16 vector";
    }
    // SADDLP ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000010100000000000) {
        return Instruction.@"SADDLP ";
    }
    // VSUQADDVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000011100000000000) {
        return Instruction.@"VSUQADD Vector";
    }
    // CLS (vector)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000100100000000000) {
        return Instruction.@"CLS vector";
    }
    // CNT ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000101100000000000) {
        return Instruction.@"CNT ";
    }
    // SADALP ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000110100000000000) {
        return Instruction.@"SADALP ";
    }
    // VSQABSVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000000111100000000000) {
        return Instruction.@"VSQABS Vector";
    }
    // VCMGTVector (zero)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000001000100000000000) {
        return Instruction.@"VCMGT Vectorzero";
    }
    // VCMEQVector (zero)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000001001100000000000) {
        return Instruction.@"VCMEQ Vectorzero";
    }
    // VCMLTVector (zero)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000001010100000000000) {
        return Instruction.@"VCMLT Vectorzero";
    }
    // VABSVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000001011100000000000) {
        return Instruction.@"VABS Vector";
    }
    // XTN ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000010010100000000000) {
        return Instruction.@"XTN ";
    }
    // XTN2 ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000010010100000000000) {
        return Instruction.@"XTN2 ";
    }
    // VSQXTNVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000010100100000000000) {
        return Instruction.@"VSQXTN Vector";
    }
    // VSQXTN2Vector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001000010100100000000000) {
        return Instruction.@"VSQXTN2 Vector";
    }
    // FCVTN ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000010110100000000000) {
        return Instruction.@"FCVTN ";
    }
    // FCVTN2 ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000010110100000000000) {
        return Instruction.@"FCVTN2 ";
    }
    // FCVTL ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000010111100000000000) {
        return Instruction.@"FCVTL ";
    }
    // FCVTL2 ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000010111100000000000) {
        return Instruction.@"FCVTL2 ";
    }
    // FRINTN (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011000100000000000) {
        return Instruction.@"FRINTN vector";
    }
    // FRINTM (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011001100000000000) {
        return Instruction.@"FRINTM vector";
    }
    // VFCVTNSVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011010100000000000) {
        return Instruction.@"VFCVTNS Vectorvector";
    }
    // VFCVTMSVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011011100000000000) {
        return Instruction.@"VFCVTMS Vectorvector";
    }
    // VFCVTASVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011100100000000000) {
        return Instruction.@"VFCVTAS Vectorvector";
    }
    // VSCVTFVector (vector_integer)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110001000011101100000000000) {
        return Instruction.@"VSCVTF Vectorvector_integer";
    }
    // VFCMGTVector (zero)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000001100100000000000) {
        return Instruction.@"VFCMGT Vectorzero";
    }
    // VFCMEQVector (zero)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000001101100000000000) {
        return Instruction.@"VFCMEQ Vectorzero";
    }
    // VFCMLTVector (zero)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000001110100000000000) {
        return Instruction.@"VFCMLT Vectorzero";
    }
    // FABS (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000001111100000000000) {
        return Instruction.@"FABS vector";
    }
    // FRINTP (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011000100000000000) {
        return Instruction.@"FRINTP vector";
    }
    // FRINTZ (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011001100000000000) {
        return Instruction.@"FRINTZ vector";
    }
    // VFCVTPSVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011010100000000000) {
        return Instruction.@"VFCVTPS Vectorvector";
    }
    // VFCVTZSVector (vector_integer)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011011100000000000) {
        return Instruction.@"VFCVTZS Vectorvector_integer";
    }
    // URECPE ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011100100000000000) {
        return Instruction.@"URECPE ";
    }
    // VFRECPEVector ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00001110101000011101100000000000) {
        return Instruction.@"VFRECPE Vector";
    }
    // REV32 (vector)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000000100000000000) {
        return Instruction.@"REV32 vector";
    }
    // UADDLP ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000010100000000000) {
        return Instruction.@"UADDLP ";
    }
    // VUSQADDVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000011100000000000) {
        return Instruction.@"VUSQADD Vector";
    }
    // CLZ (vector)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000100100000000000) {
        return Instruction.@"CLZ vector";
    }
    // UADALP ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000110100000000000) {
        return Instruction.@"UADALP ";
    }
    // VSQNEGVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000000111100000000000) {
        return Instruction.@"VSQNEG Vector";
    }
    // VCMGEVector (zero)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000001000100000000000) {
        return Instruction.@"VCMGE Vectorzero";
    }
    // VCMLEVector (zero)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000001001100000000000) {
        return Instruction.@"VCMLE Vectorzero";
    }
    // VNEGVector (vector)
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000001011100000000000) {
        return Instruction.@"VNEG Vectorvector";
    }
    // VSQXTUNVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010010100000000000) {
        return Instruction.@"VSQXTUN Vector";
    }
    // VSQXTUN2Vector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010010100000000000) {
        return Instruction.@"VSQXTUN2 Vector";
    }
    // SHLL ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010011100000000000) {
        return Instruction.@"SHLL ";
    }
    // SHLL2 ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010011100000000000) {
        return Instruction.@"SHLL2 ";
    }
    // VUQXTNVector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010100100000000000) {
        return Instruction.@"VUQXTN Vector";
    }
    // VUQXTN2Vector ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001000010100100000000000) {
        return Instruction.@"VUQXTN2 Vector";
    }
    // VFCVTXNVector ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000010110100000000000) {
        return Instruction.@"VFCVTXN Vector";
    }
    // VFCVTXN2Vector ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000010110100000000000) {
        return Instruction.@"VFCVTXN2 Vector";
    }
    // FRINTA (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011000100000000000) {
        return Instruction.@"FRINTA vector";
    }
    // FRINTX (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011001100000000000) {
        return Instruction.@"FRINTX vector";
    }
    // VFCVTNUVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011010100000000000) {
        return Instruction.@"VFCVTNU Vectorvector";
    }
    // VFCVTMUVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011011100000000000) {
        return Instruction.@"VFCVTMU Vectorvector";
    }
    // VFCVTAUVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011100100000000000) {
        return Instruction.@"VFCVTAU Vectorvector";
    }
    // VUCVTFVector (vector_integer)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001000011101100000000000) {
        return Instruction.@"VUCVTF Vectorvector_integer";
    }
    // NOT ()
    if ((opcode & 0b10111111111111111111110000000000) == 0b00101110001000000101100000000000) {
        return Instruction.@"NOT ";
    }
    // RBIT (vector)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00101110011000000101100000000000) {
        return Instruction.@"RBIT vector";
    }
    // VFCMGEVector (zero)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000001100100000000000) {
        return Instruction.@"VFCMGE Vectorzero";
    }
    // VFCMLEVector (zero)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000001101100000000000) {
        return Instruction.@"VFCMLE Vectorzero";
    }
    // FNEG (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000001111100000000000) {
        return Instruction.@"FNEG vector";
    }
    // FRINTI (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011001100000000000) {
        return Instruction.@"FRINTI vector";
    }
    // VFCVTPUVector (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011010100000000000) {
        return Instruction.@"VFCVTPU Vectorvector";
    }
    // VFCVTZUVector (vector_integer)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011011100000000000) {
        return Instruction.@"VFCVTZU Vectorvector_integer";
    }
    // URSQRTE ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011100100000000000) {
        return Instruction.@"URSQRTE ";
    }
    // VFRSQRTEVector ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011101100000000000) {
        return Instruction.@"VFRSQRTE Vector";
    }
    // FSQRT (vector)
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101000011111100000000000) {
        return Instruction.@"FSQRT vector";
    }
    // SADDLV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001100000011100000000000) {
        return Instruction.@"SADDLV ";
    }
    // SMAXV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001100001010100000000000) {
        return Instruction.@"SMAXV ";
    }
    // SMINV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001100011010100000000000) {
        return Instruction.@"SMINV ";
    }
    // ADDV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00001110001100011011100000000000) {
        return Instruction.@"ADDV ";
    }
    // UADDLV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001100000011100000000000) {
        return Instruction.@"UADDLV ";
    }
    // UMAXV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001100001010100000000000) {
        return Instruction.@"UMAXV ";
    }
    // UMINV ()
    if ((opcode & 0b10111111001111111111110000000000) == 0b00101110001100011010100000000000) {
        return Instruction.@"UMINV ";
    }
    // FMAXNMV ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001100001100100000000000) {
        return Instruction.@"FMAXNMV ";
    }
    // FMAXV ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110001100001111100000000000) {
        return Instruction.@"FMAXV ";
    }
    // FMINNMV ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101100001100100000000000) {
        return Instruction.@"FMINNMV ";
    }
    // FMINV ()
    if ((opcode & 0b10111111101111111111110000000000) == 0b00101110101100001111100000000000) {
        return Instruction.@"FMINV ";
    }
    // VDUPVector (element)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000000010000000000) {
        return Instruction.@"VDUP Vectorelement";
    }
    // DUP (general)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000000110000000000) {
        return Instruction.@"DUP general";
    }
    // VSMOV32_bit ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00001110000000000010110000000000) {
        return Instruction.@"VSMOV 32_bit";
    }
    // VUMOV32_bit ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b00001110000000000011110000000000) {
        return Instruction.@"VUMOV 32_bit";
    }
    // INS (general)
    if ((opcode & 0b11111111111000001111110000000000) == 0b01001110000000000001110000000000) {
        return Instruction.@"INS general";
    }
    // VSMOV64_bit ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01001110000000000010110000000000) {
        return Instruction.@"VSMOV 64_bit";
    }
    // VUMOV64_bit ()
    if ((opcode & 0b11111111111000001111110000000000) == 0b01001110000000000011110000000000) {
        return Instruction.@"VUMOV 64_bit";
    }
    // INS (element)
    if ((opcode & 0b11111111111000001000010000000000) == 0b01101110000000000000010000000000) {
        return Instruction.@"INS element";
    }
    // SMLAL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000010000000000000) {
        return Instruction.@"SMLAL by_element";
    }
    // SMLAL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000010000000000000) {
        return Instruction.@"SMLAL2 by_element";
    }
    // VSQDMLALVector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000011000000000000) {
        return Instruction.@"VSQDMLAL Vectorby_element";
    }
    // VSQDMLAL2Vector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000011000000000000) {
        return Instruction.@"VSQDMLAL2 Vectorby_element";
    }
    // SMLSL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000110000000000000) {
        return Instruction.@"SMLSL by_element";
    }
    // SMLSL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000110000000000000) {
        return Instruction.@"SMLSL2 by_element";
    }
    // VSQDMLSLVector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000111000000000000) {
        return Instruction.@"VSQDMLSL Vectorby_element";
    }
    // VSQDMLSL2Vector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000000111000000000000) {
        return Instruction.@"VSQDMLSL2 Vectorby_element";
    }
    // MUL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001000000000000000) {
        return Instruction.@"MUL by_element";
    }
    // SMULL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001010000000000000) {
        return Instruction.@"SMULL by_element";
    }
    // SMULL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001010000000000000) {
        return Instruction.@"SMULL2 by_element";
    }
    // VSQDMULLVector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001011000000000000) {
        return Instruction.@"VSQDMULL Vectorby_element";
    }
    // VSQDMULL2Vector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001011000000000000) {
        return Instruction.@"VSQDMULL2 Vectorby_element";
    }
    // VSQDMULHVector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001100000000000000) {
        return Instruction.@"VSQDMULH Vectorby_element";
    }
    // VSQRDMULHVector (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00001111000000001101000000000000) {
        return Instruction.@"VSQRDMULH Vectorby_element";
    }
    // VFMLAVector (by_element)
    if ((opcode & 0b10111111100000001111010000000000) == 0b00001111100000000001000000000000) {
        return Instruction.@"VFMLA Vectorby_element";
    }
    // VFMLSVector (by_element)
    if ((opcode & 0b10111111100000001111010000000000) == 0b00001111100000000101000000000000) {
        return Instruction.@"VFMLS Vectorby_element";
    }
    // VFMULVector (by_element)
    if ((opcode & 0b10111111100000001111010000000000) == 0b00001111100000001001000000000000) {
        return Instruction.@"VFMUL Vectorby_element";
    }
    // MLA (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000000000000000000) {
        return Instruction.@"MLA by_element";
    }
    // UMLAL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000010000000000000) {
        return Instruction.@"UMLAL by_element";
    }
    // UMLAL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000010000000000000) {
        return Instruction.@"UMLAL2 by_element";
    }
    // MLS (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000100000000000000) {
        return Instruction.@"MLS by_element";
    }
    // UMLSL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000110000000000000) {
        return Instruction.@"UMLSL by_element";
    }
    // UMLSL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000000110000000000000) {
        return Instruction.@"UMLSL2 by_element";
    }
    // UMULL (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000001010000000000000) {
        return Instruction.@"UMULL by_element";
    }
    // UMULL2 (by_element)
    if ((opcode & 0b10111111000000001111010000000000) == 0b00101111000000001010000000000000) {
        return Instruction.@"UMULL2 by_element";
    }
    // VFMULXVector (by_element)
    if ((opcode & 0b10111111100000001111010000000000) == 0b00101111100000001001000000000000) {
        return Instruction.@"VFMULX Vectorby_element";
    }
    // VMOVI32_bit_shifted_immediate ()
    if ((opcode & 0b10111111111110001001110000000000) == 0b00001111000000000000010000000000) {
        return Instruction.@"VMOVI 32_bit_shifted_immediate";
    }
    // VORR32_bit (vector_immediate)
    if ((opcode & 0b10111111111110001001110000000000) == 0b00001111000000000001010000000000) {
        return Instruction.@"VORR 32_bitvector_immediate";
    }
    // VMOVI16_bit_shifted_immediate ()
    if ((opcode & 0b10111111111110001101110000000000) == 0b00001111000000001000010000000000) {
        return Instruction.@"VMOVI 16_bit_shifted_immediate";
    }
    // VORR16_bit (vector_immediate)
    if ((opcode & 0b10111111111110001101110000000000) == 0b00001111000000001001010000000000) {
        return Instruction.@"VORR 16_bitvector_immediate";
    }
    // VMOVI32_bit_shifting_ones ()
    if ((opcode & 0b10111111111110001110110000000000) == 0b00001111000000001100010000000000) {
        return Instruction.@"VMOVI 32_bit_shifting_ones";
    }
    // VMOVI8_bit ()
    if ((opcode & 0b10111111111110001111110000000000) == 0b00001111000000001110010000000000) {
        return Instruction.@"VMOVI 8_bit";
    }
    // VFMOVSingle_precision (vector_immediate)
    if ((opcode & 0b10111111111110001111110000000000) == 0b00001111000000001111010000000000) {
        return Instruction.@"VFMOV Single_precisionvector_immediate";
    }
    // VMVNI32_bit_shifted_immediate ()
    if ((opcode & 0b10111111111110001001110000000000) == 0b00101111000000000000010000000000) {
        return Instruction.@"VMVNI 32_bit_shifted_immediate";
    }
    // VBIC32_bit (vector_immediate)
    if ((opcode & 0b10111111111110001001110000000000) == 0b00101111000000000001010000000000) {
        return Instruction.@"VBIC 32_bitvector_immediate";
    }
    // VMVNI16_bit_shifted_immediate ()
    if ((opcode & 0b10111111111110001101110000000000) == 0b00101111000000001000010000000000) {
        return Instruction.@"VMVNI 16_bit_shifted_immediate";
    }
    // VBIC16_bit (vector_immediate)
    if ((opcode & 0b10111111111110001101110000000000) == 0b00101111000000001001010000000000) {
        return Instruction.@"VBIC 16_bitvector_immediate";
    }
    // VMVNI32_bit_shifting_ones ()
    if ((opcode & 0b10111111111110001110110000000000) == 0b00101111000000001100010000000000) {
        return Instruction.@"VMVNI 32_bit_shifting_ones";
    }
    // VMOVI64_bit_scalar ()
    if ((opcode & 0b11111111111110001111110000000000) == 0b00101111000000001110010000000000) {
        return Instruction.@"VMOVI 64_bit_scalar";
    }
    // VMOVI64_bit_vector ()
    if ((opcode & 0b11111111111110001111110000000000) == 0b01101111000000001110010000000000) {
        return Instruction.@"VMOVI 64_bit_vector";
    }
    // VFMOVDouble_precision (vector_immediate)
    if ((opcode & 0b11111111111110001111110000000000) == 0b01101111000000001111010000000000) {
        return Instruction.@"VFMOV Double_precisionvector_immediate";
    }
    // VSSHRVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000000010000000000) {
        return Instruction.@"VSSHR Vector";
    }
    // VSSRAVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000001010000000000) {
        return Instruction.@"VSSRA Vector";
    }
    // VSRSHRVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000010010000000000) {
        return Instruction.@"VSRSHR Vector";
    }
    // VSRSRAVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000011010000000000) {
        return Instruction.@"VSRSRA Vector";
    }
    // VSHLVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000101010000000000) {
        return Instruction.@"VSHL Vector";
    }
    // VSQSHLVector (immediate)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000000111010000000000) {
        return Instruction.@"VSQSHL Vectorimmediate";
    }
    // SHRN ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001000010000000000) {
        return Instruction.@"SHRN ";
    }
    // SHRN2 ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001000010000000000) {
        return Instruction.@"SHRN2 ";
    }
    // RSHRN ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001000110000000000) {
        return Instruction.@"RSHRN ";
    }
    // RSHRN2 ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001000110000000000) {
        return Instruction.@"RSHRN2 ";
    }
    // VSQSHRNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001001010000000000) {
        return Instruction.@"VSQSHRN Vector";
    }
    // VSQSHRN2Vector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001001010000000000) {
        return Instruction.@"VSQSHRN2 Vector";
    }
    // VSQRSHRNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001001110000000000) {
        return Instruction.@"VSQRSHRN Vector";
    }
    // VSQRSHRN2Vector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001001110000000000) {
        return Instruction.@"VSQRSHRN2 Vector";
    }
    // SSHLL ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001010010000000000) {
        return Instruction.@"SSHLL ";
    }
    // SSHLL2 ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001010010000000000) {
        return Instruction.@"SSHLL2 ";
    }
    // VSCVTFVector (vector_fixed_point)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001110010000000000) {
        return Instruction.@"VSCVTF Vectorvector_fixed_point";
    }
    // VFCVTZSVector (vector_fixed_point)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00001111000000001111110000000000) {
        return Instruction.@"VFCVTZS Vectorvector_fixed_point";
    }
    // VUSHRVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000000010000000000) {
        return Instruction.@"VUSHR Vector";
    }
    // VUSRAVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000001010000000000) {
        return Instruction.@"VUSRA Vector";
    }
    // VURSHRVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000010010000000000) {
        return Instruction.@"VURSHR Vector";
    }
    // VURSRAVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000011010000000000) {
        return Instruction.@"VURSRA Vector";
    }
    // VSRIVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000100010000000000) {
        return Instruction.@"VSRI Vector";
    }
    // VSLIVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000101010000000000) {
        return Instruction.@"VSLI Vector";
    }
    // VSQSHLUVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000110010000000000) {
        return Instruction.@"VSQSHLU Vector";
    }
    // VUQSHLVector (immediate)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000000111010000000000) {
        return Instruction.@"VUQSHL Vectorimmediate";
    }
    // VSQSHRUNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001000010000000000) {
        return Instruction.@"VSQSHRUN Vector";
    }
    // VSQSHRUN2Vector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001000010000000000) {
        return Instruction.@"VSQSHRUN2 Vector";
    }
    // VSQRSHRUNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001000110000000000) {
        return Instruction.@"VSQRSHRUN Vector";
    }
    // VSQRSHRUN2Vector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001000110000000000) {
        return Instruction.@"VSQRSHRUN2 Vector";
    }
    // VUQSHRNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001001010000000000) {
        return Instruction.@"VUQSHRN Vector";
    }
    // VUQRSHRNVector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001001110000000000) {
        return Instruction.@"VUQRSHRN Vector";
    }
    // VUQRSHRN2Vector ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001001110000000000) {
        return Instruction.@"VUQRSHRN2 Vector";
    }
    // USHLL ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001010010000000000) {
        return Instruction.@"USHLL ";
    }
    // USHLL2 ()
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001010010000000000) {
        return Instruction.@"USHLL2 ";
    }
    // VUCVTFVector (vector_fixed_point)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001110010000000000) {
        return Instruction.@"VUCVTF Vectorvector_fixed_point";
    }
    // VFCVTZUVector (vector_fixed_point)
    if ((opcode & 0b10111111100000001111110000000000) == 0b00101111000000001111110000000000) {
        return Instruction.@"VFCVTZU Vectorvector_fixed_point";
    }
    // VTBLSingle_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000000000000000000) {
        return Instruction.@"VTBL Single_register_table";
    }
    // VTBXSingle_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000001000000000000) {
        return Instruction.@"VTBX Single_register_table";
    }
    // VTBLTwo_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000010000000000000) {
        return Instruction.@"VTBL Two_register_table";
    }
    // VTBXTwo_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000011000000000000) {
        return Instruction.@"VTBX Two_register_table";
    }
    // VTBLThree_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000100000000000000) {
        return Instruction.@"VTBL Three_register_table";
    }
    // VTBXThree_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000101000000000000) {
        return Instruction.@"VTBX Three_register_table";
    }
    // VTBLFour_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000110000000000000) {
        return Instruction.@"VTBL Four_register_table";
    }
    // VTBXFour_register_table ()
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001110000000000111000000000000) {
        return Instruction.@"VTBX Four_register_table";
    }
    // UZP1 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000001100000000000) {
        return Instruction.@"UZP1 ";
    }
    // TRN1 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000010100000000000) {
        return Instruction.@"TRN1 ";
    }
    // ZIP1 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000011100000000000) {
        return Instruction.@"ZIP1 ";
    }
    // UZP2 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000101100000000000) {
        return Instruction.@"UZP2 ";
    }
    // TRN2 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000110100000000000) {
        return Instruction.@"TRN2 ";
    }
    // ZIP2 ()
    if ((opcode & 0b10111111001000001111110000000000) == 0b00001110000000000111100000000000) {
        return Instruction.@"ZIP2 ";
    }
    // EXT ()
    if ((opcode & 0b10111111111000001000010000000000) == 0b00101110000000000000000000000000) {
        return Instruction.@"EXT ";
    }
    // VST4No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000000000000000000000) {
        return Instruction.@"VST4 No_offsetmultiple_structures";
    }
    // VST1Four_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000000010000000000000) {
        return Instruction.@"VST1 Four_registersmultiple_structures";
    }
    // VST3No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000000100000000000000) {
        return Instruction.@"VST3 No_offsetmultiple_structures";
    }
    // VST1Three_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000000110000000000000) {
        return Instruction.@"VST1 Three_registersmultiple_structures";
    }
    // VST1One_register (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000000111000000000000) {
        return Instruction.@"VST1 One_registermultiple_structures";
    }
    // VST2No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000001000000000000000) {
        return Instruction.@"VST2 No_offsetmultiple_structures";
    }
    // VST1Two_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100000000001010000000000000) {
        return Instruction.@"VST1 Two_registersmultiple_structures";
    }
    // VLD4No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000000000000000000000) {
        return Instruction.@"VLD4 No_offsetmultiple_structures";
    }
    // VLD1Four_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000000010000000000000) {
        return Instruction.@"VLD1 Four_registersmultiple_structures";
    }
    // VLD3No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000000100000000000000) {
        return Instruction.@"VLD3 No_offsetmultiple_structures";
    }
    // VLD1Three_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000000110000000000000) {
        return Instruction.@"VLD1 Three_registersmultiple_structures";
    }
    // VLD1One_register (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000000111000000000000) {
        return Instruction.@"VLD1 One_registermultiple_structures";
    }
    // VLD2No_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000001000000000000000) {
        return Instruction.@"VLD2 No_offsetmultiple_structures";
    }
    // VLD1Two_registers (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100010000001010000000000000) {
        return Instruction.@"VLD1 Two_registersmultiple_structures";
    }
    // VST4Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000000000000000000000) {
        return Instruction.@"VST4 Register_offsetmultiple_structures";
    }
    // VST1Four_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000000010000000000000) {
        return Instruction.@"VST1 Four_registers_register_offsetmultiple_structures";
    }
    // VST3Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000000100000000000000) {
        return Instruction.@"VST3 Register_offsetmultiple_structures";
    }
    // VST1Three_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000000110000000000000) {
        return Instruction.@"VST1 Three_registers_register_offsetmultiple_structures";
    }
    // VST1One_register_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000000111000000000000) {
        return Instruction.@"VST1 One_register_register_offsetmultiple_structures";
    }
    // VST2Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000001000000000000000) {
        return Instruction.@"VST2 Register_offsetmultiple_structures";
    }
    // VST1Two_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100100000001010000000000000) {
        return Instruction.@"VST1 Two_registers_register_offsetmultiple_structures";
    }
    // VST4Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111110000000000000000) {
        return Instruction.@"VST4 Immediate_offsetmultiple_structures";
    }
    // VST1Four_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111110010000000000000) {
        return Instruction.@"VST1 Four_registers_immediate_offsetmultiple_structures";
    }
    // VST3Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111110100000000000000) {
        return Instruction.@"VST3 Immediate_offsetmultiple_structures";
    }
    // VST1Three_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111110110000000000000) {
        return Instruction.@"VST1 Three_registers_immediate_offsetmultiple_structures";
    }
    // VST1One_register_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111110111000000000000) {
        return Instruction.@"VST1 One_register_immediate_offsetmultiple_structures";
    }
    // VST2Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111111000000000000000) {
        return Instruction.@"VST2 Immediate_offsetmultiple_structures";
    }
    // VST1Two_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100100111111010000000000000) {
        return Instruction.@"VST1 Two_registers_immediate_offsetmultiple_structures";
    }
    // VLD4Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000000000000000000000) {
        return Instruction.@"VLD4 Register_offsetmultiple_structures";
    }
    // VLD1Four_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000000010000000000000) {
        return Instruction.@"VLD1 Four_registers_register_offsetmultiple_structures";
    }
    // VLD3Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000000100000000000000) {
        return Instruction.@"VLD3 Register_offsetmultiple_structures";
    }
    // VLD1Three_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000000110000000000000) {
        return Instruction.@"VLD1 Three_registers_register_offsetmultiple_structures";
    }
    // VLD1One_register_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000000111000000000000) {
        return Instruction.@"VLD1 One_register_register_offsetmultiple_structures";
    }
    // VLD2Register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000001000000000000000) {
        return Instruction.@"VLD2 Register_offsetmultiple_structures";
    }
    // VLD1Two_registers_register_offset (multiple_structures)
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001100110000001010000000000000) {
        return Instruction.@"VLD1 Two_registers_register_offsetmultiple_structures";
    }
    // VLD4Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111110000000000000000) {
        return Instruction.@"VLD4 Immediate_offsetmultiple_structures";
    }
    // VLD1Four_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111110010000000000000) {
        return Instruction.@"VLD1 Four_registers_immediate_offsetmultiple_structures";
    }
    // VLD3Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111110100000000000000) {
        return Instruction.@"VLD3 Immediate_offsetmultiple_structures";
    }
    // VLD1Three_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111110110000000000000) {
        return Instruction.@"VLD1 Three_registers_immediate_offsetmultiple_structures";
    }
    // VLD1One_register_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111110111000000000000) {
        return Instruction.@"VLD1 One_register_immediate_offsetmultiple_structures";
    }
    // VLD2Immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111111000000000000000) {
        return Instruction.@"VLD2 Immediate_offsetmultiple_structures";
    }
    // VLD1Two_registers_immediate_offset (multiple_structures)
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001100110111111010000000000000) {
        return Instruction.@"VLD1 Two_registers_immediate_offsetmultiple_structures";
    }
    // VST18_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101000000000000000000000000) {
        return Instruction.@"VST1 8_bitsingle_structure";
    }
    // VST38_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101000000000010000000000000) {
        return Instruction.@"VST3 8_bitsingle_structure";
    }
    // VST116_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101000000000100000000000000) {
        return Instruction.@"VST1 16_bitsingle_structure";
    }
    // VST316_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101000000000110000000000000) {
        return Instruction.@"VST3 16_bitsingle_structure";
    }
    // VST132_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101000000001000000000000000) {
        return Instruction.@"VST1 32_bitsingle_structure";
    }
    // VST164_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101000000001000010000000000) {
        return Instruction.@"VST1 64_bitsingle_structure";
    }
    // VST332_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101000000001010000000000000) {
        return Instruction.@"VST3 32_bitsingle_structure";
    }
    // VST364_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101000000001010010000000000) {
        return Instruction.@"VST3 64_bitsingle_structure";
    }
    // VST28_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101001000000000000000000000) {
        return Instruction.@"VST2 8_bitsingle_structure";
    }
    // VST48_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101001000000010000000000000) {
        return Instruction.@"VST4 8_bitsingle_structure";
    }
    // VST216_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101001000000100000000000000) {
        return Instruction.@"VST2 16_bitsingle_structure";
    }
    // VST416_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101001000000110000000000000) {
        return Instruction.@"VST4 16_bitsingle_structure";
    }
    // VST232_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101001000001000000000000000) {
        return Instruction.@"VST2 32_bitsingle_structure";
    }
    // VST264_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101001000001000010000000000) {
        return Instruction.@"VST2 64_bitsingle_structure";
    }
    // VST432_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101001000001010000000000000) {
        return Instruction.@"VST4 32_bitsingle_structure";
    }
    // VST464_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101001000001010010000000000) {
        return Instruction.@"VST4 64_bitsingle_structure";
    }
    // VLD18_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101010000000000000000000000) {
        return Instruction.@"VLD1 8_bitsingle_structure";
    }
    // VLD38_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101010000000010000000000000) {
        return Instruction.@"VLD3 8_bitsingle_structure";
    }
    // VLD116_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101010000000100000000000000) {
        return Instruction.@"VLD1 16_bitsingle_structure";
    }
    // VLD316_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101010000000110000000000000) {
        return Instruction.@"VLD3 16_bitsingle_structure";
    }
    // VLD132_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101010000001000000000000000) {
        return Instruction.@"VLD1 32_bitsingle_structure";
    }
    // VLD164_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101010000001000010000000000) {
        return Instruction.@"VLD1 64_bitsingle_structure";
    }
    // VLD332_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101010000001010000000000000) {
        return Instruction.@"VLD3 32_bitsingle_structure";
    }
    // VLD364_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101010000001010010000000000) {
        return Instruction.@"VLD3 64_bitsingle_structure";
    }
    // VLD1RNo_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101010000001100000000000000) {
        return Instruction.@"VLD1R No_offset";
    }
    // VLD3RNo_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101010000001110000000000000) {
        return Instruction.@"VLD3R No_offset";
    }
    // VLD28_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101011000000000000000000000) {
        return Instruction.@"VLD2 8_bitsingle_structure";
    }
    // VLD48_bit (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101011000000010000000000000) {
        return Instruction.@"VLD4 8_bitsingle_structure";
    }
    // VLD216_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101011000000100000000000000) {
        return Instruction.@"VLD2 16_bitsingle_structure";
    }
    // VLD416_bit (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101011000000110000000000000) {
        return Instruction.@"VLD4 16_bitsingle_structure";
    }
    // VLD232_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101011000001000000000000000) {
        return Instruction.@"VLD2 32_bitsingle_structure";
    }
    // VLD264_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101011000001000010000000000) {
        return Instruction.@"VLD2 64_bitsingle_structure";
    }
    // VLD432_bit (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101011000001010000000000000) {
        return Instruction.@"VLD4 32_bitsingle_structure";
    }
    // VLD464_bit (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101011000001010010000000000) {
        return Instruction.@"VLD4 64_bitsingle_structure";
    }
    // VLD2RNo_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101011000001100000000000000) {
        return Instruction.@"VLD2R No_offset";
    }
    // VLD4RNo_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101011000001110000000000000) {
        return Instruction.@"VLD4R No_offset";
    }
    // VST18_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101100000000000000000000000) {
        return Instruction.@"VST1 8_bit_register_offsetsingle_structure";
    }
    // VST38_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101100000000010000000000000) {
        return Instruction.@"VST3 8_bit_register_offsetsingle_structure";
    }
    // VST116_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101100000000100000000000000) {
        return Instruction.@"VST1 16_bit_register_offsetsingle_structure";
    }
    // VST316_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101100000000110000000000000) {
        return Instruction.@"VST3 16_bit_register_offsetsingle_structure";
    }
    // VST132_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101100000001000000000000000) {
        return Instruction.@"VST1 32_bit_register_offsetsingle_structure";
    }
    // VST164_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101100000001000010000000000) {
        return Instruction.@"VST1 64_bit_register_offsetsingle_structure";
    }
    // VST332_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101100000001010000000000000) {
        return Instruction.@"VST3 32_bit_register_offsetsingle_structure";
    }
    // VST364_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101100000001010010000000000) {
        return Instruction.@"VST3 64_bit_register_offsetsingle_structure";
    }
    // VST18_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101100111110000000000000000) {
        return Instruction.@"VST1 8_bit_immediate_offsetsingle_structure";
    }
    // VST38_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101100111110010000000000000) {
        return Instruction.@"VST3 8_bit_immediate_offsetsingle_structure";
    }
    // VST116_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101100111110100000000000000) {
        return Instruction.@"VST1 16_bit_immediate_offsetsingle_structure";
    }
    // VST316_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101100111110110000000000000) {
        return Instruction.@"VST3 16_bit_immediate_offsetsingle_structure";
    }
    // VST132_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101100111111000000000000000) {
        return Instruction.@"VST1 32_bit_immediate_offsetsingle_structure";
    }
    // VST164_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101100111111000010000000000) {
        return Instruction.@"VST1 64_bit_immediate_offsetsingle_structure";
    }
    // VST332_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101100111111010000000000000) {
        return Instruction.@"VST3 32_bit_immediate_offsetsingle_structure";
    }
    // VST364_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101100111111010010000000000) {
        return Instruction.@"VST3 64_bit_immediate_offsetsingle_structure";
    }
    // VST28_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101101000000000000000000000) {
        return Instruction.@"VST2 8_bit_register_offsetsingle_structure";
    }
    // VST48_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101101000000010000000000000) {
        return Instruction.@"VST4 8_bit_register_offsetsingle_structure";
    }
    // VST216_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101101000000100000000000000) {
        return Instruction.@"VST2 16_bit_register_offsetsingle_structure";
    }
    // VST416_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101101000000110000000000000) {
        return Instruction.@"VST4 16_bit_register_offsetsingle_structure";
    }
    // VST232_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101101000001000000000000000) {
        return Instruction.@"VST2 32_bit_register_offsetsingle_structure";
    }
    // VST264_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101101000001000010000000000) {
        return Instruction.@"VST2 64_bit_register_offsetsingle_structure";
    }
    // VST432_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101101000001010000000000000) {
        return Instruction.@"VST4 32_bit_register_offsetsingle_structure";
    }
    // VST464_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101101000001010010000000000) {
        return Instruction.@"VST4 64_bit_register_offsetsingle_structure";
    }
    // VST28_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101101111110000000000000000) {
        return Instruction.@"VST2 8_bit_immediate_offsetsingle_structure";
    }
    // VST48_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101101111110010000000000000) {
        return Instruction.@"VST4 8_bit_immediate_offsetsingle_structure";
    }
    // VST216_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101101111110100000000000000) {
        return Instruction.@"VST2 16_bit_immediate_offsetsingle_structure";
    }
    // VST416_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101101111110110000000000000) {
        return Instruction.@"VST4 16_bit_immediate_offsetsingle_structure";
    }
    // VST232_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101101111111000000000000000) {
        return Instruction.@"VST2 32_bit_immediate_offsetsingle_structure";
    }
    // VST264_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101101111111000010000000000) {
        return Instruction.@"VST2 64_bit_immediate_offsetsingle_structure";
    }
    // VST432_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101101111111010000000000000) {
        return Instruction.@"VST4 32_bit_immediate_offsetsingle_structure";
    }
    // VST464_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101101111111010010000000000) {
        return Instruction.@"VST4 64_bit_immediate_offsetsingle_structure";
    }
    // VLD18_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101110000000000000000000000) {
        return Instruction.@"VLD1 8_bit_register_offsetsingle_structure";
    }
    // VLD38_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101110000000010000000000000) {
        return Instruction.@"VLD3 8_bit_register_offsetsingle_structure";
    }
    // VLD116_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101110000000100000000000000) {
        return Instruction.@"VLD1 16_bit_register_offsetsingle_structure";
    }
    // VLD316_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101110000000110000000000000) {
        return Instruction.@"VLD3 16_bit_register_offsetsingle_structure";
    }
    // VLD132_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101110000001000000000000000) {
        return Instruction.@"VLD1 32_bit_register_offsetsingle_structure";
    }
    // VLD164_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101110000001000010000000000) {
        return Instruction.@"VLD1 64_bit_register_offsetsingle_structure";
    }
    // VLD332_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101110000001010000000000000) {
        return Instruction.@"VLD3 32_bit_register_offsetsingle_structure";
    }
    // VLD364_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101110000001010010000000000) {
        return Instruction.@"VLD3 64_bit_register_offsetsingle_structure";
    }
    // VLD1RRegister_offset ()
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001101110000001100000000000000) {
        return Instruction.@"VLD1R Register_offset";
    }
    // VLD3RRegister_offset ()
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001101110000001110000000000000) {
        return Instruction.@"VLD3R Register_offset";
    }
    // VLD18_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101110111110000000000000000) {
        return Instruction.@"VLD1 8_bit_immediate_offsetsingle_structure";
    }
    // VLD38_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101110111110010000000000000) {
        return Instruction.@"VLD3 8_bit_immediate_offsetsingle_structure";
    }
    // VLD116_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101110111110100000000000000) {
        return Instruction.@"VLD1 16_bit_immediate_offsetsingle_structure";
    }
    // VLD316_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101110111110110000000000000) {
        return Instruction.@"VLD3 16_bit_immediate_offsetsingle_structure";
    }
    // VLD132_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101110111111000000000000000) {
        return Instruction.@"VLD1 32_bit_immediate_offsetsingle_structure";
    }
    // VLD164_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101110111111000010000000000) {
        return Instruction.@"VLD1 64_bit_immediate_offsetsingle_structure";
    }
    // VLD332_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101110111111010000000000000) {
        return Instruction.@"VLD3 32_bit_immediate_offsetsingle_structure";
    }
    // VLD364_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101110111111010010000000000) {
        return Instruction.@"VLD3 64_bit_immediate_offsetsingle_structure";
    }
    // VLD1RImmediate_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101110111111100000000000000) {
        return Instruction.@"VLD1R Immediate_offset";
    }
    // VLD3RImmediate_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101110111111110000000000000) {
        return Instruction.@"VLD3R Immediate_offset";
    }
    // VLD28_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101111000000000000000000000) {
        return Instruction.@"VLD2 8_bit_register_offsetsingle_structure";
    }
    // VLD48_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110000000000000) == 0b00001101111000000010000000000000) {
        return Instruction.@"VLD4 8_bit_register_offsetsingle_structure";
    }
    // VLD216_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101111000000100000000000000) {
        return Instruction.@"VLD2 16_bit_register_offsetsingle_structure";
    }
    // VLD416_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110010000000000) == 0b00001101111000000110000000000000) {
        return Instruction.@"VLD4 16_bit_register_offsetsingle_structure";
    }
    // VLD232_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101111000001000000000000000) {
        return Instruction.@"VLD2 32_bit_register_offsetsingle_structure";
    }
    // VLD264_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101111000001000010000000000) {
        return Instruction.@"VLD2 64_bit_register_offsetsingle_structure";
    }
    // VLD432_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001110110000000000) == 0b00001101111000001010000000000000) {
        return Instruction.@"VLD4 32_bit_register_offsetsingle_structure";
    }
    // VLD464_bit_register_offset (single_structure)
    if ((opcode & 0b10111111111000001111110000000000) == 0b00001101111000001010010000000000) {
        return Instruction.@"VLD4 64_bit_register_offsetsingle_structure";
    }
    // VLD2RRegister_offset ()
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001101111000001100000000000000) {
        return Instruction.@"VLD2R Register_offset";
    }
    // VLD4RRegister_offset ()
    if ((opcode & 0b10111111111000001111000000000000) == 0b00001101111000001110000000000000) {
        return Instruction.@"VLD4R Register_offset";
    }
    // VLD28_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101111111110000000000000000) {
        return Instruction.@"VLD2 8_bit_immediate_offsetsingle_structure";
    }
    // VLD48_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110000000000000) == 0b00001101111111110010000000000000) {
        return Instruction.@"VLD4 8_bit_immediate_offsetsingle_structure";
    }
    // VLD216_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101111111110100000000000000) {
        return Instruction.@"VLD2 16_bit_immediate_offsetsingle_structure";
    }
    // VLD416_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110010000000000) == 0b00001101111111110110000000000000) {
        return Instruction.@"VLD4 16_bit_immediate_offsetsingle_structure";
    }
    // VLD232_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101111111111000000000000000) {
        return Instruction.@"VLD2 32_bit_immediate_offsetsingle_structure";
    }
    // VLD264_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101111111111000010000000000) {
        return Instruction.@"VLD2 64_bit_immediate_offsetsingle_structure";
    }
    // VLD432_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111110110000000000) == 0b00001101111111111010000000000000) {
        return Instruction.@"VLD4 32_bit_immediate_offsetsingle_structure";
    }
    // VLD464_bit_immediate_offset (single_structure)
    if ((opcode & 0b10111111111111111111110000000000) == 0b00001101111111111010010000000000) {
        return Instruction.@"VLD4 64_bit_immediate_offsetsingle_structure";
    }
    // VLD2RImmediate_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101111111111100000000000000) {
        return Instruction.@"VLD2R Immediate_offset";
    }
    // VLD4RImmediate_offset ()
    if ((opcode & 0b10111111111111111111000000000000) == 0b00001101111111111110000000000000) {
        return Instruction.@"VLD4R Immediate_offset";
    }
    return Instruction.@"BAD ";
}
