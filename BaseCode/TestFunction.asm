[ORIGPOS]: 0x8023DD0C
[RAMPOS]: 0x800C0000
[PauseFlag]: 0x802A0B83
[OrigRomOffset]: 0x000C0000
[GameState]: 0x802BC5D0

;hook
.org 0x58504
J @RAMPOS
NOP

.org 0xC0000
;start of function
ADDIU SP, SP, 0xFFC4
SW T9, 0x0000 (SP)
SW T8, 0x0004 (SP)
SW T7, 0x0008 (SP)
SW T6, 0x000C (SP)
SW T5, 0x0010 (SP)
SW T4, 0x0014 (SP)
SW T3, 0x0018 (SP)
SW T2, 0x001C (SP)
SW T1, 0x0020 (SP)
SW T0, 0x0024 (SP)
SWC1 F30, 0x0028 (SP)
SWC1 F28, 0x002C (SP)

LUI T9, @GameState
LW T9, @GameState (T9)
BEQ T9, R0, StartCode
NOP
ADDIU T8, R0, 0x0008
BNE T9, T8, NotInGame
NOP
StartCode:


;restore vars
NotInGame:
LW T9, 0x0000 (SP)
LW T8, 0x0004 (SP)
LW T7, 0x0008 (SP)
LW T6, 0x000C (SP)
LW T5, 0x0010 (SP)
LW T4, 0x0014 (SP)
LW T3, 0x0018 (SP)
LW T2, 0x001C (SP)
LW T1, 0x0020 (SP)
LW T0, 0x0024 (SP)
LWC1 F30, 0x0028 (SP)
LWC1 F28, 0x002C (SP)
ADDIU SP, SP, 0x003C
LW V0, 0xC5D0 (V0)
J @ORIGPOS
LUI AT, 0x802A
NOP


.align #4
.ascii "END_"