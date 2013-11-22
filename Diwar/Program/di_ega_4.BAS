'
'  Program DI-EGA-2.BAS  (KILDECRAUN)
'
DECLARE SUB Correct (var())
DECLARE SUB drawtext (s$, txt$)
DECLARE SUB Terminal ()
DECLARE SUB PseudoPlot (var!(), Hm0!, Tz!)
DECLARE SUB HsTz (var!(), Hm0!, Tz!)
DECLARE SUB PlotSpec (var!(), Hm0, Tz)
DECLARE SUB PlotData (D!(), HS!, Offs!)
DECLARE SUB Offset (D!(), Offs!)
DECLARE SUB LIEVENSE ()
DECLARE SUB Hsig (D!(), HS!)
DECLARE SUB FFT (co!(), si!(), a!(), Re!(), Im!(), R!(), i!())
DECLARE SUB Taper (n!(), co!(), Re!(), Im!())
DECLARE SUB Transfer (i!, D!(), Re!(), Im!())
DECLARE SUB MakeSpt (D!(), var!())
DECLARE SUB Variance (var!(), R!(), i!())
DECLARE SUB MakeTables (a!(), co!(), si!())
DECLARE SUB OpenCom (comport$)
DECLARE SUB TestLock (diwar!, channel!, chn)
DECLARE SUB GetData (chn, command!, ndw!, D!())
DECLARE SUB CommTest (ndw!)
DECLARE SUB Connect (nr$, a$)
DECLARE SUB Terminate ()
DECLARE SUB SendCommand (n!)
DECLARE SUB DiwarTest (ndw!)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'INSTELLING:
COMMON SHARED Hm0, HS, Tz
comport$ = "com1"    'Serial port number
nr$ = " T 0659058273" 'Tone dial, Limerick !!!
diwar = 1
channel = 1
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

DIM D(5, 511)
DIM SHARED var(127)
DIM SHARED char$(127)
DIM SHARED X(127)
DIM SHARED AY4(127), BY4(127), CY4(127), DY4(127), EY4(127)
DIM SHARED AAY4(127), BBY4(127), CCY4(127), DDY4(127), EEY4(127)
DIM SHARED AZ4(127), BZ4(127), CZ4(127), DZ4(127), EZ4(127)
DIM SHARED AYT(127), BYT(127), CYT(127), DYT(127), EYT(127)
DIM SHARED AAYT(127), BBYT(127), CCYT(127), DDYT(127), EEYT(127)
DIM SHARED AZT(127), BZT(127), CZT(127), DZT(127), EZT(127)
DIM SHARED SPY(127), SPX(127)
'
' temporary  !!!!!!!!!!
' test

'
REM ****************************************************
REM *                                                  *
REM *     waarden gedigitaliseerde responsfuncties     *
REM *     voor een 116.000 dwt bulk carrier            *
REM *     voor verschillende hoeken en snelheden       *
REM *                                                  *
REM ****************************************************
REM
REM ****************************************************
REM *                                                  *
REM *     4 knopen, 0 graden (achterinkomend)          *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,41,41,42,42,43,44,45,46,48,50,52
DATA 54,56,59,62,64,68,74,77,80,82,83,82,80,78,75
DATA 72,69,66,62,58,53,50,45,40,35,30,25,20,17,16
DATA 17,20,25,29,33,35,37,38,37,35,33,30,27,24,22
DATA 20,19,18,18,16,15,14,12,10, 9, 8, 7, 6, 6, 5
DATA  5, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0
REM
REM ****************************************************
REM *                                                  *
REM *     4 knopen, 30 graden (schuin achterinkomend)  *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,41,41,42,42,43,44,45,46,48,50,52
DATA 54,56,60,62,64,68,74,77,79,81,82,84,86,87,88
DATA 88,87,86,85,83,80,77,72,68,60,55,50,42,36,27
DATA 21,13, 6, 3, 1, 3, 5, 9,15,17,18,19,19,18,17
DATA 16,16,15,15,14,13,12,11,10,10,9,9,8,8,8
DATA  7, 7, 6, 6, 6, 5, 5, 5, 4, 4, 4, 4, 4, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1
REM
REM ****************************************************
REM *                                                  *
REM *     4 knopen, 45 graden (schuin achterinkomend)  *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,42,42,43,44,45,46,48,50,52,53,55
DATA 57,60,63,67,70,72,74,77,80,83,86,89,92,94,97
DATA 99,102,104,106,107,108,109,107,106,103,100,97,93,87,80
DATA 75,70,65,60,53,46,40,33,22,15,13,11,9,8,8
DATA 8,8,7,7,7,8,8,9,8,8,8,8,7,7,6
DATA 6,6,5,5,5,5,5,5,4,4,4,4,4,4,4,3,3,3,2,2,2,2,1,1,0
REM
REM ****************************************************
REM *                                                  *
REM *     4 knopen, 135 graden (schuin voorinkomend)   *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,41,41,42,43,44,46,46,47,53,56,62
DATA 65,68,71,75,78,82,85,89,94,98,100,101,100,100,99
DATA 95,88,85,78,74,70,68,66,65,64,62,61,60,58,55
DATA 50,48,43,37,35,30,25,20,17,14,11,9,8,8,7
DATA 6,6,6,6,6,5,5,4,3,3,3,3,3,3,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,0,0,0,0
REM
REM ****************************************************
REM *                                                  *
REM *     4 knopen, 180 graden (voorinkomend)          *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,41,41,42,43,44,46,46,47,53,56,62
DATA 65,67,77,80,86,89,92,94,95,94,94,93,90,87,85
DATA 82,77,74,70,66,61,55,50,43,37,32,28,22,18,15
DATA 13,11,10,10,10,9,9,8,8,8,8,8,7,7,6
DATA 6,5,4,3,3,3,2,2,2,2,1,1,1,1,1
DATA 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
'
' volgende serie
'
REM ****************************************************
REM *                                                  *
REM *     12 knopen, 30 graden (achterinkomend)        *
REM *     101 punten. schaalfactor frequentie .5/50    *
REM *     (rad/s) en respons 1.25/50 (-)               *
REM *                                                  *
REM ****************************************************
REM
DATA 40,40,40,41,41,41,41,42,42,42,42,42,42,43,44,45,46,47,48,50,52
DATA 53,55,57,60,62,64,66,67,68,68,67,65,63,60,56,50,45,40,35,30
DATA 25,20,17,15,14,14,15,17,20,23,25,27,29,31,32,32,31,30,29,27
DATA 26,25,23,21,20,17,12,9,7,6,7,11,13,18,20,21,21,21,21,21
DATA 20,20,19,19,18,17,17,16,15,15,14,14,14,13,13,13,12,12,12,11
REM
REM *******************************************************
REM *                                                     *
REM *     12 knopen, 30 graden (schuin achterinkomend)    *
REM *     101 punten. schaalfactor frequentie .5/50       *
REM *     (rad/s) en respons 1.25/50 (-)                  *
REM *                                                     *
REM *******************************************************
REM
DATA 40,40,40,40,41,41,41,41,41,41,41,41,42,42,42,42,42,42,43,43,44
DATA 46,48,52,56,60,63,66,69,72,72,72,70,67,63,60,58,56,55,53,52
DATA 50,46,42,38,35,30,26,20,17,14,14,15,17,20,22,24,25,26,27,28
DATA 29,30,31,32,32,30,28,24,20,15,13,10,8,7,6,6,6,7,8,9
DATA 9,9,8,8,6,5,4,4,5,5,6,6,6,7,7,7,7,7,7,7
REM
REM *******************************************************
REM *                                                     *
REM *     12 knopen, 45 graden (schuin achterinkomend)    *
REM *     101 punten. schaalfactor frequentie .5/50       *
REM *     (rad/s) en respons 1.25/50 (-)                  *
REM *                                                     *
REM *******************************************************
REM
DATA 40,40,40,40,41,41,41,41,42,42,43,43,44,44,45,45,46,47,48,49,51
DATA 53,55,57,59,62,64,66,68,72,74,76,77,79,80,81,81,82,81,81,80
DATA 79,78,76,73,70,68,63,59,55,50,40,35,30,22,16,13,9,8,8,9
DATA 10,14,18,22,24,26,27,27,26,26,26,25,24,23,22,21,20,18,16,15
DATA 13,10,8,6,5,4,4,4,5,5,5,6,6,7,7,7,7,7,7,6
REM
REM *******************************************************
REM *                                                     *
REM *     12 knopen, 145 graden (schuin voorinkomend)     *
REM *     101 punten. schaalfactor frequentie .5/50       *
REM *     (rad/s) en respons 1.25/50 (-)                  *
REM *                                                     *
REM *******************************************************
REM
DATA 40,40,40,40,40,40,41,41,42,42,43,45,48,52,57,61,67,78,85,92,98
DATA 103,109,111,111,110,100,90,82,75,68,66,69,73,74,74,73,69,60,54,50
DATA 42,38,35,31,28,26,25,23,21,19,17,15,14,12,11,9,8,7,6,5
DATA 4,4,3,3,2,2,2,1,1,1,1,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
REM
REM *******************************************************
REM *                                                     *
REM *     12 knopen, 180 graden (schuin voorinkomend)     *
REM *     101 punten. schaalfactor frequentie .5/50       *
REM *     (rad/s) en respons 1.25/50 (-)                  *
REM *                                                     *
REM *******************************************************
REM
DATA 40,40,40,40,41,41,42,42,43,45,47,48,51,56,62,69,76,88,98,110,113
DATA 112,110,106,100,93,90,85,83,81,78,73,68,63,55,48,42,35,29,23,18
DATA 15,13,10,9,8,7,6,6,5,5,5,5,4,4,4,4,4,4,4,4
DATA 3,3,3,3,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
'
' inlezen
'
REM ****************************************************
REM *                                                  *
REM *     Inlezen responswaarden voor verschillende    *
REM *     hoeken resp. 0, 30, 40, 135 en 180 graden    *
REM *     bij een snelheid van 4 knopen                *
REM *     tevens omrekening met schaalfactor           *
REM *                                                  *
REM ****************************************************
FOR i = 1 TO 101
READ AY4(i): AY4(i) = 1.25 / 50 * AY4(i): REM AY4(I) in [m/m]
NEXT i
FOR i = 1 TO 101
READ BY4(i): BY4(i) = 1.25 / 50 * BY4(i)
NEXT i
FOR i = 1 TO 101
READ CY4(i): CY4(i) = 1.25 / 50 * CY4(i)
NEXT i
FOR i = 1 TO 101
READ DY4(i): DY4(i) = 1.25 / 50 * DY4(i)
NEXT i
FOR i = 1 TO 101
READ EY4(i): EY4(i) = 1.25 / 50 * EY4(i)
NEXT i
FOR i = 1 TO 101
READ AYT(i): AYT(i) = 1.25 / 50 * AYT(i): REM AYt(I) in [m/m]
NEXT i
FOR i = 1 TO 101
READ BYT(i): BYT(i) = 1.25 / 50 * BYT(i)
NEXT i
FOR i = 1 TO 101
READ CYT(i): CYT(i) = 1.25 / 50 * CYT(i)
NEXT i
FOR i = 1 TO 101
READ DYT(i): DYT(i) = 1.25 / 50 * DYT(i)
NEXT i
FOR i = 1 TO 101
READ EYT(i): EYT(i) = 1.25 / 50 * EYT(i)
NEXT i
'
' back up of values
'
FOR i = 1 TO 101
 AAY4(i) = AY4(i)
 BBY4(i) = BY4(i)
 CCY4(i) = CY4(i)
 DDY4(i) = DY4(i)
 EEY4(i) = EY4(i)
 AAYT(i) = AYT(i)
 BBYT(i) = BYT(i)
 CCYT(i) = CYT(i)
 DDYT(i) = DYT(i)
 EEYT(i) = EYT(i)
NEXT i
'
AutoDial:
SCREEN 0: CLS
KEY 1, " BREAK": ON KEY(1) GOSUB BREAK: KEY(1) ON
KEY 10, " QUIT": ON KEY(10) GOSUB Quit: KEY(10) ON
KEY 2, " TERM": ON KEY(2) GOSUB Term: KEY(2) ON
KEY 3, "": KEY(3) OFF
KEY 4, "": KEY(4) OFF
KEY 9, "": KEY(9) OFF
KEY ON

chn = 2 ^ (channel + 1)

        CALL OpenCom(comport$)
SLEEP 5
        CALL Connect(nr$, a$): IF INSTR(a$, "CONNECT") = 0 THEN GOSUB BREAK
SLEEP 5
        CALL CommTest(diwar)
        CALL DiwarTest(diwar)
        CALL TestLock(diwar, channel, chn)
        CALL GetData(chn, command, diwar, D())
        CALL Terminate
        CALL Offset(D(), Offs)
        CALL Hsig(D(), HS)
        CALL PlotData(D(), HS, Offs)     ' uit bij niet-EGA kaart
        CALL MakeSpt(D(), var())
        CALL Correct(var())
        CALL HsTz(var(), Hm0, Tz)
'       CALL PseudoPlot(var(), Hm0, Tz) ' aan bij niet-EGA kaart
        CALL PlotSpec(var(), Hm0, Tz)   ' uit bij niet-EGA kaart

KEY 3, " DATA": ON KEY(3) GOSUB Dataplot: KEY(3) ON
KEY 4, " SPEC": ON KEY(4) GOSUB SpecPlot: KEY(4) ON
KEY 9, " GO ?": ON KEY(9) GOSUB LIEV: KEY(9) ON
idle:
KEY 1, " CALL": ON KEY(1) GOSUB Dial: KEY(1) ON
KEY ON
DO
LOOP

END
Dataplot:
        CALL PlotData(D(), HS, Offs)
RETURN
SpecPlot:
        CALL PlotSpec(var(), Hm0, Tz)
RETURN

Dial:
RETURN AutoDial

BREAK:
CALL SendCommand(command + 2)
CALL Terminate
RETURN idle

BREAK2:
CALL SendCommand(command + 2)
CALL Terminate
RESUME idle

LIEV:
  CALL LIEVENSE
RETURN

Term:
  CALL Terminal
RETURN

Quit:
RESET
END

SUB CommTest (ndw)

        command = 64 + 4 * ndw
        CALL SendCommand(command + 2)
        ' stop diwar
        PRINT "CHECKING DIWAR"
                SLEEP 1
                IF LOC(1) THEN y$ = INPUT$(LOC(1), #1)

        CALL SendCommand(command)' START DIWAR AUTO
        SLEEP 5
        IF EOF(1) THEN
                PRINT "NO ANSWER"
                CALL Terminate
                END
        ELSE
                PRINT "DIWAR TALKS"
        END IF
        CALL SendCommand(command + 2)
        'stop diwar
        SLEEP 1
        y$ = INPUT$(LOC(1), #1)
        SLEEP 1
        IF NOT EOF(1) THEN
                y$ = INPUT$(LOC(1), #1)
                PRINT y$, "CAN NOT CONTROL DIWAR !"
                CALL Terminate
        ELSE
                PRINT "DIWAR UNDER CONTROL"
        END IF

END SUB

SUB Connect (nr$, a$)

LOCATE 1, 1, 0
        IF nr$ = "" THEN
                PRINT "Dial Number and press any key"
                WHILE INKEY$ = ""
                WEND
        END IF
        PRINT #1, "ATD" + nr$
               LINE INPUT #1, a$
               PRINT a$
        DO
               LINE INPUT #1, a$
               PRINT a$
        LOOP UNTIL a$ <> ""
        SLEEP 2
END SUB

SUB Correct (var())
REM:wave rider amplitude transfer is : 1/sqr(1+(period/30.8 sec)^4)
k = 200 / 30.8
  FOR n = 6 TO 127
    p = k / n
    corr = (1 + p * p * p * p)
    var(n) = var(n) * corr
  NEXT
END SUB

SUB DiwarTest (ndw)

        command = 4 * ndw + 2
        PRINT "TEST FREQUENCY #1: ";
        FOR n = 0 TO 10
                SLEEP 1
                CALL SendCommand(command)
                LOCATE , 20, 0
                PRINT "      ";
                y$ = INPUT$(3, #1)
                d1 = ASC(y$)
                D2 = ASC(MID$(y$, 2, 1))
                d0 = 256 * d1 + D2 - 4096 * ndw - 2048
                LOCATE , 20, 0
                PRINT USING "+#####"; d0;
        NEXT
        PRINT
        command = 4 * ndw + 34
        PRINT "TEST FREQUENCY #2: ";
        FOR n = 0 TO 10
                SLEEP 1
                CALL SendCommand(command)
                LOCATE , 20, 0
                PRINT "      ";

                y$ = INPUT$(3, #1)
                d1 = ASC(y$)
                D2 = ASC(MID$(y$, 2, 1))
                D3 = 256 * d1 + D2 - 4096 * ndw - 2048
                LOCATE , 20, 0
                PRINT USING "+#####"; D3;
        NEXT
        PRINT
        D2 = (D3 - d0) / 14.337
        D3 = .2875 * d0 + .7125 * D3
        PRINT USING "Offset :+### cm"; D3
        PRINT USING "Scale error  :+##.#"; D2 - 100; : PRINT " %"
        SLEEP 1
        WHILE NOT EOF(1)
                y$ = INPUT$(LOC(1), #1)
                PRINT y$;
        WEND

END SUB

SUB drawtext (s$, txt$)
        DRAW s$
        FOR n = 1 TO LEN(txt$)
                m = ASC(MID$(txt$, n, 1))
                DRAW char$(m)
        NEXT

END SUB

SUB FFT (co(), si(), a(), Re(), Im(), R(), i())

nst = 128
WHILE nst >= 1
FOR n1 = 0 TO 127 STEP nst
        nc = n1 / nst
                FOR n2 = 0 TO nst - 1
                        na = n2 + 2 * n1: nb = na + nst
                        R = co(nc) * Re(nb) + si(nc) * Im(nb)
                        i = co(nc) * Im(nb) - si(nc) * Re(nb)
                        Re(nb) = Re(na) - R
                        Im(nb) = Im(na) - i
                        Re(na) = Re(na) + R
                        Im(na) = Im(na) + i
                NEXT
        NEXT
        nst = nst * .5
WEND

FOR nd = 1 TO 255
        na = a(nd): nb = a(256 - nd)
        r0 = Re(na) + Re(nb)
        i0 = Im(na) + Im(nb)
        R1 = Re(na) - Re(nb)
        i1 = Im(na) - Im(nb)
        R(nd) = (r0 + co(na) * i0 - si(na) * R1) / 512
        i(nd) = (i1 - si(na) * i0 - co(na) * R1) / 512

NEXT

END SUB

SUB GetData (chn, command, ndw, D())

ON ERROR GOTO BREAK2

        FOR i = 0 TO 5
            j = 0
            DO
                LOCATE 20, 1, 0
                PRINT TIME$,
                PRINT USING "      BLOCK: #     POINT: ###    "; i + 1; j + 1;
                y$ = INPUT$(3, #1)
                d1 = ASC(y$)
                IF ASC(MID$(y$, 3)) <> chn THEN ERROR 57
                IF d1 > 127 THEN
                        PRINT "UNLOCKED                     ";
                        d1 = d1 - 128
                        FOR j = 0 TO 10
                                y$ = INPUT$(3, #1)
                        NEXT
                        j = 0
                ELSE
                        PRINT "   DATA   ";
                        D2 = ASC(MID$(y$, 2, 1))
                        d0 = 256 * d1 + D2 - 4096 * ndw - 2048
                        PRINT USING "+#####   "; d0;
                        D(i, j) = d0
                        j = j + 1
                END IF
            LOOP UNTIL j = 512
         NEXT
ON ERROR GOTO 0
'
  a$ = LEFT$(DATE$, 2)
  b$ = LEFT$(DATE$, 5)
  b$ = RIGHT$(b$, 2)
  c$ = LEFT$(TIME$, 2)
  D$ = LEFT$(TIME$, 5)
  D$ = RIGHT$(D$, 2)
  resname$ = "C:\DIWAR\FILES\" + a$ + "-" + b$ + "-" + c$ + "." + D$ + "A"
'
  OPEN resname$ FOR OUTPUT AS #3
  FOR j = 0 TO 511
   PRINT #3, D(0, j), D(1, j), D(2, j), D(3, j), D(4, j), D(5, j)
  NEXT j
  CLOSE #3
'
END SUB

SUB Hsig (D(), HS)

        m0 = 0
        FOR i = 0 TO 5
                FOR j = 0 TO 511
                m0 = m0 + D(i, j) * D(i, j)
                NEXT
        NEXT
        m0 = m0 / 3072
        HS = 4 * SQR(m0)
END SUB

SUB HsTz (var(), Hm0, Tz)

' calculate Hm0 and Tz for .03 to .635 Hz

mo = 0: m2 = 0
        FOR n = 15 TO 127
                m0 = m0 + var(n)
                m2 = m2 + var(n) * n * n
        NEXT
        Hm0 = 4 * SQR(.005 * m0)
        Tz = 200 * SQR(m0 / m2)

END SUB

SUB LIEVENSE
CLS
T1 = Tz
PI = 3.1415927#
KEY OFF
REM ****************************************************
110 REM *                                                  *
REM *     ax(i) is de x-coordinaat, dus frequentie     *
REM *     ay(i) is de x-coordinaat, dus respontie      *
REM *     zelfde voor bx,by,cx,cy,dx,dy,ex,ey,spx,spy  *
REM *                                                  *
REM ****************************************************
CLS
PRINT "Calculations of ship motions (bulkcarriers 100.000-170.000 dwt)"
PRINT "============================================================="
PRINT : PRINT "Some characteristics :": PRINT "====================="
PRINT : INPUT "displacement                  [m3] : "; IV
INPUT "draft                          [m] : "; draft
INPUT "length between perpendiculars  [m] : "; LPP
INPUT "speed                      [knots] : "; VS
INPUT "waterdepth (approx.)           [m] : "; wd
F = (IV / 139700!) ^ (1 / 6)
REM ****************************************************
REM *                                                  *
REM *     Berekening frequenties behorende bij de      *
REM *     responswaarden die bekend zijn voor          *
REM *     de verschillende hoeken en snelheden         *
REM *                                                  *
REM ****************************************************
FOR i = 1 TO 101
X(i) = (i - 1) * .5 / 50: REM    schaalfactor
X(i) = X(i) / 2 / PI / F: REM    omrekening naar Hertz en dwt-schip
NEXT i
REM ****************************************************
REM *                                                  *
REM *     bepalen respons voor de frequenties          *
REM *     waarop het spectrum bekend is (Datawell)     *
REM *                                                  *
REM ****************************************************
j = 6
870 FOR i = 1 TO 100
IF X(i) <= j * .005 AND X(i + 1) >= j * .005 THEN GOTO 890 ELSE GOTO 1000
890 AZ4(j) = AY4(i) + (AY4(i + 1) - AY4(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
BZ4(j) = BY4(i) + (BY4(i + 1) - BY4(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
CZ4(j) = CY4(i) + (CY4(i + 1) - CY4(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
DZ4(j) = DY4(i) + (DY4(i + 1) - DY4(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
EZ4(j) = EY4(i) + (EY4(i + 1) - EY4(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
AZT(j) = AYT(i) + (AYT(i + 1) - AYT(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
BZT(j) = BYT(i) + (BYT(i + 1) - BYT(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
CZT(j) = CYT(i) + (CYT(i + 1) - CYT(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
DZT(j) = DYT(i) + (DYT(i + 1) - DYT(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
EZT(j) = EYT(i) + (EYT(i + 1) - EYT(i)) / (X(i + 1) - X(i)) * (j * .005 - X(i))
i = 101
1000 NEXT i
j = j + 1
IF j * .005 > X(101) THEN GOTO 1040
GOTO 870
1040 FOR i = 1 TO 126
AY4(i) = AZ4(i): BY4(i) = BZ4(i): CY4(i) = CZ4(i): DY4(i) = DZ4(i): EY4(i) = EZ4(i)
AYT(i) = AZT(i): BYT(i) = BZT(i): CYT(i) = CZT(i): DYT(i) = DZT(i): EYT(i) = EZT(i)
NEXT i
FOR i = 1 TO 126
X(i) = i * .005
NEXT i
REM ****************************************************
REM *                                                  *
REM *     Berekening energien (spectrum)               *
REM *     voor dezelfde frequenties en hetzelfde       *
REM *     aantal frequenties als door de software      *
REM *     van Datawell wordt bepaald                   *
REM *                                                  *
REM ****************************************************
REM
FOR i = 6 TO 126
SPX(i) = .005 * i: REM  frequenties in Hz
SPY(i) = var(i) / 10000
NEXT i
REM ****************************************************
REM *                                                  *
REM *     Grafische weergave respons en spectrum       *
REM *     voor verschillende sea-states, 4 knopen      *
REM *     en hoeken 0, 30, 45, 135 en 180 graden       *
REM *                                                  *
REM ****************************************************
REM
REM ****************************************************
REM *                                                  *
REM *     responsfuncties                              *
REM *                                                  *
REM ****************************************************
RA4 = 0: RB4 = 0: RC4 = 0: RD4 = 0: RE4 = 0
RAT = 0: RBT = 0: RCT = 0: RDT = 0: RET = 0
FOR i = 1 TO 100
RA4 = RA4 + SPY(i) * AY4(i) * AY4(i) * .005
RB4 = RB4 + SPY(i) * BY4(i) * BY4(i) * .005
RC4 = RC4 + SPY(i) * CY4(i) * CY4(i) * .005
RD4 = RD4 + SPY(i) * DY4(i) * DY4(i) * .005
RE4 = RE4 + SPY(i) * EY4(i) * EY4(i) * .005
RAT = RAT + SPY(i) * AYT(i) * AYT(i) * .005
RBT = RBT + SPY(i) * BYT(i) * BYT(i) * .005
RCT = RCT + SPY(i) * CYT(i) * CYT(i) * .005
RDT = RDT + SPY(i) * DYT(i) * DYT(i) * .005
RET = RET + SPY(i) * EYT(i) * EYT(i) * .005
NEXT i
RA4 = 4 * SQR(RA4): RB4 = 4 * SQR(RB4): RC4 = 4 * SQR(RC4): RD4 = 4 * SQR(RD4): RE4 = 4 * SQR(RE4)
RAT = 4 * SQR(RAT): RBT = 4 * SQR(RBT): RCT = 4 * SQR(RCT): RDT = 4 * SQR(RDT): RET = 4 * SQR(RET)
CLS
PRINT "Some characteristics :": PRINT "======================": PRINT
PRINT "displacement                  [m3] : "; USING "######"; IV
PRINT "draft                          [m] : "; USING "###.##"; draft
PRINT "lenght between perpendiculars  [m] : "; USING "###.##"; LPP
PRINT "speed                      [knots] : "; USING "######"; VS
PRINT "waterdepth                     [m] : "; USING "###.##"; wd
PRINT
PRINT "significant wave height Hmo    [m] : "; USING "###.##"; Hm0 / 100
PRINT "significant wave height Hs     [m] : "; USING "###.##"; HS / 100
PRINT "average wave period          [sec] : "; USING "###.##"; T1
PRINT
779 a$ = INKEY$: IF a$ = "" THEN 779
CLS
REM ***************************************************************
REM *                                                             *
REM *     verticale bewegingsamplitude met een overschrijdings    *
REM *     kans van 10^-2 per passage. Lengte traject 3000 m.       *
REM *                                                             *
REM ***************************************************************
tijdsduur = 3000 / VS * 2: REM  snelheid van [knots] naar [m/s]
AANTAL = tijdsduur / T1: REM  aantal oscillaties
NKC = SQR(-2 * LOG(-1 / AANTAL * LOG(1 - .01))) / 4:
REM net keelclearancefactor
REM NKC is factor waarmee significantie bewegingshoogte dient te
REM worden vermenigvuldigd om de benodigde netto kielspeling
REM te verkrijgen.
PRINT
PRINT "number of oscillations   : "; USING "####"; AANTAL
PRINT "net keelclearance factor : "; USING "#.##"; NKC
PRINT : PRINT
REM *********************************************************
REM *                                                       *
REM *     berekening squat volgens methode als aanbevolen   *
REM *     door het waterloopkundig laboratorium  :          *
REM *     Tuck-Tayler methode, aangepast door Huuska        *
REM *                                                       *
REM *********************************************************
FH = VS / 2 / SQR(9.810001 * wd): REM   getal van Froude + vs naar m/s
squat = 1.75 * IV * FH * FH / (LPP * LPP * SQR(1 - FH * FH))
squat = squat * (7.45 * draft / wd / 9 + .76): REM   Huuska factor
PRINT "CALCULATED SQUAT (Tuck Taylor) : "; USING "#.##"; squat
3120 a$ = INKEY$: IF a$ = "" THEN 3120
CLS
PRINT "significant motion amplitude during passage and"
PRINT "maximum motion amplitude (chance of exceeding 1% per passage)"
PRINT "============================================================="
PRINT
PRINT "angle     speed     amplif.     sign. ampl.     1% ampl.     advice"
PRINT "[deg]    [knots]      [-]           [m]           [m]        go/stop"
PRINT "=====    =======      ===           ===           ===        ======="
PRINT "   0        4       ";
PRINT USING "####.##"; RA4 / HS * 100; : PRINT USING "############.##"; RA4 / 2;
PRINT USING "#############.##"; RA4 * NKC; : PRINT "        ";
decis1 = 0
decis2 = 0
IF (wd - draft - squat - RA4 * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  30        4       ";
PRINT USING "####.##"; RB4 / HS * 100; : PRINT USING "############.##"; RB4 / 2;
PRINT USING "#############.##"; RB4 * NKC; : PRINT "        ";
IF (wd - draft - squat - RB4 * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  45        4       ";
PRINT USING "####.##"; RC4 / HS * 100; : PRINT USING "############.##"; RC4 / 2;
PRINT USING "#############.##"; RC4 * NKC; : PRINT "        ";
IF (wd - draft - squat - RC4 * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  135       4       ";
PRINT USING "####.##"; RD4 / HS * 100; : PRINT USING "############.##"; RD4 / 2;
PRINT USING "#############.##"; RD4 * NKC; : PRINT "        ";
IF (wd - draft - squat - RD4 * NKC) < 0 THEN
    PRINT "STOP"
    decis2 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  180       4       ";
PRINT USING "####.##"; RE4 / HS * 100; : PRINT USING "############.##"; RE4 / 2;
PRINT USING "#############.##"; RE4 * NKC; : PRINT "        ";
IF (wd - draft - squat - RE4 * NKC) < 0 THEN
    PRINT "STOP"
    decis2 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "   0       12       ";
PRINT USING "####.##"; RAT / HS * 100; : PRINT USING "############.##"; RAT / 2;
PRINT USING "#############.##"; RAT * NKC; : PRINT "        ";
IF (wd - draft - squat - RAT * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  30       12       ";
PRINT USING "####.##"; RBT / HS * 100; : PRINT USING "############.##"; RBT / 2;
PRINT USING "#############.##"; RBT * NKC; : PRINT "        ";
IF (wd - draft - squat - RBT * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  45       12       ";
PRINT USING "####.##"; RCT / HS * 100; : PRINT USING "############.##"; RCT / 2;
PRINT USING "#############.##"; RCT * NKC; : PRINT "        ";
IF (wd - draft - squat - RCT * NKC) < 0 THEN
    PRINT "STOP"
    decis1 = 1
  ELSE
    PRINT "GO"
END IF
PRINT "  135      12       ";
PRINT USING "####.##"; RDT / HS * 100; : PRINT USING "############.##"; RDT / 2;
PRINT USING "#############.##"; RDT * NKC; : PRINT "        ";
IF (wd - draft - squat - RDT * NKC) < 0 THEN
    PRINT "STOP"
    decis2 = 1
  ELSE
    PRINT "GO"
  END IF
PRINT "  180      12       ";
PRINT USING "####.##"; RET / HS * 100; : PRINT USING "############.##"; RET / 2;
PRINT USING "#############.##"; RET * NKC; : PRINT "        ";
IF (wd - draft - squat - RET * NKC) < 0 THEN
    PRINT "STOP"
    decis2 = 1
  ELSE
    PRINT "GO"
END IF
3620 a$ = INKEY$: IF a$ = "" THEN 3620
CLS
PRINT "SHIP HEADING FOR SHANNON RIVER :"
PRINT "================================"
PRINT
IF decis1 = 0 THEN GOTO 898
COLOR 15
PRINT "               XXXXXXXX    XXXXXXXX    XXXXXXXX    XXXXXXXX "
PRINT "               XXXXXXXX    XXXXXXXX    XXXXXXXX    XXXXXXXX "
PRINT "               XX             XX       XX    XX    XX    XX "
PRINT "               XX             XX       XX    XX    XX    XX "
PRINT "               XXXXXXXX       XX       XX    XX    XXXXXXXX "
PRINT "               XXXXXXXX       XX       XX    XX    XXXXXXXX "
PRINT "                     XX       XX       XX    XX    XX       "
PRINT "                     XX       XX       XX    XX    XX       "
PRINT "               XXXXXXXX       XX       XXXXXXXX    XX       "
PRINT "               XXXXXXXX       XX       XXXXXXXX    XX       "
COLOR 7, 0
GOTO 899
898 REM
COLOR 15
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XX          XX    XX             "
PRINT "                           XX          XX    XX             "
PRINT "                           XX  XXXX    XX    XX             "
PRINT "                           XX  XXXX    XX    XX             "
PRINT "                           XX    XX    XX    XX             "
PRINT "                           XX    XX    XX    XX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
COLOR 7, 0
899 LOCATE 24, 1
PRINT "any key to continue...";
912 a$ = INKEY$: IF a$ = "" THEN 912
CLS
PRINT "SHIP HEADING FOR ATLANTIC OCEAN :"
PRINT "================================="
PRINT
IF decis2 = 0 THEN GOTO 888
COLOR 15
PRINT "               XXXXXXXX    XXXXXXXX    XXXXXXXX    XXXXXXXX "
PRINT "               XXXXXXXX    XXXXXXXX    XXXXXXXX    XXXXXXXX "
PRINT "               XX             XX       XX    XX    XX    XX "
PRINT "               XX             XX       XX    XX    XX    XX "
PRINT "               XXXXXXXX       XX       XX    XX    XXXXXXXX "
PRINT "               XXXXXXXX       XX       XX    XX    XXXXXXXX "
PRINT "                     XX       XX       XX    XX    XX       "
PRINT "                     XX       XX       XX    XX    XX       "
PRINT "               XXXXXXXX       XX       XXXXXXXX    XX       "
PRINT "               XXXXXXXX       XX       XXXXXXXX    XX       "
COLOR 7, 0
GOTO 889
888 REM
COLOR 15
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XX          XX    XX             "
PRINT "                           XX          XX    XX             "
PRINT "                           XX  XXXX    XX    XX             "
PRINT "                           XX  XXXX    XX    XX             "
PRINT "                           XX    XX    XX    XX             "
PRINT "                           XX    XX    XX    XX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
PRINT "                           XXXXXXXX    XXXXXXXX             "
COLOR 7, 0
889 LOCATE 24, 1
PRINT "any key to continue...";
3640 a$ = INKEY$: IF a$ = "" THEN 3640
FOR i = 1 TO 101
  AY4(i) = AAY4(i)
  BY4(i) = BBY4(i)
  CY4(i) = CCY4(i)
  DY4(i) = DDY4(i)
  EY4(i) = EEY4(i)
  AYT(i) = AAYT(i)
  BYT(i) = BBYT(i)
  CYT(i) = CCYT(i)
  DYT(i) = DDYT(i)
  EYT(i) = EEYT(i)
NEXT i
'
'  ============================
'  uitbreiding : printeruitvoer
'  ============================
CLS
INPUT "Do you like to have printer output "; a$
IF a$ = "Y" OR a$ = "y" THEN
   PRINT "check that the printer is online....."
   PRINT
   PRINT "check any key to continue, or press S to skip printing"
   PRINT
357 a$ = INKEY$: IF a$ = "" THEN 357
   IF a$ = "S" OR a$ = "s" THEN GOTO 963
ELSE
   GOTO 963
END IF
LPRINT "INPUT CHARACTERISTICS :": LPRINT "======================": LPRINT
LPRINT "displacement                         [m3] : "; USING "######"; IV
LPRINT "draft                                 [m] : "; USING "###.##"; draft
LPRINT "length between perpendiculars         [m] : "; USING "###.##"; LPP
LPRINT "speed                             [knots] : "; USING "######"; VS
LPRINT "waterdepth                            [m] : "; USING "###.##"; wd
LPRINT
LPRINT
LPRINT "RESULTS OF WAVE MEASUREMENTS"
LPRINT "============================"
LPRINT
LPRINT "significant wave height Hmo           [m] : "; USING "###.##"; Hm0 / 100
LPRINT "significant wave height Hs            [m] : "; USING "###.##"; HS / 100
LPRINT "average wave period                 [sec] : "; USING "###.##"; T1
LPRINT
LPRINT
LPRINT "CALCULATION RESULTS"
LPRINT "==================="
LPRINT
LPRINT "passage time for 3000 m             [sec] : "; USING "######"; tijdsduur
LPRINT "number of oscillations                    : "; USING "######"; AANTAL
LPRINT "net keelclearance factor                  : "; USING "###.##"; NKC
LPRINT "calculated squat                      [m] : "; USING "###.##"; squat
LPRINT
LPRINT "remaining depth for wave motions      [m] : "; USING "###.##"; wd - draft - squat
LPRINT
LPRINT
LPRINT "Ship heading for Shannon River :"
LPRINT
LPRINT "angle     speed     amplif.     sign. ampl.     1% ampl.     advice"
LPRINT "[deg]    [knots]      [-]           [m]           [m]        go/stop"
LPRINT "=====    =======      ===           ===           ===        ======="
LPRINT "   0        4       ";
LPRINT USING "##.##"; RA4 / HS * 100; : LPRINT USING "###########.##"; RA4 / 2;
LPRINT USING "###########.##"; RA4 * NKC; : LPRINT "         ";
decis1 = 0
decis2 = 0
IF (wd - draft - squat - RA4 * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  30        4       ";
LPRINT USING "##.##"; RB4 / HS * 100; : LPRINT USING "###########.##"; RB4 / 2;
LPRINT USING "###########.##"; RB4 * NKC; : LPRINT "         ";
IF (wd - draft - squat - RB4 * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  45        4       ";
LPRINT USING "##.##"; RC4 / HS * 100; : LPRINT USING "###########.##"; RC4 / 2;
LPRINT USING "###########.##"; RC4 * NKC; : LPRINT "         ";
IF (wd - draft - squat - RC4 * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "   0       12       ";
LPRINT USING "##.##"; RAT / HS * 100; : LPRINT USING "###########.##"; RAT / 2;
LPRINT USING "###########.##"; RAT * NKC; : LPRINT "         ";
IF (wd - draft - squat - RAT * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  30       12       ";
LPRINT USING "##.##"; RBT / HS * 100; : LPRINT USING "###########.##"; RBT / 2;
LPRINT USING "###########.##"; RBT * NKC; : LPRINT "         ";
IF (wd - draft - squat - RBT * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  45       12       ";
LPRINT USING "##.##"; RCT / HS * 100; : LPRINT USING "###########.##"; RCT / 2;
LPRINT USING "###########.##"; RCT * NKC; : LPRINT "         ";
IF (wd - draft - squat - RCT * NKC) < 0 THEN
    LPRINT "STOP"
    decis1 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT
LPRINT
LPRINT "Ship heading for Atlantic Ocean :"
LPRINT
LPRINT "angle     speed     amplif.     sign. ampl.     1% ampl.     advice"
LPRINT "[deg]    [knots]      [-]           [m]           [m]        go/stop"
LPRINT "=====    =======      ===           ===           ===        ======="
LPRINT "  135       4       ";
LPRINT USING "##.##"; RD4 / HS * 100; : LPRINT USING "###########.##"; RD4 / 2;
LPRINT USING "###########.##"; RD4 * NKC; : LPRINT "         ";
IF (wd - draft - squat - RD4 * NKC) < 0 THEN
    LPRINT "STOP"
    decis2 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  180       4       ";
LPRINT USING "##.##"; RE4 / HS * 100; : LPRINT USING "###########.##"; RE4 / 2;
LPRINT USING "###########.##"; RE4 * NKC; : LPRINT "         ";
IF (wd - draft - squat - RE4 * NKC) < 0 THEN
    LPRINT "STOP"
    decis2 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT "  135      12       ";
LPRINT USING "##.##"; RDT / HS * 100; : LPRINT USING "###########.##"; RDT / 2;
LPRINT USING "###########.##"; RDT * NKC; : LPRINT "         ";
IF (wd - draft - squat - RDT * NKC) < 0 THEN
    LPRINT "STOP"
    decis2 = 1
  ELSE
    LPRINT "GO"
  END IF
LPRINT "  180      12       ";
LPRINT USING "##.##"; RET / HS * 100; : LPRINT USING "###########.##"; RET / 2;
LPRINT USING "###########.##"; RET * NKC; : LPRINT "         ";
IF (wd - draft - squat - RET * NKC) < 0 THEN
    LPRINT "STOP"
    decis2 = 1
  ELSE
    LPRINT "GO"
END IF
LPRINT
LPRINT
LPRINT "CONCLUSION"
LPRINT "=========="
LPRINT
IF decis1 = 0 THEN
  LPRINT "Ship heading for Shannon River  : PROCEED !"
  ELSE
  LPRINT "Ship heading for Shannon River  : WAIT !"
END IF
IF decis2 = 0 THEN
  LPRINT "Ship heading for Atlantic Ocean : PROCEED !"
  ELSE
  LPRINT "Ship heading for Atlantic Ocean : WAIT !"
END IF
LPRINT CHR$(12)
963 CLS

KEY ON
END SUB

SUB MakeSpt (D(), var())

DIM a(255), si(255), co(255)
DIM Re(255), Im(255), R(255), i(255)
CALL MakeTables(a(), co(), si())

FOR n = 0 TO 127
        var(n) = 0
NEXT

FOR i = 0 TO 5
        CALL Transfer(i, D(), Re(), Im())
        CALL Taper(a(), co(), Re(), Im())
        CALL FFT(co(), si(), a(), Re(), Im(), R(), i())
        CALL Variance(var(), R(), i())
NEXT

END SUB

SUB MakeTables (a(), co(), si())

PI = 3.1415927#

a(255) = 0: j = 0: k = 256

WHILE k >= 1
        FOR i = .5 * k TO k - 1
        a(j) = i: j = j + 1
        NEXT
k = .5 * k
WEND
        i = 0

FOR k = 0 TO 255
        j = a(i): a(i) = k
        co(i) = COS(PI * k / 256)
        si(i) = SIN(PI * k / 256)
        i = j
NEXT

END SUB

SUB Offset (D(), Offs)

Offs = 0
        FOR i = 0 TO 5
                FOR j = 0 TO 511
                        Offs = Offs + D(i, j)
                NEXT
        NEXT
        Offs = Offs / 3072
        FOR i = 0 TO 5
                FOR j = 0 TO 511
                        D(i, j) = D(i, j) - Offs
                NEXT
        NEXT

END SUB

SUB OpenCom (comport$)

        CLOSE #1
       
        OPEN comport$ + ":2400,n,8,1,cs0,ds0,cd0" FOR RANDOM AS #1
        

END SUB

SUB PlotData (D(), HS, Offs)
max = 0
        FOR i = 0 TO 5
                FOR j = 0 TO 511
                        IF ABS(D(i, j)) > max THEN max = ABS(D(i, j))
                NEXT
        NEXT
SCREEN 9: CLS
PRINT USING "Offset = +### cm , Hs = ##.## m"; Offs; .01 * HS
WINDOW (0, 0)-(512, 14 * max)
        FOR i = 0 TO 5
                y = (12 - 2 * i) * max
                PSET (512, y): LINE -(0, y)
                FOR j = 0 TO 511
                        LINE -(j, D(i, j) + y)
                NEXT
        NEXT

END SUB

SUB PlotSpec (var(), Hm0, Tz)

OPEN "C:\diwar\program\graphchr" FOR INPUT AS #1
FOR n = 0 TO 127
        LINE INPUT #1, char$(n)
NEXT
CLOSE #1

SCREEN 9: CLS
        PRINT USING " Hm0 = ##.## m  , Tz = ##.## sec"; .01 * Hm0; Tz

        max = 0
        
        FOR n = 0 TO 127
                IF var(n) > max THEN max = var(n)
        NEXT

        WINDOW (-10, -.2 * max)-(127, 1.2 * max)
        FOR n = 0 TO 120 STEP 40
                PSET (n, 0)
                LINE -(n, -.02 * max)
                txt$ = STR$(.005 * n)
                CALL drawtext("s4bd12bl24", txt$)
        NEXT
        CALL drawtext("s4", "Hz")
        PSET (127, 0)
        LINE -(0, 0)

        FOR n = 1 TO 127
                LINE -(n, var(n))
        NEXT


END SUB

SUB PseudoPlot (var(), Hm0, Tz)
REM ***************** PLOT IN ALPHA SCREEN *******************************
DIM spec(60)
SCREEN 0: CLS
PRINT USING "SIGNIFICANT WAVE HEIGHT: ##.## m        Tz (TM02): ##.# sec"; .01 * Hm0; Tz

FOR n = 1 TO 60
        spec(n) = .5 * (var(2 * n - 1) + var(2 * n))
        IF spec(n) > max THEN max = spec(n)
NEXT

FOR n = 1 TO 60
        a = spec(n) / max * 16
        n1 = 0
        DO
                n2 = ((a - n1) > .5) - 220 * ((a - n1) > .25)
                LOCATE 20 - n1, n, 0
                PRINT CHR$(n2)
                n1 = n1 + 1
        LOOP UNTIL n2 = 0
NEXT
LOCATE 21, 1, 0
FOR n = 1 TO 12
        PRINT CHR$(194); CHR$(194); CHR$(194); CHR$(194); CHR$(203);
NEXT
FOR n = 1 TO 11
        LOCATE 22, 5 * n - 1, 0: PRINT .05 * n;
NEXT
LOCATE 22, 59, 0: PRINT "Hz";

END SUB

SUB SendCommand (n)
        PRINT #1, CHR$(n);

END SUB

SUB simul (D())
        FOR i = 0 TO 5
                FOR j = 0 TO 511
                        D(i, j) = 100 * SIN(.5 * j)
                NEXT
        NEXT
END SUB

SUB Taper (a(), co(), Re(), Im())

FOR nd = 0 TO 31

         n1 = 8 * nd: n2 = a(n1 + 4): n1 = a(n1): n0 = 255 - nd
         a = .5 * (1 - co(n1)): b = .5 * (1 - co(n2))
         Re(nd) = a * Re(nd): Im(nd) = b * Im(nd)
         Re(n0) = b * Re(n0): Im(n0) = a * Im(n0)

NEXT

END SUB

SUB Terminal
SCREEN 0: CLS
PRINT "Press ESC to exit terminal mode"
DO
        i$ = INKEY$
        IF i$ <> "" THEN
                IF i$ = CHR$(27) THEN
                        EXIT SUB
                ELSE
                        PRINT #1, i$;
                END IF
        END IF
         WHILE NOT EOF(1)
                PRINT INPUT$(LOC(1), #1);
         WEND
LOOP

END SUB

SUB Terminate

        LOCATE 24, 1, 0
        PRINT #1, "+++ATH0"
        PRINT SPACE$(80);
        PRINT "DISCONNECTED";
        CLOSE #1

END SUB

SUB TestLock (diwar, channel, chn)

        command = 4 * diwar + 32 * (channel + 1)
                CALL SendCommand(command)
                FOR n = 0 TO 5
                        y$ = INPUT$(3, #1)
                NEXT
                IF ASC(MID$(y$, 3, 1)) = chn THEN
                        PRINT "CHANNEL "; channel;
                ELSE
                        PRINT "CAN NOT CONTROL CHANNEL !"

                END IF
                WHILE ASC(y$) > 127
                        PRINT "      UNLOCKED";
                        LOCATE , 15, 0
                        FOR n = 1 TO 5
                                y$ = INPUT$(3, #1)
                        NEXT
                WEND
                        
                        PRINT "        LOCKED", TIME$
END SUB

SUB Transfer (i, D(), Re(), Im())

    FOR n = 0 TO 255
        Re(n) = D(i, 2 * n)
        Im(n) = D(i, 2 * n + 1)
    NEXT

END SUB

SUB Variance (var(), R(), i())

k = .5 * 200 * (32 / 27) / 6
'.5 * (1/df) * (correction for taper)/(6 blocks)

        FOR n = 0 TO 127
                var(n) = var(n) + k * (R(n) * R(n) + i(n) * i(n))
        NEXT

END SUB

