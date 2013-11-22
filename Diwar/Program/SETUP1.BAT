ECHO Type Ctrl-Break to abort if you don't have a hard disk or would rather
ECHO just do it yourself - - - 
ECHO 
PAUSE
IF "%3"=="" GOTO ExNoD
IF EXIST %3\*.* GOTO ExD
md %3
:ExD
ECHO Copying BC.EXE and QB.EXE to %1%3
copy a:*.exe %3
ECHO 
ECHO Put Disk 2 in drive A:
PAUSE
ECHO 
ECHO Copying BRUN41.EXE to %1%3
copy a:*.exe %3
GOTO CpyLib
:ExNoD
ECHO Copying BC.EXE and QB.EXE to %1%2
copy a:*.exe %2
ECHO 
ECHO Put Disk 2 in drive A:
PAUSE
ECHO 
ECHO Copying BRUN41.EXE to %1%2
copy a:*.exe %2
:CpyLib
IF "%4"=="" GOTO LiNoD
IF EXIST %4\*.* GOTO LiD
md %4
:LiD
ECHO Copying LIB files to %1%4
copy a:*.lib %4
GOTO Cpy1
:LiNoD
ECHO Copying LIB files to %1%2
copy a:*.lib %2
:Cpy1
ECHO 
ECHO Put Disk 3 in drive A:
PAUSE
ECHO 
IF "%3"=="" GOTO Ex2NoD
ECHO Copying LIB.EXE, LINK.EXE, and MOUSE.COM to %1%3
copy a:*.exe %3
copy a:mouse.com %3
GOTO Fin
:Ex2NoD
ECHO Copying LIB.EXE, LINK.EXE, and MOUSE.COM to %1%2
copy a:*.exe %2
copy a:mo*.* %2
:Fin
ECHO 
ECHO Copying BAS files to %1%2
copy a:*.bas %2
copy a:\source\*.* %2
ECHO 
ECHO Copying other supporting files to %1%2
copy a:qb.* %2
copy a:*.obj %2
ECHO 
ECHO Installation complete.
ECHO 
ECHO Installation does NOT modify DOS environment variables.
IF "%3"=="" GOTO Ex3NoD
ECHO Since you specified %1%3 for EXE and COM files, you should ensure
ECHO you have an appropriate PATH= parameter in your autoexec.bat.
:Ex3NoD
IF "%4"=="" GOTO Li2NoD
ECHO Since you specified %1%4 for LIB files, you should ensure you have an
ECHO appropriate LIB= parameter in your autoexec.bat.
:Li2NoD
ECHO For complete information on setting DOS environment variables for use
ECHO with QuickBASIC, see the section entitled 'Setting DOS Environment
ECHO Variables' in the 'Learning and Using QuickBASIC' manual.
ECHO 
ECHO Note that installation does not copy README.DOC or PACKING.LST from disk 1,
ECHO UPDATE.DOC from DISK 2, or QBHERC.COM, FIXSHIFT.COM, PATCH87.EXE,
ECHO ABSOLUTE.ASM, or INTRPT.ASM from disk 3.
