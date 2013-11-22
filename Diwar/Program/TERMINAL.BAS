comport$ = "com1"' Serial port


CLOSE #1

OPEN comport$ + ":2400,n,8,1,cs0,ds0,cd0" FOR RANDOM AS #1


SCREEN 0: CLS : KEY OFF
LOCATE 25, 1, 0: PRINT "Press ESC to Quit"
DO
        i$ = INKEY$
        IF i$ <> "" THEN
                IF i$ = CHR$(27) THEN
                        END
                ELSE
                        PRINT #1, i$;
                END IF
        END IF
         WHILE NOT EOF(1)
                PRINT INPUT$(LOC(1), #1);
         WEND
LOOP
CLOSE #1
END

