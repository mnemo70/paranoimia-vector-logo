music_tick:
	movem.l	D0-D7/A0-A6,-(SP)
	lea	musicdata(PC),A6
	tst.b	$10(A6)
	bne.s	lbC000028
	bsr	lbC0000D4
	bra.s	lbC00002C

lbC000028:
	bsr	lbC0001B6
lbC00002C:
	addq.b	#1,$10(A6)
	move.b	$10(A6),D0
	cmp.b	$12(A6),D0
	bne.w	lbC0000BA
	clr.b	$10(A6)
	addq.b	#1,$11(A6)
	cmp.b	#$10,$11(A6)
	bne.s	lbC0000A0
	clr.b	$11(A6)
	addq.w	#1,$14(A6)
	lea	$22E(A6),A1
lbC000058:
	clr.l	D0
	move.w	$14(A6),D0
	mulu.w	#$14,D0
	tst.l	(A1,D0.W)
	bne.s	lbC00006E
	clr.w	$14(A6)
	bra.s	lbC000058

lbC00006E:
	move.l	$16(A6),A0
	move.l	(A1,D0.W),(A0)
	move.l	4(A1,D0.W),$68(A0)
	move.l	8(A1,D0.W),$D0(A0)
	move.l	12(A1,D0.W),$138(A0)
	move.b	$10(A1,D0.W),$66(A0)
	move.b	$11(A1,D0.W),$CE(A0)
	move.b	$12(A1,D0.W),$136(A0)
	move.b	$13(A1,D0.W),$19E(A0)
lbC0000A0:
	move.l	$16(A6),A0
	moveq	#3,D7
lbC0000A6:
	bsr	lbC00037E
	bsr	lbC0001F6
	lea	$68(A0),A0
	dbra	D7,lbC0000A6
	bra.s	lbC0000CE

lbC0000BA:
	move.l	$16(A6),A0
	moveq	#3,D7
lbC0000C0:
	bsr	lbC0001F6
	lea	$68(A0),A0
	dbra	D7,lbC0000C0
lbC0000CE:
	movem.l	(SP)+,D0-D7/A0-A6
	rts

lbC0000D4:
	move.l	$16(A6),A0
	clr.w	D6
	tst.w	$1A(A0)
	beq.s	lbC0000E4
	bset	#0,D6
lbC0000E4:
	tst.w	$82(A0)
	beq.s	lbC0000EE
	bset	#1,D6
lbC0000EE:
	tst.w	$EA(A0)
	beq.s	lbC0000F8
	bset	#2,D6
lbC0000F8:
	tst.w	$152(A0)
	beq.s	lbC000102
	bset	#3,D6
lbC000102:
	move.w	D6,$DFF096
	lea	$DFF0A0,A1
	move.l	$16(A6),A0
	moveq	#3,D7
lbC000114:
	move.b	$15(A0),9(A1)
	move.w	$20(A0),6(A1)
	tst.w	$1A(A0)
	beq.s	lbC000130
	move.l	$16(A0),(A1)
	move.w	$1A(A0),4(A1)
lbC000130:
	lea	$68(A0),A0
	lea	$10(A1),A1
	dbra	D7,lbC000114
	move.l	$16(A6),A0
	lea	$22(A0),A0
	moveq	#7,D0
lbC00014C:
	move.l	$158(A0),$138(A0)
	move.l	$F0(A0),$D0(A0)
	move.l	$88(A0),$68(A0)
	move.l	$20(A0),(A0)+
	dbra	D0,lbC00014C
	move.w	#$100,D0
lbC00016A:
	dbra	D0,lbC00016A
	ori.w	#$8000,D6
	move.w	D6,$DFF096
	move.l	$16(A6),A0
	lea	$DFF0A0,A1
	moveq	#3,D7
lbC000184:
	tst.w	$1A(A0)
	beq.s	lbC0001A4
	clr.l	D1
	move.w	$1C(A0),D1
	lsl.l	#1,D1
	move.l	$16(A0),A2
	adda.l	D1,A2
	move.l	A2,(A1)
	move.w	$1E(A0),4(A1)
	clr.w	$1A(A0)
lbC0001A4:
	lea	$68(A0),A0
	lea	$10(A1),A1
	dbra	D7,lbC000184
	rts

lbC0001B6:
	lea	$DFF0A0,A1
	move.l	$16(A6),A0
	moveq	#3,D7
lbC0001C2:
	move.b	$15(A0),9(A1)
	move.w	$20(A0),6(A1)
	btst	#0,$14(A0)
	beq.s	lbC0001E4
	lea	$22(A0),A2
	moveq	#7,D0
lbC0001DC:
	move.l	$20(A2),(A2)+
	dbra	D0,lbC0001DC
lbC0001E4:
	lea	$68(A0),A0
	lea	$10(A1),A1
	dbra	D7,lbC0001C2
	rts

lbC0001F6:
	tst.b	$14(A0)
	bmi	lbC00037C
	move.l	4(A0),A1
	move.l	(A1),A2
	move.w	$10(A0),D0
	clr.w	D1
	move.b	(A2,D0.W),D1
	moveq	#0,D2
	move.b	12(A0),D2
	mulu.w	D2,D1
	lsr.w	#7,D1
	move.b	D1,$15(A0)
	lea	$46(A6),A2
	lea	$5A2(A6),A3
	clr.l	D5
	move.b	14(A0),D5
	lsl.w	#3,D5
	moveq	#0,D6
	move.b	15(A0),D6
	add.w	D6,D5
	move.w	8(A0),D0
	move.l	8(A1),A4
	move.w	$64(A0),D1
	clr.w	D2
	move.b	(A4,D1.W),D2
	move.w	$62(A0),D3
	bpl.s	lbC00024E
	neg.w	D3
lbC00024E:
	sub.w	#$4000,D3
	muls.w	D2,D3
	lsr.l	#6,D3
	lsr.l	#6,D3
	add.w	D3,D0
	move.w	D0,D1
	lsr.w	#8,D1
	sub.b	(A3,D5.W),D1
	lsl.w	#1,D1
	move.w	(A2,D1.W),D3
	and.w	#$FF,D0
	beq.s	lbC000280
	move.w	2(A2,D1.W),D4
	move.w	#$100,D2
	sub.w	D0,D2
	mulu.w	D0,D4
	mulu.w	D2,D3
	add.l	D4,D3
	lsr.l	#8,D3
lbC000280:
	move.w	D3,$20(A0)
	btst	#0,$14(A0)
	beq.s	lbC0002FA
	move.w	$12(A0),D0
	move.l	$12(A1),A2
	moveq	#0,D1
	move.b	(A2,D0.W),D1
	move.w	#$80,D0
	sub.w	D1,D0
	move.w	#$1F,D4
	lea	$42(A0),A2
	move.l	$1A(A1),A3
	tst.l	$1E(A1)
	beq.s	lbC0002D0
	move.l	$1E(A1),A4
lbC0002B8:
	move.b	(A3)+,D2
	ext.w	D2
	move.b	(A4)+,D3
	ext.w	D3
	muls.w	D0,D2
	muls.w	D1,D3
	add.w	D2,D3
	asr.w	#7,D3
	move.b	D3,(A2)+
	dbra	D4,lbC0002B8
	bra.s	lbC0002FA

lbC0002D0:
	btst	#1,$14(A0)
	beq.s	lbC0002DC
	move.l	A2,A3
lbC0002DC:
	bset	#1,$14(A0)
	move.b	$1F(A3),D3
	ext.w	D3
lbC0002E8:
	move.b	(A3)+,D2
	ext.w	D2
	muls.w	D0,D2
	muls.w	D1,D3
	add.w	D2,D3
	asr.w	#7,D3
	move.b	D3,(A2)+
	dbra	D4,lbC0002E8
lbC0002FA:
	move.w	10(A0),D0
	add.w	D0,8(A0)
	clr.w	D0
	clr.w	D1
	move.b	13(A0),D0
	ext.w	D0
	move.b	12(A0),D1
	add.w	D0,D1
	bpl.s	lbC000318
	clr.b	D1
	bra.s	lbC000322

lbC000318:
	cmp.w	#$81,D1
	bmi.s	lbC000322
	move.w	#$80,D1
lbC000322:
	move.b	D1,12(A0)
	addq.b	#1,15(A0)
	and.b	#7,15(A0)
	addq.w	#1,$10(A0)
	move.w	$10(A0),D0
	cmp.w	4(A1),D0
	bne.s	lbC000344
	move.w	6(A1),$10(A0)
lbC000344:
	move.w	$10(A1),D0
	add.w	D0,$62(A0)
	addq.w	#1,$64(A0)
	move.w	$64(A0),D0
	cmp.w	12(A1),D0
	bne.s	lbC000360
	move.w	14(A1),$64(A0)
lbC000360:
	btst	#0,$14(A0)
	beq.s	lbC00037C
	addq.w	#1,$12(A0)
	move.w	$12(A0),D0
	cmp.w	$16(A1),D0
	bne.s	lbC00037C
	move.w	$18(A1),$12(A0)
lbC00037C:
	rts

lbC00037E:
	move.l	(A0),A1
lbC000380:
	move.b	(A1)+,D0
	beq	lbC00047E
	bpl.s	lbC0003DE
	cmp.b	#$B8,D0
	bpl	lbC000468
	cmp.b	#$9C,D0
	bne.s	lbC0003A0
	move.b	(A1)+,14(A0)
	clr.b	15(A0)
	bra.s	lbC000380

lbC0003A0:
	cmp.b	#$9B,D0
	bne.s	lbC0003B2
	clr.w	D0
	move.b	(A1)+,D0
	ext.w	D0
	move.w	D0,10(A0)
	bra.s	lbC000380

lbC0003B2:
	cmp.b	#$9A,D0
	bne.s	lbC0003BE
	move.b	(A1)+,13(A0)
	bra.s	lbC000380

lbC0003BE:
	cmp.b	#$99,D0
	bne.s	lbC0003D2
	move.b	(A1)+,D1
	lsl.b	#1,D1
	move.b	D1,12(A0)
	clr.b	13(A0)
	bra.s	lbC000380

lbC0003D2:
	cmp.b	#$98,D0
	bne.s	lbC0003DC
	move.b	(A1)+,$12(A6)
lbC0003DC:
	bra.s	lbC000380

lbC0003DE:
	btst	#6,D0
	beq.s	lbC00042A
	lea	$D6(A6),A2
	sub.b	#$40,D0
	clr.l	D1
	move.b	D0,D1
	mulu.w	#$22,D1
	lea	(A2,D1.W),A3
	move.l	A3,4(A0)
	clr.l	14(A0)
	clr.w	$12(A0)
	clr.l	$62(A0)
	move.b	#1,$14(A0)
	lea	$22(A0),A4
	move.l	A4,$16(A0)
	move.w	#$10,$1A(A0)
	clr.w	$1C(A0)
	move.w	#$10,$1E(A0)
	bra	lbC000380

lbC00042A:
	subq.b	#1,D0
	lea	$22A(A6),A2
	clr.l	D1
	move.b	D0,D1
	mulu.w	#$1C,D1
	lea	(A2,D1.W),A3
	move.l	A3,4(A0)
	clr.l	14(A0)
	clr.b	$14(A0)
	clr.l	$62(A0)
	move.l	$12(A3),$16(A0)
	move.w	$16(A3),$1A(A0)
	move.w	$18(A3),$1C(A0)
	move.w	$1A(A3),$1E(A0)
	bra	lbC000380

lbC000468:
	not.b	D0
	sub.b	$66(A0),D0
	move.b	D0,8(A0)
	clr.b	9(A0)
	clr.w	10(A0)
	bra	lbC000380

lbC00047E:
	move.l	A1,(A0)
	rts

musicdata:
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0
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
