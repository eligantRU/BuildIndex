@ECHO OFF

REM Start test 1 
buildindex.exe < tests\testYO.txt > tests\output1.idx 
C:\Windows\System32\FC /B tests\output1.idx tests\correctYO.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output1.idx 
ECHO Test YO succeed  

REM Start test 2 
buildindex.exe < tests\testDashesAndOpostrophesInsideLexems.txt > tests\output2.idx 
C:\Windows\System32\FC /B tests\output2.idx tests\correctDashesAndOpostrophesInsideLexems.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output2.idx 
ECHO Test DashesAndOpostrophesInsideLexems succeed  

REM Start test 3 
buildindex.exe < tests\testDashesAndOpostrophesOnLexemSides.txt > tests\output3.idx 
C:\Windows\System32\FC /B tests\output3.idx tests\correctDashesAndOpostrophesOnLexemSides.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output3.idx 
ECHO Test DashesAndOpostrophesOnLexemEdges succeed

REM Start test 4 
buildindex.exe < tests\testLexemCounting.txt > tests\output4.idx 
C:\Windows\System32\FC /B tests\output4.idx tests\correctLexemCounting.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output4.idx 
ECHO Test LexemCounting succeed 

REM Start test 5 
buildindex.exe < tests\testLowerRegister.txt > tests\output5.idx 
C:\Windows\System32\FC /B tests\output5.idx tests\correctLowerRegister.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output5.idx 
ECHO Test LowerRegister succeed 

REM Start test 6 
buildindex.exe < tests\testSingleDashesAndOpostrophes.txt > tests\output6.idx 
C:\Windows\System32\FC /B tests\output6.idx tests\correctSingleDashesAndOpostrophes.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output6.idx 
ECHO Test SingleDashesAndOpostrophes succeed 

REM Start test 7 
buildindex.exe < tests\testMerging.txt > tests\output7.idx 
C:\Windows\System32\FC /B tests\output7.idx tests\correctMerging.idx 
IF ERRORLEVEL 1 GOTO err 
DEL tests\output7.idx 
ECHO Test Merging succeed 

ECHO ALL TESTS WERE SUCCEED

EXIT

:err
ECHO Test failed
EXIT