@ECHO OFF

REM Start test 1 
buildindex.exe < tests\test1.txt > tests\output1.idx 
C:\Windows\System32\FC tests\output1.idx tests\correct1.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output1.idx 
ECHO Test1 succeed  

REM Start test 2 
buildindex.exe < tests\test2.txt > tests\output2.idx 
C:\Windows\System32\FC tests\output2.idx tests\correct2.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output2.idx 
ECHO Test2 succeed  

REM Start test 3 
buildindex.exe < tests\test3.txt > tests\output3.idx 
C:\Windows\System32\FC tests\output3.idx tests\correct3.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output3.idx 
ECHO Test3 succeed

REM Start test 4 
buildindex.exe < tests\test4.txt > tests\output4.idx 
C:\Windows\System32\FC tests\output4.idx tests\correct4.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output4.idx 
ECHO Test4 succeed 

REM Start test 5 
buildindex.exe < tests\test5.txt > tests\output5.idx 
C:\Windows\System32\FC tests\output5.idx tests\correct5.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output5.idx 
ECHO Test5 succeed 

REM Start test 6 
buildindex.exe < tests\test6.txt > tests\output6.idx 
C:\Windows\System32\FC tests\output6.idx tests\correct6.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output6.idx 
ECHO Test6 succeed 

REM Start test 7 
buildindex.exe < tests\test7.txt > tests\output7.idx 
C:\Windows\System32\FC tests\output7.idx tests\correct7.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output7.idx 
ECHO Test7 succeed 

REM Start test 8 
buildindex.exe < tests\test8.txt > tests\output8.idx 
C:\Windows\System32\FC tests\output8.idx tests\correct8.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output8.idx 
ECHO Test8 succeed 

ECHO ALL TESTS WERE SUCCEED

EXIT

:err
ECHO Test failed
EXIT