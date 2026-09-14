:ST
@chcp 65001
@cls
@call :SCRMAIN
@pause
@goto :ST

:SCRMAIN
@REM @cd /d "I:\YUZUSOFT\natsukana"
@cd /d "W:\GINKA"
@REM @cd /d "I:\DC\DC5SH"
@REM @cd /d "I:\ryuu\HanaganeKanadeGram"
@REM @SET "name=fgimage"
@REM @SET "name=bgimage"
@REM @SET "name=evimage"
@REM @SET "name=voice"

@for /f "delims=" %%f in ('dir /b /A-D %name%*.xp3') do @call :Sub "%%f"
@type UnknownFileName.txt >UnknownFileName.prev.txt
@grep  -inFr -C 5 UnknownFileName *.lst >UnknownFileName.txt
@BCompare UnknownFileName.txt UnknownFileName.prev.txt
@goto :END

:Sub
@SET LIST=%*.lst
@SET LIST2=%*.filelist.txt
@if exist %LIST2% @GOTO :END
@echo.%*
@GARbro.Console.exe %* >%LIST%
@findstr "UnknownFileName_" %LIST% >nul 2>&1
@if "%errorlevel%" == "1" @rename %LIST% %LIST2%

:END