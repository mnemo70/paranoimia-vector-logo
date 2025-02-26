*******************************************************
*
* PARANOIMIA Vector Cracktro
*
* Code:  Pwy (Electronic Artists, NO)
* Music: TSM (Sunriders, DE)
*
* Disassembled and modernized by MnemoTroN/Spreadpoint
* in 2023 using ReSource V6.06.
*
* This is a slightly improved version of the source
* including more compatible startup code. (P) 2025.
*
* Compiles in Visual Studio Code with the Amiga Assembly
* extension:
* https://github.com/prb28/vscode-amiga-assembly
*
*******************************************************

; 3D starfield
num_stars	EQU	37

; 3D vector logo
num_points	EQU	37
num_lines	EQU	28

****************************************************************************

	opt	o+

	section	main,code_c

; Uses startup code by StingRay
	include	"startup.i"

; Main entry point. Called from startup.i

MAIN:
; Clear BSS data. Kickstart 1.3 seems to mess that up.
	LEA	starpostab,A0
	move.w	#(stardatalength/4)-1,D0
	moveq	#0,D1
.clear
	move.l	D1,(A0)+
	dbra	D0,.clear

;Initialize rotation vectors to their original content
	move.w	#$3333,d0
	move.w	d0,rot_a
	move.w	d0,rot_b

	move.l	#scrolltext,scrollpointer

	bsr	init_bpl_pointers

	move.w	#$0038,$DFF092		;DDFSTRT
	move.w	#$00D0,$DFF094		;DDFSTOP
	move.w	#$2041,$DFF08E		;DIWSTRT V=32,H=65 ($2041)
;following value seems wrong. $15FF works
;	move.w	#$35FF,$DFF090		;DIWSTOP V=53,H=255 ($35FF)
	move.w	#$15FF,$DFF090		;DIWSTOP V=53,H=255 ($35FF)

	move.w	#$0020,$DFF096		;DMACON
	move.w	#0,$DFF10A		;BPL2MOD

	move.w	#$83C0,$DFF096
	move.w	#$4000,$DFF09A

	move.l	#copper_list,$DFF080	;COP1LCH
	clr.w	$DFF088			;COPJMP1
mainloop:
	move.l	$DFF004,D0		;VPOSR
	asr.l	#8,D0
	cmp.w	#$101,D0
	bne.s	mainloop

	bsr	clearplane
	bsr	calc_vect
	bsr	do_proj
	bsr	draw_lines
	jsr	music_tick
	bsr	scroll_text
	bsr	do_stars
	btst	#6,$BFE001
	bne.s	mainloop

;	bsr	sound_off
	rts

;MTN: Obsolete due to startup.i
;sound_off:
;	clr.w	$DFF0A8
;	clr.w	$DFF0B8
;	clr.w	$DFF0C8
;	clr.w	$DFF0D8
;	move.w	#15,$DFF096
;	rts

;Set all bitplane pointers in the copper list

init_bpl_pointers:
	move.l	#ea_logo,D0
	move.w	D0,ea_logo_ptr1+4
	move.w	D0,ea_logo_ptr2+4
	swap	D0
	move.w	D0,ea_logo_ptr1
	move.w	D0,ea_logo_ptr2

	move.l	#stars_bpl1,D0
	move.w	D0,cop_stars_ptr1+4
	swap	D0
	move.w	D0,cop_stars_ptr1

	move.l	#stars_bpl2,D0
	move.w	D0,cop_stars_ptr2+4
	swap	D0
	move.w	D0,cop_stars_ptr2

	move.l	#text_bpl+2,D0
	move.w	D0,cop_text_ptr1+4
	move.w	D0,cop_text_ptr2+4
	move.w	D0,cop_text_bpl_bottom1+4
	move.w	D0,cop_text_bpl_bottom2+4
	swap	D0
	move.w	D0,cop_text_ptr1
	move.w	D0,cop_text_ptr2
	move.w	D0,cop_text_bpl_bottom1
	move.w	D0,cop_text_bpl_bottom2

;Show vector bitplane skipping 30 lines at the top for over-drawing
	move.l	#vector_buffer+30*40,D0
	move.w	D0,cop_vector_ptr1+4
	move.w	D0,cop_vector_ptr2+4
	move.w	D0,cop_vector_ptr1a+4
	move.w	D0,cop_vector_ptr2a+4
	move.w	D0,cop_vector_ptr1b+4
	move.w	D0,cop_vector_ptr2b+4
	swap	D0
	move.w	D0,cop_vector_ptr1
	move.w	D0,cop_vector_ptr2
	move.w	D0,cop_vector_ptr1a
	move.w	D0,cop_vector_ptr2a
	move.w	D0,cop_vector_ptr1b
	move.w	D0,cop_vector_ptr2b
	rts

***************
* SCROLL TEXT *
***************

scroll_text:
	move.l	#$000E000E,$DFF064	;BLTAMOD/BLTDMOD
	move.l	#text_bpl+2,$DFF050	;BLTAPTR
	move.l	#text_bpl,$DFF054	;BLTDPTR
	move.l	#$F9F00000,$DFF040	;BLTCON0/BLTCON1
; Use blitter to scroll the text by one pixel
	move.w	#7<<6+23,$DFF058	;BLTSIZE
.waitblit:
	btst	#6,$DFF002		;DMACONR
	bne.s	.waitblit

	addq.b	#1,scrollbitcnt
	cmp.b	#8,scrollbitcnt
	bne.s	scroll_done
	clr.b	scrollbitcnt
scroll_nextchar:
	clr.l	D0
	move.l	scrollpointer,A0
	move.b	(A0)+,D0
	addq.l	#1,scrollpointer
	tst.b	D0
	bne.s	scrollnotend
	move.l	#scrolltext,scrollpointer
	bra.s	scroll_nextchar

scrollnotend:
	sub.w	#$20,D0
	add.w	D0,D0
	LEA	fontoffsets,A0
	LEA	fontdata,A1
	add.w	(A0,D0.W),A1
;Text bitplane is displayed at +2 bytes for scroll oversize at
;the left. The new character is copied to additional +2 bytes
;outside of view on the right.
	LEA	text_bpl+44,A2
	move.b	40(A1),(A2)
	move.b	80(A1),60(A2)
	move.b	120(A1),120(A2)
	move.b	160(A1),180(A2)
	move.b	200(A1),240(A2)
	move.b	240(A1),300(A2)
	move.b	280(A1),360(A2)
scroll_done:
	rts

**************
* STAR FIELD *
**************

do_stars:
;starpostab stores (x,y,z) for each star in words
	moveq	#num_stars-1,D3
;Prep for PRNG call
	LEA	prnd_value,A3
;starrestoretab stores (star offset in bpl,bit number) in words
	LEA	starpostab,A4
	LEA	starrestoretab,A5

	LEA	stars_bpl1,A1
	LEA	stars_bpl2,A2
starloop:

;Erase old star first
	move.w	(A5),D0		;get old offset
	bmi.s	.skiperase
	move.w	2(A5),D1	;get old bit
;Clear old star in both bitplanes
	bclr	D1,(A1,D0.W)
	bclr	D1,(A2,D0.W)
.skiperase:
	move.w	(A4)+,D4	;3D x-pos
	move.w	(A4)+,D5	;3D y-pos
	move.w	(A4),D6		;3D z-pos
	subq.w	#6,(A4)+	;decrease stored z (distance)
	tst.w	D6
	ble.s	reinit_starpos
;Project 3D position to 2D screen coordinates
	ext.l	D4
	ext.l	D5
	divs.w	D6,D4
	divs.w	D6,D5
	add.w	#160,D4
	bmi.s	reinit_starpos
	add.w	#128,D5
	bmi.s	reinit_starpos
	cmp.w	#319,D4
	bgt.s	reinit_starpos
	cmp.w	#255,D5
	bgt.s	reinit_starpos
	mulu.w	#40,D5		;y * bytes per line
	move.w	D4,D7
	lsr.w	#3,D4		;x/8 -> byte offset
	add.w	D4,D5
	not.b	D7		;flip bit order in byte
	move.w	D5,(A5)+
	move.w	D7,(A5)+	;store new offset

;Check z distance for drawing color (different bitplanes)
	cmp.w	#400,D6
	bgt.s	star_depth1
	cmp.w	#300,D6
	bgt.s	star_depth2
;Set star in both bitplanes
	bset	D7,(A1,D5.W)
	bset	D7,(A2,D5.W)
nextstar:
	dbra	D3,starloop
	rts

;Set star only in bitplane 2
star_depth2:
	bset	D7,(A2,D5.W)
	bra.s	nextstar

;Set star only in bitplane 1
star_depth1:
	bset	D7,(A1,D5.W)
	bra.s	nextstar

reinit_starpos:
	bsr.s	update_starrnd
	move.w	D0,-6(A4)
	bsr.s	update_starrnd
	move.w	D0,-4(A4)
	move.w	#$300,-2(A4)
	bra.s	nextstar

; Pseudo random number generator. Depends on HPOS, which makes it
; unfit for faster processors, resulting in equal values.

update_starrnd:
	move.w	$DFF006,D0
	muls.w	(A3),D0
	add.w	#4681,D0
	move.w	D0,(A3)
	rts

******************
* 3D Vector Logo *
******************

calc_vect:
	addq.w	#3,rot_a		;rotate around x-axis
	and.w	#$1FF,rot_a
	addq.w	#4,rot_b		;rotate around y-axis
	and.w	#$1FF,rot_b
	bsr.s	init_rot
	bsr	calc_rot_b
	bsr	calc_rot_a
	bsr	calc_points
	rts

;Clear the vector bitplane with the Blitter
clearplane:
	move.l	#$01000000,$DFF040		;BLTCON0/1
	move.l	#vector_buffer+30*40,$DFF054	;BLTDPTR
	move.w	#0,$DFF066			;BLTDMOD
;Optimized size of area to clear with Blitter
	move.w	#128<<6+20,$DFF058		;BLTSIZE
	rts

; Get Sine and Cosine from table
; input  D0 = x
; output D1 = sin(x)
; output D2 = cos(x)
get_sines:
	lea	sine_data,A1
	add.w	D0,D0
	move.w	(A1,D0.W),D1
	lea	cosine_data,A1
	move.w	(A1,D0.W),D2
	rts

init_rot:
	moveq	#0,D1
	move.w	#$4000,D2
	move.w	D2,w57E64
	move.w	D1,w57E66
	move.w	D1,w57E68
	move.w	D1,w57E6A
	move.w	D2,w57E6C
	move.w	D1,w57E6E
	move.w	D1,w57E70
	move.w	D1,w57E72
	move.w	D2,w57E74
	rts

calc_rot_b:
	move.w	rot_b,D0
	bsr.s	get_sines
	move.w	D1,D3
	move.w	D2,D4
	move.w	w57E64,w57E52
	move.w	w57E6A,w57E58
	move.w	w57E70,w57E5E
	muls.w	w57E66,D2
	muls.w	w57E68,D1
	sub.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E54
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E6C,D2
	muls.w	w57E6E,D1
	sub.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E5A
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E72,D2
	muls.w	w57E74,D1
	sub.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E60
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E66,D1
	muls.w	w57E68,D2
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E56
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E6C,D1
	muls.w	w57E6E,D2
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E5C
	muls.w	w57E72,D3
	muls.w	w57E74,D4
	add.l	D3,D4
	lsl.l	#2,D4
	swap	D4
	move.w	D4,w57E62

	move.l	#w57E52,A1
	move.l	#w57E64,A2
	moveq	#8,D7
.copy:
	move.w	(A1)+,(A2)+
	dbra	D7,.copy
	rts

calc_rot_a:
	move.w	rot_a,D0
	bsr	get_sines
	move.w	D1,D3
	move.w	D2,D4
	muls.w	w57E64,D2
	muls.w	w57E68,D1
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E52
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E6A,D2
	muls.w	w57E6E,D1
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E58
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E70,D2
	muls.w	w57E74,D1
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E5E
	neg.w	D3
	move.w	D3,D1
	move.w	D4,D2
	move.w	w57E66,w57E54
	move.w	w57E6C,w57E5A
	move.w	w57E72,w57E60
	muls.w	w57E64,D1
	muls.w	w57E68,D2
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E56
	move.w	D3,D1
	move.w	D4,D2
	muls.w	w57E6A,D1
	muls.w	w57E6E,D2
	add.l	D1,D2
	lsl.l	#2,D2
	swap	D2
	move.w	D2,w57E5C
	muls.w	w57E70,D3
	muls.w	w57E74,D4
	add.l	D3,D4
	lsl.l	#2,D4
	swap	D4
	move.w	D4,w57E62

	moveq	#8,D7
	move.l	#w57E52,A1
	move.l	#w57E64,A2
.copy:
	move.w	(A1)+,(A2)+
	dbra	D7,.copy
	rts

calc_points:
	moveq	#num_points-1,D0
	move.l	#points_x,A1
	move.l	#points_y,A2
	move.l	#points_rot_x,A4
	move.l	#points_rot_y,A5
	move.l	#points_rot_z,A6
calcloop:
	move.w	(A1)+,D1
	move.w	D1,D4
	move.w	(A2)+,D2
	move.w	D2,D5
	moveq	#0,D3			;Z=0
	move.w	D3,D6
	muls.w	w57E64,D1
	muls.w	w57E6A,D2
	muls.w	w57E70,D3
	add.l	D1,D2
	add.l	D2,D3
	swap	D3
	move.w	D3,(A4)+
	move.w	D4,D1
	move.w	D5,D2
	move.w	D6,D3
	muls.w	w57E66,D1
	muls.w	w57E6C,D2
	muls.w	w57E72,D3
	add.l	D1,D2
	add.l	D2,D3
	swap	D3
	move.w	D3,(A5)+
	muls.w	w57E68,D4
	muls.w	w57E6E,D5
	muls.w	w57E74,D6
	add.l	D4,D5
	add.l	D5,D6
	swap	D6
	move.w	D6,(A6)+
	dbra	D0,calcloop
	rts

; Project the points from three-dimensional space (x,y,z)
; to screen coordinates (x,y)

do_proj:
	move.l	#points_rot_x,A1
	move.l	#points_rot_y,A2
	move.l	#points_rot_z,A3
	move.l	#points_proj_x,A4
	move.l	#points_proj_y,A5
	moveq	#num_points-1,D0
projloop:
	move.w	(A3)+,D3
	move.w	(A1)+,D4
	move.w	(A2)+,D5
	lsl.l	#8,D4
	lsl.l	#8,D5
	ext.l	D4
	ext.l	D5
	add.w	#$100,D3
	tst.w	D3
	bne.s	.notzero
	moveq	#1,D3
.notzero:
	divs.w	D3,D4
	divs.w	D3,D5
	add.w	#168,D4
	add.w	#128,D5
	move.w	D4,(A4)+
	move.w	D5,(A5)+
	dbra	D0,projloop
	rts

draw_lines:
	move.l	#points_proj_x,A4
	move.l	#points_proj_y,A5
	move.l	#line_table,A6
	moveq	#num_lines-1,D0
.loop:
	move.l	(A6)+,D1		;get start and end index
	subq.w	#1,D1
	add.w	D1,D1
	move.w	(A4,D1.W),D2		;draw end x
	move.w	(A5,D1.W),D3		;draw end y
	swap	D1			;get start index
	subq.w	#1,D1
	add.w	D1,D1
	move.w	(A4,D1.W),A2		;draw start x
	move.w	(A5,D1.W),A3		;draw start y
	move.l	D0,-(SP)
	bsr.s	draw_line
	move.l	(SP)+,D0
	dbra	D0,.loop
	rts

draw_line:
	move.w	D2,D0
	move.w	D3,D1
	move.w	A2,D2
	move.w	A3,D3
	move.l	#vector_buffer,A0
	sub.w	D1,D3
	bpl.s	lbC003152
	neg.w	D3
	sub.w	D0,D2
	bpl.s	lbC003160
	neg.w	D2
	cmp.w	D3,D2
	bpl.s	lbC003170
	moveq	#13,D4
	bra.s	lbC003180

lbC003152:
	sub.w	D0,D2
	bpl.s	lbC003168
	neg.w	D2
	cmp.w	D3,D2
	bpl.s	lbC003174
	moveq	#9,D4
	bra.s	lbC003180

lbC003160:
	cmp.w	D3,D2
	bpl.s	lbC00317C
	moveq	#5,D4
	bra.s	lbC003180

lbC003168:
	cmp.w	D3,D2
	bpl.s	lbC003178
	moveq	#1,D4
	bra.s	lbC003180

lbC003170:
	moveq	#29,D4
	bra.s	lbC003182

lbC003174:
	moveq	#21,D4
	bra.s	lbC003182

lbC003178:
	moveq	#17,D4
	bra.s	lbC003182

lbC00317C:
	moveq	#25,D4
	bra.s	lbC003182

lbC003180:
	exg	D3,D2
lbC003182:
	move.w	D2,D5
	addq.w	#1,D5
	asl.w	#6,D5
	addq.w	#2,D5
	move.w	D0,D6
	lsr.w	#3,D0
	mulu.w	#40,D1
	add.w	D1,D0
	add.w	D0,A0
	add.w	D3,D3
	move.w	D3,D7
	cmp.w	D2,D7
	bpl.s	lbC0031BA
	bset	#6,D4
	sub.w	D2,D7
	sub.w	D2,D7
	bsr.s	blitprio
	move.w	D7,$DFF052		;BLTAPTL
	add.w	D7,D7
	move.w	D7,$DFF064		;BLTAMOD
	bra.s	lbC0031D0

lbC0031BA:
	bsr.s	blitprio
	move.w	D7,$DFF052		;BLTAPTL
	sub.w	D2,D7
	sub.w	D2,D7
	add.w	D7,D7
	move.w	D7,$DFF064		;BLTAMOD
lbC0031D0:
	add.w	D3,D3
	move.w	D3,$DFF062
	ror.w	#4,D6
	and.w	#$F000,D6
	or.w	#$0BFA,D6
	move.w	#40,$DFF060		;BLTCMOD
	move.l	#$FFFFFFFF,$DFF044	;BLTAFWM
	move.w	#$8000,$DFF074		;BLTADAT
	move.w	D6,$DFF040		;BLTCON0
	move.w	D4,$DFF042		;BLTCON1
	move.l	A0,$DFF048		;BLTCPTH
	move.l	A0,$DFF054		;BLTDPTH
	move.w	D5,$DFF058		;BLTSIZE
	rts

blitprio:
	move.w	#$8400,$DFF096		;DMACON, set blitter prio
.waitblit:
	btst	#6,$DFF002		;DMACONR
	bne.s	.waitblit
	move.w	#$400,$DFF002		;Reset blitter prio
	rts

scrolltext:
	dc.b	' THE LATEST CRACK FROM PARANOIMIA IS CALLED  '
	dc.b	'BEACH VOLLEY !!!!!  THIS MAGIC IS DEDICATED '
	dc.b	'TO JIMMY JAMES AND TERRI LEWIS OF FLYTE TIME '
	dc.b	'PRODUCTIONS. WHAT THEY DID HAS ALWAYS BEEN '
	dc.b	'EXTRAORDINARY AND FANTASTIC: NOW LET''S SPEND '
	dc.b	'SOME TIME ON THE TOTAL OPPOSITE : KOTEX. '
	dc.b	'A GROUP FULL OF LAMERS AND THEIR BOSS A '
	dc.b	'PSEUDO - CRACKER, WHO IS THE MOST UGLY LOOKING '
	dc.b	'GUY IN THE WORLD OF PIRACY. WHE HAS ONE '
	dc.b	'ESSENTIALL TIP FOR HIM : TO IMPROVE YOUR IMAGE '
	dc.b	'A LITTLE BIT YOU SHOULD START USING SHAMPOO TO '
	dc.b	'WASH YOUR HAIR. THATS ENOUGH ABOUT QUARTEX '
	dc.b	'FOR TODAY      ',0

	EVEN

; Offset of the character data in the font bitmap (320x15 pixels).
; Starts with character 32 (space).
fontoffsets:
	dc.w	$14B,$1E,0,0,0,0,0,$1D
	dc.w	$20,$21,0,0,$1C,0,$1B,$22
	dc.w	$149,$140,$141,$142,$143,$144,$145,$146
	dc.w	$147,$148,0,0,0,0,0,$1F
	dc.w	0,0,1,2,3,4,5,6
	dc.w	7,8,9,10,11,12,13,14
	dc.w	15,$10,$11,$12,$13,$14,$15,$16
	dc.w	$17,$18,$19

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

; Sine data table
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
;	dc.w	$4000

	EVEN

;Font data for scroller
;1 bitplane, 320x16
;Copied by CPU so doesn't need to be in chip RAM

fontdata:
	incbin	"scrollfont.raw"

; The famous music

	include	"sunriders-music.S"

	section	chipdata,data_c
copper_list:
	dc.w	$2001,$FFFE

	dc.w	$0100,$4600		;BPLCON0, enable bitplanes

;Set $E0/$E8 to vector bitplane to prevent bitplane data rollover
;previous frame
	dc.w	$0108,-40
	dc.w	$00E0			;BPL1PTH vector bitplane
cop_vector_ptr1a:
	dc.w	0
	dc.w	$00E2
	dc.w	0
	dc.w	$00E8			;BPL3PTH vector bitplane
cop_vector_ptr2a:
	dc.w	0
	dc.w	$00EA
	dc.w	0

	dc.w	$00E4
cop_stars_ptr1:
	dc.w	0			;BPL2PTH stars bitplane A
	dc.w	$00E6
	dc.w	0
	dc.w	$00EC
cop_stars_ptr2:
	dc.w	0			;BPL4PTH stars bitplane B
	dc.w	$00EE,0
	dc.w	$0186,$0FFF		;COLOR03

	dc.w	$3207,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$3307,$FFFE
	dc.w	$0180,$000C		;COLOR00

	dc.w	$3507,$FFFE
	dc.w	$00E0
cop_text_ptr1:
	dc.w	0			;BPL1PTH text bitplane
	dc.w	$00E2
	dc.w	0
	dc.w	$00E8
cop_text_ptr2:
	dc.w	0			;BPL3PTH text bitplane
	dc.w	$00EA
	dc.w	0
	dc.w	$0108,20		;BPL1MOD, skip 20 bytes

	dc.w	$3E07,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$3F07,$FFFE
	dc.w	$0180,$0000		;COLOR00

;Removed wait so star bitplane won't show between scroller and vectors
;	dc.w	$4007,$FFFE

	dc.w	$00E0			;BPL1PTH vector bitplane
cop_vector_ptr1:
	dc.w	0
	dc.w	$00E2
	dc.w	0
	dc.w	$00E8			;BPL3PTH vector bitplane
cop_vector_ptr2:
	dc.w	0
	dc.w	$00EA
	dc.w	0
	dc.w	$0108,$0000		;BPL1MOD, no skip
	dc.w	$0192,$0777		;COLOR09
	dc.w	$0194,$0BBB		;COLOR10
	dc.w	$0196,$0FFF		;COLOR11

	dc.w	$EA07,$FFFE
	dc.w	$00E0			;BPL1PTH credits logo
ea_logo_ptr1:
	dc.w	0
	dc.w	$00E2,0
	dc.w	$00E8			;BPL3PTH credits logo
ea_logo_ptr2:
	dc.w	0
	dc.w	$00EA,0
;	dc.w	$0108,$0000		;BPL1MOD

	dc.w	$EF07,$FFFE
	dc.w	$0186,$0000		;COLOR03
	dc.w	$0100,$4600		;BPLCON0

	dc.w	$F207,$FFFE
	dc.w	$0180,$000A		;COLOR00
	dc.w	$0186,$000A		;COLOR03

	dc.w	$F307,$FFFE
	dc.w	$0180,$000C		;COLOR00
	dc.w	$0186,$000C		;COLOR03

	dc.w	$F507,$FFFE
	dc.w	$00E0
cop_text_bpl_bottom1:
	dc.w	0			;text bitplane
	dc.w	$00E2
	dc.w	0
	dc.w	$0186,$0FFF		;COLOR03
	dc.w	$00E8
cop_text_bpl_bottom2:
	dc.w	0			;text bitplane
	dc.w	$00EA
	dc.w	0

	dc.w	$0108,20		;BPL1MOD, skip 20 bytes

	dc.w	$FE07,$FFFE
	dc.w	$0180,$000A		;COLOR00

	dc.w	$FF07,$FFFE
	dc.w	$0180,$0000		;COLOR00

	dc.w	$0108,-40
	dc.w	$00E0			;BPL1PTH vector bitplane
cop_vector_ptr1b:
	dc.w	0
	dc.w	$00E2
	dc.w	0
	dc.w	$00E8			;BPL3PTH vector bitplane
cop_vector_ptr2b:
	dc.w	0
	dc.w	$00EA
	dc.w	0

	dc.w	$FFDF,$FFFE
	dc.w	$2007,$FFFE
	dc.w	$0100,$0600		;BPLCON0, disable bitplanes
	dc.w	$FFFF,$FFFE

; Electronic Artists logo
; 1 bitplane 320x?
ea_logo:
	INCBIN	"ea_logo.raw"

	section	screens,bss_c

;Scrolltext bitplane with overscan
text_bpl	ds.b	60*10

;Starfield bitplanes
stars_bpl1:	ds.b	256*40
stars_bpl2:	ds.b	256*40

;Vector bitplane has oversize on top and bottom
vector_buffer:	ds.b	(280+60)*40

	section	data,bss

prnd_value:	ds.w	1
scrollbitcnt:	ds.b	1
		even
scrollpointer:	ds.l	1

; Vector rotation angles
; Initialized to $3333 in the unpacked data, which probably was
; not intentional, but sets the rotation to a specific start.
rot_b:		ds.w	1
rot_a:		ds.w	1

; Temporary variables for vector calculation
w57E52:		ds.w	1
w57E54:		ds.w	1
w57E56:		ds.w	1
w57E58:		ds.w	1
w57E5A:		ds.w	1
w57E5C:		ds.w	1
w57E5E:		ds.w	1
w57E60:		ds.w	1
w57E62:		ds.w	1

w57E64:		ds.w	1
w57E66:		ds.w	1
w57E68:		ds.w	1
w57E6A:		ds.w	1
w57E6C:		ds.w	1
w57E6E:		ds.w	1
w57E70:		ds.w	1
w57E72:		ds.w	1
w57E74:		ds.w	1

;star positions in 3D
starpostab:	ds.w	num_stars*3 + 3

;star positions to clear as word offset and bit number
starrestoretab:	ds.w	num_stars*2 + 2

stardatalength	EQU	*-starpostab

; Destination arrays for vector calculations
points_rot_x:	ds.w	num_points
points_rot_y:	ds.w	num_points
points_rot_z:	ds.w	num_points
points_proj_x:	ds.w	num_points
points_proj_y:	ds.w	num_points
