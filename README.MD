## PROJETO E-COMMERCE FULL-STACK - DEV[N]OLOGY
Solução completa de e-commerce desenvolvida para o desafio técnico de Desenvolvedor(a) Full-Stack. O sistema integra produtos de dois fornecedores distintos via API e oferece uma experiência de compra através de uma aplicação web (React) e um aplicativo mobile (Flutter), ambos consumindo um backend centralizado (NestJS).

## ✨ FUNCIONALIDADES IMPLEMENTADAS
O projeto foi concluído com sucesso, entregando todos os requisitos obrigatórios e opcionais.

[x] Backend em Node.js com NestJS

[x] Endpoint unificado para produtos

[x] Registro de compras no banco de dados via API

[x] Interface Web com React

[x] Listagem de produtos dos dois fornecedores

[x] Busca e filtro de produtos

[x] Carrinho de compras (adicionar/remover)

[x] Finalização da compra com formulário

[x] Aplicativo Mobile com Flutter

[x] Listagem de produtos consumindo o mesmo backend

[x] Carrinho de compras funcional

[x] Finalização da compra e registro do pedido

## 💻 PRÉ-REQUISITOS
Antes de começar, verifique se você atendeu aos seguintes requisitos:

Você instalou a versão mais recente de:

Node.js (v18 ou superior)

(https://flutter.dev/docs/get-started/install)

(https://www.docker.com/products/docker-desktop/)

Você tem uma máquina Windows, Linux ou Mac.

Você tem um editor de código como o VS Code.

## 🚀 INSTALANDO O PROJETO
Para instalar o projeto, siga estas etapas:

Bash

# Clone o repositório
git clone https://github.com/RoberthFurtadoDev/Teste-IN8-Junior.git

# Navegue até a pasta do projeto
cd Teste-IN8-Junior

# Instale todas as dependências (backend e frontend)
npm install
## 🔥 EXECUTANDO A APLICAÇÃO
Para rodar a aplicação completa, você precisará de 3 terminais abertos na raiz do projeto.

Bash

# A partir da pasta raiz, inicie o contêiner do PostgreSQL
docker-compose up -d
Bash

# Navegue até a pasta do backend
cd apps/backend

# Inicie o servidor em modo de desenvolvimento
npm run start:dev
O servidor estará rodando em http://localhost:3000.

Bash

# Navegue até a pasta do frontend
cd apps/frontend

# Inicie o servidor de desenvolvimento
npm run dev
A aplicação web estará disponível em http://localhost:5173.

Bash

# Garanta que um emulador Android esteja rodando
# Navegue até a pasta do app mobile
cd apps/mobile

# Execute o aplicativo
flutter run
O código já está configurado para se comunicar com o backend a partir do navegador/emulador.

## 🧠 DECISÕES TÉCNICAS E ARQUITETURAIS
Esta seção detalha as principais escolhas feitas durante o desenvolvimento, visando não apenas cumprir os requisitos, mas construir uma solução robusta, escalável e alinhada com as melhores práticas do mercado.    

1. ARQUITETURA DE MONOREPO
Decisão: O projeto foi estruturado como um monorepo, contendo as pastas apps/backend, apps/frontend e apps/mobile em um único repositório Git.

Justificativa: Esta abordagem centraliza a gestão de dependências, simplifica a configuração do ambiente de desenvolvimento e facilita o compartilhamento de código e tipos (como as interfaces TypeScript entre o backend e o frontend).    

2. BACKEND COMO API GATEWAY
Decisão: Em vez de fazer os clientes (React e Flutter) chamarem as duas APIs de fornecedores, o backend em NestJS foi implementado seguindo o padrão API Gateway.    

Justificativa: Esta é a decisão arquitetural mais impactante do projeto. Ela abstrai a complexidade dos múltiplos fornecedores para os clientes, que agora consomem um único e coeso endpoint (/products). Isso simplifica drasticamente o código do frontend e do mobile, centraliza a lógica de negócios, permite a implementação de cache no servidor e torna o sistema muito mais fácil de manter e escalar.    

3. GERENCIAMENTO DE ESTADO
React (Context API): Para o carrinho de compras na web, foi escolhida a Context API nativa do React.    

Justificativa: Esta abordagem oferece um gerenciamento de estado robusto e previsível, ideal para a escala deste projeto, sem a complexidade e o boilerplate de bibliotecas externas como o Redux. Demonstra proficiência com as ferramentas nativas do React para resolver problemas de estado compartilhado.    

Flutter (Provider): Para o app mobile, foi utilizado o pacote provider.

Justificativa: Provider é a abordagem recomendada oficialmente pelo time do Flutter para gerenciamento de estado. É simples, poderoso e perfeitamente adequado para compartilhar o estado do carrinho por toda a árvore de widgets da aplicação.

4. PERSISTÊNCIA DE DADOS E SCHEMA DO BANCO
Decisão: O banco de dados PostgreSQL foi escolhido por sua robustez e conformidade com o padrão SQL. O schema foi desenhado para garantir a integridade histórica dos pedidos.

Justificativa: Na tabela que armazena os itens de um pedido, foram gravados não apenas o product_id, mas também o product_name e o price no momento da compra. Isso garante que, mesmo que os dados dos produtos mudem nas APIs externas, os registros de pedidos permaneçam historicamente precisos, o que é vital para relatórios financeiros e para o histórico do cliente.    

5. DESENVOLVIMENTO MULTIPLATAFORMA
Decisão: O desafio foi cumprido integralmente, com a entrega de ambas as plataformas obrigatórias (React e Flutter).

Justificativa: A construção de ambas as interfaces consumindo o mesmo backend demonstra uma compreensão completa do desenvolvimento full-stack e da importância de uma API bem projetada como a única fonte da verdade para múltiplos clientes.    

💻 Roberth Furtado © 2025 | Todos os direitos reservados.
