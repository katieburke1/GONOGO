REM                     set com port parameters
RESTORE
SCREEN 9, 1, 1, 1
COLOR 14, 1
DIM col$(5, 1): FOR i = 0 TO 5: FOR j = 0 TO 1: READ col$(i, j): NEXT j: NEXT i: REM Start values for default
DIM C(6): FOR i = 0 TO 6: READ C(i): NEXT i: REM Start position in data matrix for each parameter
DIM a$(25): FOR i = 0 TO 25: READ a$(i): NEXT i: REM Parameter data
DATA 1,0,19200,0,None,0,5,0,1,0,YES,0
DATA 0,3,12,17,21,24,26
DATA  1,2,3
DATA  19200,9600,4800,2400,1200,600,300,150,110
DATA  None, Odd, Even, Mark, Space
DATA  5,6,7,8
DATA  1 , 1.5 ,2
DATA  YES ,  NO

REM                     Define keys

KEY 15, CHR$(&H80) + CHR$(72): REM up
KEY 16, CHR$(&H80) + CHR$(75): REM left
KEY 17, CHR$(&H80) + CHR$(77): REM right
KEY 18, CHR$(&H80) + CHR$(80): REM down

KEY 19, CHR$(&H0) + CHR$(57): REM :space bar
KEY 20, CHR$(&H0) + CHR$(28): REM :return

PRINT TAB(30); "COM PORT SET UP": LOCATE 10, 1
PRINT "PORT NO"; TAB(21); a$(C(0))
PRINT "SPEED(baud) "; TAB(21); a$(C(1))
PRINT "parity "; TAB(21); a$(C(2))
PRINT "data  "; TAB(21); a$(C(3))
PRINT "stop "; TAB(21); a$(C(4))
PRINT "Retry"; TAB(21); a$(C(5))

1000
GOSUB keystop
temp = VAL(col$(r, 1)): range = C(r + 1) - C(r) - 1
location = C(r) + temp
LOCATE (10 + r), 21: PRINT "           ";
FOR i = 1 TO 30000: NEXT i
LOCATE (10 + r), 21: PRINT a$(C(r) + temp); : col$(r, 0) = a$(location)
LOCATE 19, 1: PRINT " com string selected is";
LOCATE 20, 1: Q$ = "                                        ": PRINT Q$;
LOCATE 20, 1:
p$ = "com":
p$ = p$ + col$(0, 0) + ":": p$ = p$ + MID$(col$(1, 0), 1, 2):
p$ = p$ + "," + MID$(col$(2, 0), 1, 1)
p$ = p$ + "," + MID$(col$(3, 0), 1, 1)
p$ = p$ + "," + MID$(col$(4, 0), 1, 1)
p$ = p$ + "," + MID$(col$(5, 0), 1, 1)
PRINT p$;
FOR i = 1 TO 30000: NEXT i

KEY(11) ON
KEY(12) ON
KEY(13) ON
KEY(14) ON
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
KEY(19) ON
KEY(20) ON

ON KEY(11) GOSUB up
ON KEY(12) GOSUB left
ON KEY(13) GOSUB right
ON KEY(14) GOSUB down
ON KEY(15) GOSUB up
ON KEY(16) GOSUB left
ON KEY(17) GOSUB right
ON KEY(18) GOSUB down

ON KEY(19) GOSUB finish
ON KEY(20) GOSUB finish

GOTO 1000
END

up: GOSUB keystop
LOCATE (10 + r), 20: PRINT "           "
LOCATE (10 + r), 21: PRINT a$(C(r) + temp);
IF r = 0 THEN RETURN
r = r - 1

RETURN

left: GOSUB keystop
LOCATE (10 + r), 20: PRINT "           "
LOCATE (10 + r), 21: PRINT a$(C(r) + temp);
IF VAL(col$(r, 1)) = 0 THEN RETURN
col$(r, 1) = STR$(VAL(col$(r, 1)) - 1)

RETURN

right: GOSUB keystop
LOCATE (10 + r), 20: PRINT "           "
LOCATE (10 + r), 21: PRINT a$(C(r) + temp);
IF VAL(col$(r, 1)) = range THEN RETURN
col$(r, 1) = STR$(VAL(col$(r, 1)) + 1)

RETURN

down: GOSUB keystop
LOCATE (10 + r), 20: PRINT "           "
LOCATE (10 + r), 21: PRINT a$(C(r) + temp);
IF r = 5 THEN RETURN
r = r + 1

RETURN

finish: BEEP: END

REM shell "com$"
GOTO 1000

keystop:
KEY(11) STOP
KEY(12) STOP
KEY(13) STOP
KEY(14) STOP
KEY(15) STOP
KEY(16) STOP
KEY(18) STOP
KEY(19) STOP
KEY(20) STOP
RETURN

