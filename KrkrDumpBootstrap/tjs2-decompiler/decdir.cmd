@SET Var0=%0
@IF '^%Var0:~0,1%'=='^"' @SET Var0=%Var0:~1,-1%
@FOR /f "delims=" %%I in ("%Var0%") do @Set PD=%%~dpI

@cd /d %PD:~0,-1%

@SET Var0=%*
@IF '^%Var0:~0,1%'=='^"' @SET "Var0=%Var0:~1,-1%"

@python3 tjs2_decompiler.py "%Var0%" -r -o "%Var0%.decomp"
@pause