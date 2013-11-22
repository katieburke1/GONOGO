'test program to com one
'
DECLARE SUB OpenCom (comport$)

COMMON SHARED X, Y
comport$ = "com1"


CLS
PRINT "please enter a value"
INPUT X
LET Y = X * 10
CLS
PRINT X + 10, X, Y
CALL OpenCom(comport$)

SUB OpenCom (comport$)

CLOSE #1

OPEN comport$ + ":2400,n,8,1,cs0,ds0,cd0" FOR OUTPUT AS #1


PRINT #1, "HS ="; X, Y;
END SUB

