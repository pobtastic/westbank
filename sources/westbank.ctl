; Copyright DINAMIC SOFTWARE 1985, 2023 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @org=$4000
> $4000 @start=$6000
@ $4000 org
@ $4000 replace=/#CHARACTERSET,\i/#UDGARRAY1,attr=\1,scale=4,step=1;(#PC)-(#PC+$08)-$01-$08
@ $4000 replace=/#CHARACTERS/#UDGARRAY6,attr=40,scale=4,step=6;(#PC)-(#PC+$1E5)-$01-$30
@ $4000 replace=/#BANG/#UDGARRAY8,attr=2,scale=4,step=8;(#PC)-(#PC+$F8)-$01-$40

b $4000 Loading screen
D $4000 #UDGTABLE { #SCR2(loading) | West Bank Loading Screen. } TABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels
  $5800,$300,$20 Attributes

s $5B00 General Buffer
@ $5B00 label=BufferGeneral
  $5B00,$80

c $5B80 Draw Text (alias)
D $5B80 This is an alias for a jump to #R$CBD2.
@ $5B80 label=Print_TwoToneText_Alias

c $5B83 Displays The "Life" Images
D $5B83 An alias for a jump to #R$CC5A.
@ $5B83 label=Draw_Lives_Images_Alias

c $5B86 Lives Memory Address
@ $5B86 label=Lives_Address
W $5B86 The 16 bit memory location for the address that holds how many lives the player has remaining.

c $5B88 Jump Controls
@ $5B88 label=Jump_Control_Method
D $5B88 Loads the 16 bit address stored at #R$CE12 into #REGhl and jumps to it.

c $5B8C Scoring Preparation (alias)
@ $5B8C label=Scoring_Prep_Alias

c $5B8F Character Address (alias)
@ $5B8F label=Character_Address_Alias
D $5B8F An alias for #R$D5B0 which returns the 16 bit memory location of a character from a given character index.

c $5B92 Draw Character (alias)
@ $5B92 label=Draw_Character

c $5B95 Merge Shot (alias)
@ $5B95 label=Merge_Shot_Alias

c $5B98 Display The "Score" Images (alias)
@ $5B98 label=Draw_Score_Alias

c $5B9B
  $5B9B,$07 Stashes a text attribute at #R$CBD0.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$05 | #N$05 | #N$00 | #N$00 }
. TABLE#

g $5BC0 Dueller Number 1
@ $5BC0 label=Dueller_01
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
g $5BD1 Dueller Number 2
@ $5BD1 label=Dueller_02
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
g $5BE2 Dueller Number 3
@ $5BE2 label=Dueller_03
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
@ $5CB0 label=Controller
D $5CB0 Whether to utilise keyboard or joystick for input.
E $5CB0 #TABLE(default,centre)
. { =h Value | =h Method }
. { #N$00 | Kempston }
. { #N$01 | Keyboard }
. TABLE#
g $5CB1 Current Level
@ $5CB1 label=Level

i $5CB2
b $5CF0

t $6000 High Score Table
@ $6000 label=Highscore_Table_Name
  $6000,$1E0,$10 #TABLE(default,centre) { =h Address | =h Entry } #FOR#(#PC),$61D0,$10,(n,{ #N(n) | #STR(n,$07,$10) },,)) TABLE#
S $61E0,$20
@ $6200 label=Highscore_Table_Score
  $6200,$102,$06 #TABLE(default,centre) { =h Address | =h Entry } #FOR#(#PC),$62FC,$06,(n,{ #N(n) | #STR(n,$07,$06) },,)) TABLE#

i $6302

c $6380 Level Selection
@ $6380 label=LevelSelect
  $6380 #REGhl points to $5B80 on entry as #REGde is also $5B80 - this does nothing, it just creates a very short pause.
  $6388,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
  $6395,$0D Writes $28 to $58A0 in the attribute buffer $100 times.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$28 | #N$00 | #N$05 | #N$00 }
. TABLE#
  $63A2,$07 ...and $20 to the attribute buffer another $5F times (following on from the previous location).
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$20 | #N$00 | #N$04 | #N$00 }
. TABLE#

N $63A9 Prints the labels to the screen.
  $63A9,$08 Pass #R$64AC to #R$647C (index "1").
  $63B1,$08 Pass #R$64B3 to #R$647C (index "2").
  $63B9,$08 Pass #R$64BA to #R$647C (index "3").

  $63C1,$0C Points to #R$6492 and sends it to #R$5B80
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$06 | #N$06 | #N$00 | #N$00 }
. TABLE#

N $63CD Prints the images to the screen.
  $63CD,$07 Calls #R$643A with (#R$B450(draw | #N$25)) for index "1".
  $63D4,$07 Calls #R$643A with (#R$7880(draw | #N$08)) for index "2".
  $63DB,$07 Calls #R$643A with (#R$9B90(draw | #N$19)) for index "3".

N $63E2 Loop for getting user keyboard input.
  $63E2,$03 Used later for setting the current level at #R$5CB1.
@ $63E5 label=LevelSelect_Input
  $63E5,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#

  $63E9,$03 If "1" is pressed, jump to #R$63F4.
  $63EC,$03 If "2" is pressed, jump to #R$6405.
  $63EF,$03 If "3" is pressed, jump to #R$6416.
  $63F2,$02 Cycle back to #R$63E5.

N $63F4 Act on level being selected.
@ $63F4 label=LevelSelect_Level_01
  $63F4,$09 Store $01 at #R$5CB1 and call #R$6427 with (#R$B660(shot | #N$26)) for index "1".
  $63FD,$08 Jump to #R$6457 with #REGhl=#R$64AC and #REGa=$01.
@ $6405 label=LevelSelect_Level_03
  $6405,$09 Store $02 at #R$5CB1 and call #R$6427 with (#R$7A90(shot | #N$09)) for index "2".
  $640E,$08 Jump to #R$6457 with #REGhl=#R$64B3 and #REGa=$02.
@ $6416 label=LevelSelect_Level_06
  $6416,$09 Store $03 at #R$5CB1 and call #R$6427 with (#R$9DA0(shot | #N$1A)) for index "3".
  $641F,$08 Jump to #R$6457 with #REGhl=#R$64BA and #REGa=$03.

N $6427 Animates the selected bandit being shot.
@ $6427 label=LS_AnimateShot
@ $6430 label=LS_AnimateShot_Halt_Loop
  $6428,$03 Call #R$643A.
  $642B,$03 Call #R$6500.
  $642E,$05 Short interrupt driven halt loop.
  $6434,$05 Call #R$643A with (#R$B870(floor | #N27)).
  $6439,$01 Return.

N $643A Prints the images to the screen.
@ $643A label=LevelSelect_Graphics
  $643A,$04 Stash the current counter and convert the accumulator which is holding a character ID into their memory location.
  $6440,$0F Work out which screen position to use;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $40A2 }
. { #N$02 | $40AD }
. { #N$03 | $40B8 }
. TABLE#
@ $644F label=LevelSelect_Graphics_Skip
  $644F,$07 Set the dimensions and call #R$5B92.
  $6456,$01 Return.

N $6457 Flashes the selected level text.
@ $6457 label=LevelSelect_Text_Flash
@ $645A label=LevelSelect_Text_Flash_Loop
@ $6462 label=LevelSelect_Flash_Halt_Loop_01
@ $6470 label=LevelSelect_Flash_Halt_Loop_02
  $6457,$24 This prints #R$64C1 and the passed level copy alternately with a delay caused by a HALT loop
.           (which continues execution after an interrupt is fired), the sequence repeats $08 times.
  $647B,$01 Return.

N $647C Print level select copy to the screen.
@ $647C label=Print_LevelSelect
  $647C,$0F First, work out which screen position to use;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $5022 }
. { #N$02 | $502D }
. { #N$03 | $5038 }
. TABLE#
  $648B,$06 Then call the print routine at #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$02 | #N$02 | #N$00 | #N$00 }
. TABLE#
  $6491,$01 Return.

t $6492 Level Selection Text
@ $6492 label=LevelSelect_Copy
  $6492,$1A "#STR#(#PC),$0B($b==$FF)".
@ $64AC label=LevelSelect_One
  $64AC,$07 "#STR#(#PC),$0B($b==$FF)".
@ $64B3 label=LevelSelect_Three
  $64B3,$07 "#STR#(#PC),$0B($b==$FF)".
@ $64BA label=LevelSelect_Six
  $64BA,$07 "#STR#(#PC),$0B($b==$FF)".
@ $64C1 label=LevelSelect_Whitespace
  $64C1,$07 "WHITESPACE"

u $64C8
i $64CB

c $6500 Sounds
@ $6500 label=Shot_Sound_01_Alias
@ $6502 label=Shot_Sound_02_Alias
@ $6504 label=Shot_Sound_03_Alias

W $6506,$14
B $651A,$05

N $651F Sound data.
W $651F,$18,$02
@ $651F label=Data_Sound_01
@ $6527 label=Data_Sound_02
@ $652F label=Data_Sound_03

N $6537 Shot sound 1.
@ $6537 label=Shot_Sound_01
  $6537,$07 Calls #R$654F using #R$651F.
  $653E,$01 Return.

N $653F Shot sound 2.
@ $653F label=Shot_Sound_02
  $653F,$07 Calls #R$654F using #R$6527.
  $6546,$01 Return.

N $6547 Shot sound 3.
@ $6547 label=Shot_Sound_03
  $6547,$07 Calls #R$654F using #R$652F.
  $654E,$01 Return.

@ $654F label=Play_Shot_Sound
  $654F,$03 Call #R$655E.
  $6552,$08 Increase #REGix by $04.
  $655A,$03 Call #R$655E.
  $655D,$01 Return.

@ $655E label=Shot_Sound
  $655E,$10 jjj
@ $6571 label=Shot_Sound_Loopback
  $657F,$01 Return.

u $6580

i $65B1
u $65AE

c $6600 Scroll Screen Right
N $6600
@ $6600 label=ScreenScroll_Right
  $6600,$02 #REGb=#N$0B.
@ $6602 label=ScreenScroll_Right_Loop
  $6602,$01 Push the counter onto the stack.
  $6603,$03 Call #R$6610.
  $6606,$03 Call #R$6647.
  $6609,$03 Call #R$6647 again.
  $660C,$01 Restore the counter off the stack.
  $660D,$02 Decrease counter by one and loop back to #R$6602 until counter is zero.
  $660F,$01 Return.
N $6610 ...
@ $6610 label=ScreenScroll_Right_
  $6610,$04 #REGix=#R$5B00.
  $6614,$03 #REGhl=#N$406A.
  $6617,$02 #REGb=#N$0D.
  $6619,$03 Call #R$6664.
  $661C,$03 #REGhl=#N$407E.
  $661F,$03 #REGde=#N$407F.
  $6622,$04 #REGix=#R$5B00.
  $6626,$02 #REGb=#N$0D.
  $6628,$03 Call #R$66A0.
  $662B,$03 #REGhl=#N$59EA.
  $662E,$04 #REGix=#R$5B00.
  $6632,$02 #REGb=#N$0D.
  $6634,$03 Call #R$6681.
  $6637,$03 #REGhl=#N$59FE.
  $663A,$03 #REGde=#N$59FF.
  $663D,$04 #REGix=#R$5B00.
  $6641,$02 #REGb=#N$0D.
  $6643,$03 Call #R$668E.
  $6646,$01 Return.
N $6647 ...
@ $6647 label=ScreenScroll_Right__
  $6647,$04 #REGix=#R$5B00.
  $664B,$03 #REGhl=#N$502A.
  $664E,$02 #REGb=#N$04.
  $6650,$03 Call #R$6664.
  $6653,$03 #REGhl=#N$503E.
  $6656,$03 #REGde=#N$503F.
  $6659,$04 #REGix=#R$5B00.
  $665D,$02 #REGb=#N$04.
  $665F,$03 Call #R$66A0.
  $6662,$01 Return.
  $6663,$01 Return? Possibly unused.
N $6664 Copies screen data into the (general) buffer.
@ $6664 label=ScreenScroll_Right_Copy
  $6664,$02 #REGc=#N$08.
  $6666,$04 Store the contents of memory #REGhl is referencing to #REGix.
  $666A,$02 Increment #REGix by one.
  $666C,$01 Increment #REGh by one.
  $666D,$01 Decrease #REGc by one.

  $6680,$01 Return.
N $6681 ...
@ $6681 label=ScreenScroll_Right___
  $6681,$04 Store the contents of memory #REGhl is referencing to #REGix.
  $6685,$03 #REGde=#R$FFE0.

  $668B,$02 Decrease counter by one and loop back to #R$6681 until counter is zero.
  $668D,$01 Return.

N $668E ...
  $668E
  $669F,$01 Return.

  $66D6,$01 Return.
i $66D7 Unused?

c $6700 Scroll Screen Left
  $6700,$02 #REGb=#N$0B.
  $6702,$01 Push the counter onto the stack.
  $6703,$03 Call #R$6710.
  $6706,$03 Call #R$6747.
  $6709,$03 Call #R$6747 again.
  $670C,$01 Restore the counter off the stack.
  $670D,$02 Decrease counter by one and loop back to #R$6702 until counter is zero.
  $670F,$01 Return.

b $6800 Jack Vicious (bandit)
D $6800 JACK VISCIOUS - The sponging swindler of the WEST. Don't hesitate
.       - shoot whenever you see his face.
E $6800 #UDGARRAY*character-00,100;character-01;character-02;(jack-frames)
N $6800 Bandit 1 (draw | #N$00)
@ $6800 label=Character_00
  $6800,$210,$06 #CHARACTERS(character-00*)
N $6A10 Bandit 1 (shot | #N$01)
@ $6A10 label=Character_01
  $6A10,$210,$06 #CHARACTERS(character-01*)
N $6C20 Bandit 1 (floor | #N$02)
@ $6C20 label=Character_02
  $6C20,$210,$06 #CHARACTERS(character-02*)

b $6E30 Green Jordan (customer)
D $6E30 GREEN JORDAN - The farmer. The untiring worker who goes to the
.       bank to put in his savings. You should not shoot
.       him.
E $6E30 #UDGARRAY*character-03,50;character-04;character-05;character-00(green-jordan-uncover-frames)
.       #UDGARRAY*character-03,50;character-04;character-06;character-07(green-jordan-shot-frames)
N $6E30 Green Jordan (depositing | #N$03)
@ $6E30 label=Character_03
  $6E30,$210,$06 #CHARACTERS(character-03*)
N $7040 Green Jordan (hands up | #N$04)
@ $7040 label=Character_04
  $7040,$210,$06 #CHARACTERS(character-04*)
N $7250 Green Jordan (uncover | #N$05)
@ $7250 label=Character_05
  $7250,$210,$06 #CHARACTERS(character-05*)
N $7460 Green Jordan (shot | #N$06)
@ $7460 label=Character_06
  $7460,$210,$06 #CHARACTERS(character-06*)
N $7670 Green Jordan (floor | #N$07)
@ $7670 label=Character_07
  $7670,$210,$06 #CHARACTERS(character-07*)

b $7880 Bandit 2
D $7880 ALFRED DALTON - A real baddie. Shoot as soon as he takes out his
.       gun!
E $7880 #UDGARRAY*character-08,100;character-09;character-07;(bandit-2-frames)
N $7880 Bandit 2 (draw | #N$08)
@ $7880 label=Character_08
  $7880,$210,$06 #CHARACTERS(character-08*)
N $7A90 Bandit 2 (shot | #N$09)
@ $7A90 label=Character_09
  $7A90,$210,$06 #CHARACTERS(character-09*)

b $7CA0 Daisy (customer)
D $7CA0 DAISY - The beautiful daughter of the City Jeweller.
.       Always loaded with money - never hurt her.
E $7CA0 #UDGARRAY*character-10,50;character-11;character-12;character-00(daisy-uncover-frames)
.       #UDGARRAY*character-10,50;character-11;character-13;character-14(daisy-shot-frames)
N $7CA0 Normal 2 (depositing | #N$0A)
@ $7CA0 label=Character_10
  $7CA0,$210,$06 #CHARACTERS(character-10*)
N $7EB0 Normal 2 (hands up | #N$0B)
@ $7EB0 label=Character_11
  $7EB0,$210,$06 #CHARACTERS(character-11*)
N $80C0 Normal 2 (uncover | #N$0C)
@ $80C0 label=Character_12
  $80C0,$210,$06 #CHARACTERS(character-12*)
N $82D0 Normal 2 (shot | #N$0D)
@ $82D0 label=Character_13
  $82D0,$210,$06 #CHARACTERS(character-13*)
N $84E0 Normal 2 (floor | #N$0E)
@ $84E0 label=Character_14
  $84E0,$210,$06 #CHARACTERS(character-14*)

b $86F0 Bandit 3
D $86F0 JOE DALTON - Alfred Dalton's brother. It runs in the family.
.       Shoot as soon as he takes out his gun.
E $86F0 #UDGARRAY*character-16,100;character-15;character-17;character-07;(bandit-3-frames)
N $86F0 Bandit 3 (draw | #N$0F)
@ $86F0 label=Character_15
  $86F0,$210,$06 #CHARACTERS(character-15*)
N $8900 Bandit 3 (stand off | #N$10)
@ $8900 label=Character_16
  $8900,$210,$06 #CHARACTERS(character-16*)
N $8B10 Bandit 3 (shot | #N$11)
@ $8B10 label=Character_17
  $8B10,$210,$06 #CHARACTERS(character-17*)

b $8D20 Bandit 4
D $8D20 MACKEYHAM - The bloodthirsty villain. Everyone trembles when
.       they come up against him. Don't hesitate or it
.       might be too late. Shoot as quickly as you can.
E $8D20 #UDGARRAY*character-18,100;character-19;character-20;character-07;(bandit-4-frames)
N $8D20 Bandit 4 (stand off | #N$12)
@ $8D20 label=Character_18
  $8D20,$210,$06 #CHARACTERS(character-18*)
N $8F30 Bandit 4 (draw | #N$13)
@ $8F30 label=Character_19
  $8F30,$210,$06 #CHARACTERS(character-19*)
N $9140 Bandit 4 (shot | #N$14)
@ $9140 label=Character_20
  $9140,$210,$06 #CHARACTERS(character-20*)

b $9350 Bandit 5
D $9350
E $9350 #UDGARRAY*character-21,100;character-22;character-23;character-07;(bandit-5-frames)
N $9350 Bandit 5 (stand off | #N$15)
@ $9350 label=Character_21
  $9350,$210,$06 #CHARACTERS(character-21*)
N $9560 Bandit 5 (draw | #N$16)
@ $9560 label=Character_22
  $9560,$210,$06 #CHARACTERS(character-22*)
N $9770 Bandit 5 (shot | #N$17)
@ $9770 label=Character_23
  $9770,$210,$06 #CHARACTERS(character-23*)

b $9980 Bandit 6
D $9980
E $9980 #UDGARRAY*character-24,100;character-25;character-26;character-07;(bandit-6-frames)
N $9980 Bandit 6 (stand off | #N$18)
@ $9980 label=Character_24
  $9980,$210,$06 #CHARACTERS(character-24*)
N $9B90 Bandit 6 (draw | #N$19)
@ $9B90 label=Character_25
  $9B90,$210,$06 #CHARACTERS(character-25*)
N $9DA0 Bandit 6 (shot | #N$1A)
@ $9DA0 label=Character_26
  $9DA0,$210,$06 #CHARACTERS(character-26*)

b $9FB0 Bowie (special)
D $9FB0 BOWIE - The dwarf. He is a constant practical joker. Make
.       holes in his hats but take care that the bottom
.       hat doesn't conceal a bomb or you will lose a
.       life.
E $9FB0 #UDGARRAY*character-27,50;character-28;character-29;character-30;character-31;character-32;character-33;character-34(bowie-bomb-frames)
.       #UDGARRAY*character-27,50;character-28;character-29;character-30;character-31;character-32;character-33;character-35(bowie-cash-frames)
N $9FB0 Bowie (7 hats | #N$1B)
@ $9FB0 label=Character_27
  $9FB0,$210,$06 #CHARACTERS(character-27*)
N $A1C0 Bowie (6 hats | #N$1C)
@ $A1C0 label=Character_28
  $A1C0,$210,$06 #CHARACTERS(character-28*)
N $A3D0 Bowie (5 hats | #N$1D)
@ $A3D0 label=Character_29
  $A3D0,$210,$06 #CHARACTERS(character-29*)
N $A5E0 Bowie (4 hats | #N$1E)
@ $A5E0 label=Character_30
  $A5E0,$210,$06 #CHARACTERS(character-30*)
N $A7F0 Bowie (3 hats | #N$1F)
@ $A7F0 label=Character_31
  $A7F0,$210,$06 #CHARACTERS(character-31*)
N $AA00 Bowie (2 hats | #N$20)
@ $AA00 label=Character_32
  $AA00,$210,$06 #CHARACTERS(character-32*)
N $AC10 Bowie (1 hat | #N$21)
@ $AC10 label=Character_33
  $AC10,$210,$06 #CHARACTERS(character-33*)
N $AE20 Bowie (bomb | #N$22)
@ $AE20 label=Character_34
  $AE20,$210,$06 #CHARACTERS(character-34*)
N $B030 Bowie (cash | #N$23)
@ $B030 label=Character_35
  $B030,$210,$06 #CHARACTERS(character-35*)

b $B240 Julius (special)
D $B240 JULIUS - The dandy. He is a box of surprises. He may give
. you a bag of gold or he might shoot you. Take
. things very carefully with this one.
E $B240 #UDGARRAY*character-36,100;character-37;character-38;character-39(julius-frames)
N $B240 Bandit 7 (stand off | #N$24)
@ $B240 label=Character_36
  $B240,$210,$06 #CHARACTERS(character-36*)
N $B450 Bandit 7 (draw | #N$25)
@ $B450 label=Character_37
  $B450,$210,$06 #CHARACTERS(character-37*)
N $B660 Bandit 7 (shot | #N$26)
@ $B660 label=Character_38
  $B660,$210,$06 #CHARACTERS(character-38*)
N $B870 Bandit 7 (floor | #N$27)
@ $B870 label=Character_39
  $B870,$210,$06 #CHARACTERS(character-39*)

b $BA80 Door Frame 1
D $BA80 The door is shut.
@ $BA80 label=Door_Frame_01
  $BA80,$268,$07 #UDGARRAY7,attr=48,scale=4,step=7;(#PC)-(#PC+$236)-$01-$38(door-1)

b $BCE8 Door Frame 2
D $BCE8 The door is only slightly open.
@ $BCE8 label=Door_Frame_02
  $BCE8,$1B8,$05 #UDGARRAY5,attr=48,scale=4,step=5;(#PC)-(#PC+$194)-$01-$28(door-2)

b $BEA0 Door Frame 3
D $BEA0 The door is nearly fully open.
@ $BEA0 label=Door_Frame_03
  $BEA0,$108,$03 #UDGARRAY3,attr=48,scale=4,step=3;(#PC)-(#PC+$F2)-$01-$18(door-3)

b $BFA8 Door Frame 4
D $BFA8 The door is fully open.
@ $BFA8 label=Door_Frame_04
  $BFA8,$58,$01 #UDGARRAY1,attr=48,scale=4,step=1;(#PC)-(#PC+$50)-$01-$08(door-4)

c $C000 BANG!
@ $C000 label=Bang
  $C000,$03 Clear the screen.
  $C003,$08 Pass #R$F000 to #R$C061.
  $C00B,$08 Pass #R$F100 to #R$C061.
  $C013,$08 Pass #R$F200 to #R$C061.
  $C01B,$06 Calls $6502 twice.
  $C021,$08 Pass #R$F300 to #R$C061.
  $C029,$08 Pass #R$F400 to #R$C061.
  $C031,$08 Pass #R$F500 to #R$C061.
  $C039,$08 Blanks the display by passing a "clear" part of the screen buffer to #R$C061.
  $C041,$05 Jump to #R$C06D.

  $C046 Prepares For BANG!
@ $C046 label=Prep_Bang
  $C046,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
  $C053,$0D Continues into the attributes buffer, and writes $02 (red ink) to every location.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$02 | #N$00 | #N$00 | #N$00 }
. TABLE#
  $C060,$01 Returns.

  $C061,$0F Sets the screen location and the bang image frame sizing, then calls #R$C071, issues a short pause and ...
@ $C061 label=Bang_Copy
@ $C06D label=Bang_Halt_Loop
  $C070,$01 ...returns.

  $C071,$13 Copy the bang image frame to the screen buffer.
@ $C071 label=Print_Bang
  $C084,$01 Return.

@ $C085 label=Bang_Next_Line
  $C085,$0D Handles working out the next line progressively in the screen buffer.
  $C092,$01 Return.

B $C093

b $C0A0 Character Set
D $C0A0 All characters are 8x16.

N $C0A0 Lettering.
@ $C0A0 label=Char_A
  $C0A0 #CHARACTERSET,7(char-A) Letter "A".
@ $C0B0 label=Char_B
  $C0B0 #CHARACTERSET,7(char-B) Letter "B".
@ $C0C0 label=Char_C
  $C0C0 #CHARACTERSET,7(char-C) Letter "C".
@ $C0D0 label=Char_D
  $C0D0 #CHARACTERSET,7(char-D) Letter "D".
@ $C0E0 label=Char_E
  $C0E0 #CHARACTERSET,7(char-E) Letter "E".
@ $C0F0 label=Char_F
  $C0F0 #CHARACTERSET,7(char-F) Letter "F".
@ $C100 label=Char_G
  $C100 #CHARACTERSET,7(char-G) Letter "G".
@ $C110 label=Char_H
  $C110 #CHARACTERSET,7(char-H) Letter "H".
@ $C120 label=Char_I
  $C120 #CHARACTERSET,7(char-I) Letter "I".
@ $C130 label=Char_J
  $C130 #CHARACTERSET,7(char-J) Letter "J".
@ $C140 label=Char_K
  $C140 #CHARACTERSET,7(char-K) Letter "K".
@ $C150 label=Char_L
  $C150 #CHARACTERSET,7(char-L) Letter "L".
@ $C160 label=Char_M
  $C160 #CHARACTERSET,7(char-M) Letter "M".
@ $C170 label=Char_N
  $C170 #CHARACTERSET,7(char-N) Letter "N".
@ $C180 label=Char_O
  $C180 #CHARACTERSET,7(char-O) Letter "O".
@ $C190 label=Char_P
  $C190 #CHARACTERSET,7(char-P) Letter "P".
@ $C1A0 label=Char_Q
  $C1A0 #CHARACTERSET,7(char-Q) Letter "Q".
@ $C1B0 label=Char_R
  $C1B0 #CHARACTERSET,7(char-R) Letter "R".
@ $C1C0 label=Char_S
  $C1C0 #CHARACTERSET,7(char-S) Letter "S".
@ $C1D0 label=Char_T
  $C1D0 #CHARACTERSET,7(char-T) Letter "T".
@ $C1E0 label=Char_U
  $C1E0 #CHARACTERSET,7(char-U) Letter "U".
@ $C1F0 label=Char_V
  $C1F0 #CHARACTERSET,7(char-V) Letter "V".
@ $C200 label=Char_W
  $C200 #CHARACTERSET,7(char-W) Letter "W".
@ $C210 label=Char_X
  $C210 #CHARACTERSET,7(char-X) Letter "X".
@ $C220 label=Char_Y
  $C220 #CHARACTERSET,7(char-Y) Letter "Y".
@ $C230 label=Char_Z
  $C230 #CHARACTERSET,7(char-Z) Letter "Z".

N $C240 Numbering.
@ $C240 label=Char_1
  $C240 #CHARACTERSET,7(char-1) Number "1".
@ $C250 label=Char_2
  $C250 #CHARACTERSET,7(char-2) Number "2".
@ $C260 label=Char_3
  $C260 #CHARACTERSET,7(char-3) Number "3".
@ $C270 label=Char_4
  $C270 #CHARACTERSET,7(char-4) Number "4".
@ $C280 label=Char_5
  $C280 #CHARACTERSET,7(char-5) Number "5".
@ $C290 label=Char_6
  $C290 #CHARACTERSET,7(char-6) Number "6".
@ $C2A0 label=Char_7
  $C2A0 #CHARACTERSET,7(char-7) Number "7".
@ $C2B0 label=Char_8
  $C2B0 #CHARACTERSET,7(char-8) Number "8".
@ $C2C0 label=Char_9
  $C2C0 #CHARACTERSET,7(char-9) Number "9".
@ $C2D0 label=Char_0
  $C2D0 #CHARACTERSET,7(char-0) Number "0".

c $C2E0

c $C300 Draw Playfield
@ $C300 label=Draw_Playfield
  $C300,$09 Set #R$D5E6 as the destination address at #R$C3B7.
  $C309,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.
N $C316 Draws the numbering of the deposit boxes on the left and right of the screen.
  $C316,$0C Points #REGhl to $4001 (screen buffer) and #REGde to #R$DFA0, then calls the routine at #R$C3B7.
  $C322,$0C Points #REGhl to $4013 (screen buffer) and #REGde to #R$E000, then calls the routine at #R$C3B7.
N $C32E Draws the centrepiece "till" image.
  $C32E,$0D Points #REGhl to $400E (screen buffer) and #REGde to #R$E060, then calls the routine at #R$C3B7.
N $C33B Draws the game play area (doors and wall sections).
  $C33B,$0C Points #REGhl to $4060 (screen buffer) and #REGde to #R$E0C0, then calls the routine at #R$C3B7.
  $C347,$0D Points #REGhl to $4080 (screen buffer) and #REGde to #R$E1C0, then calls the routine at #R$C3B7.
  $C354,$0D Points #REGhl to $4089 (screen buffer) and #REGde to #R$E270, then calls the routine at #R$C3B7.
  $C361,$0D Points #REGhl to $4094 (screen buffer) and #REGde to #R$E270, then calls the routine at #R$C3B7.
  $C36E,$0D Points #REGhl to $409F (screen buffer) and #REGde to #R$E3D0, then calls the routine at #R$C3B7.
  $C37B,$0C Points #REGhl to $48E0 (screen buffer) and #REGde to #R$E428, then calls the routine at #R$C3B7.
N $C387 Draws the Bank Teller desks.
  $C387,$0C Points #REGhl to $5020 (screen buffer) and #REGde to #R$E528, then calls the routine at #R$C3B7.
N $C393 Writes the "SCORE" and "LIVES" labels (these aren't text, they're images).
  $C393,$0C Points #REGhl to $50C1 (screen buffer) and #REGde to #R$E928, then calls the routine at #R$C3B7.
  $C39F,$0C Points #REGhl to $50B0 (screen buffer) and #REGde to #R$E988, then calls the routine at #R$C3B7.
N $C3AB Copies attribute data to the screen.
  $C3AB,$0B Copies $300 bytes of attribute data from #R$ED00 to $5800.
  $C3B6,$01 Return.
  $C3B7,$03 Draws the image pointed to in #REGde to the screen location in #REGhl using the dimensions in #REGbc.
@ $C3B7 label=Alias_Copy_Routine
  $C3BA,$01 Return.
  $C3BB,$05 Unused.

c $C3C0
  $C3C0,$03 Call #R$C3DD.
  $C3C3,$03 Grab #R$C421.
@ $C3C9 label=Rebuild
  $C3C9,$05 Interrupt driven HALT loop ($20 cycles).
@ $C3CB label=Rebuild_Halt_Loop
  $C3CF,$06 Is #R$CC59 more than $06?
  $C3D5,$02 If so, jump to #R$C3D8.
  $C3D8,$03 If #R$CC59 is zero then return.
  $C3DB,$02 Set the carry flag and return.

N $C3DD Kicks off the duelling bonus round.
@ $C3DD label=Init_Duel
  $C3DD,$02 Stashes #REGbc and #REGde.
  $C3DF,$08 Copies $1B of data from #REGhl to #R$5B80.
  $C3E7,$03 Jump to #R$C422.

c $C3EA Duel Bonus Round Data
@ $C3EA label=Duel_Data
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
@ $C41D label=Duel_Bonus_Text
N $C41D Buffer holding bonus text.
T $C41D,$04 Bonus text buffer changes during play - "#STR#(#PC),$08($b==$FF)".
N $C421 Not sure ... it is used though @todo.
B $C421,$01

c $C422 Duel Bonus Round
@ $C422 label=Duel_Prep
  $C422,$0B Copies $33 bytes of data from #R$C3EA to #R$5BC0 (and across all three duellists).

  $C430,$07 Calls #R$C67F with #R$5BC0.
  $C438,$07 Calls #R$C67F with #R$5BD1.
  $C440,$07 Calls #R$C67F with #R$5BE2.
  $C447,$09 Reset the flags (writes $00 to #R$C6E2, #R$C6E3 and #R$C6E4).
  $C450,$03 #R$C421.
@ $C460 label=Duel_Prep_Loop

@ $C463 label=Duel_Clear_Screen
  $C463,$04 ....
N $C467 Clears down the screen buffer.
  $C467,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
N $C474 Writes the attributes for the playfield (sky, grass, footer).
  $C474,$0D Writes $28 to $5880 in the attribute buffer $180 times...
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$00 | #N$05 | #N$00 | #N$00 }
. TABLE#
  $C481,$07 ...continuing, writes $20 $80 times...
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$00 | #N$04 | #N$00 | #N$00 }
. TABLE#
  $C488,$07 ...and finally, writes $07 $7F times.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$00 | #N$00 | #N$00 }
. TABLE#

N $C48F Creates the footer.
  $C48F,$06 Point to #R$C655 and print using #R$C6A7.
  $C495,$03
  $C498,$0C Point to #R$C64D and prints using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$03 | #N$03 | #N$00 | #N$00 }
. TABLE#
  $C4A4,$03 Writes the players score.

N $C4A7 Initialise duellers.
  $C4A7,$0A Initialise #R$5BC0 (draws frame 1).
  $C4B1,$0A Initialise #R$5BD1 (draws frame 1).
  $C4BB,$0A Initialise #R$5BE2 (draws frame 1).

N $C4C5 Count down 5-4-3-2-1...0!
  $C4C5,$06 Initialise countdown to "5" seconds ($35 in ASCII), hold this at #R$C6E0.
@ $C4C5 label=Countdown_Initialise
@ $C4C7 label=Countdown_Loop

  $C4CE,$05 Short halt loop (1 second pause).
@ $C4D0 label=Countdown_Halt_Loop
  $C4D3,$06 Keep looping back to #R$C4C7 until the countdown is "0" ($30 in ASCII).

  $C4D9,$08 Blank the countdown timer by printing a "SPACE" ($20 in ASCII) over the top of it.
  $C4E1,$02 Jump to #R$C4F9 and start the duel!

@ $C4E3 label=Duel_Loop
  $C4E3,$07 Calls #R$C530 with #R$5BC0.
  $C4EA,$07 Calls #R$C530 with #R$5BD1.
  $C4F1,$07 Calls #R$C530 with #R$5BE2.
  $C4F8,$01 Return.

N $C4F9 DRAW!
@ $C4F9 label=Duel_Start
  $C4F9,$05 #REGde=#R$C52E and push it on the stack.
@ $C4FD label=Duel_Start_Loop

W $C52E,$02

@ $C530 label=Duel_Actions
  $C530
  $C542,$01 Return.

@ $C543 label=Duel_Action_01
  $C543,$03 Calls #R$5B88.
  $C546,$03 Return if bit 4 of #REGa is zero.
  $C549,$05 If bit 0 is not zero then return setting #REGa to $03.
  $C54E,$02 Set #REGa to zero and return.

@ $C550 label=Duel_Action_02
  $C550,$03 Calls #R$5B88.
  $C553,$03 Return if bit 4 of #REGa is zero.
  $C556,$05 If bit 1 is not zero then return setting #REGa to $01.
  $C55B,$02 Set #REGa to zero and return.

@ $C55D label=Duel_Action_03
  $C55D
  $C56A,$01 Return.

@ $C56B label=Duel_Action_04
  $C56B,$05 If the dueller position has been changed to zero then jump to #R$C575.
  $C574,$01 Return.

@ $C575 label=Duel_Dunno
  $C575
  $C57F,$03 Set dueller state to $01.
  $C582,$01 Return.

  $C58B,$05 If IX+$08 is zero then return.
  $C590,$06 If dueller frame index is $01 then jump to #R$C5A1.
  $C596,$03 If dueller frame index is $02 then jump to #R$C5B5.
  $C599,$03 If dueller frame index is $03 then jump to #R$C5BD.
  $C59C,$03 If dueller frame index is $04 then jump to #R$C5CF.
  $C59F,$02 Jump to #R$C5DD.

  $C5A1,$03 #R$C6E5.

c $C5EB
@ $C5EB label=Dueller_Down
  $C5EB,$05 Check if the current duellers state is zero (complete), return if so.
  $C5F0,$04 Mark the current dueller as complete.
  $C5F4,$02 Restore #REGa and jump to whatever address is held by #REGhl.

N $C5F6 Not related?
  $C5F6

c $C607 Displays The Bonus Score Text
@ $C607 label=Print_BonusScore
  $C607,$09 Stores the ASCII representation of the number at #R$C41D (it adds ASCII "0") so for example 1 ends up being
.           1 + $30 = $31 (e.g. "1" in ASCII).
  $C610,$06 Print using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$29 | #N$01 | #N$05 | #N$00 }
. { #N$28 | #N$00 | #N$05 | #N$00 }
. TABLE#
  $C61F,$03 Jump to #R$C583.

t $C622 "Extra" text
@ $C622 label=Extra_Text_Copy
  $C622,$06 "#STR#(#PC),$08($b==$FF)".

c $C628 Displays "Extra" and Bonus Score text
@ $C628 label=Duel_Points
D $C628 Handles whether to display points or "EXTRA" above each downed Bandit.
  $C628,$08 If #R$C6E4 is NOT zero then award 9(00) bonus points.
  $C630,$0A Fetch a 16 bit address from #R$5B86 (#R$CC59), if it is higher than $05 then award 9(00) bonus points.
  $C63A,$0A Points to #R$C622 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$2A | #N$02 | #N$05 | #N$00 }
. { #N$29 | #N$01 | #N$05 | #N$00 }
. TABLE#
  $C644,$05 Writes $01 to #R$C6E4.
  $C649,$03 Move onto the next frame.
  $C64C,$01 Return.

t $C64D Playfield Text
@ $C64D label=Playfield_Score
  $C64D,$08 "#STR#(#PC),$08($b==$FF)".
@ $C655 label=Playfield_Lives
  $C655,$06 "#STR#(#PC),$08($b==$FF)".
@ $C65B label=Playfield_Whitespace
  $C65B,$06 "WHITESPACE".

c $C661 Draw Duel Bandit
@ $C661 label=Duel_Draw_Bandit_Prep
  $C661,$03 Fetch the address of the character from the given index in #REGa.
  $C665,$03 Retrieve the character position.

  $C668,$06 If this character is in position "1" then point to the screen buffer at $4804 and jump to #R$C677.
  $C66E,$06 If this character is in position "2" then point to the screen buffer at $480C and jump to #R$C677.
  $C674,$03 Else this character is in position "3" so point to the screen buffer at $4814.

  $C677,$07 Call the draw routine with the image dimensions.
@ $C677 label=Duel_Draw_Bandit
  $C67E,$01 Return.

c $C67F
@ $C67F label=Update_Duel_Timer
  $C67F,$07 Updates dueller timer.
  $C686,$01 Return.

c $C687 Lose A Life
@ $C687 label=Lose_Life
  $C687,$03 Calls the subroutine to display the "BANG" animation.
  $C68A,$05 Decrease the lives counter by one (#R$CC59), set the zero flag if all lives are lost.
  $C68F,$01 Return.

c $C690 Is The Duel Finished?
@ $C690 label=Duel_Complete
  $C690,$07 Jump to #R$C6F0 if #R$C6E3 is not zero.
  $C697,$07 Jump to #R$C687 if #R$C6E2 is not zero.
  $C69E,$07 Jump to #R$C6B1 if #R$C6E4 is not zero.
  $C6A5,$02 Set the carry flag and return.

c $C6A7 Write "Lives" text
@ $C6A7 label=Duel_Print_Lives
  $C6A7,$09 Helper routine called from #R$C463 used for writing #R$C655 to the screen using the colours held in #REGbc;
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$02 | #N$02 | #N$00 | #N$00 }
. TABLE#
  $C6B0,$01 Return.

c $C6B1 Duel: Gain Extra Life
@ $C6B1 label=Duel_Flash_Text
@ $C6B3 label=Duel_Flash_Text_Loop
@ $C6BC label=Duel_Flash_Halt_Loop_01
@ $C6C7 label=Duel_Flash_Halt_Loop_02
  $C6B1,$1C Alternates displaying #R$C65B and #R$C655 to "flash" the lives indicator.
  $C6CD,$04 Increase the lives counter by one (#R$CC59).
  $C6D1,$02 Sets the carry flag and returns.

c $C6D3 Write "Countdown" text
@ $C6D3 label=Duel_Print_Countdown
  $C6D3,$0C Helper routine used for writing #R$C6E0 to the screen using the colours held in #REGbc;
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$03 | #N$03 | #N$00 | #N$00 }
. TABLE#
  $C6DF,$01 Return.

g $C6E0 Duel Countdown Timer
@ $C6E0 label=Duel_Timer
B $C6E0,$01
B $C6E1,$01
g $C6E2 Duel Shot Flag
D $C6E2 See #R$C690 for the clearest example of usage.
B $C6E2,$01 Holds $00/ $01 to indicate player has been shot.
@ $C6E2 label=Duel_Bang_Flag
g $C6E3 Duel Lost Life Flag
D $C6E3 See #R$C690 for the clearest example of usage.
B $C6E3,$01 Holds $00/ $01 to indicate player should lose a life (as they shot too quickly).
@ $C6E3 label=Duel_Lose_Life
g $C6E4 Duel Extra Life Flag
D $C6E4 See #R$C690 for the clearest example of usage.
B $C6E4,$01 Holds $00/ $01 to indicate player has gained an extra life.
@ $C6E4 label=Duel_Extra_Life

c $C6E5 Process Dueller Shot
@ $C6E5 label=Dueller_Shot
  $C6E5,$05 Writes $04 to #R$C6E3.
  $C6EA,$03 Sets the dueller frame index to $04.
  $C6ED,$03 Jump to #R$C583.

c $C6F0 Flash Life Image
D $C6F0 This routine flashes the last life image eight times, and returns with lives being one less and the carry flag
.       being set.
@ $C6F0 label=Flash_Life_Image
  $C6F0,$04 Decrease #R$CC59 by one.
  $C6F4,$02 Sets #REGb (the counter) to loop $08 times.
@ $C6F6 label=Flash_Life_Image_Loop
  $C6F8,$04 Increase #R$CC59 by one and call #R$5B83.
  $C6FC,$05 Interrupt driven halt loop.
@ $C6FE label=Flash_Life_Image_Halt_Loop_01
  $C703,$04 Decrease #R$CC59 by one and call #R$5B83.
  $C708,$05 Interrupt driven halt loop.
@ $C70A label=Flash_Life_Image_Halt_Loop_02
  $C70D,$03 Retrieves #REGb (the counter) from the stack and loop back until finished.
  $C710,$02 Set the carry flag and return.


i $C712

b $C71E

c $C720 Sheriff's Star Page
@ $C720 label=Sheriff_Star
  $C720,$0D Writes $00 to all 6144 bytes of the screen buffer (i.e. "blanks it").
  $C72D,$07 Continues into the attributes buffer, and writes $06 to every location.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$06 | #N$06 | #N$00 | #N$00 }
. TABLE#
  $C734,$0C Points to #R$F600 and prints it to the screen using #R$5B92.
  $C740,$0C Points to #R$C765 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$02 | #N$02 | #N$00 | #N$00 }
. TABLE#
  $C74C,$0C Points to #R$C784 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$02 | #N$02 | #N$00 | #N$00 }
. TABLE#
  $C758,$0C Points to #R$C7A3 and prints it to the screen using #R$5B80.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$02 | #N$02 | #N$00 | #N$00 }
. TABLE#
  $C764,$01 Return.

t $C765 Sheriff's Star Page Text
@ $C765 label=Header_01
  $C765,$1F "#STR#(#PC),$08($b==$FF)".
@ $C784 label=Header_02
  $C784,$1F "#STR#(#PC),$08($b==$FF)".
@ $C7A3 label=Header_03
  $C7A3,$1A "#STR#(#PC),$08($b==$FF)".

u $C7BD

c $C7C0 New Game
@ $C7C0 label=New_Game
  $C7C0,$03 #HTML(Fetch <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)
  $C7C3,$03 Write it to #R$D8AC.
  $C7C6,$03 Call #R$C7E5.
  $C7C9,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.
  $C7D6,$05 Calls #R$CD64 with the counter $80.
  $C7DB,$0A Jump to #R$FA00 with #REGhl=#R$CBB4 and #REGix=#R$CD86.

c $C7E5 Display title screen
D $C7E5 Displays the title screen and on return, sets the control method and initiates variables for a new game.
@ $C7E5 label=Init_Title_Screen
  $C7E5,$06 Calls #R$FE00 with #REGhl=#R$CBB4.
  $C7EB,$02 Unused.
  $C7ED,$09 Grab the value stored at #R$5CB0 and if it is $01 then jump ahead to #R$C7F9 which writes #R$D39B to #R$CE12.
  $C7F6,$06 Write #R$D392 to #R$CE12.
@ $C7F9 label=Set_Control_Alias
N $C7FC Resets all game variables/ states ready for a new game.
  $C7FC,$0D Clears the score (writes $00 over seven bytes from #R$CD86).

@ $C809 label=Starting_Lives
  $C809,$05 Initialise #R$CC59 to $03.

  $C80E,$06 Initialise #R$D45C to $0101.

  $C814,$0C Clears #R$CE14, #R$CE16 and #R$CE18 (sets them to $0000).

  $C820,$09 Clear #R$CA58 and #R$CA5A to $2020 (ASCII space-space).

  $C829,$0D Clear down the deposit flags (copies $00 to each from #R$CC8D).

  $C836,$03 Set the border to black.
  $C839,$04 Write $01 to #R$CBCF.

  $C846,$05 Writes $03 to #R$CE1B.
  $C84B,$06 Writes $0500 to #R$CE1C.
  $C851,$05 Writes $01 to #R$D191.
  $C856,$09 Grabs the #R$5CB1, if it's level 1 then jump to #R$C878 with #REGhl=#R$CA4A.

@ $C878 label=Level_01
  $C878,$06 Writes #R$CE42 to #R$CE1F.

  $C882,$06 Writes #R$CE6F to #R$CE1F.

  $C88F,$06 Writes #R$CE5F to #R$CE1F.

  $C89C,$06 Writes #R$CE55 to #R$CE1F.

  $C8A9,$06 Writes #R$CE7E to #R$CE1F.

  $C8B6,$06 Writes #R$CE8D to #R$CE1F.

  $C8C3,$06 Writes #R$CE9C to #R$CE1F.

  $C8D0,$06 Writes #R$CE9C to #R$CE1F.

  $C8E0,$06 Writes #R$CE9C to #R$CE1F.

  $C927,$03 Call #R$C720.

c $C959 Door Attributes
N $C959 Sets the door attributes for the "time of day".
@ $C959 label=Set_Day_Attributes
  $C959,$05 Call #R$C966 using #R$C96F.

@ $C95E label=Set_Dusk_Attributes
  $C95E,$05 Call #R$C966 using #R$C987.

@ $C963 label=Set_Night_Attributes
  $C963,$03 Call #R$C966 using #R$C99F.

N $C966 Note this is for the opened door background hence it starts from frame 2 (as frame 1 is a closed door).
@ $C966 label=Set_Door_Attributes
  $C966,$09 Copies $18 bytes of data to #R$D6B9, then return.

N $C96F Door frame attribute data for each day phase.
@ $C96F label=Door_Attributes_Day
B $C96F,$18,$08 The attributes for the "day" state.
@ $C987 label=Door_Attributes_Dusk
B $C987,$18,$08 The attributes for the "dusk" state.
@ $C99F label=Door_Attributes_Night
B $C99F,$18,$08 The attributes for the "night" state.

c $C9B7 Prepare To Display The Current Phase
N $C9B7 Clears the cashbox flags, clears the screen and displays the phase number.
@ $C9B7 label=Prep_Display_Phase
  $C9B7,$06 Writes $01 to both #R$D45C and #R$D45D.
  $C9BD,$0D Clear down the deposit flags (copies $00 to each from #R$CC8D).
  $C9CA,$04 Call #R$C9D0 (using $00).
  $C9CE,$02 Jump to #R$C9DD.

N $C9D0 This routine has the ability to write any value across the screen buffer, however it's only ever called with
.       #REGa=$00 (clear screen).
@ $C9D0 label=Clear_Screen
  $C9D0,$0D Clears the screen buffer by writing $00 to all 6912 memory locations.

N $C9DD Displays the current "phase".
@ $C9DD label=Display_Phase
  $C9DD,$0B Copies #R$CA4E into #R$CA5C ($05 bytes of text data).
  $C9E8,$06 Writes #R$CA5A to #R$CA5C (at $CA61 - just overwriting the numeric part).
  $C9EE,$06 Call #R$CA19 with #R$CA4A.
  $C9F4,$06 Writes $CA61 back to #R$CA5A.
  $C9FA,$01 Return.

N $C9FB Displays the current "day".
@ $C9FB label=Display_Day
  $C9FB,$0B Copies #R$CA53 into #R$CA5C ($05 bytes of text data).
  $CA06,$06 Writes #R$CA58 to #R$CA5C (at $CA61 - just overwriting the numeric part).
  $CA0C,$06 Call #R$CA19 with #R$CA4C.
  $CA12,$06 Writes $CA61 back to #R$CA58.
  $CA18,$01 Return.

N $CA19 This routine is for converting progress numbers into ASCII. On entry #REGhl will be either #R$CA4A or #R$CA4C.
@ $CA19 label=Progress_Base_10
  $CA19,$06 If the passed number is not more than 10 jump to #R$CA27.
  $CA1F,$06 Stores the ASCII representation of the number at $CA62 (for #R$CA5C). It adds ASCII "0" so for example 1
.           ends up being 1 + $30 = $31 (e.g. "1" in ASCII).
  $CA25,$02 Jump to #R$CA38.

N $CA27 Ensures the progress digit remains 0-9. On entry #REGhl will be either #R$CA4A or #R$CA4C.
@ $CA27 label=Progress_Divisible_10
  $CA27,$02 Reset the current progress digit to $00.
  $CA29,$01 Use the secondary digit of the currently focused progress.
N $CA2A Note this doesn't account for a third digit and so leads to eventual corruption. Once past day/ phase "99", this
.       will display "00" and past "09" the first ASCII digit doesn't point to any usable image data. Note however, this
.       occurs after ~4 hours of game play so isn't especially an issue.
  $CA2A,$01 Increase this second digit by one.
  $CA2B,$06 Add ASCII "0" so for example 1 ends up being 1 + $30 = $31 (e.g. "1" in ASCII). Write this number to $CA61
.           (for #R$CA5C).
  $CA31,$01 Move back to point to the original location of #REGhl.
  $CA32,$06 Again, add ASCII "0" for this digit too. Write this number to $CA62 (for #R$CA5C).

N $CA38 Prints the current progress buffer message to the screen.
@ $CA38 label=Print_Progress
  $CA38,$0C Prints #R$CA5C to the screen buffer at $486C using #R$CBD2.
. #TABLE(default,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$03 | #N$03 | #N$00 | #N$00 }
. TABLE#
@ $CA46 label=Progress_Halt_Loop
  $CA44,$05 Interrupt driven HALT loop ($50 cycles).
  $CA49,$01 Return.

@ $CA4A label=Phase
@ $CA4C label=Day
W $CA4A,$04,$02
@ $CA4E label=Phase_Copy
T $CA4E,$05 "#STR#(#PC),$04,$05".
@ $CA53 label=Day_Copy
T $CA53,$05 "#STR#(#PC),$04,$05".

@ $CA58 label=Day_ASCII
T $CA58,$02 "#STR#(#PC),$04,$02".
@ $CA5A label=Phase_ASCII
T $CA5A,$02 "#STR#(#PC),$04,$02".
@ $CA5C label=Progress_Buffer
T $CA5C,$08 This is a buffer - so text changes during play: "#STR#(#PC),$08($b==$FF)".

N $CA64 Clears the screen and displays the day number.
@ $CA64 label=Prep_Display_Day
  $CA64,$04 Clears the screen by passing $00 to #R$C9D0.
  $CA68,$03 Call #R$C9FB.
  $CA6B,$01 Return.

N $CA6C Clear down the day/ progress states.
@ $CA6C label=Init_Progress
  $CA6C,$09 Clears #R$CA4A and #R$CA4C (writes $0000 to them).
  $CA75,$0A Writes ASCII space ($20) to $CA61 and ASCII "0" ($30) to $CA62 (i.e. writes " 0" to the numeric portion of
.           #R$CA5C).
  $CA7F,$01 Return.

B $CA80,$01
@ $CA80 label=Cashboxes_Completed_Flag
  $CA81
@ $CA81 label=Cashboxes_Completed
@ $CA87 label=Cashboxes_Flash_Loop

  $CAB9,$0C Writes #REGa across all the deposit flags (copies to each from #R$CC8D).
@ $CAB9 label=Deposit_Flash_Prep
  $CAC5,$03 Jump to #R$CC9B.

  $CACB,$04 Writes $00 to #R$D2FE.

  $CAD4,$03 Call #R$CD68.
  $CAD7,$03 Call #R$CC3A.
  $CADA,$03 Call #R$CC5A.
  $CADD,$03 Call #R$CC9B.
  $CAE0,$03 Call #R$CD90.
  $CAE3,$03 Call #R$D45E.
  $CAE6,$01 Return.

c $CAE7 A
  $CAE7,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $CAEB,$03 If "SPACE" is pressed.
  $CAEE,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $CAFB,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $CB03,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $CB0B,$03 Call #R$D2CF.
  $CB0E,$04 #REGbc=#R$CE1C.

  $CB1A,$03 Call #R$CBA6.
  $CB1D,$04 #REGix=#R$D165.

  $CB25,$03 #REGhl=#R$CE14.

  $CB83,$08 If bit 0 of #R$D2FE is not zero then jump to #R$CD47.
  $CB8B,$05 Else if bit 1 is not zero, jump to #R$CD1B.
  $CB90,$03 Call #R$CDC3.

  $CB93,$0A If #R$D190 is not zero then call #R$CBA0 (also, writes $00 to #R$D190 to clear it).

  $CBA6,$0E Blanks $FF bytes from #R$5B00 onwards, then returns.

B $CBB4 Copied to $5B80.
@ $CBB4 label=Copied_5B80
B $CBCF

c $CBD0 Draw Text
@ $CBD0 label=TwoTone_Attributes_Buffer
W $CBD0 Stores the attributes; top attribute/ bottom attribute.
@ $CBD2 label=Print_TwoToneText
  $CBD2,$04 Stash the attributes at #R$CBD0.
@ $CBD6 label=Print_TwoToneText_Loop
  $CBD6,$04 Grab the next character in the string, if it's $FF then return.

@ $CBFC label=Print_TwoToneText_SpaceCheck
  $CBFC,$04 If the character is a space then jump forward to #R$CC0E.
  $CC20,$0A Load the stored top/ bottom attribute bytes back into #REGbc and write them to the screen.
  $CC2A,$01 Return.

c $CC2B
  $CC37,$01 Return.

g $CC38 Buffer for holding #R$D5E6 address
@ $CC38 label=Buffer_Copy
W $CC38,$02

c $CC3A Main Playfield Initialisation
N $CC3A Draws Main Playfield with all three doors closed.
@ $CC3A label=Draw_PlayWithDoors
  $CC3A,$07 Draw the main game playfield.
  $CC41,$08 Calls #R$D664 with #R$CE1A set to $01.
  $CC49,$08 Calls #R$D664 with #R$CE1A set to $02.
  $CC51,$08 Jump to #R$D664 with #R$CE1A set to $03.

@ $CC59 label=Lives
g $CC59 Number of lives remaining

c $CC5A Display The "Life" Images
@ $CC5A label=Life_Images
N $CC5A Set up counter=$05 screen buffer=$50B6.
  $CC5A,$02 #REGb=$05.
  $CC5C,$03 #REGhl=$50B6.
@ $CC5F label=Life_Images_Loop
  $CC5F,$01 Push the counter onto the stack.
  $CC60,$03 #REGde=#R$5B00.
  $CC63,$03 Call #R$CC84.
  $CC66,$02 Increase #REGhl by two.
  $CC68,$01 Restore the counter off the stack.
  $CC69,$02 Decrease counter by one and loop back to #R$CC5F until counter is zero.
  $CC6B,$05 If #R$CC59 are zero then return.
  $CC70,$03 If #R$CC59 is more than or equal to "#N$06" then return.
@ $CC77 label=Draw_LivesLoop
  $CC80,$01 Return.
@ $CC81 label=Draw_Lives_Images
  $CC81,$0A Point at the #R$FFB8 and call #R$D5E6.
@ $CC84 label=Copy_RoutineLoop
  $CC8C,$01 Return.

g $CC8D Deposit Flags
D $CC8D Stores whether a deposit has been made for each door.
@ $CC8D label=DoorDeposited_01
@ $CC8E label=DoorDeposited_02
@ $CC8F label=DoorDeposited_03
@ $CC90 label=DoorDeposited_04
@ $CC91 label=DoorDeposited_05
@ $CC92 label=DoorDeposited_06
@ $CC93 label=DoorDeposited_07
@ $CC94 label=DoorDeposited_08
@ $CC95 label=DoorDeposited_09
@ $CC96 label=DoorDeposited_10
@ $CC97 label=DoorDeposited_11
@ $CC98 label=DoorDeposited_12
B $CC8D,$0C,$01

g $CC99 Probably represents each block of six deposit flags
@ $CC99 label=DoorDeposited_01_06
@ $CC9A label=DoorDeposited_07_12
B $CC99,$02,$01

c $CC9B Draws Deposit Cashboxes
  $CC9B,$0A Converts #R$D45C into cash deposit box flag address (e.g. "#N$01" becomes #R$CC8D and so on).
  $CCA5,$07 #REGa=#R$D16D.
  $CCAF,$07 #REGa=#R$D17B.
  $CCB9,$07 #REGa=#R$D189.

  $CCC2,$03 #REGde=#R$CC99.
  $CCC5,$03 #REGhl=#R$CC8D.
  $CCC8,$01 Fetch the flag for #R$CC99.
  $CCC9,$01 Run a logical OR against the contents of #REGhl.
  $CCCA,$01 Writes this back into #REGhl (setting the flag).
  $CCCC,$01 Move onto #R$CC9A.
  $CCCD,$01 Fetch the flag for #R$CC9A.
  $CCCE,$01 Run a logical OR against the contents of #REGhl.
  $CCCF,$01 Writes this back into #REGhl (setting the flag).

@ $CCD3 label=Cashboxescomplete
  $CCD3,$03 Points to the cashbox flags (beginning at #R$CC8D).
  $CCD6,$05 Write $00 to #R$CA80.
  $CCDB,$02 Testing against all 12 cashboxes.
  $CCDD,$03 Fetch the cashbox flag, return if its zero.
  $CCE0,$03 Move onto the next cashbox (loop back to #R$CCDD) or continue once all 12 are checked.
  $CCE3,$02 Write #REGa ($01) to #R$CA80.
@ $CCDD label=Cashboxescomplete_Loop
@ $CCE5 label=Draw_GameCashbox
  $CCE5,$15 Determines whether to send #R$FF78 or #R$FF98 to #R$D5E6.
  $CCFA,$01 Return.

N $CCFB Draws all the cashboxes in two blocks of 6.
@ $CCFB label=Draw_GameCashboxes
@ $CD0A label=Draw_GameCashboxes_Skip
@ $CD0C label=Draw_GameCashboxes_Loop
  $CCFB,$1F The statuses for the cashboxes begin at #R$CC8D. This routine processes them in two blocks of 6 (as they
.           appear. The first block is displayed at $401F, after processing the subroutine returns and continues for the
.           next six blocks, just altering the screen location to $4025.
  $CD1A,$01 Return.

c $CD1B Flash Lives/ Lose Life
@ $CD1B label=Flash_Lives
  $CD1B,$05 Short pause.
  $CD20,$06 Point to #R$CC59. Set a counter for $05 times and stash it.
@ $CD25 label=Flash_Lives_Loop
  $CD26,$05 Decrease the number of lives by one, stash the lives memory location and draw the decreased life images.
  $CD2B,$05 Short pause.
  $CD30,$06 Grab the lives memory location, increase it by one, stash the location again and draw the now increased life
.           images (i.e. what they were on entry to the routine).
  $CD36,$05 Short pause.
  $CD3C,$03 Loop back until the counter is zero.
  $CD3F,$06 Finally decrease lives by one and if they are not zero jump to #R$CACB.
  $CD45,$02 Set the carry flag and return.

c $CD47
  $CD47,$07 If bit 2 of #R$D2FE is zero then jump to #R$CD53.

c $CD64 Configurable "pause"
R $CD64 B The counter
N $CD64 Loops back on itself using #REGb as a counter.
@ $CD64 label=Halt_Loop
  $CD64,$04 Short interrupt driven pause, and return.

c $CD68 Initialise Door Flags
N $CD68 Populates the state flags for each door.
@ $CD68 label=Populate_Door_Buffer
  $CD68,$07 Call #R$D8A1 using #REGix=#R$D165.
  $CD6F,$07 Call #R$D8A1 using #REGix=#R$D173.
  $CD76,$07 Call #R$D8A1 using #REGix=#R$D181.
  $CD7D,$01 Return.

c $CD7E Debugger
@ $CD7E label=Debugger
D $CD7E As the game uses its own character set, it's unlikely this routine was/ is used for the actual game (it doesn't
.       seem to be called from anywhere).
.       At a guess, it was probably used for "testing" text messages and outputs during development.
  $CD7E,$04 Grab a byte from #REGhl return if it's $FF (our termination character).
  $CD82,$01 #HTML(Print to screen (see <a href="https://skoolkid.github.io/rom/asm/0010.html">PRINT_A_1</a>).)
  $CD83,$03 Increase #REGhl by one and loop back to #R$CD7E.

g $CD86 Score ($06 bytes)
@ $CD86 label=Scoredigit06
B $CD86,$06,$01
@ $CD87 label=Scoredigit05
@ $CD88 label=Scoredigit04
@ $CD89 label=Scoredigit03
@ $CD8A label=Scoredigit02
@ $CD8B label=Scoredigit01

g $CD8C
B $CD8C,$01

g $CD8D
B $CD8D,$03 ???

c $CD90 Draw Score To The Screen
@ $CD90 label=Draw_Score
  $CD90,$08 Starting values; #TABLE(default,centre,centre,centre,centre)
. { =h Source | =h Screen Buffer | =h Counter }
. { #R$CD8B | $50C8 | #N$06 }
. TABLE#
  $CD98,$03 Stash the lot.
  $CD9B,$0B Grab the number at the source memory location;
. #LIST
. { If it's zero then add $0A (as the numbers are stored 1-2-3-4-5-6-7-8-9-0 whereas ASCII uses 0-1-2-3-4-5-6-7-8-9) }
. { add $23 (so for example "2" will be "$25" - see #R$CDAE) }
. { Call #R$CDAE }
. LIST#
@ $CD98 label=Scoredigit_Loop
@ $CDA1 label=Scoredigit_Non_Zero
  $CDA6,$03 Retrieve our current source, destination and counter from the stack.
  $CDA9,$04 Increase the screen buffer memory location by one, decrease the source memory location and loop round to
.           #R$CD98 until it is zero.
  $CDAD,$01 Return.

c $CDAE Draw Numbering from Character Set Index
@ $CDAE label=Draw_Number
  $CDAE,$14 Using $C000 as a base address, this works out the character set memory address from a given index passed
.           in #REGa. To give an example using "2" ($25 - see #R$CD90);
. #LIST
. { #HTML(Loads <strong>$25</strong> as the low-order byte; #REGhl=$0025) }
. { #HTML(Times by <strong>$10</strong>; #REGhl=$250) }
. { #HTML(Add <strong>$C000</strong>=#R$C250) }
. LIST#
. This is then passed to #R$D5E6.
  $CDC2,$01 Return.

c $CDC3 Apply Scoring
@ $CDC3 label=Scoring
  $CDC3,$15 Calls #R$CDDC three times with #REGix containing;
. #LIST
. { #R$D165 }
. { #R$D173 }
. { #R$D181 }
. LIST#
  $CDD8,$03 Call #R$CD90.
  $CDDB,$01 Return.

N $CDDC Passes the higher and lower score values to #R$CDF7 for the current door.
@ $CDDC label=Scoring_Prep
  $CDDC,$03 References #R$CD87.
  $CDDF,$03 Retrieves #REGix+$06, stores it in #REGb then reset it to zero.
  $CDE6,$03 Call #R$CDF7.
  $CDE9,$03 References #R$CD88.
  $CDEC,$03 Retrieves #REGix+$07, stores it in #REGb then reset it to zero.
  $CDF3,$03 Call #R$CDF7.
  $CDF6,$01 Return.

N $CDF7 Applies the door scores into the player score.
@ $CDF7 label=Scoring_Apply
  $CDF7,$05 Pass the current score digit to #R$CE08 and overwrite the digit with the result.
  $CDFC,$02 Sets a counter to $05 (5 more digits in the score).
@ $CDFE label=Scoring_Apply_Loop
  $CDFE,$01 Move onto the next scoring digit.
  $CDFF,$05 Pass the current score digit to #R$CE08 and overwrite the digit with the result.
  $CE04,$03 Loop back to #R$CDFE until the counter is zero (and all scoring digits are accounted for).
  $CE07,$01 Return.

N $CE08 Ensures the current scoring digit remains 0-9 (if $0A then it's reset and the carry digit is forwarded on).
@ $CE08 label=Scoring_Base_10
  $CE08,$01 Adds current score digit with passed score.
  $CE09,$02 Reset passed score to zero.
  $CE0B,$03 Return if result is less than $0A (base 10).
  $CE0E,$02 Subtract $0A to keep this digit in base 10 (e.g. "11" becomes "1", "12" becomes "2", and so on).
  $CE10,$02 Add one onto the passed score (which carries onto the next digit as it goes lowest to highest) and return.

g $CE12 Control Method Routine Alias
D $CE12 Points to either #R$D392 or #R$D39B depending on the chosen control method.
@ $CE12 label=Control_Routine_Alias
B $CE12,$02 16 bit memory location of either the keyboard or joystick control routines.

g $CE14 Door Routine Buffer
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
@ $CE14 label=Door_Routine_01
W $CE14,$02 Door 1 character/ door routine in-play.
@ $CE16 label=Door_Routine_02
W $CE16,$02 Door 2 character/ door routine in-play.
@ $CE18 label=Door_Routine_03
W $CE18,$02 Door 3 character/ door routine in-play.

g $CE1A Door Frame Reference
D $CE1A Only one door is "active" at a time, this status buffer points to the "currently in-focus door".
@ $CE1A label=Door_Frame_Reference
B $CE1A,$01 #TABLE(default,centre,centre)
. { =h Value | =h Which One }
. { #N$01 | Door 1 }
. { #N$02 | Door 2 }
. { #N$03 | Door 3 }
. TABLE#

g $CE1B
B $CE1B,$01
W $CE1C,$02
B $CE1E,$01
N $CE1F Defines the entry point for the choosing routines. Note, this isn't for one choice - they chain into each other
.       this simply points to where the chain starts.
@ $CE1F label=Chooser_Routine_Buffer
W $CE1F,$02

c $CE21 Choose Door Character
N $CE21 The characters available on a particular level are determined by #R$CE1F.
. #TABLE(default,centre,centre)
. { =h Initialisation Routine | =h Door }
. { #R$CE42 | Door 1 }
. { #R$CE8D | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
@ $CE21 label=Character_Chooser
  $CE21,$06 Decrease #R$CE1E by one.
  $CE27,$01 Return if not zero.
  $CE28,$04 Copies #R$CE1B into #R$CE1E.
  $CE2C,$07 Decrease ????? by one.
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16E | Door 1 }
. { #R$D17C | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
  $CE33,$01 Return if not zero.

N $CE34 f
@ $CE34 label=Chooser
  $CE34,$03 Call #R$D8B0.
  $CE37,$02 Keep bits 0-4 (so 0-31).
  $CE39,$05 Set bit 3 and write the resulting value to;
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16E | Door 1 }
. { #R$D17C | Door 2 }
. { #R$D18A | Door 3 }
. TABLE#
  $CE3E,$04 Jump to the memory address contained at #R$CE1F.

N $CE42 Handles choosing one of the initial "default" characters. A
.       character is always chosen here, so this is the end of the
.       choosing routine.
@ $CE42 label=Choose_Default_Set
  $CE42,$03 Call #R$DAEF.
  $CE45,$02 Keep only bits 0 and 1 (which determine the type of character).
  $CE47,$0E Determines which character initialisation to run;
. #TABLE(default,centre,centre)
. { =h #REGa | =h Initialisation Routine }
. { #N$00 | #R$CEB8 }
. { #N$01 | #R$CEFC }
. { #N$02 | #R$CF5E }
. { #N$03 | #R$CF2B }
. TABLE#

N $CE55 Handles whether or not to choose Julius.
@ $CE55 label=Choose_Julius
  $CE55,$03 Call #R$D8B0.
  $CE58,$04 Keep only bits 2 and 3. Jump to the next character "test" if
.           this is a non-zero number at #R$CE5F.
  $CE5C,$03 Jump to #R$CFB7.

N $CE5F Handles whether or not to choose Bandit 2.
@ $CE5F label=Choose_Bandit_02
  $CE5F,$03 Call #R$D8B0.
  $CE62,$04 Keep only bits 3, 4 and 7. Jump to the next character "test" if
.           this is a non-zero number at #R$CE6F.
  $CE66,$03 Set source character data to #R$D119.
  $CE69,$03 Set target character buffer to #R$D124.
  $CE6C,$03 Jump to #R$CEA9.

N $CE6F Handles whether or not to choose Bandit 3.
@ $CE6F label=Choose_Bandit_03
  $CE6F,$03 Call #R$D8B0.
  $CE72,$04 Keep only bits 0, 4 and 5. Jump to the next character "test" if
.           this is a non-zero number then jump back to the #R$CE42.
  $CE76,$03 Set source character data to #R$D0C1.
  $CE79,$03 Set target character buffer to #R$D0CC.
  $CE7C,$02 Jump to #R$CEA9.

N $CE7E Handles whether or not to choose Bandit 4.
@ $CE7E label=Choose_Bandit_04
  $CE7E,$03 Call #R$D8B0.
  $CE81,$04 Keep only bits 0, 1 and 7. Jump to the next character "test" if
.           this is a non-zero number #R$CE55.
  $CE85,$03 Set source character data to #R$D0D7.
  $CE88,$03 Set target character buffer to #R$D0E2.
  $CE8B,$02 Jump to #R$CEA9.

N $CE8D Handles whether or not to choose Bandit 5.
@ $CE8D label=Choose_Bandit_05
  $CE8D,$03 Call #R$D8B0.
  $CE90,$04 Keep only bits 3, 4 and 6. Jump to the next character "test" if
.           this is a non-zero number #R$CE7E.
  $CE94,$03 Set source character data to #R$D0ED.
  $CE97,$03 Set target character buffer to #R$D0F8.
  $CE9A,$02 Jump to #R$CEA9.

N $CE9C Handles whether or not to choose Bandit 6.
@ $CE9C label=Choose_Bandit_06
  $CE9C,$03 Call #R$D8B0.
  $CE9F,$04 Keep only bits 0, 4, 5 and 6. Jump to the next character "test" if
.           this is a non-zero number #R$CE8D.
  $CEA3,$03 Set source character data to #R$D103.
  $CEA6,$03 Set target character buffer to #R$D10E.

N $CEA9 Stashes the chosen character source/ buffer to the door state buffer.
@ $CEA9 label=Choose_Action
  $CEA9,$06 Writes the character source memory address to one of the following (depending on which door is currently
.           being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D171 | Door 1 }
. { #R$D17F | Door 2 }
. { #R$D18D | Door 3 }
. TABLE#
  $CEAF,$06 Writes the character target/ buffer memory address to one of the following (depending on which door is
.           currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
  $CEB5,$03 Jump to #R$D019.

  $CF2B
  $CF5E

c $CEB8 Character Initialisations
N $CEB8 Writes a "bandit opening the door" to the door flags/ cache.
@ $CEB8 label=Init_Bandit_Open
  $CEB8,$0C Writes #R$D192 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
  $CEC4,$0E Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D076.
  $CED2,$06 Writes $01 to #R$D18F and return.

N $CED8 Writes a "bandit closing the door" to the door flags/ cache.
@ $CED8 label=Init_Bandit_Close
  $CED8,$0C Writes #R$D1B7 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
  $CEE4,$0E Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D07D.
  $CEF2,$05 Writes $01 to #R$D18F.

N $CEFC Writes "Bowie" to the door flags/ cache.
@ $CEFC label=Init_Bowie
  $CEFC,$0C Writes #R$D1DC to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF16 label=Init_Bowie_Set_Flag

N $CF2B Writes a "customer opening the door" to the door flags/ cache.
@ $CF2B label=Init_Customer_Open
  $CF2B,$0C Writes #R$D201 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF45 label=Init_Customer_Open_Set_Flag

N $CF5E Writes a "customer closing the door" to the door flags/ cache.
@ $CF5E label=Init_Customer_Close
  $CF5E,$0C Writes #R$D201 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CF78 label=Init_Customer_Close_Set_Flag

N $CF91 Writes a "customer being shot" to the door flags/ cache.
@ $CF91 label=Init_Customer_Shot
  $CF91,$0C Writes #R$D226 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
  $CF9D,$06 Loads e.g. #R$D167 (depending on which door is currently
.           being actioned) into #REGde.
  $CFA3,$03 #REGhl=#R$D0AB.
  $CFA6,$06 Increase #REGde by $06.
  $CFAC,$05 Copies three sequential bytes of data from #REGhl to #REGde.
  $CFB1,$06 Writes $01 to #R$D18F and return.

N $CFB7 Writes "Julius opening the door" to the door flags/ cache.
@ $CFB7 label=Init_Julius_Open
  $CFB7,$0C Writes #R$D241 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
@ $CFD1 label=Init_Julius_Open_Set_Flag

N $CFDD Writes "Julius closing the door" to the door flags/ cache.
@ $CFDD label=Init_Julius_Close
  $CFDD,$05 Writes $01 to #R$D0B8.
  $CFE2,$0C Writes #R$D265 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
  $CFEE,$0F Handles copying $0009 bytes of data from the address (plus 1) contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D0B8.
  $CFFD,$02 #REGa=#N$01.
  $D002,$03 #REGhl=#R$D0B8.
  $D018,$01 Return.


c $D019
  $D019,$0C Writes #R$D289 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
  $D025,$11 Copies $000B bytes of data from (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Source | =h Destination | =h Door }
. { #R$D171 | #R$D167 | Door 1 }
. { #R$D17F | #R$D175 | Door 2 }
. { #R$D18D | #R$D183 | Door 3 }
. TABLE#
  $D036,$01 Return.

c $D037
@ $D037 label=Todo_Door_Reset
  $D037,$09 Writes $01 to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
. This is the first byte of character state data.

  $D040,$0C Writes #R$D2AD to the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre,centre)
. { =h Address | =h Door | =h Target }
. { #R$D165 | Door 1 | #R$CE14 }
. { #R$D173 | Door 2 | #R$CE16 }
. { #R$D181 | Door 3 | #R$CE18 }
. TABLE#
. This is copying the actual source data into the cache where it can be manipulated by the game events.

  $D04C,$11 Copies $000B bytes of data from (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Source | =h Destination | =h Door }
. { #R$D16F | #R$D167 | Door 1 }
. { #R$D17D | #R$D175 | Door 2 }
. { #R$D18B | #R$D183 | Door 3 }
. TABLE#

  $D05D,$05 Initialise #R$D18F (writes $01 to it).
  $D062,$07 Loads #REGa with the flag from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D16F | Door 1 }
. { #R$D17D | Door 2 }
. { #R$D18B | Door 3 }
. TABLE#
. As per #R$D037, this should be $01.


  $D069,$04
  $D075,$01 Return.

b $D076

b $D07D

  $D0B8,$09 ??

  $D0AB,$03 Source
  $D0AE

N $D0C1 Bandit 3.
  $D0C1,$0B Bandit 3 source data.
  $D0CC,$0B Bandit 3 buffer.

N $D0D7 Bandit 4.
  $D0D7,$0B Bandit 4 source data.
  $D0E2,$0B Bandit 4 buffer.

N $D0ED Bandit 5.
  $D0ED,$0B Bandit 5 source data.
  $D0F8,$0B Bandit 5 buffer.

N $D103 Bandit 6.
  $D103,$0B Bandit 6 source data.
  $D10E,$0B Bandit 6 buffer.

N $D119 Bandit 2.
  $D119,$0B Bandit 2 source data.
  $D124,$0B Bandit 2 buffer.

  $D141,$0B

  $D153,$0B Target

g $D165 Door 1 Flags
@ $D165 label=Door_Flags_01
@ $D167 label=Door_Source_01
@ $D169 label=Door_Bowie_Action_01
@ $D16B label=Door_Scoring_01
@ $D16D label=Door_Cash_Action_01
@ $D16F label=Door_Char_Buffer_01
@ $D171 label=Door_Char_Source_01
W $D165,$08
B $D16D,$01
B $D16E,$01
W $D16F,$04
g $D173 Door 2 Flags
@ $D173 label=Door_Flags_02
@ $D175 label=Door_Source_02
@ $D177 label=Door_Bowie_Action_02
@ $D179 label=Door_Scoring_02
@ $D17B label=Door_Cash_Action_02
@ $D17D label=Door_Char_Buffer_02
@ $D17F label=Door_Char_Source_02
W $D173,$08
B $D17B,$01
B $D17C,$01
W $D17D,$04
g $D181 Door 3 Flags
@ $D181 label=Door_Flags_03
@ $D183 label=Door_Source_03
@ $D185 label=Door_Bowie_Action_03
@ $D187 label=Door_Scoring_03
@ $D189 label=Door_Cash_Action_03
@ $D18B label=Door_Char_Buffer_03
@ $D18D label=Door_Char_Source_03
W $D181,$08
B $D189,$01
B $D18A,$01
W $D18B,$04

g $D18F

g $D190

g $D191

c $D192 Copy Source Character Data To Character State Data
N $D192 Handles copying a "normal" bandit into the bandit state cache at #R$D71E.
@ $D192 label=Prep_Bandit_Open
  $D192,$11 Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D71E.
  $D1A3,$03 Call #R$D725 to begin this characters actions.
  $D1A6,$03 Restore the source, target and counter from above.
  $D1A9,$01 Swap the source and target.
  $D1AA,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D1B4,$03 Else copy the (swapped) source back to the new target and return.

N $D1B7 And copying a successful bandit encounter to close the door.
@ $D1B7 label=Prep_Bandit_Close
  $D1B7,$11 Handles copying $0007 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D71E.
  $D1C8,$03 Call #R$D771 to begin this characters actions.
  $D1CB,$03 Restore the source, target and counter from above.
  $D1CE,$01 Swap the source and target.
  $D1CF,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D1D9,$03 Else copy the (swapped) source back to the new target and return.

N $D1DC Handles copying Bowie state data into the state cache at #R$D7C5.
@ $D1DC label=Prep_Bowie
  $D1DC,$11 Handles copying $0009 bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D7C5.
  $D1ED,$03 Call #R$D7CE to begin this characters actions.
  $D1F0,$03 Restore the source, target and counter from above.
  $D1F3,$01 Swap the source and target.
  $D1F4,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D1FE,$03 Else copy the (swapped) source back to the new target and return.

N $D201 Handles copying customer state data into the state cache at #R$D48F.
@ $D201 label=Prep_Customer
  $D201,$11 Handles copying $000F bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D48F.
  $D212,$03 Call #R$D49E to begin this characters actions.
  $D215,$03 Restore the source, target and counter from above.
  $D218,$01 Swap the source and target.
  $D219,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D223,$03 Else copy the (swapped) source back to the new target and return.

N $D226 Handles copying customer "is shot" state data into the state cache at #R$D48F.
@ $D226 label=Prep_Customer_Shot
  $D226,$11 Handles copying $000F bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D48F.
  $D237,$03 Call #R$D57B.
  $D23A,$03 Restore the source, target and counter from above.
  $D23D,$01 Swap the source and target.
  $D23E,$03 Copy the (swapped) source back to the new target and return.

N $D241 Handles copying Julius state data into the state cache at #R$D8E5.
@ $D241 label=Prep_Julius_Open
  $D241,$11 Handles copying $000A bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D8E5.
  $D252,$03 Call #R$D8EF.
  $D255,$03 Restore the source, target and counter from above.
  $D258,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D262,$03 Copy the source to the target again and return.

N $D265 And copying a successful Julius encounter to close the door.
@ $D265 label=Prep_Julius_Close
  $D265,$11 Handles copying $000A bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$D8E5.
  $D276,$03 Call #R$D997.
  $D279,$03 Restore the source, target and counter from above.
  $D27C,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D286,$03 Copy the source to the target again and return.

N $D289 Handles copying a "drawing bandit" into the bandit state cache at #R$DA0C.
@ $D289 label=Prep_Bandit_Draw_Open
  $D289,$11 Handles copying $000B bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$DA0C.
  $D29A,$03 Call #R$DA17.
  $D29D,$03 Restore the source, target and counter from above.
  $D2A0,$0A Check if #R$D18F is zero. Write $00 to it. If it wasn't zero
.           then return.
  $D2AA,$03 Copy the source to the target again and return.

N $D2AD And copying a successful "drawing bandit" encounter to close the door.
@ $D2AD label=Prep_Bandit_Draw_Close
  $D2AD,$11 Handles copying $000B bytes of data from the address contained
.           at (depending on which door is currently being actioned);
. #TABLE(default,centre,centre)
. { =h Address | =h Door }
. { #R$D167 | Door 1 }
. { #R$D175 | Door 2 }
. { #R$D183 | Door 3 }
. TABLE#
.           to #R$DA0C.
  $D2BE,$03 Call #R$DA85.
  $D2C1,$03 Restore the source, target and counter from above.
  $D2C4,$08 Check if #R$D18F is zero. If it wasn't zero then return.
  $D2CC,$03 Copy the source to the target again and return.

c $D2CF 
@ $D2CF label=Controls
  $D2CF,$03 #R$CE12
  $D2D2,$04 Stash #R$D2D7 on the stack.
  $D2D6,$01 Jumps to the control routine for whatever is in-use (either #R$D392 or #R$D39B).
W $D2D7,$02

c $D2D9

B $D2FE,$01
B $D2FF,$01

g $D300 Player Shot
@ $D300 label=Hit
B $D300 #TABLE(default,centre,centre)
. { =h Value | =h What }
. { #N$00 | No shot/ inactive }
. { #N$01 | Door 1 }
. { #N$02 | Door 2 }
. { #N$03 | Door 3 }
. TABLE#

g $D301 Player Left/ Right
N $D301 These flags don't control left/ right movement they just indicate whether keys are being pressed/ joystick used.
@ $D301 label=Right
B $D301,$01 Defaults to $00, holds $01 when the player is pressing "right".
@ $D302 label=Left
B $D302,$01 Defaults to $00, holds $01 when the player is pressing "left".

g $D303 Player Shooting
@ $D303 label=Two
B $D303,$01 Defaults to $00, holds $01 when the player is pressing "2".
@ $D304 label=Three
B $D304,$01 Defaults to $00, holds $01 when the player is pressing "3".
@ $D305 label=One
B $D305,$01 Defaults to $00, holds $01 when the player is pressing "1".
@ $D306 label=Controls_Byte
B $D306,$01 Holds the controls in one byte.
. #TABLE(default,centre,centre,centre)
. { =h Value | =h Bits | Door }
. { #N$10 | #EVAL($10, 2, 8) | Door 2 }
. { #N$11 | #EVAL($11, 2, 8) | Door 3 }
. { #N$12 | #EVAL($12, 2, 8) | Door 1 }
. TABLE#

c $D307 Action Controls
N $D307 On entry #REGa will contain one of;
. #TABLE(default,centre,centre,centre)
. { =h Value | =h Bits | Door }
. { #N$10 | #EVAL($10, 2, 8) | Door 2 }
. { #N$11 | #EVAL($11, 2, 8) | Door 3 }
. { #N$12 | #EVAL($12, 2, 8) | Door 1 }
. TABLE#
. This is written to #R$D306, and then decoded into writing a $01, $02 or $03 to #R$D300 to represent which door has
. been shot at.  This routine also writes $01 to #R$D305, #R$D303 and #R$D304 to represent the same thing.
. Before returning, #REGhl is set to the screen location for displaying the shot mask/ shot image in the centre of the
. door.
@ $D307 label=Action_Controls
  $D307,$07 Writes #REGa to #R$D306 and sets #REGhl=#R$D300.
  $D30F,$04 If "3" was pressed then jump to #R$D33B (a check for if bit 0 is set).
  $D313,$04 If "1" was pressed then jump to #R$D360 (a check for if bit 1 is set).

N $D317 Handles settings flags and shot drawing location for door 2.
@ $D317 label=Shot_Two
  $D317,$05 If #R$D303 is not zero then return.
  $D31C,$06 Sets the other two door flags to zero (#R$D304 and #R$D305).
  $D322,$07 Indicate the the middle door is being shot at (write $01 to #R$D303 and $02 to #R$D300).
  $D329,$04 Increase #R$D8AC by one.
  $D32D,$04 Sets the screen location for this shot to $482F and stash it.
  $D331,$03 Draw the shot mask.
  $D334,$04 Grab the screen location again, and now draw the shot.
  $D338,$03 Jump to #R$6500.

N $D33B Handles settings flags and shot drawing location for door 3.
@ $D33B label=Shot_Three
  $D33B,$05 If #R$D304 is not zero then return.
  $D340,$06 Sets the other two door flags to zero (#R$D303 and #R$D305).
  $D346,$07 Indicate the the right door is being shot at (write $01 to #R$D304 and $03 to #R$D300).
  $D34D,$05 Shifts the value at #R$D8AC to the left with bit 7 moved to the carry flag and bit 0 reset (zeroed).
  $D352,$04 Sets the screen location for this shot to $483A and stash it.
  $D356,$03 Draw the shot mask.
  $D359,$04 Grab the screen location again, and now draw the shot.
  $D35D,$03 Jump to #R$6502.

N $D360 Handles settings flags and shot drawing location for door 1.
@ $D360 label=Shot_One
  $D360,$05 If #R$D305 is not zero then return.
  $D365,$06 Sets the other two door flags to zero (#R$D303 and #R$D304).
  $D36B,$07 Indicate the the left door is being shot at (write $01 to #R$D305 and $01 to #R$D300).
  $D372,$05 Shifts the value at #R$D8AC to the left with bit 7 moved to the carry flag and bit 0 reset (zeroed).
  $D377,$04 Sets the screen location for this shot to $4824 and stash it.
  $D37B,$03 Draw the shot mask.
  $D37E,$04 Grab the screen location again, and now draw the shot.
  $D382,$03 Jump to #R$6504.
  $D385,$01 Return.

N $D386 Sets the flag for indicating "right" has been pressed by the player.
@ $D386 label=Set_Right
  $D386,$06 Write $01 to #R$D301 and return.

N $D38C Sets the flag for indicating "left" has been pressed by the player.
@ $D38C label=Set_Left
  $D38C,$06 Write $01 to #R$D302 and return.

c $D392 Reads In-Game Joystick Controls
@ $D392 label=Controls_Joystick
  $D392,$03
  $D395,$02 #HTML(Reads input from the Kempston joystick (see <a href="../reference/pokes.html">POKES</a>)).
  $D397,$03 If there's nothing to read fall back to #R$D39B anyway.
  $D39A,$01 Return.

c $D39B Reads In-Game Keyboard Controls (1-2-3)
@ $D39B label=Controls_Keyboard
  $D39B,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
N $D39F Handle "1" being pressed.
@ $D39F label=Controls_Input_01
  $D39F,$04 If "1" isn't being pressed then jump to #R$D3A6.
  $D3A3,$03 Set #REGa=$12 and return.
N $D3A6 Handle "2" being pressed.
@ $D3A6 label=Controls_Input_02
  $D3A6,$04 If "2" isn't being pressed then jump to #R$D3AD.
  $D3AA,$03 Set #REGa=$10 and return.
N $D3AD Handle "3" being pressed.
@ $D3AD label=Controls_Input_03
  $D3AD,$04 If "3" isn't being pressed then jump to #R$D3E2.
  $D3B1,$03 Set #REGa=$11 and return.

c $D3B4 Draw Gun Shot Mask
@ $D3B4 label=Draw_GunShot_Mask
  $D3B4,$06 Point to #R$FF58 and set the image dimensions.
  $D3BA,$01 Stash the screen location.
  $D3BB,$03 Calls #R$D5FA.
  $D3BE,$02 Very short pause.
  $D3C0,$01 Grab the screen location.
  $D3C1,$06 Point to #R$FF58 and set the image dimensions.
  $D3C7,$03 Calls #R$D5FA.
  $D3CA,$01 Return.

c $D3CB Draw Gun Shot
@ $D3CB label=Draw_GunShot
  $D3CB,$06 Point to #R$FF68 and set the image dimensions.
  $D3D1,$01 Stash the screen location.
  $D3D2,$03 Calls #R$D5FA.
  $D3D5,$02 Very short pause.
  $D3D7,$01 Grab the screen location.
  $D3D8,$06 Point to #R$FF68 and set the image dimensions.
  $D3DE,$03 Calls #R$D5FA.
  $D3E1,$01 Return.

c $D3E2 Reads In-Game Controls (Left + Right)
@ $D3E2 label=Controls_Input_O_P
  $D3E2,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $DF | P | O | I | U | Y }
. TABLE#
  $D3E6,$01 Invert all the bits of #REGa.
  $D3E7,$02 Keep only bits 0 and 1 (i.e. we only care about "P" and "O" for left and right).

  $D3E9,$01 Return.

c $D3EA
@ $D3EA label=Door_Prep_01
  $D3EA,$03 #R$CE14
  $D3ED,$03 Sets #REGa=0 and #REGb=$06 (counter).
  $D3F0

g $D45C Cash Deposit Box Reference
@ $D45C label=CashboxReference_Inactive
B $D45C,$01 Holds 01-12 which refer to the deposit cash boxes (#R$CC8D onwards).
@ $D45D label=CashboxReference_Active
B $D45D,$01 Holds 01-12 which refer to the deposit cash boxes (#R$CC8D onwards).

c $D45E Highlight Active Doors
N $D45E This routine highlights the doors which are currently being displayed in the playarea.
@ $D45E label=ActiveDoors
  $D45E,$03 #REGa=#R$D45C.
  $D461,$02 #REGc=#N$38 (not highlighted).
  $D463,$03 Call #R$D46B.
  $D466,$03 #REGa=#R$D45D.
  $D469,$02 #REGc=#N$3A (highlighted).
N $D46B Sets a counter as three doors are highlighted as being "in-view".
@ $D46B label=ActiveDoors_Start
  $D46B,$02 #REGb=#N$03.
@ $D46D label=ActiveDoors_Loop
  $D46D,$01 Stash #REGaf on the stack.
  $D46E,$03 Call #R$D47E.
  $D471,$01 Restore #REGaf from the stack.
  $D472,$01 Increment #REGa by one.
  $D473,$05 If #REGa is #N$0D then call #R$D47B.
  $D478,$02 Decrease the #REGb counter by one and loop back to #R$D46D until it is zero.
  $D47A,$01 Return.
N $D47B If the active doors spill over the last door, then cycle back to the beginning.
.       For example, if door 11 is active, then it's 11, 12 and 1 which are highlighted.
@ $D47B label=ActiveDoors_SetDoorOne
  $D47B,$02 #REGa=#N$01.
  $D47D,$01 Return.
N $D47E Handles writing the attribute value held by #REGc to the screen.
@ $D47E label=ActiveDoors_Paint
  $D47E,$02 Is #REGa less than #N$07?
  $D480,$03 #REGhl=#N$5805 (left-hand side).
  $D483,$02 If #REGa was less than #N$07, jump to #R$D488.
  $D485,$03 #REGhl=#N$58FF (right-hand side).
@ $D488 label=ActiveDoors_Paint_Skip
  $D488,$03 #REGhl=#REGhl + #REGa * #N$02.
  $D48B,$03 Writes the attribute value held by #REGc to #REGhl and #REGhl + #N$01. 
.           This is because the number images are two characters wide.
  $D48E,$01 Return.

c $D48F Customer Logic
N $D48F Character state variables/ flags.
@ $D48F label=Customer_Frame_01
B $D48F,$01 Character frame index 1.
@ $D490 label=Customer_Frame_02
B $D490,$01 Character frame index 2.
@ $D491 label=Customer_Frame_03
B $D491,$01 Character frame index 3.
@ $D492 label=Customer_Frame_04
B $D492,$01 Character frame index 4.
@ $D493 label=Customer_Frame_05
B $D493,$01 Character frame index 5.
@ $D494 label=Customer_Flag_Uncover
B $D494,$01 Represents whether the customer will move to uncover a bandit
.           ($00 "normal" / $01 "uncover" action).
@ $D495 label=Customer_State_Ref
B $D495,$01 The current character state.
@ $D496 label=Customer_Timer_01
B $D496,$01 Character timer 1.
@ $D497 label=Customer_Timer_02
B $D497,$01 Character timer 2.
@ $D498 label=Customer_Timer_03
B $D498,$01 Character timer 3.
@ $D499 label=Customer_Timer_04
B $D499,$01 Character timer 4.
@ $D49A label=Customer_Timer_05
B $D49A,$01 Character timer 5.
@ $D49B label=Customer_Timer_06
B $D49B,$01 Character timer 6.
@ $D49C label=Customer_Timer_07
B $D49C,$01 Character timer 7.
@ $D49D label=Customer_Timer_08
B $D49D,$01 Character timer 8.

N $D49E This routine looks at the current character state and routes to the correct subroutine.
@ $D49E label=Customer_Routing
  $D49E,$04 #REGa=#R$D495.
  $D4A2,$1B Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D4BD }
. { #N$02 | #R$D4CD }
. { #N$03 | #R$D4DD }
. { #N$04 | #R$D4ED }
. { #N$05 | #R$D524 }
. { #N$06 | #R$D540 }
. { #N$07 | #R$D559 }
. { #N$08 | #R$D56C }
. TABLE#

N $D4BD Handle door frame 1 countdown/ transition to door frame 2.
@ $D4BD label=Customer_Open_01
  $D4BD,$08 Decrease #R$D496 by one, return if result is not zero.
  $D4C5,$01 Move onto next character state.
  $D4C6,$03 Grab the character frame index from #R$D48F.
  $D4C9,$04 Call #R$D6D1 and return.

N $D4CD Handle door frame 2 countdown/ transition to door frame 3.
@ $D4CD label=Customer_Open_02
  $D4CD,$08 Decrease #R$D497 by one, return if result is not zero.
  $D4D5,$01 Move onto next character state.
  $D4D6,$03 Grab the character frame index from #R$D48F.
  $D4D9,$04 Call #R$D6DF and return.

N $D4DD Handle door frame 3 countdown/ transition to door frame 4.
@ $D4DD label=Customer_Open_03
  $D4DD,$08 Decrease #R$D498 by one, return if result is not zero.
  $D4E5,$01 Move onto next character state.
  $D4E6,$03 Grab the character frame index from #R$D48F.
  $D4E9,$04 Call #R$D6ED and return.

N $D4ED Handle door frame 4 timer...
@ $D4ED label=Customer_Open_04
  $D4ED,$06 Calls #R$D5A3 with #REGde=#R$CF91.
  $D4F3,$08 Decrease #R$D499 by one, return if result is not zero.
  $D4FB,$06 Jump to #R$D516 if #R$D494 is not zero.
  $D501,$02 Set #R$D495 to use state $07 (#R$D559 on the next call to #R$D49E).
  $D503,$06 Call #R$D6DF using the character frame index from #R$D48F.
  $D509,$04 Issue 500 points (by writing $05 to the high order byte of, e.g. #R$D16B).
  $D50D,$05 Register this as a deposit (by writing $01 to e.g. #R$D16D).
  $D512,$03 Writes $01 to #R$D190.
  $D515,$01 Return.

N $D516 Handle customer putting their hands up.
@ $D516 label=Customer_HandsUp
  $D516,$07 Increase #R$D495 by one.
  $D51D,$03 Grab the character frame index from #R$D490.
  $D520,$04 Call #R$D6ED and return.

N $D524 Handles customer uncovering a "hidden" bandit action.
@ $D524 label=Customer_Uncover
  $D524,$06 Calls #R$D5A3 with #REGde=#R$CF91.
  $D52A,$08 Decrease #R$D49A by one, return if result is not zero.
  $D532,$07 Increase #R$D495 by one.
  $D539,$03 Grab the character frame index from #R$D491.
  $D53C,$04 Call #R$D6ED and return.

N $D540 Handle door frame 4 countdown/ transition to door frame 3.
@ $D540 label=Customer_Close_03
  $D540,$08 Decrease #R$D49B by one, return if result is not zero.
  $D548,$03 Call #R$CEB8.
  $D54B,$08 Load, e.g. #R$D167 (bandit source data) into #REGhl, and
.           write $03 to the address contained in it.
  $D553,$05 Increase the pointer to the bandit source data by 3 and
.           write $04 to this byte.
  $D558,$01 Return.

N $D559 Handle door frame 3 countdown/ transition to door frame 2.
@ $D559 label=Customer_Close_02
  $D559,$08 Decrease #R$D49C by one, return if result is not zero.
  $D561,$04 Increase #R$D495 by one.
  $D565,$03 Grab the character frame index from #R$D48F.
  $D568,$04 Call #R$D6D1 and return.

N $D56C Handle door frame 2 countdown/ transition to door frame 1.
@ $D56C label=Customer_Close_01
  $D56C,$08 Decrease #R$D49D by one, return if result is not zero.
  $D574,$03 Call #R$D664 (i.e. no character/ door is shut).
  $D577,$04 Call #R$D8A1 and return.

N $D57B Handles customer being shot.
@ $D57B label=Customer_Shot
  $D57B,$09 If #R$D495 is zero then jump to #R$D584 else jump to #R$D58C.
@ $D584 label=Customer_Shot_MidAir
  $D584,$01 Move onto next character state.
  $D585,$03 Grab the character frame index from #R$D492.
  $D588,$04 Call #R$D6ED and return.
@ $D58C label=Customer_Shot_Floor
  $D58C,$08 Decrease #R$D497 by one, return if result is not zero.
  $D594,$03 Grab the character frame index from #R$D493.
  $D597,$03 Call #R$D6ED.
  $D59A,$05 Writes $02 to #R$D2FE.
  $D59F,$04 Call #R$D8A1 and return.

c $D5A3 Hit Detection
D $D5A3 Compares the #R$CE1A against the user input for a shot.
.       If there isn't a shot to account for then we simply return,
.       else we action a jump to the address held in #REGde on entry.
@ $D5A3 label=Hit_Detection
  $D5A3,$01 Store #REGhl on the stack for later.
  $D5A4,$07 Does a comparison of #R$D300 against #R$CE1A.
  $D5AB,$02 #HTML(Retrieve #REGhl off the stack and return if the numbers compared were <em>NOT</em> the same.)
  $D5AD,$01 Restores the character state to #REGa.
  $D5AE,$02 Jumps to the address held in #REGde on entry (with #REGde now containing the original #REGhl address).

c $D5B0 Character Index
@ $D5B0 label=Character_Address
D $D5B0 Returns the 16 bit memory location of a character from a given character index in #REGa.
  $D5B0,$19 Using #R$6800 as a base address (which is the first character), this works out the character frame from a
.           given index passed in #REGa. To give an example with $1A;
. #LIST
. { #HTML(Loads <strong>$1A</strong> as the low-order byte; #REGhl=$001A) }
. { #HTML(Times by <strong>$200</strong>; store this in #REGde=$3400) }
. { #HTML(Loads <strong>$1A</strong> as the low-order byte; #REGhl=$001A) }
. { #HTML(Times by <strong>$10</strong>; #REGhl=$1A0) }
. { #REGhl+#REGde=$35A0 }
. { #HTML(Add <strong>$6800</strong>=#R$9DA0) }
. LIST#
  $D5C9 Returns the address in #REGhl.

c $D5CA Draw Character In Doorway
D $D5CA Draws the character frame at the location of one of the three (open) doors. This is direct function, hence is
.       only used when the door is open (it doesn't utilise the door buffer).
@ $D5CA label=Draw_CharacterInDoorway
  $D5CA,$03 Retrieve the memory location for the character frame from the passed index in #REGa.
  $D5CE,$04 Sets the height and width.
  $D5D2,$03 Retrieves the currently in-focus door from #R$CE1A.
  $D5D5,$11 Work out which screen position to use for the currently focused door;
. #TABLE(default,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $4082 }
. { #N$02 | $408D }
. { #N$03 | $4098 }
. TABLE#
. Jump to #R$D5E6 to draw the character and handle the return.

c $D5E6 Copy Routine
@ $D5E6 label=Copy_Routine
N $D5E6 This routine copies bytes from #REGde TO #REGhl and uses the #REGbc register to track the number of bytes
.       and the number of lines.
  $D5E6,$07 Copies bytes from #REGde TO #REGhl x #REGc number of times.
  $D5ED,$02 Restores #REGhl with the original screen buffer location.
  $D5EF,$07 ggg
  $D5F6,$03 Grabs #REGb and decreases it by one. Loop back round to #R$D5E6 if #REGb is not zero.
  $D5F9,$01 Return.

c $D5FA Merge Gun Shot Onto Background
@ $D5FA label=Merge_Shot
  $D5FA,$02 Store #REGbc and #REGhl for later.
@ $D5FC label=Merge_Shot_Loop
  $D5FC,$01 Loads the contents of the source address held in #REGde.
  $D5FD,$01 Performs a bit-by-bit XOR comparison against the contents of the destination address held by #REGhl.
. #TABLE(default,centre,centre,centre)
. { =h #REGa register bit | =h Comparison bit | =h #REGa bit set to }
. { 0 | 0 | 0 }
. { 0 | 1 | 1 }
. { 1 | 0 | 1 }
. { 1 | 1 | 0 }
. TABLE#
  $D5FE,$01 Stores the result at the destination address.
  $D5FF,$05 Increase the source and destination addresses by one, decrease the counter by one. Loop back to #R$D5FC
.           until the #REGc counter is zero.
  $D604,$01 Restore #REGhl with the original destination address.
  $D605,$07 Increase the high-order byte of #REGhl by one, if this is on a screen third boundary (@todo what's the term for this?) then call #R$D610.
  $D60C,$03 Decrease the #REGb counter by one and loop back to #R$D5FA until it is zero.
  $D60F,$01 Return.

c $D610
@ $D610 label=Calc_Attribute
N $D610 On entry #REGhl points to an address in the screen attribute buffer.
  $D610 Let's use $58C8 as an example;
. #LIST
. { #REGa=$58 }
. { Subtract $08 = #REGa=$50 }
. { Write it into #REGhl=$50C8 }
. { #REGa=$C8 }
. { Add $20 = #REGa=$E8 }
. { Write it into #REGhl=$50E8 }
. LIST#
  $D61D,$01 Return.

c $D61E Write Character And Door To Buffer
@ $D61E label=Character_Door_Frame_02
D $D61E Door frames 2 and 3 both contain a "section" of a game character. This is copied into a buffer by first drawing
.       the game character fully to #R$EA90. Then the door frame is drawn over the top (in the correct position).
N $D61E Draws the game character together with door frame 2.
  $D61E,$06 On entry #REGa points to a character index. The call to #R$D5B0 translates this to the memory location of
.           the character frame data (held in #REGhl) and then calls #R$D654.
  $D624,$13 Copies #R$BCE8 into the #R$EA90 (+2 bytes ~ $EA92).
@ $D624 label=Door_Frame_02_Copy
@ $D62C label=Door_Frame_02_Copy_Loop
  $D637,$01 Return.

N $D638 Draws the game character together with door frame 3.
@ $D638 label=Character_Door_Frame_03
  $D638,$06 On entry #REGa points to a character index. The call to #R$D5B0 translates this to the memory location of
.           the character frame data (held in #REGhl) and then calls #R$D654.
  $D63E,$15 Copies #R$BEA0 into the #R$EA90 (+4 bytes ~ $EA94).
@ $D63E label=Door_Frame_03_Copy
@ $D646 label=Door_Frame_03_Copy_Loop
  $D653,$01 Return.

N $D654 Draws the game character alone to the door frame buffer.
  $D654,$10 Draws a character into the #R$EA90.
@ $D654 label=Door_Buffer_Copy
@ $D659 label=Door_Buffer_Copy_Loop

c $D664 Draw Doors
N $D664 Preps door frame 1.
@ $D664 label=Draw_DoorFrame1
  $D664,$06 Calls #R$D684 using #R$D6B1.
  $D66A,$03 #REGde=#R$BA80.
N $D66D Referencing the door frame index, work out the screen position and send it to the #R$D717 routine.
  $D66D,$03 #REGa=#R$CE1A.
@ $D66D label=Prep_Door_Frame
  $D670,$14 Determines which screen address to use for the door reference index currently held in #REGa.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $4082 }
. { #N$02 | $408D }
. { #N$03 | $4098 }
. TABLE#
. Jump to #R$D717.

N $D684 Copies attributes for the current door frame index.
@ $D684 label=Door_Attributes
  $D684,$01 Stash the accumulator for later.
  $D685,$03 #REGa=#R$CE1A.
  $D688,$0F
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $5882 }
. { #N$02 | $588D }
. { #N$03 | $5898 }
. TABLE#
. ...continue from #R$D697.
@ $D697 label=Door_Attributes_Skip
  $D697,$02 Sets the height of the door image.
@ $D699 label=Door_Attributes_Loop
  $D699,$06 Stash the references for later and call #R$D6AB.
  $D69F,$06 Moves the screen attribute address down to the next attribute row.
  $D6A5,$04 Restore the counter and loop back to #R$D699 until complete.
  $D6A9,$02 Restore the accumulator and return.

N $D6AB Simple helper copy routine for sending attribute data to the screen attribute buffer.
@ $D6AB label=Door_Attributes_Copy
  $D6AB,$06 Set the door width, copy the attribute data to the screen and return.

N $D6B1 Door frame attribute data.
@ $D6B1 label=Door_Attributes_01
B $D6B1,$08 Attribute data for door frame 1.
@ $D6B9 label=Door_Attributes_02
B $D6B9,$08 Attribute data for door frame 2.
@ $D6C1 label=Door_Attributes_03
B $D6C1,$08 Attribute data for door frame 3.
@ $D6C9 label=Door_Attributes_04
B $D6C9,$08 Attribute data for door frame 4.

N $D6D1 Preps door frame 2.
  $D6D1,$06 Calls #R$D684 using #R$D6B9.
@ $D6D1 label=Draw_DoorFrame02
  $D6D7,$08 Prepare the character/ door image by calling #R$D61E. Then pass #R$EA90 to #R$D66D which will draw it to the
.           screen.

N $D6DF Preps door frame 3.
  $D6DF,$06 Calls #R$D684 using #R$D6C1.
@ $D6DF label=Draw_DoorFrame03
  $D6E5,$08 Prepare the character/ door image by calling #R$D638. Then pass #R$EA90 to #R$D66D which will draw it to the
.           screen.

N $D6ED Preps door frame 4.
  $D6ED,$06 Calls #R$D684 using #R$D6C9.
@ $D6ED label=Draw_DoorFrame04
  $D6F3,$03 The door is fully open so draw the whole character in the doorway directly.
  $D6F6,$07 Reference #R$BFA8 and the dimensions for the copy routine.
  $D6FD,$03 #REGa=#R$CE1A.
  $D700,$14 Determines which screen address to use for the door reference index currently held in #REGa.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Screen Address }
. { #N$01 | $4088 }
. { #N$02 | $4093 }
. { #N$03 | $409E }
. TABLE#
. Jump to #R$D5E6.
  $D714,$03 #REGde=#R$EA90.
@ $D717 label=Draw_DoorFrame
  $D717,$07 Draws the image pointed at by #REGde to the screen address in #REGhl using #R$D5E6.

c $D71E Generic Bandit in Door Frame Logic
N $D71E Character state variables/ flags.
@ $D71E label=Bandit_State_Reference
B $D71E,$01 The current character state.
@ $D71F label=Bandit_Timer_01
B $D71F,$01 Character timer 1.
@ $D720 label=Bandit_Timer_02
B $D720,$01 Character timer 2.
@ $D721 label=Bandit_Timer_03
B $D721,$01 Character timer 3.
@ $D722 label=Bandit_Timer_04
B $D722,$01 Character timer 4.
;@ $D723 label=Bandit_5
B $D723,$01
;@ $D724 label=Bandit_6
B $D724,$01

N $D725 This routine looks at the current character state and routes to the correct subroutine.
@ $D725 label=Bandit_Open_Routing
  $D725,$04 #REGa=#R$D71E.
  $D729,$0B Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D734 }
. { #N$02 | #R$D741 }
. { #N$03 | #R$D74E }
. { #N$04 | #R$D75B }
. TABLE#

N $D734 Handle door frame 1 countdown/ transition to door frame 2.
@ $D734 label=Bandit_Open_01
  $D734,$08 Decrease #R$D71F by one, return if result is not zero.
  $D73C,$01 Move onto next character state.
  $D73D,$04 Pass character frame index (#R$6800(draw | #N$00)) to #R$D6D1 and return.

N $D741 Handle door frame 2 countdown/ transition to door frame 3.
@ $D741 label=Bandit_Open_02
  $D741,$08 Decrease #R$D720 by one, return if result is not zero.
  $D749,$01 Move onto next character state.
  $D74A,$04 Pass character frame index (#R$6800(draw | #N$00)) to #R$D6DF and return.

N $D74E Handle door frame 3 countdown/ transition to door frame 4.
@ $D74E label=Bandit_Open_03
  $D74E,$08 Decrease #R$D721 by one, return if result is not zero.
  $D756,$01 Move onto next character state.
  $D757,$04 Pass character frame index (#R$6800(draw | #N$00)) to #R$D6ED and return.

N $D75B Handle door frame 4 timer...
@ $D75B label=Bandit_Open_04
  $D75B,$06 Calls #R$D5A3 with #REGde=$CED8.
  $D761,$08 Decrease #R$D722 by one, return if result is not zero.
  $D769,$04 Writes $01 to #R$D2FE.
  $D76D,$03 Call #R$D8A1.
  $D770,$01 Return.

N $D771 This routine looks at the current character state and routes to the correct subroutine.
@ $D771 label=Bandit_Close_Routing
  $D771,$04 #REGa=#R$D71E.
  $D775,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D783 }
. { #N$02 | #R$D789 }
. { #N$03 | #R$D798 }
. { #N$04 | #R$D7A7 }
. { #N$05 | #R$D7B6 }
. TABLE#

N $D783 Handles the transition to the (#R$6A10(shot | #N$01)) frame in the open doorway.
@ $D783 label=Bandit_Shot_Action
  $D783,$01 Move onto next character state.
  $D784,$01 Move onto next character frame (i.e. #R$6A10(shot | #N$01)).
  $D785,$04 Call #R$D6ED and return.

N $D789 Handle "floor frame in open doorway" countdown.
@ $D789 label=Bandit_Close_04
  $D789,$08 Decrease #R$D71F by one, return if result is not zero.
  $D791,$01 Move onto next character state.
  $D792,$06 Pass character frame index (#R$6C20(floor | #N$02)) to #R$D6ED and return.

N $D798 Handle door frame 4 countdown/ transition to door frame 3.
@ $D798 label=Bandit_Close_03
  $D798,$08 Decrease #R$D720 by one, return if result is not zero.
  $D7A0,$01 Move onto next character state.
  $D7A1,$06 Pass character frame index (#R$6C20(floor | #N$02)), pass it to #R$D6DF and return.

N $D7A7 Handle door frame 3 countdown/ transition to door frame 2.
@ $D7A7 label=Bandit_Close_02
  $D7A7,$08 Decrease #R$D721 by one, return if result is not zero.
  $D7AF,$01 Move onto next character state.
  $D7B0,$06 Pass character frame index (#R$6C20(floor | #N$02)), pass it to #R$D6D1 and return.

N $D7B6 Handle door frame 2 countdown/ transition to door frame 1.
@ $D7B6 label=Bandit_Close_01
  $D7B6,$08 Decrease #R$D722 by one, return if result is not zero.
  $D7BE,$03 Call #R$D664 (i.e. no character/ door is shut).
  $D7C1,$03 Call #R$D8A1.
  $D7C4,$01 Return.

c $D7C5 Bowie logic
D $D7C5 Handles all the logic around drawing Bowie and handling his "special" logic.
N $D7C5 Bowie state variables/ flags.
@ $D7C5 label=Bowie_Good_Bad
B $D7C5,$01 If this is $00 then Bowie is "good". If this is $01 then he is "bad" (i.e. there's a bomb under his hat).
@ $D7C6 label=Bowie_Frame_Reference
B $D7C6,$01 The current character frame index reference.
@ $D7C7 label=Bowie_State_Reference
B $D7C7,$01 The current character state.
@ $D7C8 label=Bowie_Timer_01
B $D7C8,$01 Character timer 1.
@ $D7C9 label=Bowie_Timer_02
B $D7C9,$01 Character timer 2.
@ $D7CA label=Bowie_Timer_03
B $D7CA,$01 Character timer 3.
@ $D7CB label=Bowie_Timer_04
B $D7CB,$01 Character timer 4.
@ $D7CC label=Bowie_Timer_05
B $D7CC,$01 Character timer 5.
@ $D7CD label=Bowie_Timer_06
B $D7CD,$01 Character timer 6.

N $D7CE This routine looks at the current character state and routes to the correct subroutine.
@ $D7CE label=Bowie_Routing
  $D7CE,$04 #REGa=#R$D7C7.
  $D7D2,$11 Work out which routine to jump to based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D7E3 }
. { #N$02 | #R$D7F2 }
. { #N$03 | #R$D801 }
. { #N$04 | #R$D810 }
. { #N$05 | #R$D82C }
. { #N$06 | #R$D83C }
. TABLE#

N $D7E3 Handle door frame 1 countdown/ transition to door frame 2.
@ $D7E3 label=Bowie_Open_01
  $D7E3,$08 Decrease #R$D7C8 by one, return if result is not zero.
  $D7EB,$01 Move onto next character state.
  $D7EC,$06 Pass character index #R$9FB0($1B) to #R$D6D1 and return.

N $D7F2 Handle door frame 2 countdown/ transition to door frame 3.
@ $D7F2 label=Bowie_Open_02
  $D7F2,$08 Decrease #R$D7C9 by one, return if result is not zero.
  $D7FA,$01 Move onto next character state.
  $D7FB,$06 Pass character index #R$9FB0($1B) to #R$D6DF and return.

N $D801 Handle door frame 3 countdown/ transition to door frame 4.
@ $D801 label=Bowie_Open_03
  $D801,$08 Decrease #R$D7CA by one, return if result is not zero.
  $D809,$01 Move onto next character state.
  $D80A,$06 Pass character frame index #R$9FB0($1B) to #R$D6ED and return.

N $D810 Handle door frame 4 countdown/ transition to door frame 3.
@ $D810 label=Bowie_Open_04
  $D810,$09 Call #R$D5A3 with a callback to either #R$D84B or #R$D85D.
  $D819,$08 Decrease #R$D7CB by one, return if result is not zero.
@ $D821 label=Bowie_Close_03
  $D821,$04 Move onto next character state (#R$D7C7).
  $D825,$07 Load the character frame index from #R$D7C6, pass it to #R$D6DF and return.

N $D82C Handle door frame 3 countdown/ transition to door frame 2.
@ $D82C label=Bowie_Close_02
  $D82C,$08 Decrease #R$D7CC by one, return if result is not zero.
  $D834,$01 Move onto next character state.
  $D835,$07 Load the character frame index from #R$D7C6, pass it to #R$D6D1 and return.

N $D83C Handle door frame 2 countdown/ transition to door frame 1.
@ $D83C label=Bowie_Close_01
  $D83C,$08 Decrease #R$D7CD by one, return if result is not zero.
  $D844,$03 Call #R$D664 (i.e. no character/ door is shut).
  $D847,$03 Call #R$D8A1.
  $D84A,$01 Return.

N $D84B Handles marking this as something shootable.
@ $D84B label=Bowie_Cash_Action
  $D84B,$08 Writes $05 to #REGix+$06 and $01 to #REGix+$07.
  $D853,$08 Writes $01 to #REGix+$08 and #R$D190.
  $D85B,$02 Jump to #R$D821.

N $D85D Handles marking this as something unshootable.
@ $D85D label=Bowie_Bomb_Action
  $D85D,$06 Writes $05 to #R$D2FE and return.

N $D863 Handles both shooting the hats off Bowie's head, and checking/ routing on the last frame for the "surprise".
@ $D863 label=Bowie_Shot_Action
  $D863,$04 #REGa=#R$D7C6.
  $D867,$02 Is it character frame reference (#R$AC10(1 hat | #N$21))?
  $D869,$04 Writes $01 to #REGix+$06.
  $D86D,$02 If Bowie is on the last frame then jump forward to #R$D875.
  $D86F,$06 Else update #R$D7C6 to point at the next frame, call #R$D6ED and return.

N $D875 Checks the "good/ bad" flag and routes the gameplay accordingly.
@ $D875 label=Bowie_Check
  $D875,$06 If #R$D7C5 is zero jump to #R$D87D.
  $D87B,$02 Jump to #R$D88F.

N $D87D Handle displaying cash character frame.
@ $D87D label=Bowie_State_Cash
  $D87D,$08 Writes character frame reference #R$B030(cash | #N$23) to #R$D7C6, and pass it to #R$D6ED.
  $D885,$09 Writes #R$D84B to the current door flags (e.g. #R$D169, #R$D177 or #R$D185).
  $D88E,$01 Return.

N $D88F Handle displaying bomb character frame.
@ $D88F label=Bowie_State_Bomb
  $D88F,$08 Writes character frame reference #R$AE20(bomb | #N$22) to #R$D7C6, and pass it to #R$D6ED.
  $D897,$09 Writes #R$D85D to the current door flags (e.g. #R$D169, #R$D177 or #R$D185).
  $D8A0,$01 Return.

c $D8A1
@ $D8A1 label=Reset___
  $D8A1,$0A Blanks the 16 bit address pointed to by one of the passed door flags (i.e. writes $0000 to one of #R$CE14, #R$CE16, #R$CE18).
  $D8AB,$01 Return.

g $D8AC
W $D8AC,$02
g $D8AE
W $D8AE,$02

c $D8B0
@ $D8B0 label=Random_Number
N $D8B0 f
  $D8B0,$02 Stashes #REGbc and #REGhl for later.
  $D8B2,$07 Decrease #R$D8AE by one.
  $D8B9,$02 If the result is not zero jump to #R$D8C8.
@ $D8C8 label=Random_Number_01
@ $D8D7 label=Random_Number_02

c $D8E5 Julius logic
N $D8E5 Handles all the logic around drawing Julius and handling his "special" logic.
@ $D8E5 label=Julius_Good_Bad
B $D8E5,$01 If this is $00 then Julius is "good". If this is $01 then he is "bad" (i.e. will draw on you).
B $D8E6,$01
@ $D8E7 label=Julius_State_Reference
B $D8E7,$01 The current character state.
@ $D8E8 label=Julius_Timer_01
B $D8E8,$01 Character timer 1.
@ $D8E9 label=Julius_Timer_02
B $D8E9,$01 Character timer 2.
@ $D8EA label=Julius_Timer_03
B $D8EA,$01 Character timer 3.
@ $D8EB label=Julius_Timer_04
B $D8EB,$01 Character timer 4.
@ $D8EC label=Julius_Timer_05
B $D8EC,$01 Character timer 5.
@ $D8ED label=Julius_Timer_06
B $D8ED,$01 Character timer 6.
@ $D8EE label=Julius_Timer_07
B $D8EE,$01 Character timer 7.

N $D8EF This routine looks at the current character state and routes to the correct subroutine.
@ $D8EF label=Julius_Open_Routing
  $D8EF,$04 #REGa=#R$D8E7.
  $D8F3,$14 Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D907 }
. { #N$02 | #R$D916 }
. { #N$03 | #R$D925 }
. { #N$04 | #R$D934 }
. { #N$05 | #R$D963 }
. { #N$06 | #R$D972 }
. { #N$07 | #R$D981 }
. TABLE#

N $D907 Handle door frame 1 countdown/ transition to door frame 2.
@ $D907 label=Julius_Open_01
  $D907,$08 Decrease #R$D8E8 by one, return if result is not zero.
  $D90F,$01 Move onto next character state.
  $D910,$06 Pass character index (#R$B240(stand off | #N$24)) to #R$D6D1 and return.

N $D916 Handle door frame 2 countdown/ transition to door frame 3.
@ $D916 label=Julius_Open_02
  $D916,$08 Decrease #R$D8E9 by one, return if result is not zero.
  $D91E,$01 Move onto next character state.
  $D91F,$06 Pass character index (#R$B240(stand off | #N$24)) to #R$D6DF and return.

N $D925 Handle door frame 3 countdown/ transition to door frame 4.
@ $D925 label=Julius_Open_03
  $D925,$08 Decrease #R$D8EA by one, return if result is not zero.
  $D92D,$01 Move onto next character state.
  $D92E,$06 Pass character index (#R$B240(stand off | #N$24)) to #R$D6ED and return.

N $D934 Handle door frame 4 countdown.
@ $D934 label=Julius_Open_04
  $D934,$06 Call #R$D5A3 with a callback to #R$CFDD.
  $D93A,$08 Decrease #R$D8EB by one, return if result is not zero.
  $D942,$01 Move onto next character state.
  $D943,$06 Jump to #R$D951 if #R$D8E5 is zero (Julius is "good").
N $D949 Changes the frame to show Julius drawing his pistol.
  $D949,$02 Writes "07" to #R$D8E7.
  $D94B,$06 Pass character index (#R$B450(draw | #N$25)) to #R$D6ED and return.
N $D951 Set up (and begin) closing the door.
@ $D951 label=Julius_State_04_Close
  $D951,$05 Pass character index (#R$B240(stand off | #N$24)) to #R$D6DF.
  $D956,$0D Writes $01 to #R$D190 and #REGix+8. Writes $05 to #REGix+6 and return.

N $D963 Handle door frame 3 countdown/ transition to door frame 2.
@ $D963 label=Julius_Open_05
  $D963,$08 Decrease #R$D8EC by one, return if result is not zero.
  $D96B,$01 Move onto next character state.
  $D96C,$06 Pass character index (#R$B240(stand off | #N$24)) to #R$D6D1 and return.

N $D972 Handle door frame 2 countdown/ transition to door frame 1.
@ $D972 label=Julius_Open_06
  $D972,$08 Decrease #R$D8ED by one, return if result is not zero.
  $D97A,$03 Call #R$D664 (i.e. no character/ door is shut).
  $D97D,$03 Call #R$D8A1.
  $D980,$01 Return.

N $D981 ???
@ $D981 label=Julius_Open_07
  $D981,$06 Call #R$D5A3 with a callback to #R$CFE2.
  $D987,$08 Decrease #R$D8EE by one, return if result is not zero.
  $D98F,$01 Move onto next character state.
  $D990 Write $01 to #R$D2FE.
  $D993,$03 Call #R$D8A1.
  $D996,$01 Return.

N $D997 This routine looks at the current character state and routes to the correct subroutine.
@ $D997 label=Julius_Close_Routing
  $D997,$04 #REGa=#R$D8E7.
  $D99B,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$D9A9 }
. { #N$02 | #R$D9B8 }
. { #N$03 | #R$D9D3 }
. { #N$04 | #R$D9E2 }
. { #N$05 | #R$D9F1 }
. TABLE#

N $D9A9 Handles state countdown/ transition to character frame #R$B660($26).
@ $D9A9 label=Julius_Close_01
  $D9A9,$08 Decrease #R$D8E8 by one, return if result is not zero.
  $D9B1,$01 Move onto next character state.
  $D9B2,$06 Pass character index #R$B660(shot | #N$26) to #R$D6ED and return.

N $D9B8 Handles state countdown/ transition to character frame #R$B870($27).
@ $D9B8 label=Julius_Close_02
  $D9B8,$08 Decrease #R$D8E9 by one, return if result is not zero.
  $D9C0,$01 Move onto next character state.
  $D9C1,$05 Pass character index #R$B870(floor | #N$27) to #R$D6ED.
  $D9C6,$05 Return if #R$D8E6 is zero.
  $D9CB,$08 Else write #R$D8E6+1 to #R$D2FE, call #R$D8A1 and return.

N $D9D3 Handle door frame 4 countdown/ transition to door frame 3.
@ $D9D3 label=Julius_Close_03
  $D9D3,$08 Decrease #R$D8EA by one, return if result is not zero.
  $D9DB,$01 Move onto next character state.
  $D9DC,$06 Pass character index #R$B870(floor | #N$27) to #R$D6DF and return.

N $D9E2 Handle door frame 3 countdown/ transition to door frame 2.
@ $D9E2 label=Julius_Close_04
  $D9E2,$08 Decrease #R$D8EB by one, return if result is not zero.
  $D9EA,$01 Move onto next character state.
  $D9EB,$06 Pass character index #R$B870(floor | #N$27) to #R$D6D1 and return.

N $D9F1 Handle door frame 2 countdown/ transition to door frame 1.
@ $D9F1 label=Julius_Close_05
  $D9F1,$08 Decrease #R$D8EC by one, return if result is not zero.
  $D9F9,$03 Call #R$D664 (i.e. no character/ door is shut).
  $D9FC,$03 Call #R$D8A1.
  $D9FF,$0D Writes $01 to #R$D190 and #REGix+8. Writes $05 to #REGix+6 and return.

c $DA0C Drawing Bandit Logic
N $DA0C Character state variables/ flags.
@ $DA0C label=Bandit_Draw
B $DA0C,$01
@ $DA0D label=Bandit_Draw_Frame_01
B $DA0D,$01 Character frame index 1.
@ $DA0E label=Bandit_Draw_Frame_02
B $DA0E,$01 Character frame index 2.
@ $DA0F label=Bandit_Draw_Frame_03
B $DA0F,$01 Character frame index 3.
@ $DA10 label=Bandit_Draw_Frame_04
B $DA10,$01 Character frame index 4.
@ $DA11 label=Bandit_Draw_State_Reference
B $DA11,$01 The current character state.
@ $DA12 label=Bandit_Draw_Timer_01
B $DA12,$01 Character timer 1.
@ $DA13 label=Bandit_Draw_Timer_02
B $DA13,$01 Character timer 2.
@ $DA14 label=Bandit_Draw_Timer_03
B $DA14,$01 Character timer 3.
@ $DA15 label=Bandit_Draw_Timer_04
B $DA15,$01 Character timer 4.
@ $DA16 label=Bandit_Draw_Timer_05
B $DA16,$01 Character timer 5.

N $DA17 This routine looks at the current character state and routes to the correct subroutine.
@ $DA17 label=Bandit_Draw_Open_Routing
  $DA17,$04 #REGa=#R$DA11.
  $DA1B,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$DA29 }
. { #N$02 | #R$DA39 }
. { #N$03 | #R$DA49 }
. { #N$04 | #R$DA59 }
. { #N$05 | #R$DA6F }
. TABLE#

N $DA29 Handle door frame 1 countdown/ transition to door frame 2.
@ $DA29 label=Bandit_Draw_Open_01
  $DA29,$08 Decrease #R$DA12 by one, return if result is not zero.
  $DA31,$01 Move onto next character state.
  $DA32,$03 Grab the character frame index from #R$DA0D.
  $DA35,$04 Call #R$D6D1 and return.

N $DA39 Handle door frame 2 countdown/ transition to door frame 3.
@ $DA39 label=Bandit_Draw_Open_02
  $DA39,$08 Decrease #R$DA13 by one, return if result is not zero.
  $DA41,$01 Move onto next character state.
  $DA42,$03 Grab the character frame index from #R$DA0D.
  $DA45,$04 Call #R$D6DF and return.

N $DA49 Handle door frame 3 countdown/ transition to door frame 4.
@ $DA49 label=Bandit_Draw_Open_03
  $DA49,$08 Decrease #R$DA14 by one, return if result is not zero.
  $DA51,$01 Move onto next character state.
  $DA52,$03 Grab the character frame index from #R$DA0D.
  $DA55,$04 Call #R$D6ED and return.

N $DA59 Handles state countdown.
@ $DA59 label=Bandit_Draw_Open_04
  $DA59,$06 Call #R$D5A3 with a callback to #R$D037.
  $DA5F,$08 Decrease #R$DA15 by one, return if result is not zero.
  $DA67,$01 Move onto next character state.
  $DA68,$03 Grab the character frame index from #R$DA0E.
  $DA6B,$04 Call #R$D6ED and return.

N $DA6F Handles state countdown.
@ $DA6F label=Bandit_Draw_Open_05
  $DA6F,$06 Call #R$D5A3 with a callback to #R$D040.
  $DA75,$08 Decrease #R$DA16 by one, return if result is not zero.
  $DA7D,$08 Else write $01 to #R$D2FE, call #R$D8A1 and return.

N $DA85 This routine looks at the current character state and routes to the correct subroutine.
@ $DA85 label=Bandit_Draw_Close_Routing
  $DA85,$04 #REGa=#R$DA11.
  $DA89,$0E Work out which routine to use based on the current state.
. #TABLE(default,centre,centre)
. { =h #REGa | =h Routine }
. { #N$01 | #R$DA97 }
. { #N$02 | #R$DAA7 }
. { #N$03 | #R$DAC0 }
. { #N$04 | #R$DAD0 }
. { #N$05 | #R$DAE0 }
. TABLE#

N $DA97 Handles state countdown.
@ $DA97 label=Bandit_Draw_Close_01
  $DA97,$08 Decrease #R$DA12 by one, return if result is not zero.
  $DA9F,$01 Move onto next character state.
  $DAA0,$03 Grab the character frame index from #R$DA0F.
  $DAA3,$04 Call #R$D6ED and return.

N $DAA7 Handles state countdown.
@ $DAA7 label=Bandit_Draw_Close_02
  $DAA7,$08 Decrease #R$DA13 by one, return if result is not zero.
  $DAAF,$01 Move onto next character state.
  $DAB0,$03 Grab the character frame index from #R$DA10.
  $DAB3,$03 Call #R$D6ED.
  $DAB6,$05 Return if #R$DA0C is zero.
  $DABB,$05 Else write $01 to #R$D2FE and return.

N $DAC0 Handle door frame 4 countdown/ transition to door frame 3.
@ $DAC0 label=Bandit_Draw_Close_03
  $DAC0,$08 Decrease #R$DA14 by one, return if result is not zero.
  $DAC8,$01 Move onto next character state.
  $DAC9,$03 Grab the character frame index from #R$DA10.
  $DACC,$04 Call #R$D6DF and return.

N $DAD0 Handle door frame 3 countdown/ transition to door frame 2.
@ $DAD0 label=Bandit_Draw_Close_04
  $DAD0,$08 Decrease #R$DA15 by one, return if result is not zero.
  $DAD8,$01 Move onto next character state.
  $DAD9,$03 Grab the character frame index from #R$DA10.
  $DADC,$04 Call #R$D6D1 and return.

N $DAE0 Handle door frame 2 countdown/ transition to door frame 1.
@ $DAE0 label=Bandit_Draw_Close_05
  $DAE0,$08 Decrease #R$DA16 by one, return if result is not zero.
  $DAE8,$03 Call #R$D664 (i.e. no character/ door is shut).
  $DAEB,$04 Call #R$D8A1 and return.

c $DAEF

b $DAFE

b $DFA0 Slot Numbering
@ $DFA0 label=SlotNumbers_Left
  $DFA0,$60,$0C #UDGARRAY12,attr=56,scale=4,step=12;(#PC)-(#PC+$20)-$01-$60(numbering-01-06)
@ $E000 label=SlotNumbers_Right
  $E000,$60,$0C #UDGARRAY12,attr=56,scale=4,step=12;(#PC)-(#PC+$20)-$01-$60(numbering-07-12)

b $E060 Centrepiece
@ $E060 label=Centrepiece
  $E060,$60,$04 #UDGARRAY#(4,scale=4,step=4#FOR0,$40,$20||n|;(#PC+n)-(#PC+n)-$01-$08,#PEEK(#EVAL($ED0E+n*2));(#PC+n+$01)-(#PC+n+$02)-$01-$10,#PEEK(#EVAL($ED0F+n*2));(#PC+n+$03)-(#PC+n+$03)-$01-$08,#PEEK(#EVAL($ED11+n*2))||)(centrepiece)

b $E0C0 Top Door Frames
@ $E0C0 label=DoorsTop
D $E0C0 #UDGARRAY32,attr=4,scale=4,step=32;(#PC)-(#PC)-$01-$100;(#PC+$01)-(#PC+$09)-$01-$100,attr=24;(#PC+$0A)-(#PC+$0B)-$01-$100;(#PC+$0C)-(#PC+$14)-$01-$100,attr=24;(#PC+$15)-(#PC+$16)-$01-$100;(#PC+$17)-(#PC+$1F)-$01-$100,attr=24(doors-top)
  $E0C0,$100,$20

b $E1C0 Left Side Wall
@ $E1C0 label=WallLeft
  $E1C0,$B0,$02 #UDGARRAY#(2,scale=4,step=2#FOR0,$A0,$10||n|;(#PC+n)-(#PC+n)-$01-$08,#PEEK(#EVAL($ED80+n*2));(#PC+n+$01)-(#PC+n+$01)-$08-$10,#PEEK(#EVAL($ED81+n*2))||)(wall-left)

b $E270 Middle Wall Section
@ $E270 label=WallMiddle
  $E270,$160,$04 #UDGARRAY#(4,attr=7,scale=4,step=4#FOR#(#PC),$E330,$20||n|;n-n-$01-$20,attr=24;(n+$01)-(n+$02)-$01-$20,attr=4;(n+$03)-(n+$03)-$01-$20,attr=24||#FOR$E350,$E3B0,$20||n|;n-n-$01-$20,attr=24;(n+$01)-(n+$02)-$01-$20,attr=16;(n+$03)-(n+$03)-$01-$20,attr=24||(wall-middle))

b $E3D0 Door Frame Right Side
@ $E3D0 label=DoorFrame_Side
  $E3D0,$58,$01 #UDGARRAY1,attr=24,scale=4,step=1;(#PC)-(#PC+$50)-$01-$08(door-side)

b $E428 Bottom Door Frames
@ $E428 label=DoorBottom
D $E428 #UDGARRAY32,attr=56,scale=4,step=32;(#PC)-(#PC)-$01-$100,attr=16;(#PC+$01)-(#PC+$09)-$01-$100;(#PC+$0A)-(#PC+$0B)-$01-$100,attr=16;(#PC+$0C)-(#PC+$14)-$01-$100;(#PC+$15)-(#PC+$16)-$01-$100,attr=16;(#PC+$17)-(#PC+$1F)-$01-$100(doors-bottom)
  $E428,$100,$20

b $E528 Tellers
@ $E528 label=Tellers
D $E528 #UDGARRAY32,attr=48,scale=4,step=32;(#PC)-(#PC+$78)-$01-$100,attr=6;(#PC+$100)-(#PC+$280)-$01-$100;(#PC+$300)-(#PC+$380)-$01-$100,attr=40(tellers)
  $E528,$400,$20

b $E928 Score Image (text)
@ $E928 label=Score_Text_Image
  $E928,$60,$06 #UDGARRAY6,attr=7,scale=4,step=6;(#PC)-(#PC+$2A)-$01-$30;(#PC+$30)-(#PC+$5A)-$01-$30,attr=2(score-text)

b $E988 Lives Image (text)
@ $E988 label=Lives_Text_Image
  $E988,$84,$06 #UDGARRAY6,attr=7,scale=4,step=6;(#PC)-(#PC+$42)-$01-$30;(#PC+$60)-(#PC+$84)-$01-$30,attr=3(lives-text)

i $EA0C

b $EA90 Door Buffer
@ $EA90 label=Door_Buffer
  $EA90,$268,$07 #UDGARRAY7,scale=4,step=7;(#PC)-(#PC+$238)-$01-$38,$30(door-buffer)

i $ECF8

b $ED00 Attribute Data
  $ED00,$300,$20

b $F000 BANG Frames
E $F000 #UDGARRAY*bang-1,10;bang-2;bang-3;bang-3;bang-3;bang-4;bang-5;bang-6(bang-frames)
@ $F000 label=Bang_Frame_01
  $F000,$100,$08 #BANG(bang-1*)
@ $F100 label=Bang_Frame_02
  $F100,$100,$08 #BANG(bang-2*)
@ $F200 label=Bang_Frame_03
  $F200,$100,$08 #BANG(bang-3*)
@ $F300 label=Bang_Frame_04
  $F300,$100,$08 #BANG(bang-4*)
@ $F400 label=Bang_Frame_05
  $F400,$100,$08 #BANG(bang-5*)
@ $F500 label=Bang_Frame_06
  $F500,$100,$08 #BANG(bang-6*)

b $F600 Sheriffs Badge
D $F600
@ $F600 label=Badge_Image
  $F600,$280,$08 #UDGARRAY8,attr=6,scale=4,step=8;(#PC)-(#PC+$247)-$01-$40(badge)

c $F880 ff

b $F900 Dollar Sign
D $F900 These are the scrolling dollar signs in the centre of the header.
@ $F900 label=Dollar_Image
  $F900,$50,$02 #UDGARRAY2,attr=48,scale=4,step=2;(#PC)-(#PC+$4F)-$01-$10(dollars)

c $F950 Dollar Sign (scrolling)
@ $F950 label=Dollar_Scroll
  $F960,$0D Blanks 254 bytes from #R$5B00 onwards.
  $F96D,$08 Sends #R$F940 to #R$F9C3.
  $F975,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $0CF8 | $0006 }
. TABLE#
  $F97E,$08 Sends #R$F900 to #R$F9C3.
  $F986,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $079E | $0006 }
. TABLE#
  $F98F,$08 Sends #R$F920 to #R$F9C3.
  $F997,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $029E | $0006 }
. TABLE#
  $F9A0,$08 Sends #R$F900 to #R$F9C3.
  $F9A8,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $0209 | $0020 }
. TABLE#
  $F9B1,$08 Sends #R$F920 to #R$F9C3.
  $F9BA,$08 Sends #R$5B00 to #R$F9C3 (blanks the centrepiece).
  $F9C2,$01 Return.

N $F9C3 Draws the image to the screen.
@ $F9C3 label=Dollar_Scroll_Draw
@ $F9C9 label=Dollar_Scroll_Draw_Loop
@ $F9E3 label=Dollar_Scroll_Halt_Loop
  $F9E6,$01 Return.

c $FA00 High Score Entry
@ $FA00 label=New_HighScore
@ $FA06 label=HighScore
  $FA06,$08 Copies $40 bytes of data from #REGhl to #R$5B80.
  $FA0E,$05 Writes "0" ($30 in ASCII) to #R$FB94.
  $FA13,$03 Call #R$FAD4.
  $FA16,$06 Writes $4040 to #R$FBF0.

  $FA1E,$03 Call #R$FC09.

  $FA77,$0D Overwrites the text at #R$5BC0 with spaces to "blank" it out ($12 characters).
  $FA84,$02 Set a string termination character ($FF) at the end of the string.
  $FA89,$0C Points to #R$FB78 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$03 | #N$03 | #N$00 | #N$00 }
. TABLE#

  $FAB0,$0C Points to #R$FBB5 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$06 | #N$06 | #N$00 | #N$00 }
. TABLE#

  $FAD4,$0E Clears the screen buffer by writing $00 to all 6912 memory locations.
@ $FAD4 label=HighScore_Clear_Screen

N $FB19 Works out where in the high score table to place the score.
  $FB19 Using #R$6000 as a base, work out where to place the new score.
. #LIST
. { Decrease $1B by one... }
. { Loads $1A as the low-order byte; #REGhl=$001A }
. { Times by $10; #REGhl=$1A0 }
. { Add $6000=#R$61A0 }
. LIST#
@ $FB19 label=HighScore_Position
  $FB25,$01 Return.
  $FB26,$09 Stores #R$5BC0 at #R$FB55.
@ $FB26 label=HighScore_Something

W $FB55,$02 Cache.

N $FB62 Returns a single keypress.
@ $FB62 label=HighScore_Input
@ $FB67 label=HighScore_Input_Loop
  $FB62,$0A #HTML(Keep looping around until <em>any</em> input is detected. This is achieved by writing $00 to
.                 <a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST_K</a> and looping until it's non-zero.)
  $FB6C,$01 Store it on the stack for now.
  $FB6D,$09 #HTML(Makes a noise using the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEP</a> routine.)
. #TABLE(default,centre)
. { =h Pitch | =h Duration }
. { $00C0 | $0010 }
. TABLE#
  $FB76,$02 Return with the keypress in #REGa.

t $FB78 High Score Table Name Entry
@ $FB78 label=HighScore_Title
  $FB78,$1C "#STR#(#PC),$08($b==$FF)".
@ $FB94 label=HighScore_Text_Buffer
  $FB94,$21 This is a buffer - so text changes with playing input: "#STR#(#PC),$08($b==$FF)".
@ $FBB5 label=HighScore_Sub_Head
  $FBB5,$20 "#STR#(#PC),$08($b==$FF)".

c $FBD5
  $FBD5,$03 #REGhl=#R$FBF0.
  $FBE2,$07 Sends #REGhl to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$05 | #N$05 | #N$00 | #N$00 }
. TABLE#
W $FBF0,$02 Cache
  $FBF2,$0D Points to #R$5BC0 and sends it to #R$5B80.
. #TABLE(default,centre)
. { =h Value | =h Ink | =h Paper | =h Bright }
. { #N$07 | #N$07 | #N$00 | #N$00 }
. { #N$05 | #N$05 | #N$00 | #N$00 }
. TABLE#

u $FC67
i $FC6A

b $FD00
  $FD00,$7F,$07

c $FD80 Blah
  $FD80,$02 Jump to #R$FD84.
  $FD82,$02 Jump to #R$FDA8.
  $FD84,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FD | A | S | D | F | G }
. TABLE#
  $FD89,$02 Jump to #R$FD8D if "A" is pressed.
  $FD8B,$02 Jump to #R$FDA3.

  $FD8D,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $BF | ENTER | L | K | J | H }
. TABLE#
  $FD91,$03 Jump to #R$FD95 if "ENTER" is pressed.
  $FD94,$01 Return.

  $FD95,$03 #REGde=#R$5B80.
  $FD98,$03 #REGbc=#N$0040.
  $FD9B,$02 Copy...
  $FD9D,$03 Load the contents of #R$5B86 into #REGhl.
  $FDA0,$02 Write #N$FF to #REGhl.
  $FDA2,$01 Return.

  $FDA3,$03 #REGsp=#R$5FF0.
  $FDA6,$02 Jump to #R$FDBC.

  $FDA8,$01 Enable interrupts.
S $FDA9,$08 No-operation.
N $FDB1 Oddly enable both keyboard and kempston joystick input methods at the same time.
  $FDB1,$06 Write #N$0101 to #R$5CB0.
N $FDB7 Set the border to black and blank the screen buffer.
  $FDB7,$02 #REGa=#N$00.
  $FDB9,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/2294.html#229B">BORDER</a> routine (not from the start).)
  $FDBC,$0D Writes $00 to all #N$1AFF bytes of the screen buffer (i.e. "blanks it").
  $FDC9,$03 Call #R$C7C0.
  $FDCC,$02 Jump to #R$FDBC.

b $FDD1

c $FE00 Title Screen
@ $FE00 label=TitleScreen
N $FE00 On initialisation, #REGhl=#R$CBB4. So this section is resetting various jump aliases and game status flags to
.       default values.
  $FE00,$03 #REGde=#R$5B80.
  $FE03,$03 #REGbc=#N$0040.
  $FE06,$02 Copies #N$0040 bytes of data from the address pointed to by #REGhl to the address pointed to by #REGde.
  $FE08,$02 #REGa=#N$01.
  $FE0A,$03 No-operation?
  $FE0D,$03 Call #R$FEA4.
N $FE10 Write "WEST BANK" to the screen.
  $FE10,$0C Points to #R$FEEA and sends it to #R$5B80.
N $FE1C Writes "0 PLAY" to the screen.
  $FE1C,$09 Points to #R$FEF4 and sends it to #R$FEE4.
N $FE25 Writes "1 KEYS" to the screen.
  $FE25,$09 Points to #R$FEFC and sends it to #R$FEE4.
N $FE2E Writes "2 KEMPSTON" to the screen.
  $FE2E,$09 Points to #R$FF06 and sends it to #R$FEE4.
N $FE37 Writes "N LEVEL" to the screen.
  $FE37,$09 Points to #R$FF11 and sends it to #R$FEE4.
N $FE40 Writes "PROGRAM BY ALVARO MATEOS" to the screen.
  $FE40,$0C Points to #R$FF19 and sends it to #R$5B80.
N $FE4C Writes "COPYRIGHT  DINAMIC SOFTWARE 1985" to the screen.
  $FE4C,$0C Points to #R$FF34 and sends it to #R$5B80.

N $FE58 Act on inputs.
@ $FE58 label=TitleScreen_Input
@ $FE63 label=TitleScreen_Select_Kempston
@ $FE66 label=TitleScreen_Call_Flash
  $FE58,$11 If #R$5CB0 is zero (joystick) then #REGde=$0787 else #REGde=$8707. Then call the subroutine at #R$FE95.
. The $07/ $87 correspond to white INK and white INK flashing for the selected control method.
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Value | =h Ink | =h Paper | =h Bright | =h Flash }
. { #N$07 | #N$07 | #N$00 | #N$00 | #N$00 }
. { #N$87 | #N$07 | #N$00 | #N$00 | #N$01 }
. TABLE#

  $FE69,$03 Point #REGhl=#R$5CB0.
  $FE6C,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $FE70,$03 Jump to #R$FE86 if "1" is pressed.
  $FE73,$03 Jump to #R$FE8B if "2" is pressed.
  $FE76,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $FE7A,$04 Jump to #R$FE8F if "N" is pressed.
  $FE7E,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $FE82,$04 Return if "0" is pressed, else loop back around to #R$FE58.
N $FE86 Keyboard has been selected so "highlight" it.
@ $FE86 label=TitleScreen_Set_Keyboard
  $FE86,$05 Writes $01 to #R$5CB0 and loop back around to #R$FE58.
N $FE8B Kempston joystick has been selected so "highlight" it.
@ $FE8B label=TitleScreen_Set_Kempston
  $FE8B,$04 Writes $00 to #R$5CB0 and loop back around to #R$FE58.
N $FE8F Handles "level section".
@ $FE8F label=TitleScreen_Select_Level
  $FE8F,$06 Jump to #R$6380 with #REGhl=#R$5B80.

@ $FE95 label=TitleScreen_Flash_Text
  $FE95,$0E ggg
  $FEA3,$01 Return.

@ $FEA4 label=TitleScreen_Draw_Bandit
N $FEA4 Draw bandits.
  $FEA4,$1C Sets attributes on the left and right of the screen and points #REGde at #R$6800.
  $FEC0,$03 Jump to #R$5B92.

@ $FEC3 label=TitleScreen_Bandit_Attributes
  $FEC3,$07 Calls #R$FECE with #REGb=$08 and #REGa=$28.
  $FECA,$05 Calls #R$FEDA with #REGb=$03 and #REGa=$20.
@ $FECE label=TitleScreen_Bandit_Attributes_Loop
  $FED9,$01 Return.

@ $FEDA label=TitleScreen_Bandit_Attributes_Copy
  $FEDA,$07
  $FEE3,$01 Return.

@ $FEE4 label=TitleScreen_Print
  $FEE4,$06 #REGb=$07, #REGc=$02 and jump to #R$5B80.

t $FEEA Title Screen/ Game Options
@ $FEEA label=TitleScreen_GameName
  $FEEA,$0A "#STR#(#PC),$08($b==$FF)".
N $FEF4 Playing Options.
@ $FEF4 label=TitleScreen_Play
  $FEF4,$08 "#STR#(#PC),$08($b==$FF)".
@ $FEFC label=TitleScreen_Keys
  $FEFC,$0A "#STR#(#PC),$08($b==$FF)".
@ $FF06 label=TitleScreen_Joystick
  $FF06,$0B "#STR#(#PC),$08($b==$FF)".
@ $FF11 label=TitleScreen_Level
  $FF11,$08 "#STR#(#PC),$08($b==$FF)".
N $FF19 Credits.
@ $FF19 label=TitleScreen_Author
  $FF19,$1B "#STR#(#PC),$08($b==$FF)".
@ $FF34 label=TitleScreen_Copyright
  $FF34,$21 "#STR#(#PC),$08($b==$FF)".
  $FF55,$03 "#STR#(#PC),$08($b==$FF)".

b $FF58 Gun Shot Mask
@ $FF58 label=GunShot_Mask_Image
  $FF58,$10,$08 #UDGARRAY2,attr=7,scale=4,step=2;(#PC)-(#PC+$01)(shot-mask)

b $FF68 Gun Shot
@ $FF68 label=Shot_Image
  $FF68,$10,$08 #UDGARRAY2,attr=7,scale=4,step=2;(#PC)-(#PC+$01)(shot)

b $FF78 Cash Box
@ $FF78 label=EmptyBox_Image
  $FF78,$20,$02 #UDGARRAY2,attr=13,scale=4,step=2;(#PC)-(#PC+$11)-$01-$10(empty)
@ $FF98 label=DollarBox_Image
  $FF98,$20,$02 #UDGARRAY2,attr=13,scale=4,step=2;(#PC)-(#PC+$11)-$01-$10(dollar)

b $FFB8 Lives Graphic
@ $FFB8 label=Lives_Image
  $FFB8,$30,$02 #UDGARRAY#(2,scale=4,step=2#FOR0,$20,$10||n|;(#PC+n)-(#PC+n+$02)-$01-$10,#PEEK(#EVAL($EFBF+n*2))||)(lives)

b $FFE8
