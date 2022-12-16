<h1 align="center"> Dashboard FeirApp </h1>

![Dashboard FeirApp IMG](https://user-images.githubusercontent.com/71350546/207875010-78ae8a7c-fb2e-474c-855b-553384d2d611.png)

<p align="center">
  <img src="http://img.shields.io/static/v1?label=STATUS&message=FINALIZADO&color=GREEN&style=for-the-badge"/>
  <img src="https://img.shields.io/static/v1?label=DESENVOLVIDO%20PARA&message=TCC&color=blueviolet&style=for-the-badge"/>
  <img src="https://img.shields.io/static/v1?label=FLUTTER&message=WEB&color=informational&style=for-the-badge"/>
  <img src="https://img.shields.io/static/v1?label=FLUTTER%20VERSION&message=3.0.5&color=blue&style=for-the-badge"/>
</p>

# Índice 

* [Índice](#índice)
* [Sobre o Projeto](#sobre-o-projeto)
* [Funcionalidades do projeto](#funcionalidades-do-projeto)
* [Demonstração da Aplicação](#demonstração-da-aplicação)
* [Principais Bibliotecas Utilizadas](#principais-bibliotecas-utilizadas)
* [Autores](#autores)

## Sobre o projeto

<p text-align: justify;>
  Projeto desenvolvido para realizar a gestão do aplicativo <b>FeirApp</b>.
  Desenvolvido como projeto de TCC dos alunos concluintes do curso de Ciências da Computação da UNIFENAS no ano de 2022.
  </br>
  </br>
  O painel de gestão utiliza recursos advindos da <b>FeirApp API</b>, que é responsável por todos os end-points do banco de dados da aplicação. O painel dispõe de cadastro, visualização e deleção de produtores/produtos/propriedades que são exibidas no aplicativo.
</p>
<p>
  Desenvolvido em Flutter na sua versão 3.0.5.
</p>

## Funcionalidades do projeto

:heavy_check_mark: Realizar inserção, edição, visualização e deleção de produtores, produtos junto com seus estoques e propriedades.

:heavy_check_mark: Salvar os dados no banco de dados (durante o período de testes foi utilizado o Heroku como execução da API).

:heavy_check_mark: Mostrar visualmente ao usuário gráficos sobre usuários e pedidos realizados no app.

:heavy_check_mark: Mostrar visualmente todos os dados que foram inseridos pelo painel de controle.

❌ Preparar café

## Demonstração da Aplicação

<h3> Demonstração da tela Home da Dashboard 👇 </h3>

![Login](https://user-images.githubusercontent.com/71350546/207991513-e46f18a2-ed2a-42f5-9d59-0b8a3aa1b84f.gif)

<p text-align: justify;> 
  O fluxo de execução de todas as telas na utilização da Dashboard é bem parecido, com excessão de algumas que dispõem de DropDowns ao invés apenas de inputs.
  Um fato a se destacar é que cada um possui uma lógica própria para fazer a adição, remoção e a deleção.
</p>

<h3> Demonstração da Tela de Cadastro e Edição de Produtor 👇 </h3>

![Produtor](https://user-images.githubusercontent.com/71350546/207991148-4739f98f-05c5-4ccd-8c0f-e3e5966b1c1a.gif)

<h3> Demonstração da tela Propriedades da Dashboard 👇 </h3>

![Propriedades](https://user-images.githubusercontent.com/71350546/207991867-e83c2ae0-0ebc-4284-886b-c8299fb758ef.gif)

<h3> Dropdown desenvolvido para a aplicação 👇 </h3>

![Produto_drop](https://user-images.githubusercontent.com/71350546/207992737-831d9913-fb14-4092-b741-8ed7099fb66e.gif)


## Principais Bibliotecas Utilizadas

<p>
📘 - get 4.6.5 - Utilizado para praticamente tudo do projeto - Disponível em: https://pub.dev/packages/get </br>

📖 - Bibliotecas que já vem junto com o framework Flutter

```
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^3.0.1
  get: ^4.6.5
  syncfusion_flutter_charts: ^20.3.48
  data_table_2: ^2.3.7
  flutter_spinkit: ^5.1.0
  shared_preferences: ^2.0.15
  dropdown_button2: ^1.8.9
  intl: ^0.17.0
```
</p>

# Autores

| [<img src="https://avatars.githubusercontent.com/u/71350546?v=4" width=115><br><sub>Matheus Fidelis</sub>](https://github.com/FidelisMatheus) | [<img src="https://avatars.githubusercontent.com/u/71350546?v=4" width=115><br><sub>Matheus Fidelis</sub>](https://github.com/FidelisMatheus) |  [<img src="https://avatars.githubusercontent.com/u/71350546?v=4" width=115><br><sub>Matheus Fidelis</sub>](https://github.com/FidelisMatheus) |
| :---: | :---: | :---: 

Copyright :copyright: 2022 - Dashboard FeirApp

