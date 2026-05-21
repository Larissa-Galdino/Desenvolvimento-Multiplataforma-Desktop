# 🎮 Coleção de Jogos

Aplicativo mobile/desktop desenvolvido em Flutter para gerenciamento de coleções pessoais de jogos. O sistema permite cadastrar, organizar, visualizar e acompanhar itens da coleção, substituindo controles feitos em cadernos, planilhas ou anotações soltas.

---

## 📋 Sobre o Projeto

Muitos colecionadores de jogos têm dificuldade para organizar seus itens. Com este aplicativo, é possível saber:

- Quais jogos já possui
- Quais jogos ainda deseja adquirir
- Quais jogos estão repetidos
- Qual o estado de conservação de cada jogo
- Quanto foi pago e qual o valor estimado de cada item
- Onde cada jogo está guardado
- Quais jogos são mais raros
- Quais jogos foram emprestados, vendidos ou trocados

---

## 🚀 Tecnologias Utilizadas

| Tecnologia | Descrição |
|---|---|
| Flutter | Framework principal para desenvolvimento multiplataforma |
| Dart | Linguagem de programação |
| shared_preferences | Armazenamento local dos dados |
| Material Design 3 | Design system do aplicativo |

---

## ✅ Funcionalidades

- [x] Cadastrar jogos na coleção
- [x] Listar os jogos cadastrados
- [x] Editar informações dos jogos
- [x] Excluir jogos com confirmação
- [x] Buscar jogos pelo nome
- [x] Filtrar por status ou raridade
- [x] Registrar valor pago e valor estimado
- [x] Indicar status do item (Na Coleção, Lista de Desejos, Emprestado, Vendido, Trocado)
- [x] Registrar raridade (Comum, Incomum, Raro, Muito Raro, Único)
- [x] Registrar estado de conservação
- [x] Registrar localização do item
- [x] Marcar itens repetidos
- [x] Painel com resumo da coleção
- [x] Armazenamento local dos dados

---

## 📁 Estrutura de Pastas

```
colecao_app/
├── lib/
│   ├── main.dart               # Ponto de entrada do app
│   ├── models/
│   │   └── item_colecao.dart   # Model com toMap e fromMap
│   ├── database/
│   │   └── data_base.dart      # DatabaseHelper com CRUD completo
│   └── screens/
│       ├── lista_screen.dart   # Tela principal com busca e filtros
│       ├── formulario_screen.dart  # Tela de cadastro e edição
│       └── painel_screen.dart  # Painel com resumo da coleção
└── pubspec.yaml                # Dependências do projeto
```

---

## 🎮 Telas do Aplicativo

### Tela Principal
- Lista todos os jogos cadastrados em cards
- Barra de busca por nome
- Filtros por status e raridade
- Botão para adicionar novo item
- Botão para acessar o painel

### Formulário
- Cadastro e edição de jogos
- Campos: nome, valor pago, valor estimado, localização, status, raridade, conservação
- Categoria fixada como "Jogos"
- Toggle para marcar item como repetido
- Validação dos campos obrigatórios

### Painel
- Total de itens cadastrados
- Quantidade na coleção
- Quantidade na lista de desejos
- Quantidade emprestados
- Valor total investido
- Valor total estimado

---

## ⚙️ Como Executar

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/Larissa-Galdino/Desenvolvimento-Multiplataforma-Desktop.git

# 2. Entre na pasta do projeto
cd colecao_app

# 3. Instale as dependências
flutter pub get

# 4. Execute o aplicativo
flutter run -d web-server
```

---

## Estrutura Excalidraw = Telas do Aplicativo
![Construção do Projeto](Excalidraw/Construção%20do%20Projeto.png)
link: https://excalidraw.com/#json=5CYjegyRifnsz5cVZsSW2,0vfVy5NZNFn3TnFBN9Y4Eg