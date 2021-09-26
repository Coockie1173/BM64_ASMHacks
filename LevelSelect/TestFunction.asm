[ORIGPOS]: 0x8023DD0C
[RAMPOS]: 0x800C0000
[PauseFlag]: 0x802A0B83
[OrigRomOffset]: 0x000C0000
[GameState]: 0x802BC5D0
[TXTRAMPOS]:0x80600000
[ControllerInputs]: 0x80027064
[LevelChangeIDOne]: 0x802BC5D4
[LevelChangeIDTwo]: 0x802BC5DC
[CurrentOffsetFlag]: 0x80700008
[PreviouslyHeldData]: 0x80700004
[Diamonds]: 0x802BC62C

;08 = DPAD UP
;02 = DPAD LEFT
;01 = DPAD RIGHT
;04 = DPAD DOWN

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

;check if DPAD is same as previous frame
LUI T8, @PreviouslyHeldData
LH T7, @PreviouslyHeldData (T8)
LUI T9, @ControllerInputs
LH T9, @ControllerInputs (T9)
SH T9, @PreviouslyHeldData (T8)
ANDI T9, T9, 0x0F00
ANDI T7, T7, 0x0F00
BEQ T9, T7, IgnoreCurrentFrame

;check dpad buttons
ANDI T8, T9, 0x0100 ;not zero if presed
BEQ T8, R0, RightNotHeld
NOP
;DPAD Right pressed
LUI T9, @CurrentOffsetFlag
LW T6, @CurrentOffsetFlag (T9)
ADDIU T6, T6, 0x0001
LUI T8, @TXTRAMPOS
ADD T8, T6, T8
LB T7, 0x0000 (T8)
BNE R0, T7, EndRight
NOP
ADDIU T6, T6, 0xFFFF
EndRight:
SW T6, @CurrentOffsetFlag (T9)
LUI T5, @Diamonds
SW T6, @Diamonds (T5)
BEQ R0, R0, IgnoreCurrentFrame
NOP

RightNotHeld:
ANDI T8, T9, 0x0200 ;not zero if presed
BEQ T8, R0, LeftNotHeld
NOP
;DPAD Right pressed
LUI T9, @CurrentOffsetFlag
LW T6, @CurrentOffsetFlag (T9)
ADDIU T6, T6, 0xFFFF
LUI T8, @TXTRAMPOS
ADD T8, T6, T8
LB T7, 0x0000 (T8)
BNE R0, T7, EndLeft
NOP
ADDIU T6, T6, 0x0001
EndLeft:
SW T6, @CurrentOffsetFlag (T9)
LUI T5, @Diamonds
SW T6, @Diamonds (T5)
BEQ R0, R0, IgnoreCurrentFrame
NOP

LeftNotHeld:
ANDI T8, T9, 0x0800 ;not zero if presed
BEQ T8, R0, UpNotHeld
NOP
LUI T9, @CurrentOffsetFlag
LW T6, @CurrentOffsetFlag (T9)
LUI T8, @GameState
LW T7, @GameState (T8)
ORI T7, T7, 0x0001
SW T7, @GameState (T8)
LUI T8, @TXTRAMPOS
ADD T8, T6, T8
LB T7, 0x0000 (T8)
LUI T9, @LevelChangeIDOne
SW T7, @LevelChangeIDOne (T9)
SW T7, @LevelChangeIDTwo (T9)

UpNotHeld:
ANDI T8, T9, 0x0400 ;not zero if presed
BEQ T8, R0, IgnoreCurrentFrame
NOP
LUI T8, @GameState
LW T7, @GameState (T8)
ORI T7, T7, 0x0001
SW T7, @GameState (T8)

IgnoreCurrentFrame:
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
ADDIU SP, SP, 0x003C
LW V0, 0xC5D0 (V0)
J @ORIGPOS
LUI AT, 0x802A
NOP

.ascii "TXTR"

.incbin "TeleTable.bin"

.align #4
.ascii "END_"