'test program to com one
'
DECLARE SUB OpenCom (comport$)

COMMON SHARED X
comport$ = "com1"



PRINT "please enter a value"
INPUT X
CLS
PRINT X + 1
COM(1) ON
OPEN "com1:9600,n,8,1" FOR OUTPUT AS #1
PRINT #1, X


COM(1) OFF




SUB OpenCom (comport$)

CLOSE #1

OPEN comport$ + "9600,n,8,1,cs0,ds0,cd0" FOR RANDOM AS #1

PRINT #1, "the value x is now"; X

END SUB

