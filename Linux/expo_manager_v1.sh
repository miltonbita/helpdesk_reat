#!/bin/bash

# Caminhos padrão
PROJECTS_DIR="$HOME/ProjetosExpo"
ANDROID_EMULATOR_PATH="$HOME/Android/Sdk/emulator/emulator"

# Função para criar diretório se não existir
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Diretório $1 criado."
    fi
}

# Função para verificar dependências
check_dependencies() {
    if ! command -v node &> /dev/null; then
        echo "Node.js não está instalado. Por favor, instale o Node.js para continuar."
        exit 1
    fi

    if ! command -v npx &> /dev/null; then
        echo "NPX não está instalado. Por favor, instale o Node.js corretamente para continuar."
        exit 1
    fi
}

# Função para criar um projeto Expo
create_expo_project() {
    echo "Digite o nome do projeto:"
    read project_name
    if [ -z "$project_name" ]; then
        echo "Nome do projeto não pode ser vazio."
        return
    fi
    cd "$PROJECTS_DIR" || exit
    npx create-expo-app@latest "$project_name"
    echo "Projeto $project_name criado com sucesso!"
}

# Função para criar um projeto Expo vazio
create_blank_project() {
    echo "Digite o nome do projeto:"
    read project_name
    if [ -z "$project_name" ]; then
        echo "Nome do projeto não pode ser vazio."
        return
    fi
    cd "$PROJECTS_DIR" || exit
    npx create-expo-app@latest "$project_name" --template blank
    echo "Projeto vazio $project_name criado com sucesso!"
}

# Função para iniciar o servidor Expo
start_expo_server() {
    echo "Digite o nome do projeto para iniciar o servidor:"
    read project_name
    if [ -z "$project_name" ]; then
        echo "Nome do projeto não pode ser vazio."
        return
    fi
    cd "$PROJECTS_DIR/$project_name" || {
        echo "Projeto não encontrado.";
        return;
    }
    npx expo start
}

# Função para iniciar o emulador Android
start_android_emulator() {
    if [ ! -f "$ANDROID_EMULATOR_PATH" ]; then
        echo "Emulador Android não encontrado no caminho $ANDROID_EMULATOR_PATH."
        echo "Deseja instalar e configurar o Android SDK agora? (s/n)"
        read install_choice
        if [[ "$install_choice" == "s" || "$install_choice" == "S" ]]; then
            echo "Instalando dependências necessárias..."
            sudo apt update && sudo apt install -y android-sdk
            echo "Certifique-se de configurar o caminho do SDK em \$HOME/Android/Sdk."
        else
            echo "Por favor, configure o Android SDK manualmente antes de continuar."
        fi
        return
    fi

    echo "Lista de emuladores disponíveis:"
    "$ANDROID_EMULATOR_PATH" -list-avds
    echo "Digite o nome do emulador para iniciar:"
    read emulator_name
    if [ -z "$emulator_name" ]; then
        echo "Nome do emulador não pode ser vazio."
        return
    fi
    "$ANDROID_EMULATOR_PATH" -avd "$emulator_name"
}

# Menu principal
show_menu() {
    while true; do
        clear
        echo "=========================================="
        echo "  BEM-VINDO AO GERENCIADOR EXPO"
        echo "=========================================="
        echo "1. Criar Projeto Expo"
        echo "2. Criar Projeto Expo Vazio"
        echo "3. Iniciar Servidor Expo"
        echo "4. Iniciar Emulador Android"
        echo "5. Sair"
        echo "=========================================="
        echo "Digite uma opção:"
        read option

        case $option in
            1) create_directory "$PROJECTS_DIR"; create_expo_project ;;
            2) create_directory "$PROJECTS_DIR"; create_blank_project ;;
            3) start_expo_server ;;
            4) start_android_emulator ;;
            5) echo "Saindo..."; exit ;;
            *) echo "Opção inválida!"; sleep 2 ;;
        esac
    done
}

# Início do script
check_dependencies
show_menu
