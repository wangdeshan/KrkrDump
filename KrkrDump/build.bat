@cls
@path "T:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\Hostx86\x86";%PATH%

@SET CURPWD=%CD%

:ST
@cd %CURPWD%
@cls
@REM @CALL :CREATELIB debug
@REM @CALL :CREATELIB release
@CALL :BUILDDLL
@dir ..\KrkrDumpBootstrap\bin | findstr KrkrDump | sort
@pause
@goto ST

:CREATELIB
@mkdir libs
@cd %CURPWD%
@echo.%1
@SET LTYPE=%1
@cd %LTYPE%

@lib.exe /out:..\libs\cJSON_%LTYPE%.lib cJSON.obj
@lib.exe /out:..\libs\tp_stub_%LTYPE%.lib tp_stub.obj
@lib.exe /out:..\libs\zlib_%LTYPE%.lib  adler32.obj compress.obj crc32.obj deflate.obj gzclose.obj gzlib.obj gzread.obj gzwrite.obj infback.obj inffast.obj inflate.obj inftrees.obj trees.obj uncompr.obj zutil.obj
@lib.exe /out:..\libs\Common_%LTYPE%.lib encoding.obj file.obj log.obj path.obj pe.obj stringhelper.obj util.obj
@lib.exe /out:..\libs\detours_%LTYPE%.lib creatwth.obj detours.obj disasm.obj image.obj modules.obj
@lib.exe /out:..\libs\AllInOne_%LTYPE%.lib *.obj

@cd %CURPWD%
@goto :EOF

:BUILDDLL 
@cd %CURPWD%
@cl.exe /nologo ^
	dllmain.cpp ^
	/Fe:..\KrkrDumpBootstrap\bin\KrkrDump.dll ^
	/Fd:..\KrkrDumpBootstrap\bin\KrkrDump.pdb ^
	/Fo:..\KrkrDumpBootstrap\bin\KrkrDump.obj ^
	/LD ^
	/I"T:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\um" ^
	/I"T:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\shared" ^
	/I"T:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\ucrt" ^
	/I"T:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include" ^
	/I"..\Common" ^
	/I"..\Detours\src" ^
	/I"..\cJSON" ^
	/I"..\zlib" ^
	/I"..\KrkrPlugin" ^
	/MT ^
	/EHsc ^
	/link ^
	/LTCG ^
	/LIBPATH:"T:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x86" ^
	/LIBPATH:"T:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\ucrt\x86" ^
	/LIBPATH:"T:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\lib\x86" ^
	/LIBPATH:".\libs" ^
	AllInOne_release.lib ^
	Shell32.lib Comdlg32.lib User32.lib
@cd %CURPWD%
@goto :EOF

:EOF