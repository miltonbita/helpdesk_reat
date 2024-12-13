#!/bin/bash
# Gerenciador React Native Expo para Linux
# Autor: Rafael Vicente
# GitHub: https://github.com/RafaelVicen
# Nota: Pode fazer modificações e subir para o repositório.

# Caminhos padrão
ANDROID_EMULATOR="$HOME/Android/Sdk/emulator/emulator"
PROJECT_DIR="$HOME/ProjetosExpo"

# Criar diretório padrão para projetos se não existir
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
fi

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
  echo "Node.js não encontrado. Por favor, instale o Node.js para continuar."
  exit 1
fi

# Verificar se Expo CLI está instalada
if ! command -v npx &> /dev/null; then
  echo "Expo CLI não encontrada. Por favor, instale com 'npm install -g expo-cli'."
  exit 1
fi

# Menu principal
while true; do
  clear
  echo "==========================================="
  echo "     BEM-VINDO, $USER, AO GERENCIADOR EXPO"
  echo "==========================================="
  echo "1. Criar Projeto Expo"
  echo "2. Criar Projeto Expo Vazio"
  echo "3. Iniciar Servidor Expo"
  echo "4. Iniciar Emulador Android"
  echo "5. Sair"
  echo "==========================================="
  echo ""

  read -p "Escolha uma opção (1-5): " choice

  case $choice in
    1) # Criar Projeto Expo
      clear
      echo "==========================================="
      echo "       CRIAR UM NOVO PROJETO EXPO"
      echo "==========================================="
      read -p "Nome do projeto: " projectName
      if [ -z "$projectName" ]; then
        echo "Nome inválido. Tente novamente."
        read -p "Pressione Enter para continuar..."
        continue
      fi
      cd "$PROJECT_DIR"
      npx create-expo-app@latest "$projectName"
      if [ $? -ne 0 ]; then
        echo "Erro ao criar o projeto."
      else
        echo "Projeto criado com sucesso em $PROJECT_DIR/$projectName!"
      fi
      read -p "Pressione Enter para continuar..."
      ;;
    2) # Criar Projeto Expo Vazio
      clear
      echo "==========================================="
      echo "    CRIAR UM NOVO PROJETO EXPO VAZIO"
      echo "==========================================="
      read -p "Nome do projeto: " projectName
      if [ -z "$projectName" ]; then
        echo "Nome inválido. Tente novamente."
        read -p "Pressione Enter para continuar..."
        continue
      fi
      cd "$PROJECT_DIR"
      npx create-expo-app@latest "$projectName" --template blank
      if [ $? -ne 0 ]; then
        echo "Erro ao criar o projeto vazio."
      else
        echo "Projeto vazio criado com sucesso em $PROJECT_DIR/$projectName!"
      fi
      read -p "Pressione Enter para continuar..."
      ;;
    3) # Iniciar Servidor Expo
      clear
      echo "==========================================="
      echo "        INICIAR O SERVIDOR EXPO"
      echo "==========================================="
      cd "$PROJECT_DIR"
      npx expo start
      read -p "Pressione Enter para continuar..."
      ;;
    4) # Iniciar Emulador Android
      clear
      echo "==========================================="
      echo "       INICIAR EMULADOR ANDROID"
      echo "==========================================="
      available_emulators=($($ANDROID_EMULATOR -list-avds))
      if [ ${#available_emulators[@]} -eq 0 ]; then
        echo "Nenhum emulador encontrado. Verifique suas configurações no Android Studio."
        read -p "Pressione Enter para continuar..."
        continue
      fi

      echo "Emuladores disponíveis:"
      for i in "${!available_emulators[@]}"; do
        echo "$((i+1)). ${available_emulators[$i]}"
      done

      read -p "Escolha o número do emulador (ou 0 para voltar): " emulatorChoice

      if [ "$emulatorChoice" -eq 0 ]; then
        continue
      fi

      if [ "$emulatorChoice" -lt 1 ] || [ "$emulatorChoice" -gt ${#available_emulators[@]} ]; then
        echo "Opção inválida. Tente novamente."
        read -p "Pressione Enter para continuar..."
        continue
      fi

      selectedEmulator=${available_emulators[$((emulatorChoice-1))]}
      $ANDROID_EMULATOR -avd "$selectedEmulator"
      if [ $? -ne 0 ]; then
        echo "Erro ao iniciar o emulador. Verifique o nome e tente novamente."
      else
        echo "Emulador iniciado com sucesso!"
      fi
      read -p "Pressione Enter para continuar..."
      ;;
    5) # Sair
      echo "Obrigado por usar o Gerenciador Expo, $USER!"
      exit 0
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      read -p "Pressione Enter para continuar..."
      ;;
  esac

done
