[ROMPOS]: 0xB00C0000
[RAMPOS]: 0x800C0000
[TXTRAMPOS]:0x80600000
[TXTHex]: 0x54585452
[TXTBank]: 0x54585442
[TXTBankPos]: 0x80610000

.incasm "TestFunction.asm"

.org 0x4000C
J 0x8029DB10
NOP

.org 0xB8310
;hook position @ 0x1D610 in ROM, gets loaded into Expansion pack
ADDIU SP, SP, 0xFFD0
SW T7, 0x0000 (SP)
SW T6, 0x0004 (SP)
SW T5, 0x0008 (SP)
SW T4, 0x000C (SP)
SW T9, 0x0010 (SP)

LUI T7, @ROMPOS
LUI T5, 0x454E
ORI T5, T5, 0x445F
LUI T4, @RAMPOS
LUI T9, @TXTHex
ORI T9, T9, @TXTHex

LoadLoop:
LW T6, 0x0000(T7)
BEQ T6, T5, DoneRead
NOP
BEQ T6, T9, SetTextOffset
NOP
SW T6, 0x0000(T4)
NoStore:
ADDIU T4, T4, 0x0004
ADDIU T7, T7, 0x0004
BEQ R0, R0, LoadLoop
NOP

;restore SP and continue regular code
DoneRead:
LW T7, 0x0000 (SP)
LW T6, 0x0004 (SP)
LW T5, 0x0008 (SP)
LW T4, 0x000C (SP)
LW T9, 0x0010 (SP)
ADDIU SP, SP, 0X0030

LUI T6, 0x8022
J 0x80225810
ADDIU T6, T6, 0x5840

SetTextOffset:
LUI T4, @TXTRAMPOS
ORI T4, T4, @TXTRAMPOS
SUBI T4, T4, 0x0004
B NoStore
NOP