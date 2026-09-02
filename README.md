# Alfabetização Tecnológica

Plataforma web de inclusão digital voltada ao público idoso do município de
Curitiba, Paraná — desenvolvida em **Flutter (Web) + Dart** como parte de
uma Atividade Extensionista para a Universidade Uninter.

Aplicação **sem cadastro, sem login e sem banco de dados**: todo o conteúdo
(tutoriais, orientações de segurança digital e banco de 30 questões do quiz)
é distribuído junto com o próprio aplicativo, em arquivos JSON.

## Pré-requisitos

- Flutter SDK instalado (versão 3.22 ou superior).
- Um navegador Chrome instalado para rodar em modo de desenvolvimento web.

## Como rodar em modo de desenvolvimento

```bash
flutter pub get
flutter run -d chrome
```

## Como rodar os testes

```bash
flutter test
```

O resultado ficará na pasta `build/web`, pronto para ser publicado em
qualquer serviço de hospedagem estática (GitHub Pages, Firebase Hosting,
Netlify, Vercel, etc.), atendendo ao requisito de acesso via link público,
sem necessidade de instalação por parte do usuário final.

