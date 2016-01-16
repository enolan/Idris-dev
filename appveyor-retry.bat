@echo off
SETLOCAL
SETLOCAL EnableDelayedExpansion

REM run a command and retry it if it fails. The AppVeyor VMs have unreliable
REM network connections

FOR /L %%I IN (1,1,3) DO (
    %*
    IF !ERRORLEVEL! NEQ 0 (
        ECHO "Command failed, attempt %%I"
    ) ELSE (
        EXIT /B 0
    )
)

ECHO "Too many retries, failing"
EXIT /B 1
