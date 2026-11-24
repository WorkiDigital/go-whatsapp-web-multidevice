# Painel GOWA em português brasileiro — Worki Digital

A primeira versão da localização contém 158 substituições de textos em 14 arquivos do gowa-ui. Ela foi conferida contra os arquivos da branch main do projeto de interface original. É uma tradução inicial, não uma tradução integral nem um seletor de idiomas. Não altera os identificadores internos, rotas ou credenciais da API.

## Windows

No clone deste backend, após atualizar a branch main:

```powershell
git pull origin main
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\gowa-ui-ptbr.ps1" -Root "C:\caminho\gowa-ui" -Build
```

Substitua o caminho pelo clone local do front-end gowa-ui. Use uma versão de Node.js compatível com o package.json da interface e mantenha seu trabalho local salvo. O script cria backups .ptbr-backup, não os inclua no Git. A opção -Build instala as dependências via npm ci caso node_modules não exista, compila e verifica o contrato de HTML único, mostrando o SHA-256. Sem -Build, apenas os textos são alterados.

Revise o diff no clone do front-end e execute npm run typecheck, npm run lint e npm run test antes de publicar. O resultado do build é dist/index.html.

## Usar localmente no backend

Depois de validar o build, faça backup do painel existente em storages/ui/index.html e copie o novo dist/index.html para esse caminho. No arquivo de ambiente **ativo** do backend (src/.env para o docker-compose deste repo), mantenha APP_UI_ENABLED=true e configure APP_UI_AUTO_UPDATE=false para não substituir o arquivo local automaticamente. Se o backend usar outro volume de armazenamento, use o caminho correspondente. Reinicie o serviço e valide a interface. Não altere credenciais e não sobrescreva o painel antes de verificar o build. Para reverter, restaure o HTML e a configuração anterior.

## Distribuir via GitHub

Se o fork WorkiDigital/gowa-ui estiver publicado, faça commit da tradução no próprio repositório da interface e publique uma release com o artefato gowa-ui.html e seu checksum. Somente depois configure APP_UI_REPO=WorkiDigital/gowa-ui e valide o download. Não habilite atualizações automáticas sem revisar a release. O backend permanece compatível com o painel original.

A tradução das telas internas restantes, seletor de idiomas e testes de execução ainda estão pendentes.
