@echo off
REM Description:
REM    Simple command script to copy hooks to .git/hooks folder.
REM Syntax:
REM    cm-git\install-hooks.bat [git-repo]
REM Notes:
REM If [git-repo] is supplied, the hooks are copied to the git-repo,
REM else the hooks are copied to all git-repositories found below the
REM current directory.
REM NOTE: that if one of the repositories contains read-only hooks,
REM the script will fail.

SET mypath=%~dp0
SET repo=%1
SET hooks=%mypath%hooks

REM git-repo is not supplied
IF [%repo%] == [] GOTO :copy_all

REM git-repo is supplied
IF NOT EXIST %repo%\.git ECHO "ERROR: %repo% is not a git repository"
IF EXIST %repo%\.git (CALL :copy_hooks "%repo%\.git\hooks")

GOTO :eof

:copy_all
FOR /f "tokens=*" %%G IN ('dir /s /ad /b hooks') DO (CALL :copy_hooks "%%G")
GOTO :eof

:copy_hooks
 @setlocal enableextensions enabledelayedexpansion
 SET dest_folder=%1
 echo Installing hooks in: %dest_folder%
 IF NOT x%dest_folder:.git\hooks=%==x%dest_folder% COPY %hooks%\* %dest_folder%
 REM IF x%dest_folder:.git\hooks=%==x%dest_folder% ECHO "Skipped: not a git hooks folder: %dest_folder%
 endlocal
 EXIT /B
