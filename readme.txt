# Documentação do Script `expo_manager.bat`

## Introdução
O `expo_manager.bat` é um script criado para facilitar a criação e gerenciamento de projetos React Native com o Expo sem a necessidade de usar diretamente a linha de comando. O script oferece um menu interativo com opções para criar projetos Expo, iniciar o servidor Expo e gerenciar emuladores Android.

## Funcionalidades Principais

### 1. **Criar Projeto Expo**
Cria um projeto Expo normal no diretório padrão definido no script.

- **Comando Executado**: `npx create-expo-app@latest <nome-do-projeto>`
- **Diretório Padrão**: `C:\ProjetosExpo`

### 2. **Criar Projeto Expo Vazio**
Cria um projeto Expo usando o template "blank" (projeto vazio).

- **Comando Executado**: `npx create-expo-app@latest <nome-do-projeto> --template blank`
- **Diretório Padrão**: `C:\ProjetosExpo`

### 3. **Iniciar Servidor Expo**
Inicia o servidor Expo para o projeto atual.

- **Comando Executado**: `npx expo start`
- **Diretório Padrão**: `C:\ProjetosExpo`

### 4. **Iniciar Emulador Android**
Lista os emuladores Android instalados e permite ao utilizador escolher qual iniciar.

- **Comando Executado**: `<caminho-do-emulador> -avd <nome-do-emulador>`
- **Caminho Padrão**: `C:\Users\<nome-do-usuario>\AppData\Local\Android\Sdk\emulator\emulator.exe`

### 5. **Sair**
Encerra a execução do script.

---

## Notas Importantes

- **Verificações**: O script verifica se o Node.js e a Expo CLI estão instalados antes de executar as funções principais.
- **Diretório Padrão**: Se a pasta `C:\ProjetosExpo` não existir, o script cria automaticamente esse diretório para armazenar os projetos.
- **Nome do Utilizador**: O script obtém automaticamente o nome do utilizador do sistema para personalização.
- **Interação**: O utilizador pode navegar entre as opções e voltar ao menu principal sempre que necessário.

---

## Exemplo de Execução

Quando o script é iniciado, o menu apresenta-se da seguinte forma:

```
==========================================
     BEM-VINDO, MiltonBita, AO GERENCIADOR EXPO
==========================================
1. Criar Projeto Expo
2. Criar Projeto Expo Vazio
3. Iniciar Servidor Expo
4. Iniciar Emulador Android
5. Sair
==========================================

____________________________________________

   Autor: Milton Bita
   GitHub: https://github.com/MiltonBita
   Nota: Pode fazer modificacoes e subir para o repositório.
____________________________________________
```

---

## Requisitos do Sistema

- **Node.js** instalado
- **Expo CLI** instalado (pode ser instalado com `npm install -g expo-cli`)
- **Android Emulator** configurado

---

## Instruções de Instalação e Uso

1. **Guarda o ficheiro** com o nome `expo_manager.bat`.
2. **Executa o ficheiro** clicando duas vezes nele.
3. **Segue as instruções** apresentadas no menu.

---

## Contacto

**Autor**: Milton Bita  
**GitHub**: [https://github.com/MiltonBita](https://github.com/MiltonBita)

**Nota**: Pode fazer modificações ao script e subir para o repositório conforme necessário.

---

