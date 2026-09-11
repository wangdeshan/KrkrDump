:ST
@cls
@call :SCRMAIN
@pause
@goto :ST

:SCRMAIN
@cd /d "W:\tenshin\ÌìÉñÂÒÂþ"
@for /f "delims=" %%f in ('dir /b /A-D *.xp3') do @call :Sub "%%f"
@type UnknownFileName.txt >UnknownFileName.prev.txt
@grep.exe  -inFr -C 5 UnknownFileName *.lst >UnknownFileName.txt
@BComp.exe UnknownFileName.txt UnknownFileName.prev.txt
goto :END

:Sub
@SET LIST=%*.lst
@REM @if exist %LIST% @GOTO :END
@echo.%*
@GARbro.Console.exe %* >%LIST%

:END