> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | West Bank Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00
S $5B00
  $5B00 @start=$6000
@ $5B01 org
@ $5B01 replace=/#CHARACTERSET,\i/#UDGARRAY1,attr=\1,scale=4,step=1;(#PC)-(#PC+$08)-$01-$08
@ $5B01 replace=/#CHARACTERS/#UDGARRAY6,attr=40,scale=4,step=6;(#PC)-(#PC+$1E5)-$01-$30
@ $5B01 replace=/#BANG/#UDGARRAY8,attr=2,scale=4,step=8;(#PC)-(#PC+$F8)-$01-$40

i $5B01

c $5B80 Draw Text (alias).
D $5B80 This is an alias for a jump to #R$CBD2.
@ $5B80 label=PRINT_TWO_TONE_TEXT_ALIAS

c $5B83 Displays The "Life" Images.
D $5B83 An alias for a jump to #R$CC5A.
@ $5B83 label=DRAW_LIFE_IMAGES_ALIAS

c $5B86 Lives Memory Address.
@ $5B86 label=LIVES_ADDR
W $5B86 The 16 bit memory location for the address that holds how many lives the player has remaining.

c $5B88 Jump Controls.
@ $5B88 label=JUMP_CONTROL_METHOD
D $5B88 Loads the 16 bit address stored at #R$CE12 into #REGhl and jumps to it.

c $5B8C Scoring Preparation (alias).
@ $5B8C label=SCORING_PREP_ALIAS

c $5B8F Character Address (alias).
@ $5B8F label=CHARACTER_ADDR_ALIAS
D $5B8F An alias for #R$D5B0 which returns the 16 bit memory location of a character from a given character index.

c $5B92 Draw Character (alias).
@ $5B92 label=DRAW_CHARACTER

c $5B95 Merge Shot (alias).
@ $5B95 label=MERGE_SHOT_ALIAS

c $5B98 Display The "Score" Images (alias).
@ $5B98 label=DRAW_SCORE_ALIAS

c $5B9B
C $5B9B,$07 Stashes a text attribute at #R$CBD0.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $05 | $05 | $00 | $00 }
. TABLE#

g $5BC0 Dueller Number 1.
@ $5BC0 label=DUELLER_1
D $5BC0 Populated initially by #R$C3EA.
B $5BC0,$01 Dueller state ("0" is complete).
B $5BC1,$01 Dueller timer.
B $5BC2,$01
B $5BC3,$01 Dueller position.
W $5BC4,$02 Screen position above dueller to display "EXTRA" or points.
B $5BC6,$01
B $5BC7,$01 Bonus points (x100, e.g. "9" == "900").
B $5BC8,$01
B $5BC9,$01 Current frame?
B $5BCA,$01 Character index frame 1.
B $5BCB,$01 Character index frame 2.
B $5BCC,$01 Character index frame 3.
B $5BCD,$01
B $5BCE,$01
B $5BCF,$01
B $5BD0,$01
g $5BD1 Dueller Number 2.
@ $5BD1 label=DUELLER_2
D $5BD1 Populated initially by #R$C3EA.
B $5BD1,$01 Dueller state ("0" is complete).
B $5BD2,$01 Dueller timer.
B $5BD3,$01
B $5BD4,$01 Dueller position.
W $5BD5,$02 Screen position above dueller to display "EXTRA" or points.
B $5BD7,$01
B $5BD8,$01 Bonus points (x100, e.g. "9" == "900").
B $5BD9,$01
B $5BDA,$01 Current frame?
B $5BDB,$01 Character index frame 1.
B $5BDC,$01 Character index frame 2.
B $5BDD,$01 Character index frame 3.
B $5BDE,$01
B $5BDF,$01
B $5BE0,$01
B $5BE1,$01
g $5BE2 Dueller Number 3.
@ $5BE2 label=DUELLER_3
D $5BE2 Populated initially by #R$C3EA.
B $5BE2,$01 Dueller state ("0" is complete).
B $5BE3,$01 Dueller timer.
B $5BE4,$01
B $5BE5,$01 Dueller position.
B $5BE6,$02 Screen position above dueller to display "EXTRA" or points.
B $5BE8,$01
B $5BE9,$01 Bonus points (x100, e.g. "9" == "900").
B $5BEA,$01
B $5BEB,$01 Current frame?
B $5BEC,$01 Character index frame 1.
B $5BED,$01 Character index frame 2.
B $5BEE,$01 Character index frame 3.
B $5BEF,$01
B $5BF0,$01
B $5BF1,$01
B $5BF2,$01

b $5BF3

g $5CB0 Control method
@ $5CB0 label=CONTROLLER
D $5CB0 Whether to utilise keyboard or joystick for input.
E $5CB0 #TABLE(default,centre)
. { =h Value | =h Method }
. { $00 | Kempston }
. { $01 | Keyboard }
. TABLE#
g $5CB1 Current Level
@ $5CB1 label=LEVEL

i $5CB2
b $5CF0

@ $6000 label=HIGHSCORE_TABLE
t $6000 High Score Table
T $6000,$1E0,$10
S $61E0,$20
T $6200,$102,$06

i $6302

c $6380 Level Selection
@ $6380 label=LEVEL_SELECT
C $6380 #REGhl points to $5B80 on entry as #REGde is also $5B80 - this does nothing, it just creates a very short pause.
C $6388,$0D Writes $00 to all 6144 bytes of the screen bufffer (i.e. "blanks it").
C $6395,$0D Writes $28 to $58A0 in the attribute buffer $100 times.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $28 | $00 | $05 | $00 }
. TABLE#
C $63A2,$07 ...and $20 to the attribute buffer another $5F times (following on from the previous location).
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $20 | $00 | $04 | $00 }
. TABLE#

N $63A9 Prints the labels to the screen.
C $63A9,$08 Pass #R$64AC to #R$647C (index "1").
C $63B1,$08 Pass #R$64B3 to #R$647C (index "2").
C $63B9,$08 Pass #R$64BA to #R$647C (index "3").

C $63C1,$0C Points to #R$6492 and sends it to #R$5B80
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $06 | $06 | $00 | $00 }
. TABLE#

N $63CD Prints the images to the screen.
C $63CD,$07 Calls #R$643A with (#R$B450(draw | $25)) for index "1".
C $63D4,$07 Calls #R$643A with (#R$7880(draw | $08)) for index "2".
C $63DB,$07 Calls #R$643A with (#R$9B90(draw | $19)) for index "3".

N $63E2 Loop for getting user keyboard input.
C $63E2,$03 Used later for setting the current level at #R$5CB1.
@ $63E5 label=LEVEL_SELECT_INPUT
C $63E5,$04 Read keys 1-2-3-4-5.
C $63E9,$03 If "1" is pressed, jump to #R$63F4.
C $63EC,$03 If "2" is pressed, jump to #R$6405.
C $63EF,$03 If "3" is pressed, jump to #R$6416.
C $63F2,$02 Cycle back to #R$63E5.

N $63F4 Act on level being selected.
@ $63F4 label=LEVEL_SELECT_LEVEL_1
C $63F4,$09 Store $01 at #R$5CB1 and call #R$6427 with (#R$B660(shot | $26)) for index "1".
C $63FD,$08 Jump to #R$6457 with #REGhl=#R$64AC and #REGa=$01.
@ $6405 label=LEVEL_SELECT_LEVEL_3
C $6405,$09 Store $02 at #R$5CB1 and call #R$6427 with (#R$7A90(shot | $09)) for index "2".
C $640E,$08 Jump to #R$6457 with #REGhl=#R$64B3 and #REGa=$02.
@ $6416 label=LEVEL_SELECT_LEVEL_6
C $6416,$11 Store $03 at #R$5CB1 and call #R$6427 with (#R$9DA0(shot | $1A)) for index "3".
C $641F,$08 Jump to #R$6457 with #REGhl=#R$64BA and #REGa=$03.

N $6427 Animates the selected bandit being shot.
@ $6427 label=LS_ANIMATE_SHOT
@ $6430 label=LS_ANIMATE_SHOT_HALT_LOOP
C $6428,$03 Call #R$643A.
C $642B,$03 Call #R$6500.
C $642E,$05 Short interrupt driven halt loop.
C $6434,$05 Call #R$643A with (#R$B870(floor | $27)).
C $6439,$01 Return.

N $643A Prints the images to the screen.
@ $643A label=LEVEL_SELECT_GRAPHICS
C $643A,$04 Stash the current counter and convert the accumulator which is holding a character ID into their memory location.
C $6440,$0F Work out which screen position to use;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $40A2 }
. { $02 | $40AD }
. { $03 | $40B8 }
. TABLE#
@ $644F label=LS_GRAPHICS_SKIP
C $644F,$07 Set the dimensions and call #R$5B92.
C $6456,$01 Return.

N $6457 Flashes the selected level text.
@ $6457 label=LS_TEXT_FLASH
@ $645A label=LS_TEXT_FLASH_LOOP
@ $6462 label=LS_FLASH_HALT_LOOP_1
@ $6470 label=LS_FLASH_HALT_LOOP_2
C $6457,$24 This prints #R$64C1 and the passed level copy alternately with a delay caused by a HALT loop
.           (which continues execution after an interrupt is fired), the sequence repeats $08 times.
C $647B,$01 Return.

N $647C Print level select copy to the screen.
@ $647C label=LEVEL_SELECT_PRINT
C $647C,$0F First, work out which screen position to use;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $5022 }
. { $02 | $502D }
. { $03 | $5038 }
. TABLE#
C $648B,$06 Then call the print routine at #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $02 | $02 | $00 | $00 }
. TABLE#
C $6491,$01 Return.

t $6492 Level Selection Text
@ $6492 label=LEVEL_SELECT_COPY
T $6492,$1A "CHOOSE THE LEVEL PREFERED"
@ $64AC label=LEVEL_SELECT_ONE
T $64AC,$07 "ONE"
@ $64B3 label=LEVEL_SELECT_THREE
T $64B3,$07 "THREE"
@ $64BA label=LEVEL_SELECT_SIX
T $64BA,$07 "SIX"
@ $64C1 label=LEVEL_SELECT_WHITESPACE
T $64C1,$07 "WHITESPACE"

u $64C8
i $64CB

c $6500 Sounds.
@ $6500 label=SHOT_SOUND_1_ALIAS
@ $6502 label=SHOT_SOUND_2_ALIAS
@ $6504 label=SHOT_SOUND_3_ALIAS

W $6506,$14
B $651A,$05

N $651F Sound data.
W $651F,$18,$02
@ $651F label=DATA_SOUND_1
@ $6527 label=DATA_SOUND_2
@ $652F label=DATA_SOUND_3

N $6537 Shot sound 1.
@ $6537 label=SHOT_SOUND_1
C $6537,$07 Calls #R$654F using #R$651F.
C $653E,$01 Return.

N $653F Shot sound 2.
@ $653F label=SHOT_SOUND_2
C $653F,$07 Calls #R$654F using #R$6527.
C $6546,$01 Return.

N $6547 Shot sound 3.
@ $6547 label=SHOT_SOUND_3
C $6547,$07 Calls #R$654F using #R$652F.
C $654E,$01 Return.

@ $654F label=PLAY_SHOT_SOUND
C $654F,$03 Call #R$655E.
C $6552,$08 Increase #REGix by 4.
C $655A,$03 Call #R$655E.
C $655D,$01 Return.

@ $655E label=SHOT_SOUND
C $655E,$10 jjj
@ $6571 label=SHOT_SOUND_LOOPBACK
C $657F,$01 Return.

u $6580

i $65B1
u $65AE

c $6600

b $6800 Jack Vicious (bandit)
D $6800 JACK VISCIOUS - The sponging swindler of the WEST. Don't hesitate
.       - shoot whenever you see his face.
E $6800 #UDGARRAY*character-00,100;character-01;character-02;(jack-frames)
N $6800 Bandit 1 (draw | $00)
@ $6800 label=CHARACTER_00
B $6800,$210,$06 #CHARACTERS(character-00*)
N $6A10 Bandit 1 (shot | $01)
@ $6A10 label=CHARACTER_01
B $6A10,$210,$06 #CHARACTERS(character-01*)
N $6C20 Bandit 1 (floor | $02)
@ $6C20 label=CHARACTER_02
B $6C20,$210,$06 #CHARACTERS(character-02*)

b $6E30 Green Jordan (customer)
D $6E30 GREEN JORDAN - The farmer. The untiring worker who goes to the
.       bank to put in his savings. You should not shoot
.       him.
E $6E30 #UDGARRAY*character-03,50;character-04;character-05;character-00(green-jordan-uncover-frames)
.       #UDGARRAY*character-03,50;character-04;character-06;character-07(green-jordan-shot-frames)
N $6E30 Green Jordan (depositing | $03)
@ $6E30 label=CHARACTER_03
B $6E30,$210,$06 #CHARACTERS(character-03*)
N $7040 Green Jordan (hands up | $04)
@ $7040 label=CHARACTER_04
B $7040,$210,$06 #CHARACTERS(character-04*)
N $7250 Green Jordan (uncover | $05)
@ $7250 label=CHARACTER_05
B $7250,$210,$06 #CHARACTERS(character-05*)
N $7460 Green Jordan (shot | $06)
@ $7460 label=CHARACTER_06
B $7460,$210,$06 #CHARACTERS(character-06*)
N $7670 Green Jordan (floor | $07)
@ $7670 label=CHARACTER_07
B $7670,$210,$06 #CHARACTERS(character-07*)

b $7880 Bandit 2
D $7880 ALFRED DALTON - A real baddie. Shoot as soon as he takes out his
.       gun!
E $7880 #UDGARRAY*character-08,100;character-09;character-07;(bandit-2-frames)
N $7880 Bandit 2 (draw | $08)
@ $7880 label=CHARACTER_08
B $7880,$210,$06 #CHARACTERS(character-08*)
N $7A90 Bandit 2 (shot | $09)
@ $7A90 label=CHARACTER_09
B $7A90,$210,$06 #CHARACTERS(character-09*)

b $7CA0 Daisy (customer)
D $7CA0 DAISY - The beautiful daughter of the City Jeweller.
.       Always loaded with money - never hurt her.
E $7CA0 #UDGARRAY*character-0A,50;character-0B;character-0C;character-00(daisy-uncover-frames)
.       #UDGARRAY*character-0A,50;character-0B;character-0D;character-0E(daisy-shot-frames)
N $7CA0 Normal 2 (depositing | $0A)
@ $7CA0 label=CHARACTER_0A
B $7CA0,$210,$06 #CHARACTERS(character-0A*)
N $7EB0 Normal 2 (hands up | $0B)
@ $7EB0 label=CHARACTER_0B
B $7EB0,$210,$06 #CHARACTERS(character-0B*)
N $80C0 Normal 2 (uncover | $0C)
@ $80C0 label=CHARACTER_0C
B $80C0,$210,$06 #CHARACTERS(character-0C*)
N $82D0 Normal 2 (shot | $0D)
@ $82D0 label=CHARACTER_0D
B $82D0,$210,$06 #CHARACTERS(character-0D*)
N $84E0 Normal 2 (floor | $0E)
@ $84E0 label=CHARACTER_0E
B $84E0,$210,$06 #CHARACTERS(character-0E*)

b $86F0 Bandit 3
D $86F0 JOE DALTON - Alfred Dalton's brother. It runs in the family.
.       Shoot as soon as he takes out his gun.
E $86F0 #UDGARRAY*character-10,100;character-0F;character-11;character-07;(bandit-3-frames)
N $86F0 Bandit 3 (draw | $0F)
@ $86F0 label=CHARACTER_0F
B $86F0,$210,$06 #CHARACTERS(character-0F*)
N $8900 Bandit 3 (stand off | $10)
@ $8900 label=CHARACTER_10
B $8900,$210,$06 #CHARACTERS(character-10*)
N $8B10 Bandit 3 (shot | $11)
@ $8B10 label=CHARACTER_11
B $8B10,$210,$06 #CHARACTERS(character-11*)

b $8D20 Bandit 4
D $8D20 MACKEYHAM - The bloodthirsty villain. Everyone trembles when
.       they come up against him. Don't hesitate or it
.       might be too late. Shoot as quickly as you can.
E $8D20 #UDGARRAY*character-12,100;character-13;character-14;character-07;(bandit-4-frames)
N $8D20 Bandit 4 (stand off | $12)
@ $8D20 label=CHARACTER_12
B $8D20,$210,$06 #CHARACTERS(character-12*)
N $8F30 Bandit 4 (draw | $13)
@ $8F30 label=CHARACTER_13
B $8F30,$210,$06 #CHARACTERS(character-13*)
N $9140 Bandit 4 (shot | $14)
@ $9140 label=CHARACTER_14
B $9140,$210,$06 #CHARACTERS(character-14*)

b $9350 Bandit 5
D $9350
E $9350 #UDGARRAY*character-15,100;character-16;character-17;character-07;(bandit-5-frames)
N $9350 Bandit 5 (stand off | $15)
@ $9350 label=CHARACTER_15
B $9350,$210,$06 #CHARACTERS(character-15*)
N $9560 Bandit 5 (draw | $16)
@ $9560 label=CHARACTER_16
B $9560,$210,$06 #CHARACTERS(character-16*)
N $9770 Bandit 5 (shot | $17)
@ $9770 label=CHARACTER_17
B $9770,$210,$06 #CHARACTERS(character-17*)

b $9980 Bandit 6
D $9980
E $9980 #UDGARRAY*character-18,100;character-19;character-1A;character-07;(bandit-6-frames)
N $9980 Bandit 6 (stand off | $18)
@ $9980 label=CHARACTER_18
B $9980,$210,$06 #CHARACTERS(character-18*)
N $9B90 Bandit 6 (draw | $19)
@ $9B90 label=CHARACTER_19
B $9B90,$210,$06 #CHARACTERS(character-19*)
N $9DA0 Bandit 6 (shot | $1A)
@ $9DA0 label=CHARACTER_1A
B $9DA0,$210,$06 #CHARACTERS(character-1A*)

b $9FB0 Bowie (special)
D $9FB0 BOWIE - The dwarf. He is a constant practical joker. Make
.       holes in his hats but take care that the bottom
.       hat doesn't conceal a bomb or you will lose a
.       life.
E $9FB0 #UDGARRAY*character-1B,50;character-1C;character-1D;character-1E;character-1F;character-20;character-21;character-22(bowie-bomb-frames)
.       #UDGARRAY*character-1B,50;character-1C;character-1D;character-1E;character-1F;character-20;character-21;character-23(bowie-cash-frames)
N $9FB0 Bowie (7 hats | $1B)
@ $9FB0 label=CHARACTER_1B
B $9FB0,$210,$06 #CHARACTERS(character-1B*)
N $A1C0 Bowie (6 hats | $1C)
@ $A1C0 label=CHARACTER_1C
B $A1C0,$210,$06 #CHARACTERS(character-1C*)
N $A3D0 Bowie (5 hats | $1D)
@ $A3D0 label=CHARACTER_1D
B $A3D0,$210,$06 #CHARACTERS(character-1D*)
N $A5E0 Bowie (4 hats | $1E)
@ $A5E0 label=CHARACTER_1E
B $A5E0,$210,$06 #CHARACTERS(character-1E*)
N $A7F0 Bowie (3 hats | $1F)
@ $A7F0 label=CHARACTER_1F
B $A7F0,$210,$06 #CHARACTERS(character-1F*)
N $AA00 Bowie (2 hats | $20)
@ $AA00 label=CHARACTER_20
B $AA00,$210,$06 #CHARACTERS(character-20*)
N $AC10 Bowie (1 hat | $21)
@ $AC10 label=CHARACTER_21
B $AC10,$210,$06 #CHARACTERS(character-21*)
N $AE20 Bowie (bomb | $22)
@ $AE20 label=CHARACTER_22
B $AE20,$210,$06 #CHARACTERS(character-22*)
N $B030 Bowie (cash | $23)
@ $B030 label=CHARACTER_23
B $B030,$210,$06 #CHARACTERS(character-23*)

b $B240 Julius (special)
D $B240 JULIUS - The dandy. He is a box of surprises. He may give
. you a bag of gold or he might shoot you. Take
. things very carefully with this one.
E $B240 #UDGARRAY*character-24,100;character-25;character-26;character-27(julius-frames)
N $B240 Bandit 7 (stand off | $24)
@ $B240 label=CHARACTER_24
B $B240,$210,$06 #CHARACTERS(character-24*)
N $B450 Bandit 7 (draw | $25)
@ $B450 label=CHARACTER_25
B $B450,$210,$06 #CHARACTERS(character-25*)
N $B660 Bandit 7 (shot | $26)
@ $B660 label=CHARACTER_26
B $B660,$210,$06 #CHARACTERS(character-26*)
N $B870 Bandit 7 (floor | $27)
@ $B870 label=CHARACTER_27
B $B870,$210,$06 #CHARACTERS(character-27*)

b $BA80 Door Frame 1
D $BA80 The door is shut.
@ $BA80 label=DOOR_FRAME_1
B $BA80,$268,$07 #UDGARRAY7,attr=48,scale=4,step=7;(#PC)-(#PC+$236)-$01-$38(door-1)

b $BCE8 Door Frame 2
D $BCE8 The door is only slightly open.
@ $BCE8 label=DOOR_FRAME_2
B $BCE8,$1B8,$05 #UDGARRAY5,attr=48,scale=4,step=5;(#PC)-(#PC+$194)-$01-$28(door-2)

b $BEA0 Door Frame 3
D $BEA0 The door is nearly fully open.
@ $BEA0 label=DOOR_FRAME_3
B $BEA0,$108,$03 #UDGARRAY3,attr=48,scale=4,step=3;(#PC)-(#PC+$F2)-$01-$18(door-3)

b $BFA8 Door Frame 4
D $BFA8 The door is fully open.
@ $BFA8 label=DOOR_FRAME_4
B $BFA8,$58,$01 #UDGARRAY1,attr=48,scale=4,step=1;(#PC)-(#PC+$50)-$01-$08(door-4)

c $C000 BANG!
@ $C000 label=BANG
C $C000,$03 Clear the screen.
C $C003,$08 Pass #R$F000 to #R$C061.
C $C00B,$08 Pass #R$F100 to #R$C061.
C $C013,$08 Pass #R$F200 to #R$C061.
C $C01B,$06 Calls $6502 twice.
C $C021,$08 Pass #R$F300 to #R$C061.
C $C029,$08 Pass #R$F400 to #R$C061.
C $C031,$08 Pass #R$F500 to #R$C061.
C $C039,$08 Blanks the display by passing a "clear" part of the screen buffer to #R$C061.
C $C041,$05 Jump to #R$C06D.

C $C046 Prepares For BANG!
@ $C046 label=PREP_BANG
C $C046,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
C $C053,$0D Continues into the attributes buffer, and writes $02 (red ink) to every location.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $02 | $00 | $00 | $00 }
. TABLE#
C $C060,$01 Returns.

C $C061,$0F Sets the screen location and the bang image frame sizing, then calls #R$C071, issues a short pause and ...
@ $C061 label=BANG_COPY
@ $C06D label=BANG_HALT_LOOP
C $C070,$01 ...returns.

C $C071,$13 Copy the bang image frame to the screen buffer.
@ $C071 label=BANG_PRINT
C $C084,$01 Return.

@ $C085 label=BANG_NEXT_LINE
C $C085,$0D Handles working out the next line progressively in the screen buffer.
C $C092,$01 Return.

B $C093

b $C0A0 Character Set
D $C0A0 All characters are 8x16.

N $C0A0 Lettering.
@ $C0A0 label=CHAR_A
B $C0A0 #CHARACTERSET,7(char-A) Letter "A".
@ $C0B0 label=CHAR_B
B $C0B0 #CHARACTERSET,7(char-B) Letter "B".
@ $C0C0 label=CHAR_C
B $C0C0 #CHARACTERSET,7(char-C) Letter "C".
@ $C0D0 label=CHAR_D
B $C0D0 #CHARACTERSET,7(char-D) Letter "D".
@ $C0E0 label=CHAR_E
B $C0E0 #CHARACTERSET,7(char-E) Letter "E".
@ $C0F0 label=CHAR_F
B $C0F0 #CHARACTERSET,7(char-F) Letter "F".
@ $C100 label=CHAR_G
B $C100 #CHARACTERSET,7(char-G) Letter "G".
@ $C110 label=CHAR_H
B $C110 #CHARACTERSET,7(char-H) Letter "H".
@ $C120 label=CHAR_I
B $C120 #CHARACTERSET,7(char-I) Letter "I".
@ $C130 label=CHAR_J
B $C130 #CHARACTERSET,7(char-J) Letter "J".
@ $C140 label=CHAR_K
B $C140 #CHARACTERSET,7(char-K) Letter "K".
@ $C150 label=CHAR_L
B $C150 #CHARACTERSET,7(char-L) Letter "L".
@ $C160 label=CHAR_M
B $C160 #CHARACTERSET,7(char-M) Letter "M".
@ $C170 label=CHAR_N
B $C170 #CHARACTERSET,7(char-N) Letter "N".
@ $C180 label=CHAR_O
B $C180 #CHARACTERSET,7(char-O) Letter "O".
@ $C190 label=CHAR_P
B $C190 #CHARACTERSET,7(char-P) Letter "P".
@ $C1A0 label=CHAR_Q
B $C1A0 #CHARACTERSET,7(char-Q) Letter "Q".
@ $C1B0 label=CHAR_R
B $C1B0 #CHARACTERSET,7(char-R) Letter "R".
@ $C1C0 label=CHAR_S
B $C1C0 #CHARACTERSET,7(char-S) Letter "S".
@ $C1D0 label=CHAR_T
B $C1D0 #CHARACTERSET,7(char-T) Letter "T".
@ $C1E0 label=CHAR_U
B $C1E0 #CHARACTERSET,7(char-U) Letter "U".
@ $C1F0 label=CHAR_V
B $C1F0 #CHARACTERSET,7(char-V) Letter "V".
@ $C200 label=CHAR_W
B $C200 #CHARACTERSET,7(char-W) Letter "W".
@ $C210 label=CHAR_X
B $C210 #CHARACTERSET,7(char-X) Letter "X".
@ $C220 label=CHAR_Y
B $C220 #CHARACTERSET,7(char-Y) Letter "Y".
@ $C230 label=CHAR_Z
B $C230 #CHARACTERSET,7(char-Z) Letter "Z".

N $C240 Numbering.
@ $C240 label=CHAR_1
B $C240 #CHARACTERSET,7(char-1) Number "1".
@ $C250 label=CHAR_2
B $C250 #CHARACTERSET,7(char-2) Number "2".
@ $C260 label=CHAR_3
B $C260 #CHARACTERSET,7(char-3) Number "3".
@ $C270 label=CHAR_4
B $C270 #CHARACTERSET,7(char-4) Number "4".
@ $C280 label=CHAR_5
B $C280 #CHARACTERSET,7(char-5) Number "5".
@ $C290 label=CHAR_6
B $C290 #CHARACTERSET,7(char-6) Number "6".
@ $C2A0 label=CHAR_7
B $C2A0 #CHARACTERSET,7(char-7) Number "7".
@ $C2B0 label=CHAR_8
B $C2B0 #CHARACTERSET,7(char-8) Number "8".
@ $C2C0 label=CHAR_9
B $C2C0 #CHARACTERSET,7(char-9) Number "9".
@ $C2D0 label=CHAR_0
B $C2D0 #CHARACTERSET,7(char-0) Number "0".

c $C2E0

c $C300 Draw Playfield
@ $C300 label=DRAW_PLAYFIELD
C $C300,$09 Set #R$D5E6 as the destination address at #R$C3B7.
C $C309,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.
N $C316 Draws the numbering of the deposit boxes on the left and right of the screen.
C $C316,$0C Points #REGhl to $4001 (screen buffer) and #REGde to #R$DFA0, then calls the routine at #R$C3B7.
C $C322,$0C Points #REGhl to $4013 (screen buffer) and #REGde to #R$E000, then calls the routine at #R$C3B7.
N $C32E Draws the centrepiece "till" image.
C $C32E,$0D Points #REGhl to $400E (screen buffer) and #REGde to #R$E060, then calls the routine at #R$C3B7.
N $C33B Draws the game play area (doors and wall sections).
C $C33B,$0C Points #REGhl to $4060 (screen buffer) and #REGde to #R$E0C0, then calls the routine at #R$C3B7.
C $C347,$0D Points #REGhl to $4080 (screen buffer) and #REGde to #R$E1C0, then calls the routine at #R$C3B7.
C $C354,$0D Points #REGhl to $4089 (screen buffer) and #REGde to #R$E270, then calls the routine at #R$C3B7.
C $C361,$0D Points #REGhl to $4094 (screen buffer) and #REGde to #R$E270, then calls the routine at #R$C3B7.
C $C36E,$0D Points #REGhl to $409F (screen buffer) and #REGde to #R$E3D0, then calls the routine at #R$C3B7.
C $C37B,$0C Points #REGhl to $48E0 (screen buffer) and #REGde to #R$E428, then calls the routine at #R$C3B7.
N $C387 Draws the Bank Teller desks.
C $C387,$0C Points #REGhl to $5020 (screen buffer) and #REGde to #R$E528, then calls the routine at #R$C3B7.
N $C393 Writes the "SCORE" and "LIVES" labels (these aren't text, they're images).
C $C393,$0C Points #REGhl to $50C1 (screen buffer) and #REGde to #R$E928, then calls the routine at #R$C3B7.
C $C39F,$0C Points #REGhl to $50B0 (screen buffer) and #REGde to #R$E988, then calls the routine at #R$C3B7.
N $C3AB Copies attribute data to the screen.
C $C3AB,$0B Copies $300 bytes of attribute data from #R$ED00 to $5800.
C $C3B6,$01 Return.
C $C3B7,$03 Draws the image pointed to in #REGde to the screen location in #REGhl using the dimensions in #REGbc.
@ $C3B7 label=ALIAS_COPY_ROUTINE
C $C3BA,$01 Return.
C $C3BB,$05 Unused.

c $C3C0
C $C3C0,$03 Call #R$C3DD.
C $C3C3,$03 Grab #R$C421.
@ $C3C9 label=REBUILD
C $C3C9,$05 Interrupt driven HALT loop ($20 cycles).
@ $C3CB label=REBUILD_HALT_LOOP
C $C3CF,$06 Is #R$CC59 more than $06?
C $C3D5,$02 If so, jump to #R$C3D8.
C $C3D8,$03 If #R$CC59 is zero then return.
C $C3DB,$02 Set the carry flag and return.

N $C3DD Kicks off the duelling bonus round.
@ $C3DD label=INIT_DUEL
C $C3DD,$02 Stashes #REGbc and #REGde.
C $C3DF,$08 Copies $1B of data from #REGhl to #R$5B80.
C $C3E7,$03 Jump to #R$C422.

c $C3EA Duel Bonus Round Data.
@ $C3EA label=DUEL_DATA
N $C3EA Dueller 1 data.
B $C3EA,$01 Dueller state ("0" is complete).
B $C3EB,$01 Dueller timer.
B $C3EC,$01
B $C3ED,$01 Dueller position (1).
B $C3EE,$02 Screen position above dueller to display "EXTRA" or points.
B $C3F0,$01
B $C3F1,$01 Bonus points (x100, e.g. "9" == "900").
B $C3F2,$01
B $C3F3,$01 Current frame?
B $C3F4,$03 Dueller 1 frames.
B $C3F7,$04
N $C3FB Dueller 2 data.
B $C3FB,$01 Dueller state ("0" is complete).
B $C3FC,$01 Dueller timer.
B $C3FD,$01
B $C3FE,$01 Dueller position (2).
B $C3FF,$02 Screen position above dueller to display "EXTRA" or points.
B $C401,$01
B $C402,$01 Bonus points (x100, e.g. "9" == "900").
B $C403,$01
B $C404,$01 Current frame?
B $C405,$03 Dueller 2 frames.
B $C408,$04
N $C40C Dueller 3 data.
B $C40C,$01 Dueller state ("0" is complete).
B $C40D,$01 Dueller timer.
B $C40E,$01
B $C40F,$01 Dueller position (3).
B $C410,$02 Screen position above dueller to display "EXTRA" or points.
B $C412,$01
B $C413,$01 Bonus points (x100, e.g. "9" == "900").
B $C414,$01
B $C415,$01 Current frame?
B $C416,$03 Dueller 3 frames.
B $C419,$04
@ $C41D label=DUEL_BONUS_TEXT
N $C41D Buffer holding bonus text.
T $C41D,$04 Bonus text.
N $C421 Not sure ... it is used though @todo.
B $C421,$01

c $C422 Duel Bonus Round.
@ $C422 label=DUEL_PREP
C $C422,$0B Copies $33 bytes of data from #R$C3EA to #R$5BC0 (and across all three duellists).

C $C430,$07 Calls #R$C67F with #R$5BC0.
C $C438,$07 Calls #R$C67F with #R$5BD1.
C $C440,$07 Calls #R$C67F with #R$5BE2.
C $C447,$09 Reset the flags (writes $00 to #R$C6E2, #R$C6E3 and #R$C6E4).
C $C450,$03 #R$C421.
@ $C460 label=DUEL_PREP_LOOP

@ $C463 label=DUEL_CLEAR_SCREEN
C $C463,$04 ....
N $C467 Clears down the screen buffer.
C $C467,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
N $C474 Writes the attributes for the playfield (sky, grass, footer).
C $C474,$0D Writes $28 to $5880 in the attribute buffer $180 times...
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $00 | $05 | $00 | $00 }
. TABLE#
C $C481,$07 ...continuing, writes $20 $80 times...
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $00 | $04 | $00 | $00 }
. TABLE#
C $C488,$07 ...and finally, writes $07 $7F times.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $00 | $00 | $00 }
. TABLE#

N $C48F Creates the footer.
C $C48F,$06 Point to #R$C655 and print using #R$C6A7.
C $C495,$03
C $C498,$0C Point to #R$C64D and prints using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $03 | $03 | $00 | $00 }
. TABLE#
C $C4A4,$03 Writes the players score.

N $C4A7 Initialise duellers.
C $C4A7,$0A Initialise #R$5BC0 (draws frame 1).
C $C4B1,$0A Initialise #R$5BD1 (draws frame 1).
C $C4BB,$0A Initialise #R$5BE2 (draws frame 1).

N $C4C5 Count down 5-4-3-2-1...0!
C $C4C5,$06 Initialise countdown to "5" seconds ($35 in ASCII), hold this at #R$C6E0.
@ $C4C5 label=COUNTDOWN_INITIALISE
@ $C4C7 label=COUNTDOWN_LOOP

C $C4CE,$05 Short halt loop (1 second pause).
@ $C4D0 label=COUNTDOWN_HALT_LOOP
C $C4D3,$06 Keep looping back to #R$C4C7 until the countdown is "0" ($30 in ASCII).

C $C4D9,$08 Blank the countdown timer by printing a "SPACE" ($20 in ASCII) over the top of it.
C $C4E1,$02 Jump to #R$C4F9 and start the duel!

@ $C4E3 label=DUEL_LOOP
C $C4E3,$07 Calls #R$C530 with #R$5BC0.
C $C4EA,$07 Calls #R$C530 with #R$5BD1.
C $C4F1,$07 Calls #R$C530 with #R$5BE2.
C $C4F8,$01 Return.

N $C4F9 DRAW!
@ $C4F9 label=DUEL_START
C $C4F9,$05 #REGde=#R$C52E and push it on the stack.
@ $C4FD label=DUEL_START_LOOP

W $C52E,$02

@ $C530 label=DUEL_ACTIONS
C $C530
C $C542,$01 Return.

@ $C543 label=DUEL_ACTION_1
C $C543,$03 Calls #R$5B88.
C $C546,$03 Return if bit 4 of #REGa is zero.
C $C549,$05 If bit 0 is not zero then return setting #REGa to $03.
C $C54E,$02 Set #REGa to zero and return.

@ $C550 label=DUEL_ACTION_2
C $C550,$03 Calls #R$5B88.
C $C553,$03 Return if bit 4 of #REGa is zero.
C $C556,$05 If bit 1 is not zero then return setting #REGa to $01.
C $C55B,$02 Set #REGa to zero and return.

@ $C55D label=DUEL_ACTION_3
C $C55D
C $C56A,$01 Return.

@ $C56B label=DUEL_ACTION_4
C $C56B,$05 If the dueller position has been changed to zero then jump to #R$C575.
C $C574,$01 Return.

@ $C575 label=DUEL_DUNNO
C $C575
C $C57F,$03 Set dueller state to $01.
C $C582,$01 Return.

C $C58B,$05 If IX+$08 is zero then return.
C $C590,$06 If dueller frame index is $01 then jump to #R$C5A1.
C $C596,$03 If dueller frame index is $02 then jump to #R$C5B5.
C $C599,$03 If dueller frame index is $03 then jump to #R$C5BD.
C $C59C,$03 If dueller frame index is $04 then jump to #R$C5CF.
C $C59F,$02 Jump to #R$C5DD.

C $C5A1,$03 #R$C6E5.

c $C5EB
@ $C5EB label=DUELLER_DOWN
C $C5EB,$05 Check if the current duellers state is zero (complete), return if so.
C $C5F0,$04 Mark the current dueller as complete.
C $C5F4,$02 Restore #REGa and jump to whatever address is held by #REGhl.

N $C5F6 Not related?
C $C5F6

c $C607 Displays The Bonus Score Text.
@ $C607 label=PRINT_BONUS_SCORE
C $C607,$09 Stores the ASCII representation of the number at #R$C41D (it adds ASCII "0") so for example 1 ends up being
.           1 + $30 = $31 (e.g. "1" in ASCII).
C $C610,$06 Print using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $29 | $01 | $05 | $00 }
. { $28 | $00 | $05 | $00 }
. TABLE#
C $C61F,$03 Jump to #R$C583.
t $C622 "Extra" text.
@ $C622 label=EXTRA_TEXT_COPY
T $C622,$06

c $C628 Displays "Extra" and Bonus Score text.
@ $C628 label=DUEL_POINTS
D $C628 Handles whether to display points or "EXTRA" above each downed Bandit.
C $C628,$08 If #R$C6E4 is NOT zero then award 9(00) bonus points.
C $C630,$0A Fetch a 16 bit address from #R$5B86 (#R$CC59), if it is higher than $05 then award 9(00) bonus points.
C $C63A,$0A Points to #R$C622 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $2A | $02 | $05 | $00 }
. { $29 | $01 | $05 | $00 }
. TABLE#
C $C644,$05 Writes $01 to #R$C6E4.
C $C649,$03 Move onto the next frame.
C $C64C,$01 Return.

t $C64D Playfield Text
@ $C64D label=PLAYFIELD_SCORE
T $C64D,$08
@ $C655 label=PLAYFIELD_LIVES
T $C655,$06
@ $C65B label=PLAYFIELD_WHITESPACE
T $C65B,$06

c $C661 Draw Duel Bandit
@ $C661 label=DUEL_DRAW_BANDIT_PREP
C $C661,$03 Fetch the address of the character from the given index in #REGa.
C $C665,$03 Retrieve the character position.

C $C668,$06 If this character is in position "1" then point to the screen buffer at $4804 and jump to #R$C677.
C $C66E,$06 If this character is in position "2" then point to the screen buffer at $480C and jump to #R$C677.
C $C674,$03 Else this character is in position "3" so point to the screen buffer at $4814.

C $C677,$07 Call the draw routine with the image dimensions.
@ $C677 label=DUEL_DRAW_BANDIT
C $C67E,$01 Return.

c $C67F
@ $C67F label=DUEL_UPDATE_TIMER
C $C67F,$07 Updates dueller timer.
C $C686,$01 Return.

c $C687 Lose A Life
@ $C687 label=LOSE_LIFE
C $C687,$03 Calls the subroutine to display the "BANG" animation.
C $C68A,$05 Decrease the lives counter by one (#R$CC59), set the zero flag if all lives are lost.
C $C68F,$01 Return.

c $C690 Is The Duel Finished?
@ $C690 label=DUEL_COMPLETE
C $C690,$07 Jump to #R$C6F0 if #R$C6E3 is not zero.
C $C697,$07 Jump to #R$C687 if #R$C6E2 is not zero.
C $C69E,$07 Jump to #R$C6B1 if #R$C6E4 is not zero.
C $C6A5,$02 Set the carry flag and return.

c $C6A7 Write "Lives" text.
@ $C6A7 label=DUEL_PRINT_LIVES
C $C6A7,$09 Helper routine called from #R$C463 used for writing #R$C655 to the screen using the colours held in #REGbc;
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $02 | $02 | $00 | $00 }
. TABLE#
C $C6B0,$01 Return.

c $C6B1 Duel: Gain Extra Life.
@ $C6B1 label=DUEL_FLASH_TEXT
@ $C6B3 label=DUEL_FLASH_TEXT_LOOP
@ $C6BC label=DUEL_FLASH_HALT_LOOP_1
@ $C6C7 label=DUEL_FLASH_HALT_LOOP_2
C $C6B1,$1C Alternates displaying #R$C65B and #R$C655 to "flash" the lives indicator.
C $C6CD,$04 Increase the lives counter by one (#R$CC59).
C $C6D1,$02 Sets the carry flag and returns.

c $C6D3 Write "Countdown" text.
@ $C6D3 label=DUEL_PRINT_COUNTDOWN
C $C6D3,$0C Helper routine used for writing #R$C6E0 to the screen using the colours held in #REGbc;
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $03 | $03 | $00 | $00 }
. TABLE#
C $C6DF,$01 Return.

g $C6E0 Duel Countdown Timer
@ $C6E0 label=DUEL_TIMER
B $C6E0,$01
B $C6E1,$01
g $C6E2 Duel Shot Flag.
D $C6E2 See #R$C690 for the clearest example of usage.
B $C6E2,$01 Holds $00/ $01 to indicate player has been shot.
@ $C6E2 label=DUEL_BANG_FLAG
g $C6E3 Duel Lost Life Flag.
D $C6E3 See #R$C690 for the clearest example of usage.
B $C6E3,$01 Holds $00/ $01 to indicate player should lose a life (as they shot too quickly).
@ $C6E3 label=DUEL_LOSE_LIFE
g $C6E4 Duel Extra Life Flag.
D $C6E4 See #R$C690 for the clearest example of usage.
B $C6E4,$01 Holds $00/ $01 to indicate player has gained an extra life.
@ $C6E4 label=DUEL_EXTRA_LIFE

c $C6E5 Process Dueller Shot.
@ $C6E5 label=DUELLER_SHOT
C $C6E5,$05 Writes $04 to #R$C6E3.
C $C6EA,$03 Sets the dueller frame index to $04.
C $C6ED,$03 Jump to #R$C583.

c $C6F0 Flash Life Image.
D $C6F0 This routine flashes the last life image eight times, and returns with lives being one less and the carry flag
.       being set.
@ $C6F0 label=FLASH_LIFE_IMAGE
C $C6F0,$04 Decrease #R$CC59 by one.
C $C6F4,$02 Sets #REGb (the counter) to loop $08 times.
@ $C6F6 label=FLASH_LIFE_IMAGE_LOOP
C $C6F8,$04 Increase #R$CC59 by one and call #R$5B83.
C $C6FC,$05 Interrupt driven halt loop.
@ $C6FE label=FLASH_LIFE_IMAGE_HALT_LOOP_1
C $C703,$04 Decrease #R$CC59 by one and call #R$5B83.
C $C708,$05 Interrupt driven halt loop.
@ $C70A label=FLASH_LIFE_IMAGE_HALT_LOOP_2
C $C70D,$03 Retrieves #REGb (the counter) from the stack and loop back until finished.
C $C710,$02 Set the carry flag and return.


i $C712

b $C71E

b $C720 Sheriff's Star Page
@ $C720 label=SHERIFF_STAR
C $C720,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
C $C72D,$07 Continues into the attributes buffer, and writes $06 to every location.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $06 | $06 | $00 | $00 }
. TABLE#
C $C734,$0C Points to #R$F600 and prints it to the screen using #R$5B92.
C $C740,$0C Points to #R$C765 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $02 | $02 | $00 | $00 }
. TABLE#
C $C74C,$0C Points to #R$C784 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $02 | $02 | $00 | $00 }
. TABLE#
C $C758,$0D Points to #R$C7A3 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $02 | $02 | $00 | $00 }
. TABLE#
C $C764,$01 Return.

t $C765 Sheriff's Star Page Text
@ $C765 label=HEADER_1
T $C765,$1F
@ $C784 label=HEADER_2
T $C784,$1F
@ $C7A3 label=HEADER_3
T $C7A3,$1A

u $C7BD

c $C7C0 New Game
@ $C7C0 label=NEW_GAME
C $C7C0,$03 #HTML(Fetch <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)
C $C7C3,$03 Write it to #R$D8AC.
C $C7C6,$03 Call #R$C7E5.
C $C7C9,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.
C $C7D6,$05 Calls #R$CD64 with the counter $80.
C $C7DB,$0A Jump to #R$FA00 with #REGhl=#R$CBB4 and #REGix=#R$CD86.

N $C7E5 Displays the title screen and on return, sets the control method and initiates variables for a new game.
@ $C7E5 label=INIT_TITLE_SCREEN
C $C7E5,$06 Calls #R$FE00 with #REGhl=#R$CBB4.
C $C7EB,$02 Unused.
C $C7ED,$09 Grab the value stored at #R$5CB0 and if it is $01 then jump ahead to #R$C7F9 which writes #R$D39B to #R$CE12.
C $C7F6,$06 Write #R$D392 to #R$CE12.
@ $C7F9 label=SET_CONTROL_ALIAS
N $C7FC Resets all game variables/ states ready for a new game.
C $C7FC,$0D Clears the score (writes $00 over seven bytes from #R$CD86).

@ $C809 label=STARTING_LIVES
C $C809,$05 Initialise #R$CC59 to $03.

C $C80E,$06 Initialise #R$D45C to $0101.

C $C814,$0C Clears #R$CE14, #R$CE16 and #R$CE18 (sets them to $0000).

C $C820,$09 Clear #R$CA58 and #R$CA5A to $2020 (ASCII space-space).

C $C829,$0D Clear down the deposit flags (copies $00 to each from #R$CC8D).

C $C836,$03 Set the border to black.
C $C839,$04 Write $01 to #R$CBCF.

C $C846,$05 Writes $03 to #R$CE1B.
C $C84B,$06 Writes $0500 to #R$CE1C.
C $C851,$05 Writes $01 to #R$D191.
C $C856,$09 Grabs the #R$5CB1, if it's level 1 then jump to #R$C878 with #REGhl=#R$CA4A.

@ $C878 label=LEVEL_1
C $C878,$06 Writes #R$CE42 to #R$CE1F.

C $C882,$06 Writes #R$CE6F to #R$CE1F.

C $C88F,$06 Writes #R$CE5F to #R$CE1F.

C $C89C,$06 Writes #R$CE55 to #R$CE1F.

C $C8A9,$06 Writes #R$CE7E to #R$CE1F.

C $C8B6,$06 Writes #R$CE8D to #R$CE1F.

C $C8C3,$06 Writes #R$CE9C to #R$CE1F.

C $C8D0,$06 Writes #R$CE9C to #R$CE1F.

C $C8E0,$06 Writes #R$CE9C to #R$CE1F.

C $C927,$03 Call #R$C720.

N $C959 Sets the door attributes for the "time of day".
@ $C959 label=SET_DAY_ATTR
C $C959,$05 Call #R$C966 using #R$C96F.

@ $C95E label=SET_DUSK_ATTR
C $C95E,$05 Call #R$C966 using #R$C987.

@ $C963 label=SET_NIGHT_ATTR
C $C963,$03 Call #R$C966 using #R$C99F.

N $C966 Note this is for the opened door background hence it starts from frame 2 (as frame 1 is a closed door).
@ $C966 label=SET_DOOR_ATTR
C $C966,$09 Copies $18 bytes of data to #R$D6B9, then return.

N $C96F Door frame attribute data for each day phase.
@ $C96F label=DOOR_ATTR_DAY
B $C96F,$18
@ $C987 label=DOOR_ATTR_DUSK
B $C987,$18
@ $C99F label=DOOR_ATTR_NIGHT
B $C99F,$18

N $C9B7 Clears the cashbox flags, clears the screen and displays the phase number.
@ $C9B7 label=PREP_DISPLAY_PHASE
C $C9B7,$06 Writes $0101 to #R$D45C.
C $C9BD,$0D Clear down the deposit flags (copies $00 to each from #R$CC8D).
C $C9CA,$04 Call #R$C9D0 (using $00).
C $C9CE,$02 Jump to #R$C9DD.

N $C9D0 This routine has the ability to write any value across the screen buffer, however it's only ever called with
.       #REGa=$00 (clear screen).
@ $C9D0 label=CLEAR_SCREEN
C $C9D0,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.

N $C9DD Displays the current "phase".
@ $C9DD label=DISPLAY_PHASE
C $C9DD,$0B Copies #R$CA4E into #R$CA5C ($05 bytes of text data).
C $C9E8,$06 Writes #R$CA5A to #R$CA5C (at $CA61 - just overwriting the numeric part).
C $C9EE,$06 Call #R$CA19 with #R$CA4A.
C $C9F4,$06 Writes $CA61 back to #R$CA5A.
C $C9FA,$01 Return.

N $C9FB Displays the current "day".
@ $C9FB label=DISPLAY_DAY
C $C9FB,$0B Copies #R$CA53 into #R$CA5C ($05 bytes of text data).
C $CA06,$06 Writes #R$CA58 to #R$CA5C (at $CA61 - just overwriting the numeric part).
C $CA0C,$06 Call #R$CA19 with #R$CA4C.
C $CA12,$06 Writes $CA61 back to #R$CA58.
C $CA18,$01 Return.

N $CA19 This routine is for converting progress numbers into ASCII. On entry #REGhl will be either #R$CA4A or #R$CA4C.
@ $CA19 label=PROGRESS_BASE_10
C $CA19,$06 If the passed number is not more than 10 jump to #R$CA27.
C $CA1F,$06 Stores the ASCII representation of the number at $CA62 (for #R$CA5C). It adds ASCII "0" so for example 1
.           ends up being 1 + $30 = $31 (e.g. "1" in ASCII).
C $CA25,$02 Jump to #R$CA38.

N $CA27 Ensures the progress digit remains 0-9. On entry #REGhl will be either #R$CA4A or #R$CA4C.
@ $CA27 label=PROGRESS_DIVISIBLE_10
C $CA27,$02 Reset the current progress digit to $00.
C $CA29,$01 Use the secondary digit of the currently focused progress.
N $CA2A Note this doesn't account for a third digit and so leads to eventual corruption. Once past day/ phase "99", this
.       will display "00" and past "09" the first ASCII digit doesn't point to any usable image data. Note however, this
.       occurs after ~4 hours of game play so isn't especially an issue.
C $CA2A,$01 Increase this second digit by one.
C $CA2B,$06 Add ASCII "0" so for example 1 ends up being 1 + $30 = $31 (e.g. "1" in ASCII). Write this number to $CA61
.           (for #R$CA5C).
C $CA31,$01 Move back to point to the original location of #REGhl.
C $CA32,$06 Again, add ASCII "0" for this digit too. Write this number to $CA62 (for #R$CA5C).

N $CA38 Prints the current progress buffer message to the screen.
@ $CA38 label=PRINT_PROGRESS
C $CA38,$0C Prints #R$CA5C to the screen buffer at $486C using #R$CBD2.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $03 | $03 | $00 | $00 }
. TABLE#
@ $CA46 label=PROGRESS_HALT_LOOP
C $CA44,$05 Interrupt driven HALT loop ($50 cycles).
C $CA49,$01 Return.

@ $CA4A label=PHASE
@ $CA4C label=DAY
W $CA4A,$04,$02
@ $CA4E label=PHASE_COPY
T $CA4E,$05
@ $CA53 label=DAY_COPY
T $CA53,$05

@ $CA58 label=DAY_ASCII
T $CA58,$02
@ $CA5A label=PHASE_ASCII
T $CA5A,$02
@ $CA5C label=PROGRESS_BUFFER
T $CA5C,$08

N $CA64 Clears the screen and displays the day number.
@ $CA64 label=PREP_DISPLAY_DAY
C $CA64,$04 Clears the screen by passing $00 to #R$C9D0.
C $CA68,$03 Call #R$C9FB.
C $CA6B,$01 Return.

N $CA6C Clear down the day/ progress states.
@ $CA6C label=INIT_PROGRESS
C $CA6C,$09 Clears #R$CA4A and #R$CA4C (writes $0000 to them).
C $CA75,$0A Writes ASCII space ($20) to $CA61 and ASCII "0" ($30) to $CA62 (i.e. writes " 0" to the numeric portion of
.           #R$CA5C).
C $CA7F,$01 Return.

B $CA80,$01
@ $CA80 label=CASHBOXES_COMPLETED_FLAG
C $CA81
@ $CA81 label=CASHBOXES_COMPLETED
@ $CA87 label=CASHBOXES_FLASH_LOOP

C $CAB9,$0C Writes #REGa across all the deposit flags (copies to each from #R$CC8D).
@ $CAB9 label=DEPOSIT_FLASH_PREP
C $CAC5,$03 Jump to #R$CC9B.

C $CACB,$04 Writes $00 to #R$D2FE.

C $CAE7,$04 Read keys SPACE, FULL-STOP, M, N, & B.
C $CAEE,$04 Read keys SHIFT, Z, X, C, & V.
C $CAFB,$04 Read keys SHIFT, Z, X, C, & V.
C $CB03,$04 Read keys SHIFT, Z, X, C, & V.

C $CB83,$08 If bit 0 of #R$D2FE is not zero then jump to #R$CD47.
C $CB8B,$05 Else if bit 1 is not zero, jump to #R$CD1B.
C $CB90,$03 Call #R$CDC3.

C $CB93,$0A If #R$D190 is not zero then call #R$CBA0 (also, writes $00 to #R$D190 to clear it).

C $CBA6,$0E Blanks $FF bytes from #R$5B00 onwards, then returns.

B $CBB4 Copied to $5B80.
@ $CBB4 label=COPIED_5B80
B $CBCF

c $CBD0 Draw Text.
@ $CBD0 label=TWO_TONE_ATTRIBUTES_BUFFER
W $CBD0 Stores the attributes; top attribute/ bottom attribute.
@ $CBD2 label=PRINT_TWO_TONE_TEXT
C $CBD2,$04 Stash the attributes at #R$CBD0.
@ $CBD6 label=PRINT_TWO_TONE_TEXT_LOOP
C $CBD6,$04 Grab the next character in the string, if it's $FF then return.

@ $CBFC label=PRINT_TT_TEXT_SPACE_CHECK
C $CBFC,$04 If the character is a space then jump forward to #R$CC0E.
C $CC20,$0A Load the stored top/ bottom attribute bytes back into #REGbc and write them to the screen.
C $CC2A,$01 Return.

c $CC2B
C $CC37,$01 Return.

g $CC38 Buffer for holding #R$D5E6 address.
@ $CC38 label=BUFFER_COPY_ROUTINE
W $CC38,$02

c $CC3A Main Playfield Initialisation.
N $CC3A Draws Main Playfield with all three doors closed.
@ $CC3A label=DRAW_PLAY_WITH_DOORS
C $CC3A,$07 Draw the main game playfield.
C $CC41,$08 Calls #R$D664 with #R$CE1A set to $01.
C $CC49,$08 Calls #R$D664 with #R$CE1A set to $02.
C $CC51,$08 Jump to #R$D664 with #R$CE1A set to $03.

@ $CC59 label=LIVES
g $CC59 Number of lives remaining

c $CC5A Display The "Life" Images.
@ $CC5A label=LIFE_IMAGES
C $CC5A,$05 Set up counter=$05 screen buffer=$50B6.
@ $CC5F label=LIFE_IMAGES_LOOP
C $CC5F,$0C jjjss
C $CC6B,$05 If #R$CC59 are zero then return.
C $CC70,$03 If #R$CC59 is more than or equal to "6" then return.
@ $CC77 label=DRAW_LIFE_IMAGES_LOOP
C $CC80,$01 Return.
@ $CC81 label=DRAW_LIFE_IMAGES
C $CC81,$0A Point at the #R$FFB8 and call #R$D5E6.
@ $CC84 label=COPY_ROUTINE_LOOP
C $CC8C,$01 Return.

g $CC8D Deposit Flags.
D $CC8D Stores whether a deposit has been made for each door.
@ $CC8D label=DOOR_DEPOSITED_01
@ $CC8E label=DOOR_DEPOSITED_02
@ $CC8F label=DOOR_DEPOSITED_03
@ $CC90 label=DOOR_DEPOSITED_04
@ $CC91 label=DOOR_DEPOSITED_05
@ $CC92 label=DOOR_DEPOSITED_06
@ $CC93 label=DOOR_DEPOSITED_07
@ $CC94 label=DOOR_DEPOSITED_08
@ $CC95 label=DOOR_DEPOSITED_09
@ $CC96 label=DOOR_DEPOSITED_10
@ $CC97 label=DOOR_DEPOSITED_11
@ $CC98 label=DOOR_DEPOSITED_12
B $CC8D,$0C,$01

g $CC99 Probably represents each block of six deposit flags.
@ $CC99 label=DOOR_DEPOSITED_01_06
@ $CC9A label=DOOR_DEPOSITED_07_12
B $CC99,$02,$01

c $CC9B Draws Deposit Cashboxes.
C $CC9B,$0A Converts #R$D45C into cash deposit box flag address (e.g. "1" becomes #R$CC8D and so on).
C $CCA5,$07 #REGa=#R$D16D.
C $CCAF,$07 #REGa=#R$D17B.
C $CCB9,$07 #REGa=#R$D189.

C $CCC2,$03 #REGde=#R$CC99.
C $CCC5,$03 #REGhl=#R$CC8D.
C $CCC8,$01 Fetch the flag for #R$CC99.
C $CCC9,$01 Run a logical OR against the contents of #REGhl.
C $CCCA,$01 Writes this back into #REGhl (setting the flag).
C $CCCC,$01 Move onto #R$CC9A.
C $CCCD,$01 Fetch the flag for #R$CC9A.
C $CCCE,$01 Run a logical OR against the contents of #REGhl.
C $CCCF,$01 Writes this back into #REGhl (setting the flag).

@ $CCD3 label=CASHBOXES_COMPLETE
C $CCD3,$03 Points to the cashbox flags (beginning at #R$CC8D).
C $CCD6,$05 Write $00 to #R$CA80.
C $CCDB,$02 Testing against all 12 cashboxes.
C $CCDD,$03 Fetch the cashbox flag, return if its zero.
C $CCE0,$03 Move onto the next cashbox (loop back to #R$CCDD) or continue once all 12 are checked.
C $CCE3,$02 Write #REGa ($01) to #R$CA80.
@ $CCDD label=CASHBOXES_COMPLETE_LOOP
@ $CCE5 label=DRAW_GAME_CASHBOX
C $CCE5,$15 Determines whether to send #R$FF78 or #R$FF98 to #R$D5E6.
C $CCFA,$01 Return.

N $CCFB Draws all the cashboxes in two blocks of 6.
@ $CCFB label=GAME_CASHBOXES
@ $CD0A label=GAME_CASHBOXES_SKIP
@ $CD0C label=GAME_CASHBOXES_LOOP
C $CCFB,$1F The statuses for the cashboxes begin at #R$CC8D. This routine processes them in two blocks of 6 (as they
.           appear. The first block is displayed at $401F, after processing the subroutine returns and continues for the
.           next six blocks, just altering the screen location to $4025.
C $CD1A,$01 Return.

c $CD1B Flash Lives/ Lose Life.
@ $CD1B label=FLASH_LIVES
C $CD1B,$05 Short pause.
C $CD20,$06 Point to #R$CC59. Set a counter for $05 times and stash it.
@ $CD25 label=FLASH_LIVES_LOOP
C $CD26,$05 Decrease the number of lives by one, stash the lives memory location and draw the decreased life images.
C $CD2B,$05 Short pause.
C $CD30,$06 Grab the lives memory location, increase it by one, stash the location again and draw the now increased life
.           images (i.e. what they were on entry to the routine).
C $CD36,$05 Short pause.
C $CD3C,$03 Loop back until the counter is zero.
C $CD3F,$06 Finally decrease lives by one and if they are not zero jump to #R$CACB.
C $CD45,$02 Set the carry flag and return.

c $CD47
C $CD47,$07 If bit 2 of #R$D2FE is zero then jump to #R$CD53.

c $CD64 Configurable "pause".
N $CD64 Loops back on itself using #REGb as a counter.
@ $CD64 label=HALT_LOOP
C $CD64,$04 Short interrupt driven pause, and return.

c $CD68 Initialise Door Flags.
N $CD68 Populates the state flags for each door.
@ $CD68 label=POPULATE_DOOR_BUFFER
C $CD68,$07 Call #R$D8A1 using #REGix=#R$D165.
C $CD6F,$07 Call #R$D8A1 using #REGix=#R$D173.
C $CD76,$07 Call #R$D8A1 using #REGix=#R$D181.
C $CD7D,$01 Return.

c $CD7E Debugger
@ $CD7E label=DEBUGGER
D $CD7E As the game uses its own character set, it's unlikely this routine was/ is used for the actual game (it doesn't
.       seem to be called from anywhere).
.       At a guess, it was probably used for "testing" text messages and outputs during development.
C $CD7E,$04 Grab a byte from #REGhl return if it's $FF (our termination character).
C $CD82,$01 #HTML(Print to screen (see <a href="https://skoolkid.github.io/rom/asm/0010.html">PRINT_A_1</a>).)
C $CD83,$03 Increase #REGhl by one and loop back to #R$CD7E.

g $CD86 Score (6 bytes)
@ $CD86 label=SCORE_DIGIT_6
B $CD86,$06,$01
@ $CD87 label=SCORE_DIGIT_5
@ $CD88 label=SCORE_DIGIT_4
@ $CD89 label=SCORE_DIGIT_3
@ $CD8A label=SCORE_DIGIT_2
@ $CD8B label=SCORE_DIGIT_1

g $CD8C
B $CD8C,$01

g $CD8D
B $CD8D,$03 ???

c $CD90 Draw Score To The Screen
@ $CD90 label=DRAW_SCORE
C $CD90,$08 Starting values; #TABLE(default,centre,centre,centre,centre)
. { =h Source | =h Screen Buffer | =h Counter }
. { #R$CD8B | $50C8 | $06 }
. TABLE#
C $CD98,$03 Stash the lot.
C $CD9B,$0B Grab the number at the source memory location;
. #LIST
. { If it's zero then add $0A (as the numbers are stored 1-2-3-4-5-6-7-8-9-0 whereas ASCII uses 0-1-2-3-4-5-6-7-8-9) }
. { add $23 (so for example "2" will be "$25" - see #R$CDAE) }
. { Call #R$CDAE }
. LIST#
@ $CD98 label=SCORE_DIGIT_LOOP
@ $CDA1 label=SCORE_DIGIT_NON_ZERO
C $CDA6,$03 Retrieve our current source, destination and counter from the stack.
C $CDA9,$05 Increase the screen buffer memory location by one, decrease the source memory location and loop round to
.           #R$CD98 until it is zero.
C $CDAD,$01 Return.

c $CDAE Draw Numbering from Character Set Index.
@ $CDAE label=DRAW_NUMBER
C $CDAE,$14 Using $C000 as a base address, this works out the character set memory address from a given index passed
.           in #REGa. To give an example using "2" ($25 - see #R$CD90);
. #LIST
. { #HTML(Loads <strong>$25</strong> as the low-order byte; #REGhl=$0025) }
. { #HTML(Times by <strong>$10</strong>; #REGhl=$250) }
. { #HTML(Add <strong>$C000</strong>=#R$C250) }
. LIST#
. This is then passed to #R$D5E6.
C $CDC2,$01 Return.

c $CDC3 Apply Scoring
@ $CDC3 label=SCORING
C $CDC3,$15 Calls #R$CDDC three times with #REGix containing;
. #LIST
. { #R$D165 }
. { #R$D173 }
. { #R$D181 }
. LIST#
C $CDD8,$03 Call #R$CD90.
C $CDDB,$01 Return.

N $CDDC Passes the higher and lower score values to #R$CDF7 for the current door.
@ $CDDC label=SCORING_PREP
C $CDDC,$03 References #R$CD87.
C $CDDF,$03 Retrieves #REGix+$06, stores it in #REGb then reset it to zero.
C $CDE6,$03 Call #R$CDF7.
C $CDE9,$03 References #R$CD88.
C $CDEC,$03 Retrieves #REGix+$07, stores it in #REGb then reset it to zero.
C $CDF3,$03 Call #R$CDF7.
C $CDF6,$01 Return.

N $CDF7 Applies the door scores into the player score.
@ $CDF7 label=SCORING_APPLY
C $CDF7,$05 Pass the current score digit to #R$CE08 and overwrite the digit with the result.
C $CDFC,$02 Sets a counter to $05 (5 more digits in the score).
@ $CDFE label=SCORING_APPLY_LOOP
C $CDFE,$01 Move onto the next scoring digit.
C $CDFF,$05 Pass the current score digit to #R$CE08 and overwrite the digit with the result.
C $CE04,$03 Loop back to #R$CDFE until the counter is zero (and all scoring digits are accounted for).
C $CE07,$01 Return.

N $CE08 Ensures the current scoring digit remains 0-9 (if $0A then it's reset and the carry digit is forwarded on).
@ $CE08 label=SCORING_BASE_10
C $CE08,$01 Adds current score digit with passed score.
C $CE09,$02 Reset passed score to zero.
C $CE0B,$03 Return if result is less than $0A (base 10).
C $CE0E,$02 Subtract $0A to keep this digit in base 10 (e.g. "11" becomes "1", "12" becomes "2", and so on).
C $CE10,$02 Add one onto the passed score (which carries onto the next digit as it goes lowest to highest) and return.

g $CE12 Control Method Routine Alias.
D $CE12 Points to either #R$D392 or #R$D39B depending on the chosen control method.
@ $CE12 label=CONTROL_ROUTINE_ALIAS
B $CE12,$02 16 bit memory location of either the keyboard or joystick control routines.

g $CE14 Door Routine Buffer.
D $CE14 These buffers point to the routines for character/ door actions for each door that are currently "in-play".
.       Some example routines would be;
. #TABLE(default,centre,centre)
. { =h Routine | =h Door }
. { #R$D192 | "Normal" Bandit }
. { #R$D1DC | Bowie }
. { #R$D201 | Customer }
. { #R$D241 | Julius }
. { #R$D289 | "Drawing" Bandit }
. TABLE#
.       And will also hold the door closing routines as well.
@ $CE14 label=DOOR_1_ROUTINE
W $CE14,$02 Door 1 character/ door routine in-play.
@ $CE16 label=DOOR_2_ROUTINE
W $CE16,$02 Door 2 character/ door routine in-play.
@ $CE18 label=DOOR_3_ROUTINE
W $CE18,$02 Door 3 character/ door routine in-play.

g $CE1A Door Frame Reference
D $CE1A Only one door is "active" at a time, this status buffer points to the "currently in-focus door".
@ $CE1A label=DOOR_FRAME_REF
B $CE1A,$01 #TABLE(default,centre,centre)
. { =h Value | =h Which One }
. { $01 | Door 1 }
. { $02 | Door 2 }
. { $03 | Door 3 }
. TABLE#

g $CE1B
B $CE1B,$01
W $CE1C,$02
B $CE1E,$01
N $CE1F Defines the entry point for the choosing routines. Note, this isn't for one choice - they chain into each other
.       this simply points to where the chain starts.
@ $CE1F label=CHOOSER_ROUTINE_BUFFER
W $CE1F,$02

c $CE21 Choose Door Character.
N $CE21 The characters available on a particular level are determined by #R$CE1F.
. #TABLE(default,centre,centre)
. { =h Initialisation Routine | =h Door }
. { #R$CE42 | Door 1 }
. { #R$CE8D | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
@ $CE21 label=CHARACTER_CHOOSER
C $CE21,$06 Decrease #R$CE1E by one.
C $CE27,$01 Return if not zero.
C $CE28,$04 Copies #R$CE1B into #R$CE1E.
C $CE2C,$07 Decrease ????? by one.
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16E | Door 1 }
. { #R$D17C | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
C $CE33,$01 Return if not zero.

N $CE34 f
@ $CE34 label=CHOOSER
C $CE34,$03 Call #R$D8B0.
C $CE37,$02 Keep bits 0-4 (so 0-31).
C $CE39,$05 Set bit 3 and write the resulting value to;
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16E | Door 1 }
. { #R$D17C | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
C $CE3E,$04 Jump to the memory address contained at #R$CE1F.

N $CE42 Handles choosing one of the initial "default" characters. A
.       character is always chosen here, so this is the end of the
.       choosing routine.
@ $CE42 label=CHOOSE_DEFAULT_SET
C $CE42,$03 Call #R$DAEF.
C $CE45,$02 Keep only bits 0 and 1 (which determine the type of character).
C $CE47,$0E Determines which character initialisation to run;
. #TABLE(default,centre,centre)
. { =h #REGa | =h Initialisation Routine }
. { $00 | #R$CEB8 }
. { $01 | #R$CEFC }
. { $02 | #R$CF5E }
. { $03 | #R$CF2B }
. TABLE#

N $CE55 Handles whether or not to choose Julius.
@ $CE55 label=CHOOSE_JULIUS
C $CE55,$03 Call #R$D8B0.
C $CE58,$04 Keep only bits 2 and 3. Jump to the next character "test" if
.           this is a non-zero number at #R$CE5F.
C $CE5C,$03 Jump to #R$CFB7.

N $CE5F Handles whether or not to choose Bandit 2.
@ $CE5F label=CHOOSE_BANDIT_2
C $CE5F,$03 Call #R$D8B0.
C $CE62,$04 Keep only bits 3, 4 and 7. Jump to the next character "test" if
.           this is a non-zero number at #R$CE6F.
C $CE66,$03 Set source character data to #R$D119.
C $CE69,$03 Set target character buffer to #R$D124.
C $CE6C,$03 Jump to #R$CEA9.

N $CE6F Handles whether or not to choose Bandit 3.
@ $CE6F label=CHOOSE_BANDIT_3
C $CE6F,$03 Call #R$D8B0.
C $CE72,$04 Keep only bits 0, 4 and 5. Jump to the next character "test" if
.           this is a non-zero number then jump back to the #R$CE42.
C $CE76,$03 Set source character data to #R$D0C1.
C $CE79,$03 Set target character buffer to #R$D0CC.
C $CE7C,$02 Jump to #R$CEA9.

N $CE7E Handles whether or not to choose Bandit 4.
@ $CE7E label=CHOOSE_BANDIT_4
C $CE7E,$03 Call #R$D8B0.
C $CE81,$04 Keep only bits 0, 1 and 7. Jump to the next character "test" if
.           this is a non-zero number #R$CE55.
C $CE85,$03 Set source character data to #R$D0D7.
C $CE88,$03 Set target character buffer to #R$D0E2.
C $CE8B,$02 Jump to #R$CEA9.

N $CE8D Handles whether or not to choose Bandit 5.
@ $CE8D label=CHOOSE_BANDIT_5
C $CE8D,$03 Call #R$D8B0.
C $CE90,$04 Keep only bits 3, 4 and 6. Jump to the next character "test" if
.           this is a non-zero number #R$CE7E.
C $CE94,$03 Set source character data to #R$D0ED.
C $CE97,$03 Set target character buffer to #R$D0F8.
C $CE9A,$02 Jump to #R$CEA9.

N $CE9C Handles whether or not to choose Bandit 6.
@ $CE9C label=CHOOSE_BANDIT_6
C $CE9C,$03 Call #R$D8B0.
C $CE9F,$04 Keep only bits 0, 4, 5 and 6. Jump to the next character "test" if
.           this is a non-zero number #R$CE8D.
C $CEA3,$03 Set source character data to #R$D103.
C $CEA6,$03 Set target character buffer to #R$D10E.

N $CEA9 Stashes the chosen character source/ buffer to the door state buffer.
@ $CEA9 label=CHOOSE_ACTION
C $CEA9,$06 Writes the character source memory address to one of the following (depending on which door is currently
.           being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D171 | Door 1 }
. { #R$D17F | Door 2 }
. { #R$D18D | Door 3 }
. TABLE#
C $CEAF,$06 Writes the character target/ buffer memory address to one of the following (depending on which door is
.           currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
C $CEB5,$03 Jump to #R$D019.

C $CF2B
C $CF5E

c $CEB8 Character Initialisations.
N $CEB8 Writes a "bandit opening the door" to the door flags/ cache.
@ $CEB8 label=INIT_BANDIT_OPEN
C $CEB8,$0C Writes #R$D192 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
C $CEC4,$0E Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D076.
C $CED2,$06 Writes $01 to #R$D18F and return.

N $CED8 Writes a "bandit closing the door" to the door flags/ cache.
@ $CED8 label=INIT_BANDIT_CLOSE
C $CED8,$0C Writes #R$D1B7 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
C $CEE4,$0E Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D07D.
C $CEF2,$05 Writes $01 to #R$D18F.

N $CEFC Writes "Bowie" to the door flags/ cache.
@ $CEFC label=INIT_BOWIE
C $CEFC,$0C Writes #R$D1DC to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF16 label=INIT_BOWIE_SET_FLAG

N $CF2B Writes a "customer opening the door" to the door flags/ cache.
@ $CF2B label=INIT_CUSTOMER_OPEN
C $CF2B,$0C Writes #R$D201 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF45 label=INIT_CUST_OPEN_SET_FLAG

N $CF5E Writes a "customer closing the door" to the door flags/ cache.
@ $CF5E label=INIT_CUSTOMER_CLOSE
C $CF5E,$0C Writes #R$D201 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF78 label=INIT_CUST_CLOSE_SET_FLAG

N $CF91 Writes a "customer being shot" to the door flags/ cache.
@ $CF91 label=INIT_CUSTOMER_SHOT
C $CF91,$0C Writes #R$D226 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
C $CF9D,$06 Loads e.g. #R$D167 (depending on which door is currently
.           being actioned) into #REGde.
C $CFA3,$03 #REGhl=#R$D0AB.
C $CFA6,$06 Increase #REGde by $06.
C $CFAC,$05 Copies three sequential bytes of data from #REGhl to #REGde.
C $CFB1,$06 Writes $01 to #R$D18F and return.

N $CFB7 Writes "Julius opening the door" to the door flags/ cache.
@ $CFB7 label=INIT_JULIUS_OPEN
C $CFB7,$0C Writes #R$D241 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CFD1 label=INIT_JULIUS_OPEN_SET_FLAG

N $CFDD Writes "Julius closing the door" to the door flags/ cache.
@ $CFDD label=INIT_JULIUS_CLOSE
C $CFDD,$05 Writes $01 to #R$D0B8.
C $CFE2,$0C Writes #R$D265 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
C $CFEE,$0F Handles copying $0009 bytes of data from the address (plus 1) contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D0B8.


c $D019
C $D019,$0C Writes #R$D289 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
C $D025,$11 Copies $000B bytes of data from (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Source | =h Destination | =h Door }
. { #R$D171 | #R$D167 | Door 1 }
. { #R$D17F | #R$D175 | Door 2 }
. { #R$D18D | #R$D183 | Door 3 }
. TABLE#
C $D036,$01 Return.

c $D037
@ $D037 label=TODO_DOOR_RESET
C $D037,$09 Writes $01 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
. This is the first byte of character state data.

C $D040,$0C Writes #R$D2AD to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
. This is copying the actual source data into the cache where it can be manipulated by the game events.

C $D04C,$11 Copies $000B bytes of data from (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Source | =h Destination | =h Door }
. { #R$D16F | #R$D167 | Door 1 }
. { #R$D17D | #R$D175 | Door 2 }
. { #R$D18B | #R$D183 | Door 3 }
. TABLE#

C $D05D,$05 Initialise #R$D18F (writes $01 to it).
C $D062,$07 Loads #REGa with the flag from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
. As per #R$D037, this should be $01.


C $D069,$04
C $D075,$01 Return.

b $D076

b $D07D

B $D0B8,$09 ??

B $D0AB,$03 Source
B $D0AE

N $D0C1 Bandit 3.
B $D0C1,$0B Bandit 3 source data.
B $D0CC,$0B Bandit 3 buffer.

N $D0D7 Bandit 4.
B $D0D7,$0B Bandit 4 source data.
B $D0E2,$0B Bandit 4 buffer.

N $D0ED Bandit 5.
B $D0ED,$0B Bandit 5 source data.
B $D0F8,$0B Bandit 5 buffer.

N $D103 Bandit 6.
B $D103,$0B Bandit 6 source data.
B $D10E,$0B Bandit 6 buffer.

N $D119 Bandit 2.
B $D119,$0B Bandit 2 source data.
B $D124,$0B Bandit 2 buffer.

B $D141,$0B

B $D153,$0B Target

g $D165 Door 1 Flags.
@ $D165 label=DOOR_1_FLAGS
@ $D167 label=DOOR_1_SOURCE
@ $D169 label=DOOR_1_BOWIE_ACTION
@ $D16B label=DOOR_1_SCORING
@ $D16D label=DOOR_1_CASH_ACTION
@ $D16F label=DOOR_1_CHAR_BUFFER
@ $D171 label=DOOR_1_CHAR_SOURCE
W $D165,$08
B $D16D,$01
B $D16E,$01
W $D16F,$04
g $D173 Door 2 Flags.
@ $D173 label=DOOR_2_FLAGS
@ $D175 label=DOOR_2_SOURCE
@ $D177 label=DOOR_2_BOWIE_ACTION
@ $D179 label=DOOR_2_SCORING
@ $D17B label=DOOR_2_CASH_ACTION
@ $D17D label=DOOR_2_CHAR_BUFFER
@ $D17F label=DOOR_2_CHAR_SOURCE
W $D173,$08
B $D17B,$01
B $D17C,$01
W $D17D,$04
g $D181 Door 3 Flags.
@ $D181 label=DOOR_3_FLAGS
@ $D183 label=DOOR_3_SOURCE
@ $D185 label=DOOR_3_BOWIE_ACTION
@ $D187 label=DOOR_3_SCORING
@ $D189 label=DOOR_3_CASH_ACTION
@ $D18B label=DOOR_3_CHAR_BUFFER
@ $D18D label=DOOR_3_CHAR_SOURCE
W $D181,$08
B $D189,$01
B $D18A,$01
W $D18B,$04

g $D18F

g $D190

g $D191

c $D192 Copy Source Character Data To Character State Data.
N $D192 Handles copying a "normal" bandit into the bandit state cache at #R$D71E.
@ $D192 label=PREP_BANDIT_OPEN
C $D192,$11 Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D71E.
C $D1A3,$03 Call #R$D725 to begin this characters actions.
C $D1A6,$03 Restore the source, target and counter from above.
C $D1A9,$01 Swap the source and target.
C $D1AA,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D1B4,$03 Else copy the (swapped) source back to the new target and return.

N $D1B7 And copying a successful bandit encounter to close the door.
@ $D1B7 label=PREP_BANDIT_CLOSE
C $D1B7,$11 Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D71E.
C $D1C8,$03 Call #R$D771 to begin this characters actions.
C $D1CB,$03 Restore the source, target and counter from above.
C $D1CE,$01 Swap the source and target.
C $D1CF,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D1D9,$03 Else copy the (swapped) source back to the new target and return.

N $D1DC Handles copying Bowie state data into the state cache at #R$D7C5.
@ $D1DC label=PREP_BOWIE
C $D1DC,$11 Handles copying $0009 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D7C5.
C $D1ED,$03 Call #R$D7CE to begin this characters actions.
C $D1F0,$03 Restore the source, target and counter from above.
C $D1F3,$01 Swap the source and target.
C $D1F4,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D1FE,$03 Else copy the (swapped) source back to the new target and return.

N $D201 Handles copying customer state data into the state cache at #R$D48F.
@ $D201 label=PREP_CUSTOMER
C $D201,$11 Handles copying $000F bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D48F.
C $D212,$03 Call #R$D49E to begin this characters actions.
C $D215,$03 Restore the source, target and counter from above.
C $D218,$01 Swap the source and target.
C $D219,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D223,$03 Else copy the (swapped) source back to the new target and return.

N $D226 Handles copying customer "is shot" state data into the state cache at #R$D48F.
@ $D226 label=PREP_CUSTOMER_SHOT
C $D226,$11 Handles copying $000F bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D48F.
C $D237,$03 Call #R$D57B.
C $D23A,$03 Restore the source, target and counter from above.
C $D23D,$01 Swap the source and target.
C $D23E,$03 Copy the (swapped) source back to the new target and return.

N $D241 Handles copying Julius state data into the state cache at #R$D8E5.
@ $D241 label=PREP_JULIUS_OPEN
C $D241,$11 Handles copying $000A bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D8E5.
C $D252,$03 Call #R$D8EF.
C $D255,$03 Restore the source, target and counter from above.
C $D258,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D262,$03 Copy the source to the target again and return.

N $D265 And copying a successful Julius encounter to close the door.
@ $D265 label=PREP_JULIUS_CLOSE
C $D265,$11 Handles copying $000A bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D8E5.
C $D276,$03 Call #R$D997.
C $D279,$03 Restore the source, target and counter from above.
C $D27C,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D286,$03 Copy the source to the target again and return.

N $D289 Handles copying a "drawing bandit" into the bandit state cache at #R$DA0C.
@ $D289 label=PREP_BANDIT_DRAW_OPEN
C $D289,$11 Handles copying $000B bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$DA0C.
C $D29A,$03 Call #R$DA17.
C $D29D,$03 Restore the source, target and counter from above.
C $D2A0,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
C $D2AA,$03 Copy the source to the target again and return.

N $D2AD And copying a successful "drawing bandit" encounter to close the door.
@ $D2AD label=PREP_BANDIT_DRAW_CLOSE
C $D2AD,$11 Handles copying $000B bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$DA0C.
C $D2BE,$03 Call #R$DA85.
C $D2C1,$03 Restore the source, target and counter from above.
C $D2C4,$08 Check if #R$D18F is zero. If it wasn't zero then return.
C $D2CC,$03 Copy the source to the target again and return.

c $D2CF
C $D2CF,$03 #R$CE12
;B $D2D7,$50

B $D2FE,$01
B $D2FF,$01

g $D300 Player Shot.
@ $D300 label=HIT
B $D300 #TABLE(default,centre,centre)
. { =h Value | =h What }
. { $00 | No shot/ inactive }
. { $01 | Door 1 }
. { $02 | Door 2 }
. { $03 | Door 3 }
. TABLE#

g $D301 Player Left/ Right.
N $D301 These flags don't control left/ right movement they just indicate whether keys are being pressed/ joystick used.
@ $D301 label=RIGHT
B $D301,$01 Defaults to $00, holds $01 when the player is pressing "right".
@ $D302 label=LEFT
B $D302,$01 Defaults to $00, holds $01 when the player is pressing "left".

g $D303 Player Shooting.
@ $D303 label=TWO
B $D303,$01 Defaults to $00, holds $01 when the player is pressing "2".
@ $D304 label=THREE
B $D304,$01 Defaults to $00, holds $01 when the player is pressing "3".
@ $D305 label=ONE
B $D305,$01 Defaults to $00, holds $01 when the player is pressing "1".
@ $D306 label=CONTROLS_BYTE
B $D306,$01 Holds the controls in one byte.
. #TABLE(default,centre,centre,centre)
. { =h Value | =h Bits | Door }
. { $10 | #EVAL($10, 2, 8) | Door 2 }
. { $11 | #EVAL($11, 2, 8) | Door 3 }
. { $12 | #EVAL($12, 2, 8) | Door 1 }
. TABLE#

c $D307 Action Controls.
N $D307 On entry #REGa will contain one of;
. #TABLE(default,centre,centre,centre)
. { =h Value | =h Bits | Door }
. { $10 | #EVAL($10, 2, 8) | Door 2 }
. { $11 | #EVAL($11, 2, 8) | Door 3 }
. { $12 | #EVAL($12, 2, 8) | Door 1 }
. TABLE#
. This is written to #R$D306, and then decoded into writing a $01, $02 or $03 to #R$D300 to represent which door has
. been shot at.  This routine also writes $01 to #R$D305, #R$D303 and #R$D304 to represent the same thing.
. Before returning, #REGhl is set to the screen location for displaying the shot mask/ shot image in the centre of the
. door.
@ $D307 label=CONTROLS
C $D307,$07 Writes #REGa to #R$D306 and sets #REGhl=#R$D300.
C $D30F,$04 If "3" was pressed then jump to #R$D33B (a check for if bit 0 is set).
C $D313,$04 If "1" was pressed then jump to #R$D360 (a check for if bit 1 is set).

N $D317 Handles settings flags and shot drawing location for door 2.
@ $D317 label=SHOT_TWO
C $D317,$05 If #R$D303 is not zero then return.
C $D31C,$06 Sets the other two door flags to zero (#R$D304 and #R$D305).
C $D322,$07 Indicate the the middle door is being shot at (write $01 to #R$D303 and $02 to #R$D300).
C $D329,$04 Increase #R$D8AC by one.
C $D32D,$04 Sets the screen location for this shot to $482F and stash it.
C $D331,$03 Draw the shot mask.
C $D334,$04 Grab the screen location again, and now draw the shot.
C $D338,$03 Jump to #R$6500.

N $D33B Handles settings flags and shot drawing location for door 3.
@ $D33B label=SHOT_THREE
C $D33B,$05 If #R$D304 is not zero then return.
C $D340,$06 Sets the other two door flags to zero (#R$D303 and #R$D305).
C $D346,$07 Indicate the the right door is being shot at (write $01 to #R$D304 and $03 to #R$D300).
C $D34D,$05 Shifts the value at #R$D8AC to the left with bit 7 moved to the carry flag and bit 0 reset (zeroed).
C $D352,$04 Sets the screen location for this shot to $483A and stash it.
C $D356,$03 Draw the shot mask.
C $D359,$04 Grab the screen location again, and now draw the shot.
C $D35D,$03 Jump to #R$6502.

N $D360 Handles settings flags and shot drawing location for door 1.
@ $D360 label=SHOT_ONE
C $D360,$05 If #R$D305 is not zero then return.
C $D365,$06 Sets the other two door flags to zero (#R$D303 and #R$D304).
C $D36B,$07 Indicate the the left door is being shot at (write $01 to #R$D305 and $01 to #R$D300).
C $D372,$05 Shifts the value at #R$D8AC to the left with bit 7 moved to the carry flag and bit 0 reset (zeroed).
C $D377,$04 Sets the screen location for this shot to $4824 and stash it.
C $D37B,$03 Draw the shot mask.
C $D37E,$04 Grab the screen location again, and now draw the shot.
C $D382,$03 Jump to #R$6504.
C $D385,$01 Return.

N $D386 Sets the flag for indicating "right" has been pressed by the player.
@ $D386 label=SET_RIGHT
C $D386,$06 Write $01 to #R$D301 and return.

N $D38C Sets the flag for indicating "left" has been pressed by the player.
@ $D38C label=SET_LEFT
C $D38C,$06 Write $01 to #R$D302 and return.

c $D392 Reads In-Game Joystick Controls.
@ $D392 label=CONTROLS_JOYSTICK
C $D392,$03
C $D395,$02 #HTML(Reads input from the Kempston joystick (see <a href="../reference/pokes.html">POKES</a>)).
C $D397,$03 If there's nothing to read fall back to #R$D39B anyway.
C $D39A,$01 Return.

c $D39B Reads In-Game Keyboard Controls (1-2-3).
@ $D39B label=CONTROLS_KEYBOARD
C $D39B,$04 Read keys 1-2-3-4-5.
@ $D39F label=CONTROLS_INPUT_1
C $D39F,$04 If "1" isn't being pressed then jump to #R$D3A6.
C $D3A3,$03 Set #REGa=$12 and return.
@ $D3A6 label=CONTROLS_INPUT_2
C $D3A6,$04 If "2" isn't being pressed then jump to #R$D3AD.
C $D3AA,$03 Set #REGa=$10 and return.
@ $D3AD label=CONTROLS_INPUT_3
C $D3AD,$04 If "3" isn't being pressed then jump to #R$D3E2.
C $D3B1,$03 Set #REGa=$11 and return.

c $D3B4 Draw Gun Shot Mask.
@ $D3B4 label=DRAW_SHOT_MASK
C $D3B4,$06 Point to #R$FF58 and set the image dimensions.
C $D3BA,$01 Stash the screen location.
C $D3BB,$03 Calls #R$D5FA.
C $D3BE,$02 Very short pause.
C $D3C0,$01 Grab the screen location.
C $D3C1,$06 Point to #R$FF58 and set the image dimensions.
C $D3C7,$03 Calls #R$D5FA.
C $D3CA,$01 Return.

c $D3CB Draw Gun Shot.
@ $D3CB label=DRAW_GUN_SHOT
C $D3CB,$06 Point to #R$FF68 and set the image dimensions.
C $D3D1,$01 Stash the screen location.
C $D3D2,$03 Calls #R$D5FA.
C $D3D5,$02 Very short pause.
C $D3D7,$01 Grab the screen location.
C $D3D8,$06 Point to #R$FF68 and set the image dimensions.
C $D3DE,$03 Calls #R$D5FA.
C $D3E1,$01 Return.

c $D3E2 Reads In-Game Controls (Left + Right).
@ $D3E2 label=CONTROLS_INPUT_O_P
C $D3E2,$04 Read keys P-O-I-U-Y.
C $D3E6,$01 Invert all the bits of #REGa.
C $D3E7,$02 Keep only bits 0 and 1 (i.e. we only care about "P" and "O" for left and right).

C $D3E9,$01 Return.

c $D3EA
@ $D3EA label=DOOR_1_PREP
C $D3EA,$03 #R$CE14
C $D3ED,$03 Sets #REGa=0 and #REGb=$06 (counter).
C $D3F0

g $D45C Cash Deposit Box Reference.
@ $D45C label=CASHBOX_REF
B $D45C,$01 Holds 01-12 which refer to the deposit cash boxes (#R$CC8D onwards).
B $D45D,$01 Holds 01-12 which refer to the deposit cash boxes (#R$CC8D onwards).

c $D45E

c $D48F Customer Logic.
N $D48F Character state variables/ flags.
@ $D48F label=CUSTOMER_FRAME_1
B $D48F,$01 Character frame index 1.
@ $D490 label=CUSTOMER_FRAME_2
B $D490,$01 Character frame index 2.
@ $D491 label=CUSTOMER_FRAME_3
B $D491,$01 Character frame index 3.
@ $D492 label=CUSTOMER_FRAME_4
B $D492,$01 Character frame index 4.
@ $D493 label=CUSTOMER_FRAME_5
B $D493,$01 Character frame index 5.
@ $D494 label=CUSTOMER_FLAG_UNCOVER
B $D494,$01 Represents whether the customer will move to uncover a bandit
.           ($00 "normal" / $01 "uncover" action).
@ $D495 label=CUSTOMER_STATE_REF
B $D495,$01 The current character state.
@ $D496 label=CUSTOMER_1_TIMER
B $D496,$01 Character timer 1.
@ $D497 label=CUSTOMER_2_TIMER
B $D497,$01 Character timer 2.
@ $D498 label=CUSTOMER_3_TIMER
B $D498,$01 Character timer 3.
@ $D499 label=CUSTOMER_4_TIMER
B $D499,$01 Character timer 4.
@ $D49A label=CUSTOMER_5_TIMER
B $D49A,$01 Character timer 5.
@ $D49B label=CUSTOMER_6_TIMER
B $D49B,$01 Character timer 6.
@ $D49C label=CUSTOMER_7_TIMER
B $D49C,$01 Character timer 7.
@ $D49D label=CUSTOMER_8_TIMER
B $D49D,$01 Character timer 8.

N $D49E This routine looks at the current character state and routes to the correct subroutine.
@ $D49E label=CUSTOMER_ROUTING
C $D49E,$04 #REGa=#R$D495.
C $D4A2,$1B Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D4BD }
. { $02 | #R$D4CD }
. { $03 | #R$D4DD }
. { $04 | #R$D4ED }
. { $05 | #R$D524 }
. { $06 | #R$D540 }
. { $07 | #R$D559 }
. { $08 | #R$D56C }
. TABLE#

N $D4BD Handle door frame 1 countdown/ transition to door frame 2.
@ $D4BD label=CUSTOMER_OPEN_1
C $D4BD,$08 Decrease #R$D496 by one, return if result is not zero.
C $D4C5,$01 Move onto next character state.
C $D4C6,$03 Grab the character frame index from #R$D48F.
C $D4C9,$04 Call #R$D6D1 and return.

N $D4CD Handle door frame 2 countdown/ transition to door frame 3.
@ $D4CD label=CUSTOMER_OPEN_2
C $D4CD,$08 Decrease #R$D497 by one, return if result is not zero.
C $D4D5,$01 Move onto next character state.
C $D4D6,$03 Grab the character frame index from #R$D48F.
C $D4D9,$04 Call #R$D6DF and return.

N $D4DD Handle door frame 3 countdown/ transition to door frame 4.
@ $D4DD label=CUSTOMER_OPEN_3
C $D4DD,$08 Decrease #R$D498 by one, return if result is not zero.
C $D4E5,$01 Move onto next character state.
C $D4E6,$03 Grab the character frame index from #R$D48F.
C $D4E9,$04 Call #R$D6ED and return.

N $D4ED Handle door frame 4 timer...
@ $D4ED label=CUSTOMER_OPEN_4
C $D4ED,$06 Calls #R$D5A3 with #REGde=#R$CF91.
C $D4F3,$08 Decrease #R$D499 by one, return if result is not zero.
C $D4FB,$06 Jump to #R$D516 if #R$D494 is not zero.
C $D501,$02 Set #R$D495 to use state $07 (#R$D559 on the next call to #R$D49E).
C $D503,$06 Call #R$D6DF using the character frame index from #R$D48F.
C $D509,$04 Issue 500 points (by writing $05 to the high order byte of, e.g. #R$D16B).
C $D50D,$05 Register this as a deposit (by writing $01 to e.g. #R$D16D).
C $D512,$03 Writes $01 to #R$D190.
C $D515,$01 Return.

N $D516 Handle customer putting their hands up.
@ $D516 label=CUSTOMER_HANDS_UP
C $D516,$07 Increase #R$D495 by one.
C $D51D,$03 Grab the character frame index from #R$D490.
C $D520,$04 Call #R$D6ED and return.

N $D524 Handles customer uncovering a "hidden" bandit action.
@ $D524 label=CUSTOMER_UNCOVER
C $D524,$06 Calls #R$D5A3 with #REGde=#R$CF91.
C $D52A,$08 Decrease #R$D49A by one, return if result is not zero.
C $D532,$07 Increase #R$D495 by one.
C $D539,$03 Grab the character frame index from #R$D491.
C $D53C,$04 Call #R$D6ED and return.

N $D540 Handle door frame 4 countdown/ transition to door frame 3.
@ $D540 label=CUSTOMER_CLOSE_3
C $D540,$08 Decrease #R$D49B by one, return if result is not zero.
C $D548,$03 Call #R$CEB8.
C $D54B,$08 Load, e.g. #R$D167 (bandit source data) into #REGhl, and
.           write $03 to the address contained in it.
C $D553,$05 Increase the pointer to the bandit source data by 3 and
.           write $04 to this byte.
C $D558,$01 Return.

N $D559 Handle door frame 3 countdown/ transition to door frame 2.
@ $D559 label=CUSTOMER_CLOSE_2
C $D559,$08 Decrease #R$D49C by one, return if result is not zero.
C $D561,$04 Increase #R$D495 by one.
C $D565,$03 Grab the character frame index from #R$D48F.
C $D568,$04 Call #R$D6D1 and return.

N $D56C Handle door frame 2 countdown/ transition to door frame 1.
@ $D56C label=CUSTOMER_CLOSE_1
C $D56C,$08 Decrease #R$D49D by one, return if result is not zero.
C $D574,$03 Call #R$D664 (i.e. no character/ door is shut).
C $D577,$04 Call #R$D8A1 and return.

N $D57B Handles customer being shot.
@ $D57B label=CUSTOMER_SHOT
C $D57B,$09 If #R$D495 is zero then jump to #R$D584 else jump to #R$D58C.
@ $D584 label=CUSTOMER_SHOT_MIDAIR
C $D584,$01 Move onto next character state.
C $D585,$03 Grab the character frame index from #R$D492.
C $D588,$04 Call #R$D6ED and return.
@ $D58C label=CUSTOMER_SHOT_FLOOR
C $D58C,$08 Decrease #R$D497 by one, return if result is not zero.
C $D594,$03 Grab the character frame index from #R$D493.
C $D597,$03 Call #R$D6ED.
C $D59A,$05 Writes $02 to #R$D2FE.
C $D59F,$04 Call #R$D8A1 and return.

c $D5A3 Hit Detection.
D $D5A3 Compares the #R$CE1A against the user input for a shot.
.       If there isn't a shot to account for then we simply return,
.       else we action a jump to the address held in #REGde on entry.
@ $D5A3 label=HIT_DETECTION
C $D5A3,$01 Store #REGhl on the stack for later.
C $D5A4,$07 Does a comparison of #R$D300 against #R$CE1A.
C $D5AB,$02 #HTML(Retrieve #REGhl off the stack and return if the numbers compared were <em>NOT</em> the same.)
C $D5AD,$01 Restores the character state to #REGa.
C $D5AE,$02 Jumps to the address held in #REGde on entry (with #REGde now containing the original #REGhl address).

c $D5B0 Character Index.
@ $D5B0 label=CHARACTER_ADDR
D $D5B0 Returns the 16 bit memory location of a character from a given character index in #REGa.
C $D5B0,$19 Using #R$6800 as a base address (which is the first character), this works out the character frame from a
.           given index passed in #REGa. To give an example with $1A;
. #LIST
. { #HTML(Loads <strong>$1A</strong> as the low-order byte; #REGhl=$001A) }
. { #HTML(Times by <strong>$200</strong>; store this in #REGde=$3400) }
. { #HTML(Loads <strong>$1A</strong> as the low-order byte; #REGhl=$001A) }
. { #HTML(Times by <strong>$10</strong>; #REGhl=$1A0) }
. { #REGhl+#REGde=$35A0 }
. { #HTML(Add <strong>$6800</strong>=#R$9DA0) }
. LIST#
C $D5C9 Returns the address in #REGhl.

c $D5CA Draw Character In Doorway.
D $D5CA Draws the character frame at the location of one of the three (open) doors. This is direct function, hence is
.       only used when the door is open (it doesn't utilise the door buffer).
@ $D5CA label=DRAW_CHARACTER_IN_DOORWAY
C $D5CA,$03 Retrieve the memory location for the character frame from the passed index in #REGa.
C $D5CE,$04 Sets the height and width.
C $D5D2,$03 Retrieves the currently in-focus door from #R$CE1A.
C $D5D5,$11 Work out which screen position to use for the currently focused door;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $4082 }
. { $02 | $408D }
. { $03 | $4098 }
. TABLE#
. Jump to #R$D5E6 to draw the character and handle the return.

c $D5E6 Copy Routine.
@ $D5E6 label=COPY_ROUTINE
N $D5E6 This routine copies bytes from #REGde TO #REGhl and uses the #REGbc register to track the number of bytes
.       and the number of lines.
C $D5E6,$07 Copies bytes from #REGde TO #REGhl x #REGc number of times.
C $D5ED,$02 Restores #REGhl with the original screen buffer location.
C $D5EF,$07 ggg
C $D5F6,$03 Grabs #REGb and decreases it by one. Loop back round to #R$D5E6 if #REGb is not zero.
C $D5F9,$01 Return.

c $D5FA Merge Gun Shot Onto Background.
@ $D5FA label=MERGE_SHOT
C $D5FA,$02 Store #REGbc and #REGhl for later.
@ $D5FC label=MERGE_SHOT_LOOP
C $D5FC,$01 Loads the contents of the source address held in #REGde.
C $D5FD,$02 Performs a bit-by-bit XOR comparison against the contents of the destination address held by #REGhl.
. #TABLE(default,centre,centre,centre)
. { =h #REGa register bit | =h Comparison bit | =h #REGa bit set to }
. { 0 | 0 | 0 }
. { 0 | 1 | 1 }
. { 1 | 0 | 1 }
. { 1 | 1 | 0 }
. TABLE#
C $D5FE,$01 Stores the result at the destination address.
C $D5FF,$05 Increase the source and destination addresses by one, decrease the counter by one. Loop back to #R$D5FC
.           until the #REGc counter is zero.
C $D604,$01 Restore #REGhl with the original destination address.
C $D605,$07 Increase the high-order byte of #REGhl by one, if this is on a screen third boundary (@todo what's the term for this?) then call #R$D610.
C $D60C,$03 Decrease the #REGb counter by one and loop back to #R$D5FA until it is zero.
C $D60F,$01 Return.

c $D610
@ $D610 label=CALC_ATTR
N $D610 On entry #REGhl points to an address in the screen attribute buffer.
C $D610 Let's use $58C8 as an example;
. #LIST
. { #REGa=$58 }
. { Subtract $08 = #REGa=$50 }
. { Write it into #REGhl=$50C8 }
. { #REGa=$C8 }
. { Add $20 = #REGa=$E8 }
. { Write it into #REGhl=$50E8 }
. LIST#
C $D61D,$01 Return.

c $D61E Write Character And Door To Buffer.
@ $D61E label=CHARACTER_DOOR_FRAME_2
D $D61E Door frames 2 and 3 both contain a "section" of a game character. This is copied into a buffer by first drawing
.       the game character fully to #R$EA90. Then the door frame is drawn over the top (in the correct position).
N $D61E Draws the game character together with door frame 2.
C $D61E,$06 On entry #REGa points to a character index. The call to #R$D5B0 translates this to the memory location of
.           the character frame data (held in #REGhl) and then calls #R$D654.
C $D624,$13 Copies #R$BCE8 into the #R$EA90 (+2 bytes ~ $EA92).
@ $D624 label=DOOR_FRAME_2_COPY
@ $D62C label=DOOR_FRAME_2_COPY_LOOP
C $D637,$01 Return.

N $D638 Draws the game character together with door frame 3.
@ $D638 label=CHARACTER_DOOR_FRAME_3
C $D638,$06 On entry #REGa points to a character index. The call to #R$D5B0 translates this to the memory location of
.           the character frame data (held in #REGhl) and then calls #R$D654.
C $D63E,$15 Copies #R$BEA0 into the #R$EA90 (+4 bytes ~ $EA94).
@ $D63E label=DOOR_FRAME_3_COPY
@ $D646 label=DOOR_FRAME_3_COPY_LOOP
C $D653,$01 Return.

N $D654 Draws the game character alone to the door frame buffer.
C $D654,$10 Draws a character into the #R$EA90.
@ $D654 label=DOOR_BUFFER_COPY
@ $D659 label=DOOR_BUFFER_COPY_LOOP

c $D664 Draw Doors.
N $D664 Preps door frame 1.
@ $D664 label=DRAW_DOOR_FRAME_1
C $D664,$06 Calls #R$D684 using #R$D6B1.
C $D66A,$03 #REGde=#R$BA80.
N $D66D Referencing the door frame index, work out the screen position and send it to the #R$D717 routine.
C $D66D,$03 #REGa=#R$CE1A.
@ $D66D label=PREP_DOOR_FRAME
C $D670,$14 Determines which screen address to use for the door reference index currently held in #REGa.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $4082 }
. { $02 | $408D }
. { $03 | $4098 }
. TABLE#
. Jump to #R$D717.

N $D684 Copies attributes for the current door frame index.
@ $D684 label=DOOR_ATTRIBUTES
C $D684,$01 Stash the accumulator for later.
C $D685,$03 #REGa=#R$CE1A.
C $D688,$0F
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $5882 }
. { $02 | $588D }
. { $03 | $5898 }
. TABLE#
. ...continue from #R$D697.
@ $D697 label=DOOR_ATTRIBUTES_SKIP
C $D697,$02 Sets the height of the door image.
@ $D699 label=DOOR_ATTRIBUTES_LOOP
C $D699,$06 Stash the references for later and call #R$D6AB.
C $D69F,$06 Moves the screen attribute address down to the next attribute row.
C $D6A5,$04 Restore the counter and loop back to #R$D699 until complete.
C $D6A9,$02 Restore the accumulator and return.

N $D6AB Simple helper copy routine for sending attribute data to the screen attribute buffer.
@ $D6AB label=DOOR_ATTRIBUTES_COPY
C $D6AB,$06 Set the door width, copy the attribute data to the screen and return.

N $D6B1 Door frame attribute data.
@ $D6B1 label=DOOR_1_ATTRIBUTES
B $D6B1,$08 Attribute data for door frame 1.
@ $D6B9 label=DOOR_2_ATTRIBUTES
B $D6B9,$08 Attribute data for door frame 2.
@ $D6C1 label=DOOR_3_ATTRIBUTES
B $D6C1,$08 Attribute data for door frame 3.
@ $D6C9 label=DOOR_4_ATTRIBUTES
B $D6C9,$08 Attribute data for door frame 4.

N $D6D1 Preps door frame 2.
C $D6D1,$06 Calls #R$D684 using #R$D6B9.
@ $D6D1 label=DRAW_DOOR_FRAME_2
C $D6D7,$08 Prepare the character/ door image by calling #R$D61E. Then pass #R$EA90 to #R$D66D which will draw it to the
.           screen.

N $D6DF Preps door frame 3.
C $D6DF,$06 Calls #R$D684 using #R$D6C1.
@ $D6DF label=DRAW_DOOR_FRAME_3
C $D6E5,$08 Prepare the character/ door image by calling #R$D638. Then pass #R$EA90 to #R$D66D which will draw it to the
.           screen.

N $D6ED Preps door frame 4.
C $D6ED,$06 Calls #R$D684 using #R$D6C9.
@ $D6ED label=DRAW_DOOR_FRAME_4
C $D6F3,$03 The door is fully open so draw the whole character in the doorway directly.
C $D6F6,$07 Reference #R$BFA8 and the dimensions for the copy routine.
C $D6FD,$03 #REGa=#R$CE1A.
C $D700,$14 Determines which screen address to use for the door reference index currently held in #REGa.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { $01 | $4088 }
. { $02 | $4093 }
. { $03 | $409E }
. TABLE#
. Jump to #R$D5E6.
C $D714,$03 #REGde=#R$EA90.
@ $D717 label=DRAW_DOOR_FRAME
C $D717,$07 Draws the image pointed at by #REGde to the screen address in #REGhl using #R$D5E6.

c $D71E Generic Bandit in Door Frame Logic.
N $D71E Character state variables/ flags.
@ $D71E label=BANDIT_STATE_REF
B $D71E,$01 The current character state.
@ $D71F label=BANDIT_1_TIMER
B $D71F,$01 Character timer 1.
@ $D720 label=BANDIT_2_TIMER
B $D720,$01 Character timer 2.
@ $D721 label=BANDIT_3_TIMER
B $D721,$01 Character timer 3.
@ $D722 label=BANDIT_4_TIMER
B $D722,$01 Character timer 4.
;@ $D723 label=BANDIT_5
B $D723,$01
;@ $D724 label=BANDIT_6
B $D724,$01

N $D725 This routine looks at the current character state and routes to the correct subroutine.
@ $D725 label=BANDIT_OPEN_ROUTING
C $D725,$04 #REGa=#R$D71E.
C $D729,$0B Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D734 }
. { $02 | #R$D741 }
. { $03 | #R$D74E }
. { $04 | #R$D75B }
. TABLE#

N $D734 Handle door frame 1 countdown/ transition to door frame 2.
@ $D734 label=BANDIT_OPEN_1
C $D734,$08 Decrease #R$D71F by one, return if result is not zero.
C $D73C,$01 Move onto next character state.
C $D73D,$04 Pass character frame index (#R$6800(draw | $00)) to #R$D6D1 and return.

N $D741 Handle door frame 2 countdown/ transition to door frame 3.
@ $D741 label=BANDIT_OPEN_2
C $D741,$08 Decrease #R$D720 by one, return if result is not zero.
C $D749,$01 Move onto next character state.
C $D74A,$04 Pass character frame index (#R$6800(draw | $00)) to #R$D6DF and return.

N $D74E Handle door frame 3 countdown/ transition to door frame 4.
@ $D74E label=BANDIT_OPEN_3
C $D74E,$08 Decrease #R$D721 by one, return if result is not zero.
C $D756,$01 Move onto next character state.
C $D757,$04 Pass character frame index (#R$6800(draw | $00)) to #R$D6ED and return.

N $D75B Handle door frame 4 timer...
@ $D75B label=BANDIT_OPEN_4
C $D75B,$06 Calls #R$D5A3 with #REGde=$CED8.
C $D761,$08 Decrease #R$D722 by one, return if result is not zero.
C $D769,$04 Writes $01 to #R$D2FE.
C $D76D,$03 Call #R$D8A1.
C $D770,$01 Return.

N $D771 This routine looks at the current character state and routes to the correct subroutine.
@ $D771 label=BANDIT_CLOSE_ROUTING
C $D771,$04 #REGa=#R$D71E.
C $D775,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D783 }
. { $02 | #R$D789 }
. { $03 | #R$D798 }
. { $04 | #R$D7A7 }
. { $05 | #R$D7B6 }
. TABLE#

N $D783 Handles the transition to the (#R$6A10(shot | $01)) frame in the open doorway.
@ $D783 label=BANDIT_SHOT_ACTION
C $D783,$01 Move onto next character state.
C $D784,$01 Move onto next character frame (i.e. #R$6A10(shot | $01)).
C $D785,$04 Call #R$D6ED and return.

N $D789 Handle "floor frame in open doorway" countdown.
@ $D789 label=BANDIT_CLOSE_4
C $D789,$08 Decrease #R$D71F by one, return if result is not zero.
C $D791,$01 Move onto next character state.
C $D792,$06 Pass character frame index (#R$6C20(floor | $02)) to #R$D6ED and return.

N $D798 Handle door frame 4 countdown/ transition to door frame 3.
@ $D798 label=BANDIT_CLOSE_3
C $D798,$08 Decrease #R$D720 by one, return if result is not zero.
C $D7A0,$01 Move onto next character state.
C $D7A1,$06 Pass character frame index (#R$6C20(floor | $02)), pass it to #R$D6DF and return.

N $D7A7 Handle door frame 3 countdown/ transition to door frame 2.
@ $D7A7 label=BANDIT_CLOSE_2
C $D7A7,$08 Decrease #R$D721 by one, return if result is not zero.
C $D7AF,$01 Move onto next character state.
C $D7B0,$06 Pass character frame index (#R$6C20(floor | $02)), pass it to #R$D6D1 and return.

N $D7B6 Handle door frame 2 countdown/ transition to door frame 1.
@ $D7B6 label=BANDIT_CLOSE_1
C $D7B6,$08 Decrease #R$D722 by one, return if result is not zero.
C $D7BE,$03 Call #R$D664 (i.e. no character/ door is shut).
C $D7C1,$03 Call #R$D8A1.
C $D7C4,$01 Return.

c $D7C5 Bowie logic.
D $D7C5 Handles all the logic around drawing Bowie and handling his "special" logic.
N $D7C5 Bowie state variables/ flags.
@ $D7C5 label=BOWIE_GOOD_BAD
B $D7C5,$01 If this is $00 then Bowie is "good". If this is $01 then he is "bad" (i.e. there's a bomb under his hat).
@ $D7C6 label=BOWIE_FRAME_REF
B $D7C6,$01 The current character frame index reference.
@ $D7C7 label=BOWIE_STATE_REF
B $D7C7,$01 The current character state.
@ $D7C8 label=BOWIE_1_TIMER
B $D7C8,$01 Character timer 1.
@ $D7C9 label=BOWIE_2_TIMER
B $D7C9,$01 Character timer 2.
@ $D7CA label=BOWIE_3_TIMER
B $D7CA,$01 Character timer 3.
@ $D7CB label=BOWIE_4_TIMER
B $D7CB,$01 Character timer 4.
@ $D7CC label=BOWIE_5_TIMER
B $D7CC,$01 Character timer 5.
@ $D7CD label=BOWIE_6_TIMER
B $D7CD,$01 Character timer 6.

N $D7CE This routine looks at the current character state and routes to the correct subroutine.
@ $D7CE label=BOWIE_ROUTING
C $D7CE,$04 #REGa=#R$D7C7.
C $D7D2,$11 Work out which routine to jump to based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D7E3 }
. { $02 | #R$D7F2 }
. { $03 | #R$D801 }
. { $04 | #R$D810 }
. { $05 | #R$D82C }
. { $06 | #R$D83C }
. TABLE#

N $D7E3 Handle door frame 1 countdown/ transition to door frame 2.
@ $D7E3 label=BOWIE_OPEN_1
C $D7E3,$08 Decrease #R$D7C8 by one, return if result is not zero.
C $D7EB,$01 Move onto next character state.
C $D7EC,$06 Pass character index #R$9FB0($1B) to #R$D6D1 and return.

N $D7F2 Handle door frame 2 countdown/ transition to door frame 3.
@ $D7F2 label=BOWIE_OPEN_2
C $D7F2,$08 Decrease #R$D7C9 by one, return if result is not zero.
C $D7FA,$01 Move onto next character state.
C $D7FB,$06 Pass character index #R$9FB0($1B) to #R$D6DF and return.

N $D801 Handle door frame 3 countdown/ transition to door frame 4.
@ $D801 label=BOWIE_OPEN_3
C $D801,$08 Decrease #R$D7CA by one, return if result is not zero.
C $D809,$01 Move onto next character state.
C $D80A,$06 Pass character frame index #R$9FB0($1B) to #R$D6ED and return.

N $D810 Handle door frame 4 countdown/ transition to door frame 3.
@ $D810 label=BOWIE_OPEN_4
C $D810,$09 Call #R$D5A3 with a callback to either #R$D84B or #R$D85D.
C $D819,$08 Decrease #R$D7CB by one, return if result is not zero.
@ $D821 label=BOWIE_CLOSE_3
C $D821,$04 Move onto next character state (#R$D7C7).
C $D825,$07 Load the character frame index from #R$D7C6, pass it to #R$D6DF and return.

N $D82C Handle door frame 3 countdown/ transition to door frame 2.
@ $D82C label=BOWIE_CLOSE_2
C $D82C,$08 Decrease #R$D7CC by one, return if result is not zero.
C $D834,$01 Move onto next character state.
C $D835,$07 Load the character frame index from #R$D7C6, pass it to #R$D6D1 and return.

N $D83C Handle door frame 2 countdown/ transition to door frame 1.
@ $D83C label=BOWIE_CLOSE_1
C $D83C,$08 Decrease #R$D7CD by one, return if result is not zero.
C $D844,$03 Call #R$D664 (i.e. no character/ door is shut).
C $D847,$03 Call #R$D8A1.
C $D84A,$01 Return.

N $D84B Handles marking this as something shootable.
@ $D84B label=BOWIE_CASH_ACTION
C $D84B,$08 Writes $05 to #REGix+$06 and $01 to #REGix+$07.
C $D853,$08 Writes $01 to #REGix+$08 and #R$D190.
C $D85B,$02 Jump to #R$D821.

N $D85D Handles marking this as something unshootable.
@ $D85D label=BOWIE_BOMB_ACTION
C $D85D,$06 Writes $05 to #R$D2FE and return.

N $D863 Handles both shooting the hats off Bowie's head, and checking/ routing on the last frame for the "surprise".
@ $D863 label=BOWIE_SHOT_ACTION
C $D863,$04 #REGa=#R$D7C6.
C $D867,$02 Is it character frame reference (#R$AC10(1 hat | $21))?
C $D869,$04 Writes $01 to #REGix+$06.
C $D86D,$02 If Bowie is on the last frame then jump forward to #R$D875.
C $D86F,$06 Else update #R$D7C6 to point at the next frame, call #R$D6ED and return.

N $D875 Checks the "good/ bad" flag and routes the gameplay accordingly.
@ $D875 label=BOWIE_CHECK
C $D875,$06 If #R$D7C5 is zero jump to #R$D87D.
C $D87B,$02 Jump to #R$D88F.

N $D87D Handle displaying cash character frame.
@ $D87D label=BOWIE_STATE_CASH
C $D87D,$08 Writes character frame reference #R$B030(cash | $23) to #R$D7C6, and pass it to #R$D6ED.
C $D885,$0A Writes #R$D84B to the current door flags (e.g. #R$D169, #R$D177 or #R$D185).
C $D88E,$01 Return.

N $D88F Handle displaying bomb character frame.
@ $D88F label=BOWIE_STATE_BOMB
C $D88F,$08 Writes character frame reference #R$AE20(bomb | $22) to #R$D7C6, and pass it to #R$D6ED.
C $D897,$0A Writes #R$D85D to the current door flags (e.g. #R$D169, #R$D177 or #R$D185).
C $D8A0,$01 Return.

c $D8A1
@ $D8A1 label=RESET___
C $D8A1,$0A Blanks the 16 bit address pointed to by one of the passed door flags (i.e. writes $0000 to one of #R$CE14, #R$CE16, #R$CE18).
C $D8AB,$01 Return.

g $D8AC
W $D8AC,$02
g $D8AE
W $D8AE,$02

c $D8B0
@ $D8B0 label=RANDOM_NUMBER
N $D8B0 f
C $D8B0,$02 Stashes #REGbc and #REGhl for later.
C $D8B2,$07 Decrease #R$D8AE by one.
C $D8B9,$02 If the result is not zero jump to #R$D8C8.
@ $D8C8 label=RANDOM_NUMBER_1
@ $D8D7 label=RANDOM_NUMBER_2

c $D8E5 Julius logic.
N $D8E5 Handles all the logic around drawing Julius and handling his "special" logic.
@ $D8E5 label=JULIUS_GOOD_BAD
B $D8E5,$01 If this is $00 then Julius is "good". If this is $01 then he is "bad" (i.e. will draw on you).
B $D8E6,$01
@ $D8E7 label=JULIUS_STATE_REF
B $D8E7,$01 The current character state.
@ $D8E8 label=JULIUS_1_TIMER
B $D8E8,$01 Character timer 1.
@ $D8E9 label=JULIUS_2_TIMER
B $D8E9,$01 Character timer 2.
@ $D8EA label=JULIUS_3_TIMER
B $D8EA,$01 Character timer 3.
@ $D8EB label=JULIUS_4_TIMER
B $D8EB,$01 Character timer 4.
@ $D8EC label=JULIUS_5_TIMER
B $D8EC,$01 Character timer 5.
@ $D8ED label=JULIUS_6_TIMER
B $D8ED,$01 Character timer 6.
@ $D8EE label=JULIUS_7_TIMER
B $D8EE,$01 Character timer 7.

N $D8EF This routine looks at the current character state and routes to the correct subroutine.
@ $D8EF label=JULIUS_OPEN_ROUTING
C $D8EF,$04 #REGa=#R$D8E7.
C $D8F3,$14 Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D907 }
. { $02 | #R$D916 }
. { $03 | #R$D925 }
. { $04 | #R$D934 }
. { $05 | #R$D963 }
. { $06 | #R$D972 }
. { $07 | #R$D981 }
. TABLE#

N $D907 Handle door frame 1 countdown/ transition to door frame 2.
@ $D907 label=JULIUS_OPEN_1
C $D907,$08 Decrease #R$D8E8 by one, return if result is not zero.
C $D90F,$01 Move onto next character state.
C $D910,$06 Pass character index (#R$B240(stand off | $24)) to #R$D6D1 and return.

N $D916 Handle door frame 2 countdown/ transition to door frame 3.
@ $D916 label=JULIUS_OPEN_2
C $D916,$08 Decrease #R$D8E9 by one, return if result is not zero.
C $D91E,$01 Move onto next character state.
C $D91F,$06 Pass character index (#R$B240(stand off | $24)) to #R$D6DF and return.

N $D925 Handle door frame 3 countdown/ transition to door frame 4.
@ $D925 label=JULIUS_OPEN_3
C $D925,$08 Decrease #R$D8EA by one, return if result is not zero.
C $D92D,$01 Move onto next character state.
C $D92E,$06 Pass character index (#R$B240(stand off | $24)) to #R$D6ED and return.

N $D934 Handle door frame 4 countdown.
@ $D934 label=JULIUS_OPEN_4
C $D934,$06 Call #R$D5A3 with a callback to #R$CFDD.
C $D93A,$08 Decrease #R$D8EB by one, return if result is not zero.
C $D942,$01 Move onto next character state.
C $D943,$06 Jump to #R$D951 if #R$D8E5 is zero (Julius is "good").
N $D949 Changes the frame to show Julius drawing his pistol.
C $D949,$02 Writes "07" to #R$D8E7.
C $D94B,$06 Pass character index (#R$B450(draw | $25)) to #R$D6ED and return.
N $D951 Set up (and begin) closing the door.
@ $D951 label=JULIUS_STATE_4_CLOSE
C $D951,$05 Pass character index (#R$B240(stand off | $24)) to #R$D6DF.
C $D956,$0D Writes $01 to #R$D190 and #REGix+8. Writes $05 to #REGix+6 and return.

N $D963 Handle door frame 3 countdown/ transition to door frame 2.
@ $D963 label=JULIUS_OPEN_5
C $D963,$08 Decrease #R$D8EC by one, return if result is not zero.
C $D96B,$01 Move onto next character state.
C $D96C,$06 Pass character index (#R$B240(stand off | $24)) to #R$D6D1 and return.

N $D972 Handle door frame 2 countdown/ transition to door frame 1.
@ $D972 label=JULIUS_OPEN_6
C $D972,$08 Decrease #R$D8ED by one, return if result is not zero.
C $D97A,$03 Call #R$D664 (i.e. no character/ door is shut).
C $D97D,$03 Call #R$D8A1.
C $D980,$01 Return.

N $D981 ???
@ $D981 label=JULIUS_OPEN_7
C $D981,$06 Call #R$D5A3 with a callback to #R$CFE2.
C $D987,$08 Decrease #R$D8EE by one, return if result is not zero.
C $D98F,$01 Move onto next character state.
C $D990 Write $01 to #R$D2FE.
C $D993,$03 Call #R$D8A1.
C $D996,$01 Return.

N $D997 This routine looks at the current character state and routes to the correct subroutine.
@ $D997 label=JULIUS_CLOSE_ROUTING
C $D997,$04 #REGa=#R$D8E7.
C $D99B,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$D9A9 }
. { $02 | #R$D9B8 }
. { $03 | #R$D9D3 }
. { $04 | #R$D9E2 }
. { $05 | #R$D9F1 }
. TABLE#

N $D9A9 Handles state countdown/ transition to character frame #R$B660($26).
@ $D9A9 label=JULIUS_CLOSE_1
C $D9A9,$08 Decrease #R$D8E8 by one, return if result is not zero.
C $D9B1,$01 Move onto next character state.
C $D9B2,$06 Pass character index #R$B660(shot | $26) to #R$D6ED and return.

N $D9B8 Handles state countdown/ transition to character frame #R$B870($27).
@ $D9B8 label=JULIUS_CLOSE_2
C $D9B8,$08 Decrease #R$D8E9 by one, return if result is not zero.
C $D9C0,$01 Move onto next character state.
C $D9C1,$05 Pass character index #R$B870(floor | $27) to #R$D6ED.
C $D9C6,$05 Return if #R$D8E6 is zero.
C $D9CB,$08 Else write #R$D8E6+1 to #R$D2FE, call #R$D8A1 and return.

N $D9D3 Handle door frame 4 countdown/ transition to door frame 3.
@ $D9D3 label=JULIUS_CLOSE_3
C $D9D3,$08 Decrease #R$D8EA by one, return if result is not zero.
C $D9DB,$01 Move onto next character state.
C $D9DC,$06 Pass character index #R$B870(floor | $27) to #R$D6DF and return.

N $D9E2 Handle door frame 3 countdown/ transition to door frame 2.
@ $D9E2 label=JULIUS_CLOSE_4
C $D9E2,$08 Decrease #R$D8EB by one, return if result is not zero.
C $D9EA,$01 Move onto next character state.
C $D9EB,$06 Pass character index #R$B870(floor | $27) to #R$D6D1 and return.

N $D9F1 Handle door frame 2 countdown/ transition to door frame 1.
@ $D9F1 label=JULIUS_CLOSE_5
C $D9F1,$08 Decrease #R$D8EC by one, return if result is not zero.
C $D9F9,$03 Call #R$D664 (i.e. no character/ door is shut).
C $D9FC,$03 Call #R$D8A1.
C $D9FF,$0D Writes $01 to #R$D190 and #REGix+8. Writes $05 to #REGix+6 and return.

c $DA0C Drawing Bandit Logic.
N $DA0C Character state variables/ flags.
@ $DA0C label=BANDIT_DRAW
B $DA0C,$01
@ $DA0D label=BANDIT_DRAW_FRAME_1
B $DA0D,$01 Character frame index 1.
@ $DA0E label=BANDIT_DRAW_FRAME_2
B $DA0E,$01 Character frame index 2.
@ $DA0F label=BANDIT_DRAW_FRAME_3
B $DA0F,$01 Character frame index 3.
@ $DA10 label=BANDIT_DRAW_FRAME_4
B $DA10,$01 Character frame index 4.
@ $DA11 label=BANDIT_DRAW_STATE_REF
B $DA11,$01 The current character state.
@ $DA12 label=BANDIT_DRAW_1_TIMER
B $DA12,$01 Character timer 1.
@ $DA13 label=BANDIT_DRAW_2_TIMER
B $DA13,$01 Character timer 2.
@ $DA14 label=BANDIT_DRAW_3_TIMER
B $DA14,$01 Character timer 3.
@ $DA15 label=BANDIT_DRAW_4_TIMER
B $DA15,$01 Character timer 4.
@ $DA16 label=BANDIT_DRAW_5_TIMER
B $DA16,$01 Character timer 5.

N $DA17 This routine looks at the current character state and routes to the correct subroutine.
@ $DA17 label=BANDIT_DRAW_OPEN_ROUTING
C $DA17,$04 #REGa=#R$DA11.
C $DA1B,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$DA29 }
. { $02 | #R$DA39 }
. { $03 | #R$DA49 }
. { $04 | #R$DA59 }
. { $05 | #R$DA6F }
. TABLE#

N $DA29 Handle door frame 1 countdown/ transition to door frame 2.
@ $DA29 label=BANDIT_DRAW_OPEN_1
C $DA29,$08 Decrease #R$DA12 by one, return if result is not zero.
C $DA31,$01 Move onto next character state.
C $DA32,$03 Grab the character frame index from #R$DA0D.
C $DA35,$04 Call #R$D6D1 and return.

N $DA39 Handle door frame 2 countdown/ transition to door frame 3.
@ $DA39 label=BANDIT_DRAW_OPEN_2
C $DA39,$08 Decrease #R$DA13 by one, return if result is not zero.
C $DA41,$01 Move onto next character state.
C $DA42,$03 Grab the character frame index from #R$DA0D.
C $DA45,$04 Call #R$D6DF and return.

N $DA49 Handle door frame 3 countdown/ transition to door frame 4.
@ $DA49 label=BANDIT_DRAW_OPEN_3
C $DA49,$08 Decrease #R$DA14 by one, return if result is not zero.
C $DA51,$01 Move onto next character state.
C $DA52,$03 Grab the character frame index from #R$DA0D.
C $DA55,$04 Call #R$D6ED and return.

N $DA59 Handles state countdown.
@ $DA59 label=BANDIT_DRAW_OPEN_4
C $DA59,$06 Call #R$D5A3 with a callback to #R$D037.
C $DA5F,$08 Decrease #R$DA15 by one, return if result is not zero.
C $DA67,$01 Move onto next character state.
C $DA68,$03 Grab the character frame index from #R$DA0E.
C $DA6B,$04 Call #R$D6ED and return.

N $DA6F Handles state countdown.
@ $DA6F label=BANDIT_DRAW_OPEN_5
C $DA6F,$06 Call #R$D5A3 with a callback to #R$D040.
C $DA75,$08 Decrease #R$DA16 by one, return if result is not zero.
C $DA7D,$08 Else write $01 to #R$D2FE, call #R$D8A1 and return.

N $DA85 This routine looks at the current character state and routes to the correct subroutine.
@ $DA85 label=BANDIT_DRAW_CLOSE_ROUTING
C $DA85,$04 #REGa=#R$DA11.
C $DA89,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { $01 | #R$DA97 }
. { $02 | #R$DAA7 }
. { $03 | #R$DAC0 }
. { $04 | #R$DAD0 }
. { $05 | #R$DAE0 }
. TABLE#

N $DA97 Handles state countdown.
@ $DA97 label=BANDIT_DRAW_CLOSE_1
C $DA97,$08 Decrease #R$DA12 by one, return if result is not zero.
C $DA9F,$01 Move onto next character state.
C $DAA0,$03 Grab the character frame index from #R$DA0F.
C $DAA3,$04 Call #R$D6ED and return.

N $DAA7 Handles state countdown.
@ $DAA7 label=BANDIT_DRAW_CLOSE_2
C $DAA7,$08 Decrease #R$DA13 by one, return if result is not zero.
C $DAAF,$01 Move onto next character state.
C $DAB0,$03 Grab the character frame index from #R$DA10.
C $DAB3,$03 Call #R$D6ED.
C $DAB6,$05 Return if #R$DA0C is zero.
C $DABB,$05 Else write $01 to #R$D2FE and return.

N $DAC0 Handle door frame 4 countdown/ transition to door frame 3.
@ $DAC0 label=BANDIT_DRAW_CLOSE_3
C $DAC0,$08 Decrease #R$DA14 by one, return if result is not zero.
C $DAC8,$01 Move onto next character state.
C $DAC9,$03 Grab the character frame index from #R$DA10.
C $DACC,$04 Call #R$D6DF and return.

N $DAD0 Handle door frame 3 countdown/ transition to door frame 2.
@ $DAD0 label=BANDIT_DRAW_CLOSE_4
C $DAD0,$08 Decrease #R$DA15 by one, return if result is not zero.
C $DAD8,$01 Move onto next character state.
C $DAD9,$03 Grab the character frame index from #R$DA10.
C $DADC,$04 Call #R$D6D1 and return.

N $DAE0 Handle door frame 2 countdown/ transition to door frame 1.
@ $DAE0 label=BANDIT_DRAW_CLOSE_5
C $DAE0,$08 Decrease #R$DA16 by one, return if result is not zero.
C $DAE8,$03 Call #R$D664 (i.e. no character/ door is shut).
C $DAEB,$04 Call #R$D8A1 and return.

c $DAEF

b $DAFE

b $DFA0 Slot Numbering
@ $DFA0 label=SLOT_NUMBERS_LEFT
B $DFA0,$60,$0C #UDGARRAY12,attr=56,scale=4,step=12;(#PC)-(#PC+$20)-$01-$60(numbering-01-06)
@ $E000 label=SLOT_NUMBERS_RIGHT
B $E000,$60,$0C #UDGARRAY12,attr=56,scale=4,step=12;(#PC)-(#PC+$20)-$01-$60(numbering-07-12)

b $E060 Centrepiece
@ $E060 label=CENTREPIECE
B $E060,$60,$04 #UDGARRAY#(4,scale=4,step=4#FOR0,$40,$20||n|;(#PC+n)-(#PC+n)-$01-$08,#PEEK(#EVAL($ED0E+n*2));(#PC+n+$01)-(#PC+n+$02)-$01-$10,#PEEK(#EVAL($ED0F+n*2));(#PC+n+$03)-(#PC+n+$03)-$01-$08,#PEEK(#EVAL($ED11+n*2))||)(centrepiece)

b $E0C0 Top Door Frames
@ $E0C0 label=DOORS_TOP
D $E0C0 #UDGARRAY32,attr=4,scale=4,step=32;(#PC)-(#PC)-$01-$100;(#PC+$01)-(#PC+$09)-$01-$100,attr=24;(#PC+$0A)-(#PC+$0B)-$01-$100;(#PC+$0C)-(#PC+$14)-$01-$100,attr=24;(#PC+$15)-(#PC+$16)-$01-$100;(#PC+$17)-(#PC+$1F)-$01-$100,attr=24(doors-top)
B $E0C0,$100,$20

b $E1C0 Left Side Wall
@ $E1C0 label=WALL_LEFT
B $E1C0,$B0,$02 #UDGARRAY#(2,scale=4,step=2#FOR0,$A0,$10||n|;(#PC+n)-(#PC+n)-$01-$08,#PEEK(#EVAL($ED80+n*2));(#PC+n+$01)-(#PC+n+$01)-$08-$10,#PEEK(#EVAL($ED81+n*2))||)(wall-left)

b $E270 Middle Wall Section
@ $E270 label=WALL_MIDDLE
B $E270,$160,$04 #UDGARRAY#(4,attr=7,scale=4,step=4#FOR#(#PC),$E330,$20||n|;n-n-$01-$20,attr=24;(n+$01)-(n+$02)-$01-$20,attr=4;(n+$03)-(n+$03)-$01-$20,attr=24||#FOR$E350,$E3B0,$20||n|;n-n-$01-$20,attr=24;(n+$01)-(n+$02)-$01-$20,attr=16;(n+$03)-(n+$03)-$01-$20,attr=24||(wall-middle))

b $E3D0 Door Frame Right Side
@ $E3D0 label=DOOR_FRAME_SIDE
B $E3D0,$58,$01 #UDGARRAY1,attr=24,scale=4,step=1;(#PC)-(#PC+$50)-$01-$08(door-side)

b $E428 Bottom Door Frames
@ $E428 label=DOOR_BOTTOM
D $E428 #UDGARRAY32,attr=56,scale=4,step=32;(#PC)-(#PC)-$01-$100,attr=16;(#PC+$01)-(#PC+$09)-$01-$100;(#PC+$0A)-(#PC+$0B)-$01-$100,attr=16;(#PC+$0C)-(#PC+$14)-$01-$100;(#PC+$15)-(#PC+$16)-$01-$100,attr=16;(#PC+$17)-(#PC+$1F)-$01-$100(doors-bottom)
B $E428,$100,$20

b $E528 Tellers
@ $E528 label=TELLERS
D $E528 #UDGARRAY32,attr=48,scale=4,step=32;(#PC)-(#PC+$78)-$01-$100,attr=6;(#PC+$100)-(#PC+$280)-$01-$100;(#PC+$300)-(#PC+$380)-$01-$100,attr=40(tellers)
B $E528,$400,$20

b $E928 Score Image (text)
@ $E928 label=SCORE_TEXT_IMAGE
B $E928,$60,$06 #UDGARRAY6,attr=7,scale=4,step=6;(#PC)-(#PC+$2A)-$01-$30;(#PC+$30)-(#PC+$5A)-$01-$30,attr=2(score-text)

b $E988 Lives Image (text)
@ $E988 label=LIVES_TEXT_IMAGE
B $E988,$84,$06 #UDGARRAY6,attr=7,scale=4,step=6;(#PC)-(#PC+$42)-$01-$30;(#PC+$60)-(#PC+$84)-$01-$30,attr=3(lives-text)

i $EA0C

b $EA90 Door Buffer
@ $EA90 label=DOOR_BUFFER
B $EA90,$268,$07 #UDGARRAY7,scale=4,step=7;(#PC)-(#PC+$238)-$01-$38,$30(door-buffer)

i $ECF8

b $ED00 Attribute Data
B $ED00,$300,$20

b $F000 BANG Frames
E $F000 #UDGARRAY*bang-1,10;bang-2;bang-3;bang-3;bang-3;bang-4;bang-5;bang-6(bang-frames)
@ $F000 label=BANG_FRAME_1
B $F000,$100,$08 #BANG(bang-1*)
@ $F100 label=BANG_FRAME_2
B $F100,$100,$08 #BANG(bang-2*)
@ $F200 label=BANG_FRAME_3
B $F200,$100,$08 #BANG(bang-3*)
@ $F300 label=BANG_FRAME_4
B $F300,$100,$08 #BANG(bang-4*)
@ $F400 label=BANG_FRAME_5
B $F400,$100,$08 #BANG(bang-5*)
@ $F500 label=BANG_FRAME_6
B $F500,$100,$08 #BANG(bang-6*)

b $F600 Sheriffs Badge
D $F600
@ $F600 label=BADGE_IMAGE
B $F600,$280,$08 #UDGARRAY8,attr=6,scale=4,step=8;(#PC)-(#PC+$247)-$01-$40(badge)

c $F880 ff

b $F900 Dollar Sign
D $F900 These are the scrolling dollar signs in the centre of the header.
@ $F900 label=DOLLAR_IMAGE
B $F900,$50,$02 #UDGARRAY2,attr=48,scale=4,step=2;(#PC)-(#PC+$4F)-$01-$10(dollars)

c $F950 Dollar Sign (scrolling).
@ $F950 label=DOLLAR_SCROLL
C $F960,$0D Blanks 254 bytes from #R$5B00 onwards.
C $F96D,$08 Sends #R$F940 to #R$F9C3.
C $F975,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $0CF8 | $0006 }
. TABLE#
C $F97E,$08 Sends #R$F900 to #R$F9C3.
C $F986,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $079E | $0006 }
. TABLE#
C $F98F,$08 Sends #R$F920 to #R$F9C3.
C $F997,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $029E | $0006 }
. TABLE#
C $F9A0,$08 Sends #R$F900 to #R$F9C3.
C $F9A8,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $0209 | $0020 }
. TABLE#
C $F9B1,$08 Sends #R$F920 to #R$F9C3.
C $F9BA,$08 Sends #R$5B00 to #R$F9C3 (blanks the centrepiece).
C $F9C2,$01 Return.

N $F9C3 Draws the image to the screen.
@ $F9C3 label=DOLLAR_SCROLL_DRAW
@ $F9C9 label=DOLLAR_SCROLL_DRAW_LOOP
@ $F9E3 label=DOLLAR_SCROLL_HALT_LOOP
C $F9E6,$01 Return.

c $FA00 High Score Entry.
@ $FA00 label=NEW_HIGH_SCORE
@ $FA06 label=HIGH_SCORE
C $FA06,$08 Copies $40 bytes of data from #REGhl to #R$5B80.
C $FA0E,$05 Writes "0" ($30 in ASCII) to #R$FB94.
C $FA13,$03 Call #R$FAD4.
C $FA16,$06 Writes $4040 to #R$FBF0.

C $FA1E,$03 Call #R$FC09.

C $FA77,$0D Overwrites the text at #R$5BC0 with spaces to "blank" it out ($12 characters).
C $FA84,$02 Set a string termination character ($FF) at the end of the string.
C $FA89,$0C Points to #R$FB78 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $03 | $03 | $00 | $00 }
. TABLE#

C $FAB0,$0C Points to #R$FBB5 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $06 | $06 | $00 | $00 }
. TABLE#

C $FAD4,$0E Clears the screen buffer by writing $00 to all 6912 memory locations.
@ $FAD4 label=HIGH_SCORE_CLEAR_SCREEN

N $FB19 Works out where in the high score table to place the score.
C $FB19 Using #R$6000 as a base, work out where to place the new score.
. #LIST
. { Decrease $1B by one... }
. { Loads $1A as the low-order byte; #REGhl=$001A }
. { Times by $10; #REGhl=$1A0 }
. { Add $6000=#R$61A0 }
. LIST#
@ $FB19 label=HIGH_SCORE_POSITION
C $FB25,$01 Return.
C $FB26,$09 Stores #R$5BC0 at #R$FB55.
@ $FB26 label=HIGH_SCORE_SOMETHING

W $FB55,$02 Cache.

N $FB62 Returns a single keypress.
@ $FB62 label=HIGH_SCORE_INPUT
@ $FB67 label=HIGH_SCORE_INPUT_LOOP
C $FB62,$0A #HTML(Keep looping around until <em>any</em> input is detected. This is achieved by writing $00 to
.                 <a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST_K</a> and looping until it's non-zero.)
C $FB6C,$01 Store it on the stack for now.
C $FB6D,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $00C0 | $0010 }
. TABLE#
C $FB76,$02 Return with the keypress in #REGa.

t $FB78 High Score Table Name Entry.
@ $FB78 label=HIGH_SCORE_TITLE
T $FB78,$1C
@ $FB94 label=HIGH_SCORE_TEXT_BUFFER
T $FB94,$21
@ $FBB5 label=HIGH_SCORE_SUB_HEAD
T $FBB5,$20

c $FBD5
W $FBF0,$02 Cache
C $FBF2,$0D Points to #R$5BC0 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { $07 | $07 | $00 | $00 }
. { $05 | $05 | $00 | $00 }
. TABLE#

u $FC67
i $FC6A

b $FD00
B $FD00,$FF,$07


c $FE00 Title Screen.
@ $FE00 label=TITLE_SCREEN

C $FE10,$0C Points to #R$FEEA and sends it to #R$5B80.
C $FE1C,$0C Points to #R$FEF4 and sends it to #R$FEE4.
C $FE25,$0C Points to #R$FEFC and sends it to #R$FEE4.
C $FE2E,$0C Points to #R$FF06 and sends it to #R$FEE4.
C $FE37,$0C Points to #R$FF11 and sends it to #R$FEE4.
C $FE40,$0C Points to #R$FF19 and sends it to #R$5B80.
C $FE4C,$0C Points to #R$FF34 and sends it to #R$5B80.

N $FE58 Act on input.
@ $FE58 label=TITLE_SCREEN_INPUT
@ $FE63 label=TS_SELECT_KEMPSTON
@ $FE66 label=TS_CALL_FLASH
C $FE58,$11 If #R$5CB0 is zero (joystick) then #REGde=$0787 else #REGde=$8707. Then call the subroutine at #R$FE95.
. The $07/ $87 correspond to white INK and white INK flashing for the selected control method.
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright | =h Flash }
. { $07 | $07 | $00 | $00 | $00 }
. { $87 | $07 | $00 | $00 | $01 }
. TABLE#

C $FE69,$03 Point #REGhl=#R$5CB0.
C $FE6C,$04 Read keys 1, 2, 3, 4, 5.
C $FE70,$03 Jump to #R$FE86 if "1" is pressed.
C $FE73,$03 Jump to #R$FE8B if "2" is pressed.
C $FE76,$04 Read keys SPACE, FULL-STOP, M, N, & B.
C $FE7A,$04 Jump to #R$FE8F if "N" is pressed.
C $FE7E,$04 Read keys 0, 9, 8, 7, 6.
C $FE82,$04 Return if "0" is pressed, else loop back around to #R$FE58.

@ $FE86 label=TS_SET_KEYBOARD
C $FE86,$05 Writes $01 to #R$5CB0 and loop back around to #R$FE58.

@ $FE8B label=TS_SET_KEMPSTON
C $FE8B,$04 Writes $00 to #R$5CB0 and loop back around to #R$FE58.

@ $FE8F label=TS_SELECT_LEVEL
C $FE8F,$06 Jump to #R$6380 with #REGhl=#R$5B80.

@ $FE95 label=TS_FLASH_TEXT
C $FE95,$0E ggg
C $FEA3,$01 Return.

@ $FEA4 label=TS_DRAW_BANDIT
N $FEA4 Draw bandits.
C $FEA4,$1C Sets attributes on the left and right of the screen and points #REGde at #R$6800.
C $FEC0,$03 Jump to #R$5B92.

@ $FEC3 label=TS_BANDIT_ATTRIBUTES
C $FEC3,$07 Calls #R$FECE with #REGb=$08 and #REGa=$28.
C $FECA,$05 Calls #R$FEDA with #REGb=$03 and #REGa=$20.
@ $FECE label=TS_BANDIT_ATTR_LOOP
C $FED9,$01 Return.

@ $FEDA label=TS_BANDIT_ATTR_COPY
C $FEDA,$07
C $FEE3,$01 Return.

@ $FEE4 label=TITLE_SCREEN_PRINT
C $FEE4,$06 #REGb=$07, #REGc=$02 and jump to #R$5B80.

t $FEEA Title Screen/ Game Options
@ $FEEA label=TITLE_SCREEN_GAME_NAME
T $FEEA,$0A
N $FEF4 Playing Options.
@ $FEF4 label=TITLE_SCREEN_PLAY
T $FEF4,$08
@ $FEFC label=TITLE_SCREEN_KEYS
T $FEFC,$0A
@ $FF06 label=TITLE_SCREEN_JOYSTICK
T $FF06,$0B
@ $FF11 label=TITLE_SCREEN_LEVEL
T $FF11,$08
N $FF19 Credits.
@ $FF19 label=TITLE_SCREEN_AUTHOR
T $FF19,$1B
@ $FF34 label=TITLE_SCREEN_COPYRIGHT
T $FF34,$21
T $FF55,$03

b $FF58 Gun Shot Mask.
@ $FF58 label=SHOT_MASK_IMAGE
B $FF58,$10,$08 #UDGARRAY2,attr=7,scale=4,step=2;(#PC)-(#PC+$01)(shot-mask)

b $FF68 Gun Shot.
@ $FF68 label=SHOT_IMAGE
B $FF68,$10,$08 #UDGARRAY2,attr=7,scale=4,step=2;(#PC)-(#PC+$01)(shot)

b $FF78 Cash Box.
@ $FF78 label=EMPTY_BOX_IMAGE
B $FF78,$20,$02 #UDGARRAY2,attr=13,scale=4,step=2;(#PC)-(#PC+$11)-$01-$10(empty)
@ $FF98 label=DOLLAR_BOX_IMAGE
B $FF98,$20,$02 #UDGARRAY2,attr=13,scale=4,step=2;(#PC)-(#PC+$11)-$01-$10(dollar)

b $FFB8 Lives Graphic
@ $FFB8 label=LIVES_IMAGE
B $FFB8,$30,$02 #UDGARRAY#(2,scale=4,step=2#FOR0,$20,$10||n|;(#PC+n)-(#PC+n+$02)-$01-$10,#PEEK(#EVAL($EFBF+n*2))||)(lives)

b $FFE8
