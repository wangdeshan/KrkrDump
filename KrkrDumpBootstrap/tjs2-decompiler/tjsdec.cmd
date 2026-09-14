@SET Var0=%0
@IF '^%Var0:~0,1%'=='^"' @SET Var0=%Var0:~1,-1%
@FOR /f "delims=" %%I in ("%Var0%") do @Set PD=%%~dpI

@cd /d %PD:~0,-1%

@SET Var0=%*
@IF '^%Var0:~0,1%'=='^"' @SET "Var0=%Var0:~1,-1%"

@FOR /f "delims=" %%I in ("%Var0%") do @Set "OutBase=%%~pI"
@FOR /f "delims=" %%I in ("%Var0%") do @Set "OutNameBase=%%~nI"

@echo."%OutBase%\%OutNameBase%"

@Set "OutDir=R:\Tjsdec"
@Set "DecDir=%OutDir%\dec"

@mkdir "%DecDir%\%OutBase%">nul

@python3 tjs2_decompiler.py "%Var0%" -o "%DecDir%\%OutBase%\%OutNameBase%.tjs"
@start notepad "%DecDir%%OutBase%%OutNameBase%.tjs"
@REM @pause
