@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:start
:: Чтение настроек из Config.ini
for /f "tokens=2 delims==" %%a in ('findstr /b "light_version=" Config.ini') do set MyVar=%%a
for /f "tokens=2 delims==" %%a in ('findstr /b "design=" Config.ini') do set MyVar1=%%a
for /f "tokens=2 delims==" %%a in ('findstr /b "PercentageCalculationMode=" Config.ini') do set MyVar2=%%a

cls
if "%MyVar1%"=="0" (
    set /p min="Введите меньшее число: "
    set /p max="Введите большее число: "
) else (
    echo === РАСЧЁТ ПРОЦЕНТНОЙ РАЗНИЦЫ ===
    set /p min="Введите меньшее число: "
    set /p max="Введите большее число: "
)
if "%MyVar%"=="1" (
goto res
)
:: Проверка корректности ввода
for %%i in (%min% %max%) do (
    echo %%i|findstr "^[0-9][0-9]*$">nul || (
        echo Ошибка: введите целые числа!
        pause
        goto start
    )
)

:: Проверка на деление на ноль
if %min%==0 (
    echo Ошибка: меньшее число не может быть нулём!
    pause
    goto start
)
if %max%==0 (
    echo Ошибка: большее число не может быть нулём!
    pause
    goto start
)
:: Расчёт абсолютной разницы
set /a diff=%max%-%min%

:: Расчёт процентной разницы (базируется на большем числе)
set /a percent=diff*100/%max%
set /a percent=100-%percent%


echo Результат:
echo Разница между числами %min% и %max%:
timeout /t 2 /nobreak >nul
echo * Абсолютная: %diff%
timeout /t 2 /nobreak >nul
echo * Процентная: %percent%%%
echo.
pause
goto start
