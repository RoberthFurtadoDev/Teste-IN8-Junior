Devnology E-Commerce - Desafio Full-Stack Júnior
!(https://img.shields.io/badge/react-%2320232A.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)

!(https://img.shields.io/badge/nestjs-%23E0234E.svg?style=for-the-badge&logo=nestjs&logoColor=white)

!(https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

Este repositório contém a solução completa para o desafio técnico de Desenvolvedor(a) Full-Stack Júnior. O projeto consiste em uma plataforma de e-commerce que integra produtos de dois fornecedores distintos (um brasileiro e um europeu) e oferece uma experiência de compra coesa através de uma aplicação web (React) e um aplicativo mobile (Flutter), ambos consumindo um backend centralizado (NestJS).

🌟 Funcionalidades
Backend Unificado: Uma API RESTful em NestJS que atua como um API Gateway, buscando, unificando e servindo os dados dos produtos de forma centralizada.

Persistência de Dados: Registro de todos os pedidos e dados de clientes em um banco de dados PostgreSQL, gerenciado via Docker.

Aplicação Web (React): Interface reativa e moderna construída com Vite, permitindo:

Listagem de produtos com busca por nome e filtro por origem.

Carrinho de compras com gerenciamento de estado local.

Formulário de checkout para finalização da compra.

Aplicativo Mobile (Flutter): Experiência nativa para Android (e iOS) com as mesmas funcionalidades da aplicação web, compartilhando o mesmo backend.

📸 Demonstração
Aplicação Web (React)
Lista de Produtos e Filtros

Carrinho de Compras (Modal)

!(https://i.imgur.com/g8e1m8F.png)

!(https://i.imgur.com/gK9pZkH.png)


Exportar para as Planilhas
Aplicativo Mobile (Flutter)
Lista de Produtos

Tela do Carrinho

!(https://i.imgur.com/D4sYvso.png)

!(https://i.imgur.com/e8p2T6I.png)


Exportar para as Planilhas
🛠️ Tecnologias Utilizadas
Categoria

Tecnologia

Backend

Node.js, NestJS, TypeScript, TypeORM

Frontend Web

React, Vite, TypeScript, Tailwind CSS

App Mobile

Flutter, Dart

Banco de Dados

PostgreSQL

Gerenciamento de Estado

React Context API, Flutter Provider

Containerização

Docker, Docker Compose

Testes de API

Insomnia / Postman


Exportar para as Planilhas
🚀 Como Rodar o Projeto
Este projeto é um monorepo. Todos os comandos de instalação e execução devem ser feitos a partir do diretório raiz, salvo indicação contrária.

Pré-requisitos
Antes de começar, garanta que você tem as seguintes ferramentas instaladas:

Node.js (v18 ou superior)
-(https://flutter.dev/docs/get-started/install)
-(https://www.docker.com/products/docker-desktop/) e Docker Compose

Instalação
Clone o repositório:

Bash

git clone https://github.com/RoberthFurtadoDev/Teste-IN8-Junior.git
cd Teste-IN8-Junior
Instale todas as dependências (backend e frontend) com um único comando a partir da raiz:

Bash

npm install
Execução
Para rodar a aplicação completa, você precisará de 3 terminais abertos.

1. Iniciar o Banco de Dados (PostgreSQL)

No primeiro terminal, a partir da pasta raiz, inicie o contêiner do Docker:

Bash

docker-compose up -d
2. Iniciar o Backend (NestJS)

No segundo terminal, navegue até a pasta do backend e inicie o servidor:

Bash

cd apps/backend
npm run start:dev
O servidor estará rodando em http://localhost:3000.

3. Iniciar a Aplicação Web (React)

No terceiro terminal, navegue até a pasta do frontend e inicie o servidor de desenvolvimento:

Bash

cd apps/frontend
npm run dev
A aplicação web estará disponível em http://localhost:5173 (ou outra porta indicada pelo Vite).

4. Iniciar o Aplicativo Mobile (Flutter)

Garanta que um emulador Android esteja rodando ou um dispositivo físico esteja conectado.

No terceiro terminal (ou em um novo), navegue até a pasta do app mobile e execute:

Bash

cd apps/mobile
flutter run
Importante: O código do Flutter já está configurado para usar o IP 10.0.2.2 para se comunicar com o backend rodando no seu computador a partir do emulador Android.

🧠 Decisões Técnicas Tomadas
Esta seção detalha as principais escolhas arquiteturais feitas durante o desenvolvimento, visando não apenas cumprir os requisitos, mas construir uma solução robusta, escalável e alinhada com as melhores práticas do mercado.    

Arquitetura de Monorepo:

Decisão: O projeto foi estruturado como um monorepo, contendo as pastas apps/backend, apps/frontend e apps/mobile em um único repositório Git.

Justificativa: Esta abordagem centraliza a gestão de dependências, simplifica a configuração do ambiente de desenvolvimento e facilita o compartilhamento de código e tipos (como as interfaces TypeScript entre o backend e o frontend).    

Backend como API Gateway:

Decisão: Em vez de fazer os clientes (React e Flutter) chamarem as duas APIs de fornecedores, o backend em NestJS foi implementado seguindo o padrão API Gateway.    

Justificativa: Esta é a decisão arquitetural mais impactante do projeto. Ela abstrai a complexidade dos múltiplos fornecedores para os clientes, que agora consomem um único e coeso endpoint (/products). Isso simplifica drasticamente o código do frontend e do mobile, centraliza a lógica de negócios, permite a implementação de cache no servidor e torna o sistema muito mais fácil de manter e escalar (adicionar um novo fornecedor se torna uma tarefa exclusiva do backend).    

Gerenciamento de Estado:

React (Context API + useReducer): Para o carrinho de compras na web, foi escolhida a Context API nativa do React, combinada com o hook useReducer.    

Justificativa: Esta abordagem oferece um gerenciamento de estado robusto e previsível, similar ao Redux, mas sem a necessidade de bibliotecas externas e com menos boilerplate. Para a escala deste projeto, é a solução mais pragmática e eficiente, demonstrando proficiência com as ferramentas nativas do React.    

Flutter (Provider): Para o app mobile, foi utilizado o pacote provider.

Justificativa: Provider é a abordagem recomendada oficialmente pelo time do Flutter para gerenciamento de estado. É simples, poderoso e perfeitamente adequado para compartilhar o estado do carrinho por toda a árvore de widgets da aplicação.

Persistência de Dados e Schema do Banco:

Decisão: O banco de dados PostgreSQL foi escolhido por sua robustez e conformidade com o padrão SQL. O schema foi desenhado para garantir a integridade histórica dos pedidos.

Justificativa: Na tabela order_items, foram armazenados não apenas o product_id, mas também o product_name e o price no momento da compra. Isso garante que, mesmo que os dados dos produtos mudem nas APIs externas, os registros de pedidos permaneçam historicamente precisos, o que é vital para relatórios financeiros e para o histórico do cliente.    

Desenvolvimento Multiplataforma (Web e Mobile):

Decisão: O desafio foi cumprido integralmente, com a entrega de ambas as plataformas obrigatórias (React e Flutter).

Justificativa: A construção de ambas as interfaces consumindo o mesmo backend demonstra uma compreensão completa do desenvolvimento full-stack e da importância de uma API bem projetada como a única fonte da verdade para múltiplos clientes.    

Este projeto foi desenvolvido com o objetivo de demonstrar não apenas a capacidade de codificar, mas de pensar arquiteturalmente, tomar decisões técnicas justificadas e entregar uma solução completa e de alta qualidade.