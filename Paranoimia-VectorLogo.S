****************************************************
*
* PARANOIMIA Vector Cracktro
*
* Code:  Pwy (Electronic Artists, NO)
* Music: TSM (Sunriders, DE)
*
* Disassembled by MnemoTroN/Spreadpoint in 2023
* using ReSource 6.06.
*
* This source resembles the original code from 1990
* without modifications to preserve the original.
*
* Load into ASM-One or Asm-Pro with "r" command,
* assemble with "a" and run intro with "j main".
*
****************************************************

; 3D starfield
num_stars	EQU	37
stars_bpl1	EQU	$60000
stars_bpl2	EQU	$63000
starpostab	EQU	$66000
starrestoretab	EQU	$67000

; scrolltext bitplane
text_bpl	EQU	$68000

; 3D vector logo
num_points	EQU	37
num_lines	EQU	28
vector_buffer	EQU	$68320
vector_bpl	EQU	$68320+1200

****************************************************************************

; Original beginning of code.

; The music code is located at $50914.

; The intro's main entry point is $5334c (labeled 'main' here).
; This disassembly might not exactly match that address.

	org	$50914

music_tick:
	MOVEM.L	D0-D7/A0-A6,-(SP)
	LEA	musicdata(PC),A6
	TST.B	$10(A6)
	BNE.S	lbC000028
	BSR	lbC0000D4
	BRA.S	lbC00002C

lbC000028:
	BSR	lbC0001B6
lbC00002C:
	ADDQ.B	#1,$10(A6)
	MOVE.B	$10(A6),D0
	CMP.B	$12(A6),D0
	BNE.W	lbC0000BA
	CLR.B	$10(A6)
	ADDQ.B	#1,$11(A6)
	CMPI.B	#$10,$11(A6)
	BNE.S	lbC0000A0
	CLR.B	$11(A6)
	ADDQ.W	#1,$14(A6)
	LEA	$22E(A6),A1
lbC000058:
	CLR.L	D0
	MOVE.W	$14(A6),D0
	MULU.W	#$14,D0
	TST.L	(A1,D0.W)
	BNE.S	lbC00006E
	CLR.W	$14(A6)
	BRA.S	lbC000058

lbC00006E:
	MOVE.L	$16(A6),A0
	MOVE.L	(A1,D0.W),(A0)
	MOVE.L	4(A1,D0.W),$68(A0)
	MOVE.L	8(A1,D0.W),$D0(A0)
	MOVE.L	12(A1,D0.W),$138(A0)
	MOVE.B	$10(A1,D0.W),$66(A0)
	MOVE.B	$11(A1,D0.W),$CE(A0)
	MOVE.B	$12(A1,D0.W),$136(A0)
	MOVE.B	$13(A1,D0.W),$19E(A0)
lbC0000A0:
	MOVE.L	$16(A6),A0
	MOVEQ	#3,D7
lbC0000A6:
	BSR	lbC00037E
	BSR	lbC0001F6
	ADDA.L	#$68,A0
	DBRA	D7,lbC0000A6
	BRA.S	lbC0000CE

lbC0000BA:
	MOVE.L	$16(A6),A0
	MOVEQ	#3,D7
lbC0000C0:
	BSR	lbC0001F6
	ADDA.L	#$68,A0
	DBRA	D7,lbC0000C0
lbC0000CE:
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC0000D4:
	MOVE.L	$16(A6),A0
	CLR.W	D6
	TST.W	$1A(A0)
	BEQ.S	lbC0000E4
	BSET	#0,D6
lbC0000E4:
	TST.W	$82(A0)
	BEQ.S	lbC0000EE
	BSET	#1,D6
lbC0000EE:
	TST.W	$EA(A0)
	BEQ.S	lbC0000F8
	BSET	#2,D6
lbC0000F8:
	TST.W	$152(A0)
	BEQ.S	lbC000102
	BSET	#3,D6
lbC000102:
	MOVE.W	D6,$DFF096
	LEA	$DFF0A0,A1
	MOVE.L	$16(A6),A0
	MOVEQ	#3,D7
lbC000114:
	MOVE.B	$15(A0),9(A1)
	MOVE.W	$20(A0),6(A1)
	TST.W	$1A(A0)
	BEQ.S	lbC000130
	MOVE.L	$16(A0),(A1)
	MOVE.W	$1A(A0),4(A1)
lbC000130:
	ADDA.L	#$68,A0
	ADDA.L	#$10,A1
	DBRA	D7,lbC000114
	MOVE.L	$16(A6),A0
	ADDA.L	#$22,A0
	MOVEQ	#7,D0
lbC00014C:
	MOVE.L	$158(A0),$138(A0)
	MOVE.L	$F0(A0),$D0(A0)
	MOVE.L	$88(A0),$68(A0)
	MOVE.L	$20(A0),(A0)+
	DBRA	D0,lbC00014C
	MOVE.W	#$100,D0
lbC00016A:
	DBRA	D0,lbC00016A
	ORI.W	#$8000,D6
	MOVE.W	D6,$DFF096
	MOVE.L	$16(A6),A0
	LEA	$DFF0A0,A1
	MOVEQ	#3,D7
lbC000184:
	TST.W	$1A(A0)
	BEQ.S	lbC0001A4
	CLR.L	D1
	MOVE.W	$1C(A0),D1
	LSL.L	#1,D1
	MOVE.L	$16(A0),A2
	ADDA.L	D1,A2
	MOVE.L	A2,(A1)
	MOVE.W	$1E(A0),4(A1)
	CLR.W	$1A(A0)
lbC0001A4:
	ADDA.L	#$68,A0
	ADDA.L	#$10,A1
	DBRA	D7,lbC000184
	RTS

lbC0001B6:
	LEA	$DFF0A0,A1
	MOVE.L	$16(A6),A0
	MOVEQ	#3,D7
lbC0001C2:
	MOVE.B	$15(A0),9(A1)
	MOVE.W	$20(A0),6(A1)
	BTST	#0,$14(A0)
	BEQ.S	lbC0001E4
	LEA	$22(A0),A2
	MOVEQ	#7,D0
lbC0001DC:
	MOVE.L	$20(A2),(A2)+
	DBRA	D0,lbC0001DC
lbC0001E4:
	ADDA.L	#$68,A0
	ADDA.L	#$10,A1
	DBRA	D7,lbC0001C2
	RTS

lbC0001F6:
	TST.B	$14(A0)
	BMI.L	lbC00037C
	MOVE.L	4(A0),A1
	MOVE.L	(A1),A2
	MOVE.W	$10(A0),D0
	CLR.W	D1
	MOVE.B	(A2,D0.W),D1
	MOVEQ	#0,D2
	MOVE.B	12(A0),D2
	MULU.W	D2,D1
	LSR.W	#7,D1
	MOVE.B	D1,$15(A0)
	LEA	$46(A6),A2
	LEA	$5A2(A6),A3
	CLR.L	D5
	MOVE.B	14(A0),D5
	LSL.W	#3,D5
	MOVEQ	#0,D6
	MOVE.B	15(A0),D6
	ADD.W	D6,D5
	MOVE.W	8(A0),D0
	MOVE.L	8(A1),A4
	MOVE.W	$64(A0),D1
	CLR.W	D2
	MOVE.B	(A4,D1.W),D2
	MOVE.W	$62(A0),D3
	BPL.S	lbC00024E
	NEG.W	D3
lbC00024E:
	SUBI.W	#$4000,D3
	MULS.W	D2,D3
	LSR.L	#6,D3
	LSR.L	#6,D3
	ADD.W	D3,D0
	MOVE.W	D0,D1
	LSR.W	#8,D1
	SUB.B	(A3,D5.W),D1
	LSL.W	#1,D1
	MOVE.W	(A2,D1.W),D3
	ANDI.W	#$FF,D0
	BEQ.S	lbC000280
	MOVE.W	2(A2,D1.W),D4
	MOVE.W	#$100,D2
	SUB.W	D0,D2
	MULU.W	D0,D4
	MULU.W	D2,D3
	ADD.L	D4,D3
	LSR.L	#8,D3
lbC000280:
	MOVE.W	D3,$20(A0)
	BTST	#0,$14(A0)
	BEQ.S	lbC0002FA
	MOVE.W	$12(A0),D0
	MOVE.L	$12(A1),A2
	MOVEQ	#0,D1
	MOVE.B	(A2,D0.W),D1
	MOVE.W	#$80,D0
	SUB.W	D1,D0
	MOVE.W	#$1F,D4
	LEA	$42(A0),A2
	MOVE.L	$1A(A1),A3
	TST.L	$1E(A1)
	BEQ.L	lbC0002D0
	MOVE.L	$1E(A1),A4
lbC0002B8:
	MOVE.B	(A3)+,D2
	EXT.W	D2
	MOVE.B	(A4)+,D3
	EXT.W	D3
	MULS.W	D0,D2
	MULS.W	D1,D3
	ADD.W	D2,D3
	ASR.W	#7,D3
	MOVE.B	D3,(A2)+
	DBRA	D4,lbC0002B8
	BRA.S	lbC0002FA

lbC0002D0:
	BTST	#1,$14(A0)
	BEQ.L	lbC0002DC
	MOVE.L	A2,A3
lbC0002DC:
	BSET	#1,$14(A0)
	MOVE.B	$1F(A3),D3
	EXT.W	D3
lbC0002E8:
	MOVE.B	(A3)+,D2
	EXT.W	D2
	MULS.W	D0,D2
	MULS.W	D1,D3
	ADD.W	D2,D3
	ASR.W	#7,D3
	MOVE.B	D3,(A2)+
	DBRA	D4,lbC0002E8
lbC0002FA:
	MOVE.W	10(A0),D0
	ADD.W	D0,8(A0)
	CLR.W	D0
	CLR.W	D1
	MOVE.B	13(A0),D0
	EXT.W	D0
	MOVE.B	12(A0),D1
	ADD.W	D0,D1
	BPL.S	lbC000318
	CLR.B	D1
	BRA.S	lbC000322

lbC000318:
	CMPI.W	#$81,D1
	BMI.S	lbC000322
	MOVE.W	#$80,D1
lbC000322:
	MOVE.B	D1,12(A0)
	ADDQ.B	#1,15(A0)
	ANDI.B	#7,15(A0)
	ADDQ.W	#1,$10(A0)
	MOVE.W	$10(A0),D0
	CMP.W	4(A1),D0
	BNE.S	lbC000344
	MOVE.W	6(A1),$10(A0)
lbC000344:
	MOVE.W	$10(A1),D0
	ADD.W	D0,$62(A0)
	ADDQ.W	#1,$64(A0)
	MOVE.W	$64(A0),D0
	CMP.W	12(A1),D0
	BNE.S	lbC000360
	MOVE.W	14(A1),$64(A0)
lbC000360:
	BTST	#0,$14(A0)
	BEQ.S	lbC00037C
	ADDQ.W	#1,$12(A0)
	MOVE.W	$12(A0),D0
	CMP.W	$16(A1),D0
	BNE.S	lbC00037C
	MOVE.W	$18(A1),$12(A0)
lbC00037C:
	RTS

lbC00037E:
	MOVE.L	(A0),A1
lbC000380:
	MOVE.B	(A1)+,D0
	BEQ.L	lbC00047E
	BPL.S	lbC0003DE
	CMPI.B	#$B8,D0
	BPL.L	lbC000468
	CMPI.B	#$9C,D0
	BNE.S	lbC0003A0
	MOVE.B	(A1)+,14(A0)
	CLR.B	15(A0)
	BRA.S	lbC000380

lbC0003A0:
	CMPI.B	#$9B,D0
	BNE.S	lbC0003B2
	CLR.W	D0
	MOVE.B	(A1)+,D0
	EXT.W	D0
	MOVE.W	D0,10(A0)
	BRA.S	lbC000380

lbC0003B2:
	CMPI.B	#$9A,D0
	BNE.S	lbC0003BE
	MOVE.B	(A1)+,13(A0)
	BRA.S	lbC000380

lbC0003BE:
	CMPI.B	#$99,D0
	BNE.S	lbC0003D2
	MOVE.B	(A1)+,D1
	LSL.B	#1,D1
	MOVE.B	D1,12(A0)
	CLR.B	13(A0)
	BRA.S	lbC000380

lbC0003D2:
	CMPI.B	#$98,D0
	BNE.S	lbC0003DC
	MOVE.B	(A1)+,$12(A6)
lbC0003DC:
	BRA.S	lbC000380

lbC0003DE:
	BTST	#6,D0
	BEQ.S	lbC00042A
	LEA	$D6(A6),A2
	SUBI.B	#$40,D0
	CLR.L	D1
	MOVE.B	D0,D1
	MULU.W	#$22,D1
	LEA	(A2,D1.W),A3
	MOVE.L	A3,4(A0)
	CLR.L	14(A0)
	CLR.W	$12(A0)
	CLR.L	$62(A0)
	MOVE.B	#1,$14(A0)
	LEA	$22(A0),A4
	MOVE.L	A4,$16(A0)
	MOVE.W	#$10,$1A(A0)
	CLR.W	$1C(A0)
	MOVE.W	#$10,$1E(A0)
	BRA	lbC000380

lbC00042A:
	SUBQ.B	#1,D0
	LEA	$22A(A6),A2
	CLR.L	D1
	MOVE.B	D0,D1
	MULU.W	#$1C,D1
	LEA	(A2,D1.W),A3
	MOVE.L	A3,4(A0)
	CLR.L	14(A0)
	CLR.B	$14(A0)
	CLR.L	$62(A0)
	MOVE.L	$12(A3),$16(A0)
	MOVE.W	$16(A3),$1A(A0)
	MOVE.W	$18(A3),$1C(A0)
	MOVE.W	$1A(A3),$1E(A0)
	BRA	lbC000380

lbC000468:
	NOT.B	D0
	SUB.B	$66(A0),D0
	MOVE.B	D0,8(A0)
	CLR.B	9(A0)
	CLR.W	10(A0)
	BRA	lbC000380

lbC00047E:
	MOVE.L	A1,(A0)
	RTS

musicdata:
	dc.b	$64
	dc.b	$6F
	dc.b	$73
	dc.b	$2E
	dc.b	$6C
	dc.b	$69
	dc.b	$62
	dc.b	$72
	dc.b	$61
	dc.b	$72
	dc.b	$79
	dc.b	0
	dc.b	0
	dc.b	$FC
	dc.b	12
	dc.b	$D8
	dc.b	4
	dc.b	15
	dc.b	5
	dc.b	0
	dc.b	0
	dc.b	$1F
	dc.l	lbL00106E
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.w	$3E
	dc.w	$47
	dc.w	$4B
	dc.w	$50
	dc.w	$55
	dc.w	$5A
	dc.w	$5F
	dc.w	$65
	dc.w	$6B
	dc.w	$71
	dc.w	$78
	dc.w	$7F
	dc.w	$87
	dc.w	$8F
	dc.w	$97
	dc.w	$A0
	dc.w	$AA
	dc.w	$B4
	dc.w	$BE
	dc.w	$CA
	dc.w	$D6
	dc.w	$E2
	dc.w	$F0
	dc.w	$FE
	dc.w	$10D
	dc.w	$11D
	dc.w	$12E
	dc.w	$140
	dc.w	$153
	dc.w	$168
	dc.w	$17D
	dc.w	$194
	dc.w	$1AC
	dc.w	$1C5
	dc.w	$1E0
	dc.w	$1FC
	dc.w	$21A
	dc.w	$23A
	dc.w	$25C
	dc.w	$280
	dc.w	$2A6
	dc.w	$2D0
	dc.w	$2FA
	dc.w	$328
	dc.w	$358
	dc.w	$38A
	dc.w	$3C0
	dc.w	$3F8
	dc.w	$434
	dc.w	$474
	dc.w	$4B8
	dc.w	$500
	dc.w	$54C
	dc.w	$5A0
	dc.w	$5F4
	dc.w	$650
	dc.w	$6B0
	dc.w	$714
	dc.w	$780
	dc.w	$7F0
	dc.w	$868
	dc.w	$8E8
	dc.w	$970
	dc.w	$A00
	dc.w	$A98
	dc.w	$B40
	dc.w	$BE8
	dc.w	$CA0
	dc.w	$D60
	dc.w	$E28
	dc.w	$F00
	dc.w	$FE0
	dc.l	lbB000950
	dc.l	$40003
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB000966
	dc.w	6
	dc.w	5
	dc.l	lbB0009C4
	dc.w	0
	dc.w	0
	dc.l	lbB000938
	dc.w	1
	dc.w	0
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB000960
	dc.w	3
	dc.w	2
	dc.l	lbB000984
	dc.w	0
	dc.w	0
	dc.l	lbB000938
	dc.w	1
	dc.w	0
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB000954
	dc.w	3
	dc.w	2
	dc.l	lbB000984
	dc.w	0
	dc.w	0
	dc.l	lbB00094A
	dc.w	6
	dc.w	5
	dc.l	lbB000934
	dc.w	3
	dc.w	2
	dc.w	$1F40
	dc.l	lbB000958
	dc.w	9
	dc.w	8
	dc.l	lbB0009C4
	dc.w	0
	dc.w	0
	dc.l	lbB000938
	dc.w	6
	dc.w	5
	dc.l	lbB000934
	dc.w	3
	dc.w	2
	dc.w	$1F40
	dc.l	lbB000954
	dc.w	3
	dc.w	2
	dc.l	lbB000984
	dc.l	lbW000A04
	dc.l	lbB000944
	dc.w	6
	dc.w	5
	dc.l	lbB000934
	dc.w	3
	dc.w	2
	dc.w	$1F40
	dc.l	lbB000954
	dc.w	3
	dc.w	2
	dc.l	lbB0009C4
	dc.w	0
	dc.w	0
	dc.l	lbB000950
	dc.w	4
	dc.w	3
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB00096C
	dc.w	6
	dc.w	5
	dc.l	lbW000A04
	dc.w	0
	dc.w	0
	dc.l	lbB000950
	dc.w	4
	dc.w	3
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB000972
	dc.w	6
	dc.w	5
	dc.l	lbW000A04
	dc.w	0
	dc.w	0
	dc.l	lbB000950
	dc.w	4
	dc.w	3
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB000978
	dc.w	6
	dc.w	5
	dc.l	lbW000A04
	dc.w	0
	dc.w	0
	dc.l	lbB000950
	dc.w	4
	dc.w	3
	dc.l	lbB000934
	dc.w	2
	dc.w	1
	dc.w	$1F40
	dc.l	lbB00097E
	dc.w	6
	dc.w	5
	dc.l	lbW000A04
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.l	lbW000AA6
	dc.l	lbW000ACA
	dc.l	lbW000B28
	dc.l	lbW000CB6
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000AE8
	dc.l	lbW000B3C
	dc.l	lbW000CCA
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000B06
	dc.l	lbL000A96
	dc.l	lbL000A96
	dc.w	$303
	dc.w	$303
	dc.l	lbW000DA4
	dc.l	lbL000A96
	dc.l	lbW000B5A
	dc.l	lbW000CE6
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000ACA
	dc.l	lbL000A96
	dc.l	lbL000A96
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000AE8
	dc.l	lbW000C4E
	dc.l	lbW000D6E
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000B06
	dc.l	lbW000C68
	dc.l	lbW000D88
	dc.w	$303
	dc.w	$303
	dc.l	lbW000DA4
	dc.l	lbL000A96
	dc.l	lbL000A96
	dc.l	lbL000A96
	dc.w	$303
	dc.w	$303
	dc.l	lbW000AA6
	dc.l	lbW000B78
	dc.l	lbW000BDC
	dc.l	lbW000D02
	dc.w	$FC03
	dc.w	$F7F7
	dc.l	lbW000AA6
	dc.l	lbW000B96
	dc.l	lbW000BFA
	dc.l	lbW000D1E
	dc.w	$FF03
	dc.w	$F7F7
	dc.l	lbW000AA6
	dc.l	lbW000BB8
	dc.l	lbW000BDC
	dc.l	lbW000D02
	dc.w	$103
	dc.w	$F7F7
	dc.l	lbW000DA4
	dc.l	lbL000A96
	dc.l	lbW000BFA
	dc.l	lbW000D1E
	dc.w	$303
	dc.w	$F7F7
	dc.l	lbW000AA6
	dc.l	lbW000B78
	dc.l	lbW000BDC
	dc.l	lbW000D02
	dc.l	$FC030303
	dc.l	lbW000AA6
	dc.l	lbW000B96
	dc.l	lbW000BFA
	dc.l	lbW000D1E
	dc.l	$FF030303
	dc.l	lbW000AA6
	dc.l	lbW000BB8
	dc.l	lbW000C1A
	dc.l	lbW000D3C
	dc.l	$1030303
	dc.l	lbW000DA4
	dc.l	lbL000A96
	dc.l	lbL000C3C
	dc.l	lbL000D5C
	dc.l	$3030303
	dc.l	lbW000AA6
	dc.l	lbW000DCA
	dc.l	lbW000E3E
	dc.l	lbW000EB2
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000DE8
	dc.l	lbW000E5C
	dc.l	lbW000ECE
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000E04
	dc.l	lbW000E7A
	dc.l	lbW000EEC
	dc.l	$8030303
	dc.l	lbW000DA4
	dc.l	lbW000E22
	dc.l	lbW000E98
	dc.l	lbW000F0A
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000DCA
	dc.l	lbW000E3E
	dc.l	lbW000EB2
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000DE8
	dc.l	lbW000E5C
	dc.l	lbW000ECE
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000E04
	dc.l	lbW000E7A
	dc.l	lbW000EEC
	dc.l	$8030303
	dc.l	lbW000DA4
	dc.l	lbW000E22
	dc.l	lbW000F26
	dc.l	lbW000F44
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000F60
	dc.l	lbW000F9A
	dc.l	lbW001004
	dc.l	$A030303
	dc.l	lbW000AA6
	dc.l	lbW000F86
	dc.l	lbW000FB4
	dc.l	lbW00101E
	dc.l	$A030303
	dc.l	lbW000AA6
	dc.l	lbW000F60
	dc.l	lbW000FCE
	dc.l	lbW001038
	dc.l	$A030303
	dc.l	lbW000DA4
	dc.l	lbW000F86
	dc.l	lbW000FEA
	dc.l	lbW001054
	dc.l	$A030303
	dc.l	lbW000AA6
	dc.l	lbW000DCA
	dc.l	lbW000E3E
	dc.l	lbW000EB2
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000DE8
	dc.l	lbW000E5C
	dc.l	lbW000ECE
	dc.l	$8030303
	dc.l	lbW000AA6
	dc.l	lbW000E04
	dc.l	lbW000E7A
	dc.l	lbW000EEC
	dc.l	$8030303
	dc.l	lbW000DA4
	dc.l	lbW000E22
	dc.l	lbW000E98
	dc.l	lbW000F0A
	dc.l	$8030303
	dc.l	0
lbB000934:
	dc.b	10
	dc.b	10
	dc.b	$1E
	dc.b	0
lbB000938:
	dc.b	$40
	dc.b	$36
	dc.b	$2C
	dc.b	$22
	dc.b	$18
	dc.b	14
	dc.b	$40
	dc.b	$1C
	dc.b	$36
	dc.b	$32
	dc.b	$2F
	dc.b	$2C
lbB000944:
	dc.b	$3C
	dc.b	$32
	dc.b	$28
	dc.b	$1E
	dc.b	$14
	dc.b	10
lbB00094A:
	dc.b	$2C
	dc.b	$1C
	dc.b	$22
	dc.b	$14
	dc.b	$14
	dc.b	$14
lbB000950:
	dc.b	$40
	dc.b	$32
	dc.b	$28
	dc.b	$40
lbB000954:
	dc.b	$32
	dc.b	10
	dc.b	5
	dc.b	0
lbB000958:
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	4
	dc.b	8
	dc.b	$10
	dc.b	$20
	dc.b	$40
lbB000960:
	dc.b	0
	dc.b	$14
	dc.b	$28
	dc.b	$32
	dc.b	$46
	dc.b	$50
lbB000966:
	dc.b	0
	dc.b	10
	dc.b	$14
	dc.b	$1E
	dc.b	$23
	dc.b	$28
lbB00096C:
	dc.b	0
	dc.b	15
	dc.b	$19
	dc.b	$23
	dc.b	$28
	dc.b	$2D
lbB000972:
	dc.b	$14
	dc.b	$1E
	dc.b	$28
	dc.b	$2D
	dc.b	$32
	dc.b	$3C
lbB000978:
	dc.b	$19
	dc.b	$23
	dc.b	$2D
	dc.b	$32
	dc.b	$37
	dc.b	$5A
lbB00097E:
	dc.b	$1E
	dc.b	$28
	dc.b	$32
	dc.b	$37
	dc.b	$3C
	dc.b	$78
lbB000984:
	dc.b	$78
	dc.b	$6E
	dc.b	$64
	dc.b	$5A
	dc.b	$50
	dc.b	$46
	dc.b	$3C
	dc.b	$32
	dc.b	$28
	dc.b	$1E
	dc.b	$14
	dc.b	10
	dc.b	0
	dc.b	$78
	dc.b	$6E
	dc.b	$64
	dc.b	$5A
	dc.b	$50
	dc.b	$46
	dc.b	$3C
	dc.b	$32
	dc.b	$28
	dc.b	$1E
	dc.b	$14
	dc.b	10
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$7D
	dc.b	$7E
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7E
	dc.b	$7D
	dc.b	0
	dc.b	0
	dc.b	$7D
	dc.b	$7E
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7E
	dc.b	$7D
	dc.b	0
lbB0009C4:
	dc.b	1
	dc.b	2
	dc.b	4
	dc.b	8
	dc.b	$10
	dc.b	$20
	dc.b	$40
	dc.b	$7F
	dc.b	$40
	dc.b	$20
	dc.b	$10
	dc.b	8
	dc.b	4
	dc.b	2
	dc.b	1
	dc.b	$B0
	dc.b	$FF
	dc.b	$FE
	dc.b	$FC
	dc.b	$F8
	dc.b	$F0
	dc.b	$E0
	dc.b	$C0
	dc.b	$81
	dc.b	$C0
	dc.b	$E0
	dc.b	$F0
	dc.b	$F8
	dc.b	$FC
	dc.b	$FE
	dc.b	$FF
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	4
	dc.b	8
	dc.b	$10
	dc.b	$20
	dc.b	$40
	dc.b	$7F
	dc.b	$40
	dc.b	$20
	dc.b	$10
	dc.b	8
	dc.b	4
	dc.b	2
	dc.b	1
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	4
	dc.b	8
	dc.b	$10
	dc.b	$20
	dc.b	$40
	dc.b	$7F
	dc.b	$40
	dc.b	$20
	dc.b	$10
	dc.b	8
	dc.b	4
	dc.b	2
	dc.b	1
	dc.b	0
lbW000A04:
	dc.w	$49
	dc.w	$4824
	dc.w	$440C
	dc.w	$1B0B
	dc.w	$36FB
	dc.w	$FADC
	dc.w	$6DA
	dc.w	$F4EE
	dc.w	$20E8
	dc.w	$E8C7
	dc.w	$EDBE
	dc.w	$D7D2
	dc.w	$9DA
	dc.w	$E7D4
	dc.w	$9E7
	dc.w	$90A
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$303
	dc.w	$707
	dc.w	$303
	dc.w	$FEFE
	dc.w	$202
	dc.w	$505
	dc.w	$202
	dc.w	0
	dc.w	$303
	dc.w	$808
	dc.w	$303
	dc.w	0
	dc.w	$505
	dc.w	$707
	dc.w	$505
	dc.w	0
	dc.w	$202
	dc.w	$707
	dc.w	$202
	dc.w	$FDFD
	dc.w	0
	dc.w	$505
	dc.w	0
	dc.w	$FBFB
	dc.w	0
	dc.w	$404
	dc.w	0
	dc.w	0
	dc.w	$505
	dc.w	$A0A
	dc.w	$505
	dc.w	0
	dc.w	$303
	dc.w	$808
	dc.w	$303
	dc.w	0
	dc.w	$303
	dc.w	$707
	dc.w	$303
	dc.w	$FEFE
	dc.w	$202
	dc.w	$505
	dc.w	$202
	dc.w	$9AFE
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbL000A96:
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
lbW000AA6:
	dc.w	$C440
	dc.w	$9940
	dc.w	$9805
	dc.w	0
	dc.w	$C446
	dc.w	0
	dc.w	$C447
	dc.w	0
	dc.w	$C448
	dc.w	0
	dc.w	$C449
	dc.w	0
	dc.w	$C448
	dc.w	0
	dc.w	$C447
	dc.w	0
	dc.w	$C446
	dc.w	0
lbW000ACA:
	dc.w	$E841
	dc.w	$9940
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C02
	dc.w	0
	dc.w	0
lbW000AE8:
	dc.w	$E841
	dc.w	$9940
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C03
	dc.w	0
	dc.w	0
lbW000B06:
	dc.w	$E841
	dc.w	$9940
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	$E842
	dc.w	$9C02
	dc.w	0
lbW000B28:
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000B3C:
	dc.w	0
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$ED43
	dc.w	0
	dc.w	$E643
	dc.w	0
	dc.w	0
	dc.w	$E843
	dc.w	0
lbW000B5A:
	dc.w	0
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$ED43
	dc.w	0
	dc.w	$E643
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
lbW000B78:
	dc.w	$E842
	dc.w	$9940
	dc.w	$9C04
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C05
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	0
lbW000B96:
	dc.w	$E842
	dc.w	$9940
	dc.w	$9C04
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C05
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
lbW000BB8:
	dc.w	$E842
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C05
	dc.w	0
	dc.w	0
	dc.w	$E841
	dc.w	$9C02
	dc.w	0
	dc.w	$E842
	dc.w	$9C01
	dc.w	0
lbW000BDC:
	dc.w	0
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$F043
	dc.w	0
	dc.w	$EF43
	dc.w	0
	dc.w	0
	dc.w	$E843
	dc.w	0
lbW000BFA:
	dc.w	0
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$F043
	dc.w	0
	dc.w	$EF43
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$E843
	dc.w	0
lbW000C1A:
	dc.w	0
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$F043
	dc.w	0
	dc.w	$EF43
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$E843
	dc.w	$9C01
	dc.w	0
lbL000C3C:
	dc.l	0
	dc.l	0
	dc.l	$9B140000
	dc.l	0
	dc.w	0
lbW000C4E:
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	$E643
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
lbW000C68:
	dc.w	$E643
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$F043
	dc.w	$9900
	dc.w	$E8
	dc.w	$4300
	dc.w	$EF43
	dc.w	$E8
	dc.w	$4300
	dc.w	$F043
	dc.w	$E8
	dc.w	$4300
	dc.w	$EF43
	dc.w	$E8
	dc.w	$4300
	dc.w	$F043
	dc.w	$E8
	dc.w	$4300
	dc.w	$EF43
	dc.w	$E8
	dc.w	$4300
	dc.w	$F043
	dc.w	$E8
	dc.w	$4300
	dc.w	$EF43
	dc.w	$E8
	dc.w	$4300
lbW000CB6:
	dc.w	$E8
	dc.w	$4599
	dc.w	$4000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000CCA:
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$EB
	dc.w	$4500
	dc.w	$ED
	dc.w	$4500
	dc.w	$E6
	dc.w	$4500
	dc.w	0
	dc.w	$E8
	dc.w	$4500
lbW000CE6:
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$EB
	dc.w	$4500
	dc.w	$ED
	dc.w	$4500
	dc.w	$E6
	dc.w	$4500
	dc.w	0
	dc.w	$E3
	dc.w	$4500
lbW000D02:
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$E8
	dc.w	$4500
	dc.w	$F0
	dc.w	$4500
	dc.w	$EF
	dc.w	$4500
	dc.w	0
	dc.w	$E8
	dc.w	$4500
lbW000D1E:
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$E8
	dc.w	$4500
	dc.w	$F0
	dc.w	$4500
	dc.w	$EF
	dc.w	$4500
	dc.w	$EB
	dc.w	$4500
	dc.w	$E8
	dc.w	$4500
lbW000D3C:
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$E8
	dc.w	$4500
	dc.w	$F0
	dc.w	$4500
	dc.w	$EF
	dc.w	$4500
	dc.w	$EB
	dc.w	$4500
	dc.w	$E8
	dc.w	$459C
	dc.w	$100
lbL000D5C:
	dc.l	0
	dc.l	0
	dc.l	$9B3C00
	dc.l	0
	dc.w	0
lbW000D6E:
	dc.w	0
	dc.w	$E3
	dc.w	$4500
	dc.w	$E6
	dc.w	$4500
	dc.w	$E3
	dc.w	$4500
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	0
	dc.w	$E3
	dc.w	$4500
lbW000D88:
	dc.w	$E6
	dc.w	$4500
	dc.w	$E3
	dc.w	$4500
	dc.w	0
	dc.w	0
	dc.w	$E8
	dc.w	$4500
	dc.w	$EB
	dc.w	$4500
	dc.w	$EA
	dc.w	$4500
	dc.w	$E8
	dc.w	$4500
lbW000DA4:
	dc.w	$C440
	dc.w	$9940
	dc.w	$9805
	dc.w	0
	dc.w	$C446
	dc.w	0
	dc.w	$C447
	dc.w	0
	dc.w	$C448
	dc.w	0
	dc.w	$C449
	dc.w	0
	dc.w	$C448
	dc.w	0
	dc.w	$C447
	dc.w	0
	dc.w	$C446
	dc.w	$C4
	dc.w	$4600
lbW000DCA:
	dc.w	$E141
	dc.w	$9940
	dc.w	$9C03
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C03
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000DE8:
	dc.w	$E141
	dc.w	$9C03
	dc.w	0
	dc.w	$E141
	dc.w	$9C03
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C01
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000E04:
	dc.w	$E141
	dc.w	$9940
	dc.w	$9C02
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C02
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C02
	dc.w	0
	dc.w	0
lbW000E22:
	dc.w	$E141
	dc.w	$9C06
	dc.w	0
	dc.w	$E141
	dc.w	$9C06
	dc.w	0
	dc.w	0
	dc.w	$E141
	dc.w	$9C07
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000E3E:
	dc.w	0
	dc.w	$DF43
	dc.w	$9940
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$DF43
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$E4
	dc.w	$4300
	dc.w	0
	dc.w	$E143
	dc.w	0
lbW000E5C:
	dc.w	0
	dc.w	$DF43
	dc.w	$9940
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$DF43
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$E6
	dc.w	$4300
	dc.w	0
	dc.w	$E143
	dc.w	0
lbW000E7A:
	dc.w	0
	dc.w	$DF43
	dc.w	$9940
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$DF43
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$E8
	dc.w	$4300
	dc.w	0
	dc.w	$E143
	dc.w	0
lbW000E98:
	dc.w	0
	dc.w	$EB43
	dc.w	$9940
	dc.w	0
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	0
	dc.w	$ED43
	dc.w	0
lbW000EB2:
	dc.w	0
	dc.w	$DF
	dc.w	$4399
	dc.w	$4000
	dc.w	$E1
	dc.w	$4300
	dc.w	$DF
	dc.w	$4300
	dc.w	$E1
	dc.w	$4300
	dc.w	0
	dc.w	$E443
	dc.w	0
	dc.w	$E1
lbW000ECE:
	dc.w	$E143
	dc.w	0
	dc.w	$DF
	dc.w	$4399
	dc.w	$4000
	dc.w	$E1
	dc.w	$4300
	dc.w	$DF
	dc.w	$4300
	dc.w	$E1
	dc.w	$4300
	dc.w	0
	dc.w	$E643
	dc.w	0
	dc.w	$E1
lbW000EEC:
	dc.w	$E143
	dc.w	0
	dc.w	$DF
	dc.w	$4399
	dc.w	$4000
	dc.w	$E1
	dc.w	$4300
	dc.w	$DF
	dc.w	$4300
	dc.w	$E1
	dc.w	$4300
	dc.w	0
	dc.w	$E843
	dc.w	0
	dc.w	$E1
lbW000F0A:
	dc.w	$E143
	dc.w	0
	dc.w	$EB
	dc.w	$4399
	dc.w	$4000
	dc.w	0
	dc.w	$E8
	dc.w	$4300
	dc.w	0
	dc.w	$EB
	dc.w	$4300
	dc.w	0
	dc.w	$ED
	dc.w	$4300
lbW000F26:
	dc.w	0
	dc.w	$DF43
	dc.w	$9940
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$DF43
	dc.w	0
	dc.w	$ED43
	dc.w	0
	dc.w	$EB
	dc.w	$4300
	dc.w	0
	dc.w	$E843
	dc.w	0
lbW000F44:
	dc.w	0
	dc.w	$DF
	dc.w	$4399
	dc.w	$4000
	dc.w	$E1
	dc.w	$4300
	dc.w	$DF
	dc.w	$4300
	dc.w	$ED
	dc.w	$4300
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$E3
lbW000F60:
	dc.w	$E341
	dc.w	$9940
	dc.w	$9C08
	dc.w	0
	dc.w	$E341
	dc.w	$9C08
	dc.w	0
	dc.w	0
	dc.w	$E342
	dc.w	$9C09
	dc.w	0
	dc.w	0
	dc.w	$E341
	dc.w	$9C0B
	dc.w	0
	dc.w	0
	dc.w	$E341
	dc.w	$9C0A
	dc.w	0
lbW000F86:
	dc.w	$E342
	dc.w	$9C0A
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW000F9A:
	dc.w	$E643
	dc.w	$9940
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	0
lbW000FB4:
	dc.w	$E843
	dc.w	$9940
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	$DE43
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	0
lbW000FCE:
	dc.w	$EA43
	dc.w	$9940
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	$E143
	dc.w	0
	dc.w	$E343
	dc.w	0
	dc.w	0
	dc.w	$E343
	dc.w	0
lbW000FEA:
	dc.w	$EA43
	dc.w	$9940
	dc.w	0
	dc.w	$EB43
	dc.w	0
	dc.w	$ED43
	dc.w	0
	dc.w	$EA43
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbW001004:
	dc.w	$E6
	dc.w	$4399
	dc.w	$4000
	dc.w	0
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	$E1
	dc.w	$4300
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	0
lbW00101E:
	dc.w	$E8
	dc.w	$4399
	dc.w	$4000
	dc.w	0
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	$DE
	dc.w	$4300
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	0
lbW001038:
	dc.w	$EA
	dc.w	$4399
	dc.w	$4000
	dc.w	0
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	$E1
	dc.w	$4300
	dc.w	$E3
	dc.w	$4300
	dc.w	0
	dc.w	$E3
	dc.w	$4300
lbW001054:
	dc.w	$EA
	dc.w	$4399
	dc.w	$4000
	dc.w	$EB
	dc.w	$4300
	dc.w	$ED
	dc.w	$4300
	dc.w	$EA
	dc.w	$4300
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
lbL00106E:
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	3
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$A5E0000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$2F4
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	3
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$A5E0000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$2F4
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	3
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$A5E0000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$2F4
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	3
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$A5E0000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$2F4
	dc.l	$30000
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.w	0

; Sine data table
; Org $52000

sine_data:
	dc.w	0,$C9,$192,$25B,$324,$3ED,$4B5,$57E
	dc.w	$646,$70E,$7D6,$89D,$964,$A2B,$AF1,$BB7
	dc.w	$C7C,$D41,$E06,$ECA,$F8D,$1050,$1112,$11D3
	dc.w	$1294,$1354,$1413,$14D2,$1590,$164C,$1709,$17C4
	dc.w	$187E,$1937,$19EF,$1AA7,$1B5D,$1C12,$1CC6,$1D79
	dc.w	$1E2B,$1EDC,$1F8C,$203A,$20E7,$2193,$223D,$22E7
	dc.w	$238E,$2435,$24DA,$257E,$2620,$26C1,$2760,$27FE
	dc.w	$289A,$2935,$29CE,$2A65,$2AFB,$2B8F,$2C21,$2CB2
	dc.w	$2D41,$2DCF,$2E5A,$2EE4,$2F6C,$2FF2,$3076,$30F9
	dc.w	$3179,$31F8,$3274,$32EF,$3368,$33DF,$3453,$34C6
	dc.w	$3537,$35A5,$3612,$367D,$36E5,$374B,$37B0,$3812
	dc.w	$3871,$38CF,$392B,$3984,$39DB,$3A30,$3A82,$3AD3
	dc.w	$3B21,$3B6D,$3BB6,$3BFD,$3C42,$3C85,$3CC5,$3D03
	dc.w	$3D3F,$3D78,$3DAF,$3DE3,$3E15,$3E45,$3E72,$3E9D
	dc.w	$3EC5,$3EEB,$3F0F,$3F30,$3F4F,$3F6B,$3F85,$3F9C
	dc.w	$3FB1,$3FC4,$3FD4,$3FE1,$3FEC,$3FF5,$3FFB,$3FFF
cosine_data:
	dc.w	$4000,$3FFF,$3FFB,$3FF5,$3FEC,$3FE1,$3FD4,$3FC4
	dc.w	$3FB1,$3F9C,$3F85,$3F6B,$3F4F,$3F30,$3F0F,$3EEB
	dc.w	$3EC5,$3E9D,$3E72,$3E45,$3E15,$3DE3,$3DAF,$3D78
	dc.w	$3D3F,$3D03,$3CC5,$3C85,$3C42,$3BFD,$3BB6,$3B6D
	dc.w	$3B21,$3AD3,$3A82,$3A30,$39DB,$3984,$392B,$38CF
	dc.w	$3871,$3812,$37B0,$374B,$36E5,$367D,$3612,$35A5
	dc.w	$3537,$34C6,$3453,$33DF,$3368,$32EF,$3274,$31F8
	dc.w	$3179,$30F9,$3076,$2FF2,$2F6C,$2EE4,$2E5A,$2DCF
	dc.w	$2D41,$2CB2,$2C21,$2B8F,$2AFB,$2A65,$29CE,$2935
	dc.w	$289A,$27FE,$2760,$26C1,$2620,$257E,$24DA,$2435
	dc.w	$238E,$22E7,$223D,$2193,$20E7,$203A,$1F8C,$1EDC
	dc.w	$1E2B,$1D79,$1CC6,$1C12,$1B5D,$1AA7,$19EF,$1937
	dc.w	$187E,$17C4,$1709,$164C,$1590,$14D2,$1413,$1354
	dc.w	$1294,$11D3,$1112,$1050,$F8D,$ECA,$E06,$D41
	dc.w	$C7C,$BB7,$AF1,$A2B,$964,$89D,$7D6,$70E
	dc.w	$646,$57E,$4B5,$3ED,$324,$25B,$192,$C9
	dc.w	0,$FF37,$FE6E,$FDA5,$FCDC,$FC13,$FB4B,$FA82
	dc.w	$F9BA,$F8F2,$F82A,$F763,$F69C,$F5D5,$F50F,$F449
	dc.w	$F384,$F2BF,$F1FA,$F136,$F073,$EFB0,$EEEE,$EE2D
	dc.w	$ED6C,$ECAC,$EBED,$EB2E,$EA70,$E9B4,$E8F7,$E83C
	dc.w	$E782,$E6C9,$E611,$E559,$E4A3,$E3EE,$E33A,$E287
	dc.w	$E1D5,$E124,$E074,$DFC6,$DF19,$DE6D,$DDC3,$DD19
	dc.w	$DC72,$DBCB,$DB26,$DA82,$D9E0,$D93F,$D8A0,$D802
	dc.w	$D766,$D6CB,$D632,$D59B,$D505,$D471,$D3DF,$D34E
	dc.w	$D2BF,$D231,$D1A6,$D11C,$D094,$D00E,$CF8A,$CF07
	dc.w	$CE87,$CE08,$CD8C,$CD11,$CC98,$CC21,$CBAD,$CB3A
	dc.w	$CAC9,$CA5B,$C9EE,$C983,$C91B,$C8B5,$C850,$C7EE
	dc.w	$C78F,$C731,$C6D5,$C67C,$C625,$C5D0,$C57E,$C52D
	dc.w	$C4DF,$C493,$C44A,$C403,$C3BE,$C37B,$C33B,$C2FD
	dc.w	$C2C1,$C288,$C251,$C21D,$C1EB,$C1BB,$C18E,$C163
	dc.w	$C13B,$C115,$C0F1,$C0D0,$C0B1,$C095,$C07B,$C064
	dc.w	$C04F,$C03C,$C02C,$C01F,$C014,$C00B,$C005,$C001
	dc.w	$C000,$C001,$C005,$C00B,$C014,$C01F,$C02C,$C03C
	dc.w	$C04F,$C064,$C07B,$C095,$C0B1,$C0D0,$C0F1,$C115
	dc.w	$C13B,$C163,$C18E,$C1BB,$C1EB,$C21D,$C251,$C288
	dc.w	$C2C1,$C2FD,$C33B,$C37B,$C3BE,$C403,$C44A,$C493
	dc.w	$C4DF,$C52D,$C57E,$C5D0,$C625,$C67C,$C6D5,$C731
	dc.w	$C78F,$C7EE,$C850,$C8B5,$C91B,$C983,$C9EE,$CA5B
	dc.w	$CAC9,$CB3A,$CBAD,$CC21,$CC98,$CD11,$CD8C,$CE08
	dc.w	$CE87,$CF07,$CF8A,$D00E,$D094,$D11C,$D1A6,$D231
	dc.w	$D2BF,$D34E,$D3DF,$D471,$D505,$D59B,$D632,$D6CB
	dc.w	$D766,$D802,$D8A0,$D93F,$D9E0,$DA82,$DB26,$DBCB
	dc.w	$DC72,$DD19,$DDC3,$DE6D,$DF19,$DFC6,$E074,$E124
	dc.w	$E1D5,$E287,$E33A,$E3EE,$E4A3,$E559,$E611,$E6C9
	dc.w	$E782,$E83C,$E8F7,$E9B4,$EA70,$EB2E,$EBED,$ECAC
	dc.w	$ED6C,$EE2D,$EEEE,$EFB0,$F073,$F136,$F1FA,$F2BF
	dc.w	$F384,$F449,$F50F,$F5D5,$F69C,$F763,$F82A,$F8F2
	dc.w	$F9BA,$FA82,$FB4B,$FC13,$FCDC,$FDA5,$FE6E,$FF37
	dc.w	0,$C9,$192,$25B,$324,$3ED,$4B5,$57E
	dc.w	$646,$70E,$7D6,$89D,$964,$A2B,$AF1,$BB7
	dc.w	$C7C,$D41,$E06,$ECA,$F8D,$1050,$1112,$11D3
	dc.w	$1294,$1354,$1413,$14D2,$1590,$164C,$1709,$17C4
	dc.w	$187E,$1937,$19EF,$1AA7,$1B5D,$1C12,$1CC6,$1D79
	dc.w	$1E2B,$1EDC,$1F8C,$203A,$20E7,$2193,$223D,$22E7
	dc.w	$238E,$2435,$24DA,$257E,$2620,$26C1,$2760,$27FE
	dc.w	$289A,$2935,$29CE,$2A65,$2AFB,$2B8F,$2C21,$2CB2
	dc.w	$2D41,$2DCF,$2E5A,$2EE4,$2F6C,$2FF2,$3076,$30F9
	dc.w	$3179,$31F8,$3274,$32EF,$3368,$33DF,$3453,$34C6
	dc.w	$3537,$35A5,$3612,$367D,$36E5,$374B,$37B0,$3812
	dc.w	$3871,$38CF,$392B,$3984,$39DB,$3A30,$3A82,$3AD3
	dc.w	$3B21,$3B6D,$3BB6,$3BFD,$3C42,$3C85,$3CC5,$3D03
	dc.w	$3D3F,$3D78,$3DAF,$3DE3,$3E15,$3E45,$3E72,$3E9D
	dc.w	$3EC5,$3EEB,$3F0F,$3F30,$3F4F,$3F6B,$3F85,$3F9C
	dc.w	$3FB1,$3FC4,$3FD4,$3FE1,$3FEC,$3FF5,$3FFB,$3FFF
	dc.w	$4000

	ds.w	1407

; Font data for scroller
; Org $53000
; 1 bitplane, 320x16

fontdata:
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$73C
	dc.w	$1C78
	dc.w	$1C1E
	dc.w	$1C1B
	dc.w	$187E
	dc.w	$3330
	dc.w	$6367
	dc.w	$1C3C
	dc.w	$1C3C
	dc.w	$3C7E
	dc.w	$3363
	dc.w	$3373
	dc.w	$733F
	dc.w	0
	dc.w	$60
	dc.w	$1C1E
	dc.w	$1C1C
	dc.w	$300
	dc.w	0
	dc.w	0
	dc.w	$F76
	dc.w	$366C
	dc.w	$3633
	dc.w	$361B
	dc.w	$1867
	dc.w	$7670
	dc.w	$7773
	dc.w	$3676
	dc.w	$3676
	dc.w	$7677
	dc.w	$7363
	dc.w	$3366
	dc.w	$6676
	dc.w	0
	dc.w	$60
	dc.w	$1837
	dc.w	$3006
	dc.w	$600
	dc.w	0
	dc.w	0
	dc.w	$1B63
	dc.w	$6066
	dc.w	$6060
	dc.w	$6033
	dc.w	$1803
	dc.w	$6C60
	dc.w	$7F7B
	dc.w	$6363
	dc.w	$6363
	dc.w	$6010
	dc.w	$6336
	dc.w	$636C
	dc.w	$6C0C
	dc.w	0
	dc.w	$40
	dc.w	$1803
	dc.w	$6003
	dc.w	$C00
	dc.w	0
	dc.w	0
	dc.w	$3F7E
	dc.w	$6063
	dc.w	$7878
	dc.w	$6E3F
	dc.w	$1803
	dc.w	$7860
	dc.w	$6B7E
	dc.w	$637E
	dc.w	$6F7E
	dc.w	$3E18
	dc.w	$6336
	dc.w	$6B38
	dc.w	$3818
	dc.w	0
	dc.w	0
	dc.w	$101E
	dc.w	$6003
	dc.w	$1800
	dc.w	0
	dc.w	0
	dc.w	$3363
	dc.w	$7073
	dc.w	$6060
	dc.w	$6363
	dc.w	$1807
	dc.w	$7C70
	dc.w	$636E
	dc.w	$7360
	dc.w	$776C
	dc.w	$4318
	dc.w	$7336
	dc.w	$7F1C
	dc.w	$1830
	dc.w	0
	dc.w	$6000
	dc.w	$1000
	dc.w	$6003
	dc.w	$1800
	dc.w	0
	dc.w	0
	dc.w	$6373
	dc.w	$7173
	dc.w	$7170
	dc.w	$7363
	dc.w	$1C67
	dc.w	$7673
	dc.w	$6667
	dc.w	$7370
	dc.w	$7376
	dc.w	$7B1C
	dc.w	$731C
	dc.w	$7736
	dc.w	$1867
	dc.w	$60
	dc.w	$6000
	dc.w	$2018
	dc.w	$7007
	dc.w	$3000
	dc.w	0
	dc.w	0
	dc.w	$633F
	dc.w	$3F7E
	dc.w	$3F38
	dc.w	$3F63
	dc.w	$E3E
	dc.w	$333F
	dc.w	$6663
	dc.w	$3F38
	dc.w	$3F33
	dc.w	$7E1C
	dc.w	$3F1C
	dc.w	$6363
	dc.w	$387F
	dc.w	$60
	dc.w	$2000
	dc.w	$3018
	dc.w	$3C1E
	dc.w	$6000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$101E
	dc.w	$3E1B
	dc.w	$3C1C
	dc.w	$3C1C
	dc.w	$1E1C
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1037
	dc.w	$671B
	dc.w	$6636
	dc.w	$6636
	dc.w	$3736
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1803
	dc.w	$4333
	dc.w	$6060
	dc.w	$363
	dc.w	$6363
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$183E
	dc.w	$F3F
	dc.w	$7E7E
	dc.w	$F3E
	dc.w	$3F6B
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1C61
	dc.w	$303
	dc.w	$363
	dc.w	$363
	dc.w	$36B
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1C6F
	dc.w	$6703
	dc.w	$7B73
	dc.w	$773
	dc.w	$6763
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1C7F
	dc.w	$7E03
	dc.w	$7F3E
	dc.w	$E3E
	dc.w	$7E3E
	dc.w	0
	dc.w	0

; Electronic Artists logo
; 1 bitplane 320x?
ea_logo:
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$FB0F
	dc.w	$9DE7
	dc.w	$8E79
	dc.w	$E703
	dc.w	$9EF3
	dc.w	$CF78
	dc.w	$F000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$600
	dc.w	$C30C
	dc.w	$180
	dc.w	$C300
	dc.w	$1801
	dc.w	$8000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$E30E
	dc.w	$3037
	dc.w	$9B6C
	dc.w	$CC07
	dc.w	$DE19
	dc.w	$8E0C
	dc.w	$E000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$C30C
	dc.w	$3636
	dc.w	$DB6C
	dc.w	$CD86
	dc.w	$DB19
	dc.w	$830C
	dc.w	$3000
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$FBEF
	dc.w	$9C36
	dc.w	$CE6D
	dc.w	$E706
	dc.w	$DB1B
	dc.w	$DE0D
	dc.w	$E000

; Unused data follows
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
; Coder's group signature?
	dc.w	$ECA

; Main entry point. Originally located at $5334c

main:
; Clear area from $60000 to $6FFFF
	LEA	stars_bpl1,A0
	MOVE.L	#$8000,D0		;Unnecessary
	MOVE.L	#$FFFF,D0
.loop:
	CLR.B	(A0)+
	DBRA	D0,.loop
	MOVE.W	#$83C0,$DFF096
	MOVE.L	#mainprg,$80
	TRAP	#0
	CLR.L	D0
	RTS

mainprg:
	MOVE.W	#$4000,$DFF09A
	MOVE.L	#copper_list,$DFF080	;COP1LCH
	CLR.W	$DFF088			;COPJMP1
	MOVE.W	#$0020,$DFF096		;DMACON
mainloop:
	MOVE.L	$DFF004,D0		;VPOSR
	ASR.L	#8,D0
	CMPI.W	#$101,D0
	BNE.S	mainloop

	MOVEM.L	D0-D7/A0-A6,-(SP)
	BSR	clearplane
	BSR	calc_vect
	BSR	do_proj
	BSR	draw_lines
	MOVEM.L	(SP)+,D0-D7/A0-A6
	JSR	music_tick
	BSR	scroll_text
	BSR	do_stars
	BTST	#6,$BFE001
	BNE.S	mainloop

	BSR	sound_off

	MOVE.W	#$C000,$DFF09A	;INTENA
	MOVE.W	#$8020,$DFF096	;DMACON
; Restore copper list. This makes assumptions about the position
; of graphics.library in the list of libraries, which is bad.
	MOVE.L	4,A6
	MOVE.L	(A6),A6
	MOVE.L	(A6),A6
	MOVE.L	$26(A6),$DFF080	;COP1LCH
	CLR.W	$DFF088		;COPJMP1
	RTE

sound_off:
	CLR.W	$DFF0A8
	CLR.W	$DFF0B8
	CLR.W	$DFF0C8
	CLR.W	$DFF0D8
	MOVE.W	#15,$DFF096
	RTS

scroll_text:
	MOVE.L	#$E000E,$DFF064		;BLTAMOD/BLTDMOD
	MOVE.L	#text_bpl+2,$DFF050	;BLTAPTR
	MOVE.L	#text_bpl,$DFF054	;BLTDPTR
	MOVE.L	#$F9F00000,$DFF040	;BLTCON0/BLTCON1
	MOVE.W	#$217,$DFF058		;BLTSIZE
.waitblit:
	BTST	#14,$DFF002			;DMACONR, #14 is allowed, but should be 6
	BNE.S	.waitblit
	ADD.B	#1,scrollbitcnt
	CMPI.B	#8,scrollbitcnt
	BNE.L	scroll_done
	CLR.W	scrollbitcnt
scroll_nextchar:
	CLR.L	D0
	MOVE.L	scrollpointer,A0
	MOVE.B	(A0)+,D0
	ADD.L	#1,scrollpointer
	TST.B	D0
	BNE.L	scrollnotend
	MOVE.L	#scrolltext,scrollpointer
	BRA	scroll_nextchar

scrollnotend:
	SUBI.W	#$20,D0
	LSL.W	#1,D0
	LEA	fontoffsets,A0
	MOVE.L	#0,A5
	MOVE.W	(A0,D0.W),A5
	ADDA.L	#fontdata,A5
;text bitplane is displayed at +2
;new character is copied to additional +2 bytes outside of view
	LEA	text_bpl+44,A6
	MOVE.B	40(A5),(A6)
	MOVE.B	80(A5),60(A6)
	MOVE.B	120(A5),120(A6)
	MOVE.B	160(A5),180(A6)
	MOVE.B	200(A5),240(A6)
	MOVE.B	240(A5),300(A6)
	MOVE.B	280(A5),360(A6)
scroll_done:
	RTS

scrollpointer:
	dc.l	scrolltext

scrolltext:
	dc.b	' THE LATEST CRACK FROM PARANOIMIA IS CALLED '
	dc.b	' BEACH VOLLEY !!!!!  THIS MAGIC IS DEDICATED'
	dc.b	' TO JIMMY JAMES AND TERRI LEWIS OF FLYTE TIM'
	dc.b	'E PRODUCTIONS. WHAT THEY DID HAS ALWAYS BEEN'
	dc.b	' EXTRAORDINARY AND FANTASTIC: NOW LET''S SPE'
	dc.b	'ND SOME TIME ON THE TOTAL OPPOSITE : KOTEX. '
	dc.b	'A GROUP FULL OF LAMERS AND THEIR BOSS A PSEU'
	dc.b	'DO - CRACKER, WHO IS THE MOST UGLY LOOKING G'
	dc.b	'UY IN THE WORLD OF PIRACY. WHE HAS ONE ESSEN'
	dc.b	'TIALL TIP FOR HIM : TO IMPROVE YOUR IMAGE A '
	dc.b	'LITTLE BIT YOU SHOULD START USING SHAMPOO TO'
	dc.b	' WASH YOUR HAIR. THATS ENOUGH ABOUT QUARTEX '
	dc.b	'FOR TODAY      ',0,0
	dc.b	0
	dc.b	0
	dc.b	'                                            '
	dc.b	'                                ............'
	dc.b	'.....''',0,0

	EVEN

; Offset of the character data in the font bitmap (320x15 pixels).
; Starts with character 32 (space).
fontoffsets:
	dc.w	$14B
	dc.w	$1E
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1D
	dc.w	$20
	dc.w	$21
	dc.w	0
	dc.w	0
	dc.w	$1C
	dc.w	0
	dc.w	$1B
	dc.w	$22
	dc.w	$149
	dc.w	$140
	dc.w	$141
	dc.w	$142
	dc.w	$143
	dc.w	$144
	dc.w	$145
	dc.w	$146
	dc.w	$147
	dc.w	$148
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	$1F
	dc.w	0
	dc.w	0
	dc.w	1
	dc.w	2
	dc.w	3
	dc.w	4
	dc.w	5
	dc.w	6
	dc.w	7
	dc.w	8
	dc.w	9
	dc.w	10
	dc.w	11
	dc.w	12
	dc.w	13
	dc.w	14
	dc.w	15
	dc.w	$10
	dc.w	$11
	dc.w	$12
	dc.w	$13
	dc.w	$14
	dc.w	$15
	dc.w	$16
	dc.w	$17
	dc.w	$18
	dc.w	$19

do_stars:
	MOVEM.L	D0-D7/A0-A6,-(SP)

; starpostab stores (x,y,z) for each star in words
	LEA	starpostab,A4

	MOVE.L	#num_stars-1,D3

; starrestoretab stores (star offset in bpl,bit number) in words
	LEA	starrestoretab,A5
starloop:
	MOVE.W	(A4)+,D4	;x-pos
	MOVE.W	(A4)+,D5	;y-pos
	MOVE.W	(A4),D6	;z-pos
	SUBQ.W	#6,(A4)+	;decr z-pos
	TST.W	D6
	BLE.L	reinit_starpos
	EXT.L	D4
	EXT.L	D5
	DIVS.W	D6,D4
	DIVS.W	D6,D5
	ADD.W	#160,D4
	ADD.W	#128,D5
	TST.W	D4
	BLT.L	reinit_starpos
	TST.W	D5
	BLT.L	reinit_starpos
	CMPI.W	#319,D4
	BGT.L	reinit_starpos
	CMPI.W	#255,D5
	BGT.L	reinit_starpos
	MULU.W	#40,D5
	MOVE.W	D4,D7
	LSR.W	#3,D4
	ADD.W	D4,D5
	NOT.B	D7
	MOVE.W	(A5),D0
	MOVE.W	D5,(A5)+
	MOVE.W	(A5),D1
	MOVE.W	D7,(A5)+
	LEA	stars_bpl1,A1
	BCLR	D1,(A1,D0.W)
	ADD.L	#stars_bpl2-stars_bpl1,D0
	BCLR	D1,(A1,D0.W)
	CMPI.W	#400,D6
	BGT.S	star_depth1
	CMPI.W	#300,D6
	BGT.S	star_depth2
	BSET	D7,(A1,D5.L)
	ADD.L	#stars_bpl2-stars_bpl1,D5
	BSET	D7,(A1,D5.L)
nextstar:
	DBRA	D3,starloop
	MOVE.W	(A5)+,D0
	MOVE.W	(A5),D1
; Clear the last star. This is probably wrong because it reads over
; end of table.
	LEA	stars_bpl1,A1
	BCLR	D1,(A1,D0.W)
	ADD.L	#stars_bpl2-stars_bpl1,D0
	BCLR	D1,(A1,D0.W)

	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

; Pseudo random number generator. Depends on HPOS, which makes it
; unfit for faster processors, resulting in equal values.

update_starrnd:
	MOVE.W	$DFF006,D0
	LEA	prnd_value,A3
	MULS.W	(A3),D0
	ADD.W	#4681,D0
	MOVE.W	D0,(A3)
	RTS

reinit_starpos:
	BSR.S	update_starrnd
	MOVE.W	D0,-6(A4)
	BSR.S	update_starrnd
	MOVE.W	D0,-4(A4)
	MOVE.W	#$300,-2(A4)
	BRA	nextstar

star_depth2:
	LEA	stars_bpl2,A1
star_depth1:
	BSET	D7,(A1,D5.L)
	BRA	nextstar

copper_list:
	dc.w	$0092,$0038		;DDFSTRT
	dc.w	$0094,$00D0		;DDFSTOP
	dc.w	$008E,$2041		;DIWSTRT V=32,H=65 ($2041)
;following value seems wrong. $15FF works
	dc.w	$0090,$35FF		;DIWSTOP V=53,H=255 ($35FF)

	dc.w	$2001,$FFFE

;Note: $E0/E2 and $E8/EA are not reset here. Can result in
;garbage from vector bitplane above text scroller when running.

;Syntax for low word/high word works this way in ASM-One and Asm-Pro
;Normally the bitplane pointers are set in the code, but this binary
;already had the pointers initialized so has been reconstructed as-is.

	dc.w	$00E4,stars_bpl1>>16	;BPL2PTH stars bitplane A
	dc.w	$00E6,(stars_bpl1<<16)>>16
	dc.w	$00EC,stars_bpl2>>16	;BPL4PTH stars bitplane B
	dc.w	$00EE,(stars_bpl2<<16)>>16
	dc.w	$0186,$0FFF		;COLOR03

	dc.w	$3207,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$3307,$FFFE
	dc.w	$0180,$000C		;COLOR00

	dc.w	$3507,$FFFE
	dc.w	$00E0,text_bpl>>16	;BPL1PTH text bitplane
	dc.w	$00E2,((text_bpl+2)<<16)>>16
	dc.w	$00E8,text_bpl>>16	;BPL3PTH text bitplane
	dc.w	$00EA,((text_bpl+2)<<16)>>16
	dc.w	$0108,$0014		;BPL1MOD

	dc.w	$3E07,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$3F07,$FFFE
	dc.w	$0180,$0000		;COLOR00

	dc.w	$4007,$FFFE
	dc.w	$00E0,vector_bpl>>16	;BPL1PTH vector bitplane
	dc.w	$00E2,(vector_bpl<<16)>>16
	dc.w	$00E8,vector_bpl>>16	;BPL3PTH vector bitplane
	dc.w	$00EA,(vector_bpl<<16)>>16
	dc.w	$0108,$0000		;BPL1MOD
	dc.w	$0192,$0777		;COLOR09
	dc.w	$0194,$0BBB		;COLOR10
	dc.w	$0196,$0FFF		;COLOR11

	dc.w	$EA07,$FFFE
	dc.w	$00E0,ea_logo>>16	;BPL1PTH credits logo
	dc.w	$00E2,(ea_logo<<16)>>16
	dc.w	$00E8,ea_logo>>16	;BPL3PTH credits logo
	dc.w	$00EA,(ea_logo<<16)>>16
	dc.w	$0108,$0000		;BPL1MOD

	dc.w	$EF07,$FFFE
	dc.w	$0186,$0000		;COLOR03
	dc.w	$0100,$4600		;BPLCON0
	dc.w	$010A,$0000		;BPL2MOD - unneeded

	dc.w	$F207,$FFFE
	dc.w	$0180,$000A		;COLOR00
	dc.w	$0186,$000A		;COLOR03

	dc.w	$F307,$FFFE
	dc.w	$0180,$000C		;COLOR00
	dc.w	$0186,$000C		;COLOR03

	dc.w	$F507,$FFFE
	dc.w	$00E0,text_bpl>>16	;text bitplane
	dc.w	$00E2,((text_bpl+2)<<16)>>16
	dc.w	$0186,$0FFF		;COLOR03
	dc.w	$00E8,text_bpl>>16	;text bitplane
	dc.w	$00EA,((text_bpl+2)<<16)>>16
	dc.w	$0108,$0014		;BPL1MOD

	dc.w	$FE07,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$FF07,$FFFE
	dc.w	$0180,$0000		;COLOR00

	dc.w	$FFFF,$FFFE

prnd_value:	dc.w	0

scrollbitcnt:	dc.b	0

	even

calc_vect:
	ADD.W	#3,rot_a		;rotate around x-axis
	ANDI.W	#$1FF,rot_a
	ADD.W	#4,rot_b		;rotate around y-axis
	ANDI.W	#$1FF,rot_b
	BSR	init_rot
	BSR	calc_rot_b
	BSR	calc_rot_a
	BSR	calc_points
	RTS

;Clear the vector bitplane with the Blitter
clearplane:
	MOVE.L	#$1000000,$DFF040	;BLTCON0/1
	MOVE.L	#vector_buffer,$DFF054	;BLTDPTR
	MOVE.W	#0,$DFF066		;BLTDMOD
	MOVE.W	#$3A14,$DFF058		;BLTSIZE
	RTS

draw_line:
	MOVEM.L	D0-D7/A0-A6,-(SP)	;Excessive
	MOVE.W	D2,D0
	MOVE.W	D3,D1
	MOVE.W	A2,D2
	MOVE.W	A3,D3
	MOVE.L	#vector_buffer,A0
	SUB.W	D1,D3
	BPL.S	lbC003152
	NEG.W	D3
	SUB.W	D0,D2
	BPL.S	lbC003160
	NEG.W	D2
	CMP.W	D3,D2
	BPL.S	lbC003170
	MOVEQ	#13,D4
	BRA.S	lbC003180

lbC003152:
	SUB.W	D0,D2
	BPL.S	lbC003168
	NEG.W	D2
	CMP.W	D3,D2
	BPL.S	lbC003174
	MOVEQ	#9,D4
	BRA.S	lbC003180

lbC003160:
	CMP.W	D3,D2
	BPL.S	lbC00317C
	MOVEQ	#5,D4
	BRA.S	lbC003180

lbC003168:
	CMP.W	D3,D2
	BPL.S	lbC003178
	MOVEQ	#1,D4
	BRA.S	lbC003180

lbC003170:
	MOVEQ	#29,D4
	BRA.S	lbC003182

lbC003174:
	MOVEQ	#21,D4
	BRA.S	lbC003182

lbC003178:
	MOVEQ	#17,D4
	BRA.S	lbC003182

lbC00317C:
	MOVEQ	#25,D4
	BRA.S	lbC003182

lbC003180:
	EXG	D3,D2
lbC003182:
	MOVE.W	D2,D5
	ADDQ.W	#1,D5
	ASL.W	#6,D5
	ADDQ.W	#2,D5
	MOVE.W	D0,D6
	LSR.W	#3,D0
	MULU.W	#40,D1
	ADD.W	D1,D0
	ADDA.W	D0,A0
	ADD.W	D3,D3
	MOVE.W	D3,D7
	CMP.W	D2,D7
	BPL.S	lbC0031BA
	BSET	#6,D4
	SUB.W	D2,D7
	SUB.W	D2,D7
	BSR	blitprio
	MOVE.W	D7,$DFF052		;BLTAPTL
	ADD.W	D7,D7
	MOVE.W	D7,$DFF064		;BLTAMOD
	BRA.S	lbC0031D0

lbC0031BA:
	BSR	blitprio
	MOVE.W	D7,$DFF052		;BLTAPTL
	SUB.W	D2,D7
	SUB.W	D2,D7
	ADD.W	D7,D7
	MOVE.W	D7,$DFF064		;BLTAMOD
lbC0031D0:
	ADD.W	D3,D3
	MOVE.W	D3,$DFF062
	ROR.W	#4,D6
	ANDI.W	#$F000,D6
	ORI.W	#$0BFA,D6
	MOVE.W	#$28,$DFF060		;BLTCMOD
	MOVE.L	#$FFFFFFFF,$DFF044	;BLTAFWM
	MOVE.W	#$8000,$DFF074		;BLTADAT
	MOVE.W	D6,$DFF040		;BLTCON0
	MOVE.W	D4,$DFF042		;BLTCON1
	MOVE.L	A0,$DFF048		;BLTCPTH
	MOVE.L	A0,$DFF054		;BLTDPTH
	MOVE.W	D5,$DFF058		;BLTSIZE
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

blitprio:
	MOVE.W	#$8400,$DFF096		;DMACON, set blitter prio
.waitblit:
	BTST	#14,$DFF002		;DMACONR, #14 is allowed, but should be 6
	BNE.S	.waitblit
	MOVE.W	#$400,$DFF002		;Reset blitter prio
	RTS

; Get Sine and Cosine from table
; input  D0 = x
; output D1 = sin(x)
; output D2 = cos(x)
get_sines:
	LEA	sine_data,A1
	LSL.W	#1,D0
	MOVE.W	(A1,D0.W),D1
	LEA	cosine_data,A1
	MOVE.W	(A1,D0.W),D2
	RTS

init_rot:
	MOVEQ	#0,D1
	MOVE.W	#$4000,D2
	MOVE.W	D2,w57E64
	MOVE.W	D1,w57E66
	MOVE.W	D1,w57E68
	MOVE.W	D1,w57E6A
	MOVE.W	D2,w57E6C
	MOVE.W	D1,w57E6E
	MOVE.W	D1,w57E70
	MOVE.W	D1,w57E72
	MOVE.W	D2,w57E74
	RTS

calc_rot_b:
	MOVE.W	rot_b,D0
	JSR	get_sines
	MOVE.W	D1,D3
	MOVE.W	D2,D4
	MOVE.W	w57E64,w57E52
	MOVE.W	w57E6A,w57E58
	MOVE.W	w57E70,w57E5E
	MULS.W	w57E66,D2
	MULS.W	w57E68,D1
	SUB.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E54
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E6C,D2
	MULS.W	w57E6E,D1
	SUB.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E5A
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E72,D2
	MULS.W	w57E74,D1
	SUB.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E60
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E66,D1
	MULS.W	w57E68,D2
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E56
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E6C,D1
	MULS.W	w57E6E,D2
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E5C
	MULS.W	w57E72,D3
	MULS.W	w57E74,D4
	ADD.L	D3,D4
	LSL.L	#2,D4
	SWAP	D4
	MOVE.W	D4,w57E62

	MOVE.L	#w57E52,A1
	MOVE.L	#w57E64,A2
	MOVEQ	#8,D7
.copy:
	MOVE.W	(A1)+,(A2)+
	DBRA	D7,.copy
	RTS

calc_rot_a:
	MOVE.W	rot_a,D0
	JSR	get_sines
	MOVE.W	D1,D3
	MOVE.W	D2,D4
	MULS.W	w57E64,D2
	MULS.W	w57E68,D1
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E52
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E6A,D2
	MULS.W	w57E6E,D1
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E58
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E70,D2
	MULS.W	w57E74,D1
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E5E
	NEG.W	D3
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MOVE.W	w57E66,w57E54
	MOVE.W	w57E6C,w57E5A
	MOVE.W	w57E72,w57E60
	MULS.W	w57E64,D1
	MULS.W	w57E68,D2
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E56
	MOVE.W	D3,D1
	MOVE.W	D4,D2
	MULS.W	w57E6A,D1
	MULS.W	w57E6E,D2
	ADD.L	D1,D2
	LSL.L	#2,D2
	SWAP	D2
	MOVE.W	D2,w57E5C
	MULS.W	w57E70,D3
	MULS.W	w57E74,D4
	ADD.L	D3,D4
	LSL.L	#2,D4
	SWAP	D4
	MOVE.W	D4,w57E62

	MOVEQ	#8,D7
	MOVE.L	#w57E52,A1
	MOVE.L	#w57E64,A2
.copy:
	MOVE.W	(A1)+,(A2)+
	DBRA	D7,.copy
	RTS

calc_points:
	MOVE.L	#num_points-1,D0
	MOVE.L	#points_x,A1
	MOVE.L	#points_y,A2
	MOVE.L	#points_z,A3
	MOVE.L	#points_rot_x,A4
	MOVE.L	#points_rot_y,A5
	MOVE.L	#points_rot_z,A6
calcloop:
	MOVE.W	(A1)+,D1
	MOVE.W	D1,D4
	MOVE.W	(A2)+,D2
	MOVE.W	D2,D5
	MOVE.W	(A3)+,D3
	MOVE.W	D3,D6
	MULS.W	w57E64,D1
	MULS.W	w57E6A,D2
	MULS.W	w57E70,D3
	ADD.L	D1,D2
	ADD.L	D2,D3
	SWAP	D3
	MOVE.W	D3,(A4)+
	MOVE.W	D4,D1
	MOVE.W	D5,D2
	MOVE.W	D6,D3
	MULS.W	w57E66,D1
	MULS.W	w57E6C,D2
	MULS.W	w57E72,D3
	ADD.L	D1,D2
	ADD.L	D2,D3
	SWAP	D3
	MOVE.W	D3,(A5)+
	MULS.W	w57E68,D4
	MULS.W	w57E6E,D5
	MULS.W	w57E74,D6
	ADD.L	D4,D5
	ADD.L	D5,D6
	SWAP	D6
	MOVE.W	D6,(A6)+
	DBRA	D0,calcloop
	RTS

; Project the points from three-dimensional space (x,y,z)
; to screen coordinates (x,y)

do_proj:
	MOVE.L	#points_rot_x,A1
	MOVE.L	#points_rot_y,A2
	MOVE.L	#points_rot_z,A3
	MOVE.L	#points_proj_x,A4
	MOVE.L	#points_proj_y,A5
	MOVE.L	#num_points-1,D0
projloop:
	MOVE.W	(A3)+,D3
	MOVE.W	(A1)+,D4
	MOVE.W	(A2)+,D5
	LSL.L	#8,D4
	LSL.L	#8,D5
	EXT.L	D4
	EXT.L	D5
	ADD.W	#$100,D3
	TST.W	D3
	BNE.L	.notzero
	MOVE.W	#1,D3
.notzero:
	DIVS.W	D3,D4
	DIVS.W	D3,D5
	ADD.W	#168,D4
	ADD.W	#128,D5
	MOVE.W	D4,(A4)+
	MOVE.W	D5,(A5)+
	DBRA	D0,projloop
	RTS

draw_lines:
	MOVE.L	#points_proj_x,A4
	MOVE.L	#points_proj_y,A5
	MOVE.L	#line_table,A6
	MOVE.L	#num_lines-1,D0
.loop:
	MOVE.L	(A6)+,D1
	SUBQ.W	#1,D1
	ADD.W	D1,D1
	MOVE.W	(A4,D1.W),D2
	MOVE.W	(A5,D1.W),D3
	SWAP	D1
	SUBQ.W	#1,D1
	ADD.W	D1,D1
	MOVE.W	(A4,D1.W),A2
	MOVE.W	(A5,D1.W),A3
	BSR	draw_line
	DBRA	D0,.loop
	RTS

; 37 3D point coordinates, split into separate x, y and z value tables.
; z is always zero, which could be optimized in the code.
points_x:
	dc.w	-400,-340,-340,-400,-400
	dc.w	-320,-292,-260,-240,-180
	dc.w	-180,-240,-240,-180,$FF60
	dc.w	-132,-100,-80,-80,-20
	dc.w	-20,0,0,60,60
	dc.w	80,80,100,100,140
	dc.w	180,180,200,200,220
	dc.w	252,280

points_y:
	dc.w	-60,-60,0,0,60
	dc.w	60,-60,60,-60,-60
	dc.w	0,0,60,60,60
	dc.w	-60,60,-60,60,-60
	dc.w	60,-60,60,60,-60
	dc.w	-60,60,-60,60,0
	dc.w	-60,60,-60,60,60
	dc.w	-60,60

points_z:
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0,0,0,0
	dc.w	0,0

; Line table defining (from,to) using point ids.
; Could be made zero-based saving a SUBQ.
line_table:
	dc.w	1,2
	dc.w	2,3
	dc.w	3,4
	dc.w	1,5
	dc.w	6,7
	dc.w	7,8
	dc.w	9,10
	dc.w	10,11
	dc.w	11,12
	dc.w	9,13
	dc.w	12,14
	dc.w	15,$10
	dc.w	$10,$11
	dc.w	$12,$13
	dc.w	$14,$15
	dc.w	$12,$15
	dc.w	$16,$17
	dc.w	$17,$18
	dc.w	$18,$19
	dc.w	$19,$16
	dc.w	$1A,$1B
	dc.w	$1C,$1D
	dc.w	$1C,$1E
	dc.w	$1E,$1F
	dc.w	$1F,$20
	dc.w	$21,$22
	dc.w	$23,$24
	dc.w	$24,$25

; Vector rotation angles
; Initialized to $3333 in the unpacked data, which probably was
; not intentional, but sets the rotation to a specific start.
rot_b:	dc.w	$3333
rot_a:	dc.w	$3333

; Destination arrays for vector calculations
points_rot_x:	ds.w	1600	; org. $53FD2
points_rot_y:	ds.w	1600	; org. $54C52
points_rot_z:	ds.w	1600	; org. $558d2
points_proj_x:	ds.w	1600	; org. $56552
points_proj_y:	ds.w	1600	; org. $571d2

; Temporary variables for vector calculation
w57E52:	dc.w	0
w57E54:	dc.w	0
w57E56:	dc.w	0
w57E58:	dc.w	0
w57E5A:	dc.w	0
w57E5C:	dc.w	0
w57E5E:	dc.w	0
w57E60:	dc.w	0
w57E62:	dc.w	0

w57E64:	dc.w	0
w57E66:	dc.w	0
w57E68:	dc.w	0
w57E6A:	dc.w	0
w57E6C:	dc.w	0
w57E6E:	dc.w	0
w57E70:	dc.w	0
w57E72:	dc.w	0
w57E74:	dc.w	0
