@set OCD=%CD%
@cd E:\WIN\GARbro-mod\bin\Debug
@mkdir GameData\已添加
@REM @ECHO.Copy Base Database
@type ..\..\ArcFormats\Resources\Formats.dat>GameData\Formats.base.dat
@type GameData\Formats.base.dat>GameData\Formats.orig.dat

@FOR /F "usebackq delims=" %%i IN (`dir /b SchemeTool.*.exe`) DO  @CALL :ADDScheme "%%i"
@CD %OCD%
@pause
@goto :END

:ADDScheme
@%1
@type GameData\Formats.dat>GameData\Formats.orig.dat
@move %1 GameData\已添加\%1
@goto :END


:END