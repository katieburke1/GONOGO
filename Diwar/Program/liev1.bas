DECLARE SUB LIEVENSE ()
COMMON SHARED Hm0, HS, Tz
DIM SHARED X(127)
CLS
PRINT "Enter HS value from VTS in meters"
INPUT HS
PRINT "Enter Tz (wave period) value in seconds"
INPUT Tz
PRINT "Enter Hmo in meters"
INPUT Hm0
PRINT "PRESS F9 to calculate passage statics"
KEY 9, "GO ?": ON KEY(9) GOSUB LIEV: KEY(9) ON

LIEV:
        CALL LIEVENSE
RETURN


SUB LIEVENSE
'LIEVENSE Program with values available
'Version 1 date: 5 mar 02 liam Kelly
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

'
KEY ON
END SUB

