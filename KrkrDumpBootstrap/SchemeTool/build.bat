@REM path "Y:\Partition1\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\Roslyn"
path "%~dp0\Roslyn"

@SET "OUTPUTEXE=D:\WIN\GARbro-mod\bin\Debug\SchemeTool.HxCrypt.exe"

cd /d "E:\WIN\GARbro-mod\bin\Debug\"

del %OUTPUTEXE%
"csc.exe" %~dp0\SchemeTool.cs -out:%OUTPUTEXE% -reference:GameRes.dll -reference:ArcFormats.dll
%OUTPUTEXE%
pause