@echo off
title Gerenciador React Native Expo
setlocal enabledelayedexpansion

REM ============================
REM Gerenciador React Native Expo
REM Autor: Milton Bita
REM GitHub: https://github.com/MiltonBita
REM Nota: Pode fazer modificacoes e subir para o repositorio.
REM ============================

REM Obter o nome do utilizador automaticamente
set USERNAME=%USERNAME%

REM Definir caminhos
set ANDROID_EMULATOR="C:\Users\%USERNAME%\AppData\Local\Android\Sdk\emulator\emulator.exe"
set PROJECT_DIR="C:\ProjetosExpo"

REM Criar diretório padrão para projetos se não existir
if not exist %PROJECT_DIR% (
    mkdir %PROJECT_DIR%
)

REM Verificar se Node.js está instalado
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js não encontrado. Por favor, instale o Node.js para continuar.
    pause
    exit /b
)

REM Verificar se Expo CLI está instalada
where npx >nul 2>nul
if %errorlevel% neq 0 (
    echo Expo CLI não encontrada. Por favor, instale com 'npm install -g expo-cli'.
    pause
    exit /b
)

:menu
cls
echo ==========================================
echo      BEM-VINDO, %USERNAME%, AO GERENCIADOR EXPO
echo ==========================================
echo 1. Criar Projeto Expo
echo 2. Criar Projeto Expo Vazio
echo 3. Iniciar Servidor Expo
echo 4. Iniciar Emulador Android
echo 5. Sair e Encerrar
echo ==========================================

REM Mostrar a nota após o menu principal
echo ________________________________________________
echo.
echo    Autor: Milton Bita
echo    GitHub: https://github.com/miltonbita/helpdesk_reat
echo    Nota: Pode fazer modificacoes e subir para o repositorio.
echo ________________________________________________

set /p choice="Escolha uma opcao (1-5): "

if "%choice%"=="1" goto criar_projeto
if "%choice%"=="2" goto criar_projeto_vazio
if "%choice%"=="3" goto iniciar_servidor
if "%choice%"=="4" goto iniciar_emulador
if "%choice%"=="5" goto fim

call :error_message "Opcao invalida. Tente novamente." menu

:criar_projeto
cls
echo ==========================================
echo       CRIAR UM NOVO PROJETO EXPO
echo ==========================================
set /p projectName="Nome do projeto: "
call :validate_input "%projectName%" criar_projeto
cd %PROJECT_DIR%
npx create-expo-app@latest "%projectName%"
if %errorlevel% neq 0 (
    call :error_message "Erro ao criar o projeto." menu
) else (
    echo Projeto criado com sucesso em %PROJECT_DIR%\%projectName%!
)
pause
goto menu

:criar_projeto_vazio
cls
echo ==========================================
echo    CRIAR UM NOVO PROJETO EXPO VAZIO
echo ==========================================
set /p projectName="Nome do projeto: "
call :validate_input "%projectName%" criar_projeto_vazio
cd %PROJECT_DIR%
npx create-expo-app@latest "%projectName%" --template blank
if %errorlevel% neq 0 (
    call :error_message "Erro ao criar o projeto vazio." menu
) else (
    echo Projeto vazio criado com sucesso em %PROJECT_DIR%\%projectName%!
)
pause
goto menu

:iniciar_servidor
cls
echo ==========================================
echo        INICIAR O SERVIDOR EXPO
echo ==========================================
cd %PROJECT_DIR%
npx expo start
pause
goto menu

:iniciar_emulador
cls
echo ==========================================
echo       INICIAR EMULADOR ANDROID
echo ==========================================
REM Listar emuladores disponíveis
set /a index=1
for /f "delims=" %%a in ('%ANDROID_EMULATOR% -list-avds 2^>nul') do (
    set "emulator[!index!]=%%a"
    echo !index!. %%a
    set /a index+=1
)
if "%index%"=="1" (
    call :error_message "Nenhum emulador encontrado. Verifique suas configuracoes no Android Studio." menu
)
echo ==========================================
set /p emulatorChoice="Escolha o numero do emulador (ou 0 para voltar ao menu): "

if "%emulatorChoice%"=="0" goto menu

REM Verificar se a escolha é válida
if not defined emulator[%emulatorChoice%] (
    call :error_message "Opcao invalida. Tente novamente." iniciar_emulador
)

set selectedEmulator=!emulator[%emulatorChoice%]!
%ANDROID_EMULATOR% -avd %selectedEmulator%
if %errorlevel% neq 0 (
    call :error_message "Erro ao iniciar o emulador. Verifique o nome e tente novamente." menu
) else (
    echo Emulador iniciado com sucesso!
)
pause
goto menu

:fim
echo Obrigado por usar o Gerenciador Expo, %USERNAME%!
pause
exit

:validate_input
if "%1%"=="" (
    call :error_message "Entrada invalida! Por favor, tente novamente." %2%
)
exit /b

:error_message
echo %1
pause
goto %2
