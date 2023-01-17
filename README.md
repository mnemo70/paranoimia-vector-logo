# PARANOIMIA Vector Logo intro

![A screenshot of Paranoimia intro with the text PARANOIMIA drawn in
white 3D lines on a black background with some floating stars. Above
and below the 3D text are small blue bars with a scrolling
text.](intro-screenshot.png "PARANOIMIA Vector Logo")

## Introduction

This is a reconstruction of the infamous vector logo intro by
Paranoimia on the Commodore Amiga. Uncredited in the intro were
the coder Pwy and TSM of Sunriders, who created the music, which
was assumably ripped from somewhere else.

This disassembly was created with ReSource V6.06 directly in
Commodore Amiga emulation and then tidied up a bit in ASM-One.

## Usage

On an Amiga (or emulator), run the ASM-One or Asm-Pro assembler
and load the source file with the "r" command. Following that,
assemble with "a" and run the intro with "j main", which jumps
to the main entry point of the code.

## Notes

There are many things that could be optimized in the code, but
it was probably intended for Amiga 500 machines. Code and data
are scattered through memory, probably by using EXTERN directives
with absolute addresses and also equates for memory buffers that
are also absolute.

If you want to change the vector logo you need to adjust the
number of points and lines equates at the beginning of the file
and change the values in the points_x, points_y and line_table
tables.

The music code was disassembled as-is and works. There is a
release of the music's executable that includes assembler
symbols, but I concentrated on the graphics code and did no
commenting on the music code.

## Contact

You can reach me at mnemotron \[at\] gmail.com.

mnemo, 2023-01-17