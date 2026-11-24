param([string]$Root = (Get-Location).Path, [switch]$Build)
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path -LiteralPath $Root).Path
$package = Get-Content -LiteralPath (Join-Path $Root 'package.json') -Raw | ConvertFrom-Json
if ($package.name -ne 'gowa-ui') { throw 'Execute na pasta do frontend gowa-ui (nao no backend).' }
$rulesJson = @'
{
  "src/components/layout/app-shell.tsx": {
    "label: 'Overview'": "label: 'Visão geral'",
    "label: 'Devices'": "label: 'Dispositivos'",
    "label: 'Messaging'": "label: 'Mensagens'",
    "label: 'Scheduled'": "label: 'Agendamentos'",
    "label: 'Chats'": "label: 'Conversas'",
    "label: 'Directory'": "label: 'Diretório'",
    "label: 'Groups'": "label: 'Grupos'",
    "label: 'Account'": "label: 'Conta'",
    "label: 'System'": "label: 'Sistema'",
    "label: 'Channels & Calls'": "label: 'Canais e chamadas'",
    "label: 'Settings'": "label: 'Configurações'",
    "aria-label=\"Open navigation\"": "aria-label=\"Abrir navegação\""
  },
  "src/pages/dashboard.tsx": {
    "title=\"Devices\"": "title=\"Dispositivos\"",
    "description=\"WhatsApp accounts connected to this server\"": "description=\"Contas do WhatsApp conectadas a este servidor\"",
    "title=\"No devices yet\"": "title=\"Nenhum dispositivo cadastrado\"",
    "hint=\"Add a device slot, then pair it with your phone via QR or pairing code.\"": "hint=\"Adicione um dispositivo e vincule seu celular via QR Code ou código de pareamento.\"",
    "Failed to load devices:": "Falha ao carregar dispositivos:"
  },
  "src/pages/connect.tsx": {
    "The server rejected these credentials (401).": "O servidor rejeitou estas credenciais (401).",
    "That URL answered, but it does not look like a gowa server.": "A URL respondeu, mas não parece ser um servidor GOWA.",
    "Could not reach the server. Check the URL and that gowa is running.": "Não foi possível acessar o servidor. Confira a URL e se o GOWA está em execução.",
    "Credentials are not sent to a remote HTTP server. Use HTTPS, or allow insecure HTTP for a server you trust.": "As credenciais não são enviadas a servidores HTTP remotos. Use HTTPS ou permita HTTP inseguro apenas para um servidor confiável.",
    "Connect to your gowa server": "Conecte-se ao servidor GOWA",
    "The server URL and optional basic-auth credentials are stored in this browser only. An": "A URL do servidor e as credenciais opcionais de autenticação básica ficam armazenadas apenas neste navegador. Um",
    "address without a scheme is treated as HTTPS.": "endereço sem protocolo é tratado como HTTPS.",
    ">Server URL<": ">URL do servidor<",
    ">Username<": ">Usuário<",
    ">Password<": ">Senha<",
    "Allow credentials over HTTP": "Permitir credenciais via HTTP",
    "The username and password would be readable on this connection. Enable this only": "O usuário e a senha podem ser lidos nesta conexão. Ative esta opção apenas",
    "for a server you trust that cannot use HTTPS.": "para um servidor confiável que não possa usar HTTPS.",
    "The stored credentials were rejected — enter them again.": "As credenciais armazenadas foram rejeitadas. Informe-as novamente.",
    "The stored server was unreachable — check it and reconnect.": "O servidor salvo está inacessível. Verifique-o e conecte-se novamente.",
    "\n              Connect\n": "\n              Conectar\n"
  },
  "src/pages/groups.tsx": {
    "title=\"Groups\"": "title=\"Grupos\"",
    "description=\"Groups this device belongs to — select one to manage it.\"": "description=\"Grupos dos quais este dispositivo participa. Selecione um para gerenciá-lo.\"",
    "title=\"Group info from link\"": "title=\"Informações do grupo pelo link\"",
    "description=\"Preview a group before joining.\"": "description=\"Visualize um grupo antes de entrar.\"",
    "title=\"Join with link\"": "title=\"Entrar pelo link\"",
    "description=\"Join a group from its invite link.\"": "description=\"Entre em um grupo pelo link de convite.\"",
    "title=\"Create group\"": "title=\"Criar grupo\"",
    "description=\"Start a new group with participants.\"": "description=\"Crie um novo grupo com participantes.\"",
    "\n                  Preview link\n": "\n                  Visualizar link\n",
    "\n                  Join with link\n": "\n                  Entrar pelo link\n",
    "\n                  Create group\n": "\n                  Criar grupo\n"
  },
  "src/pages/chats.tsx": {
    "title=\"Chats\"": "title=\"Conversas\"",
    "description=\"Stored conversations for this device.\"": "description=\"Conversas armazenadas neste dispositivo.\""
  },
  "src/pages/account.tsx": {
    "label: 'User info'": "label: 'Informações do usuário'",
    "label: 'User check'": "label: 'Verificar usuário'",
    "label: 'Avatar'": "label: 'Foto de perfil'",
    "label: 'Business profile'": "label: 'Perfil comercial'",
    "title=\"Account\"": "title=\"Conta\"",
    "description=\"Profile, privacy, contacts and lookups for the selected device.\"": "description=\"Perfil, privacidade, contatos e consultas do dispositivo selecionado.\"",
    "title=\"Change avatar\"": "title=\"Alterar foto de perfil\"",
    "description=\"Update your own profile picture.\"": "description=\"Atualize sua foto de perfil.\"",
    "title=\"Change push name\"": "title=\"Alterar nome de exibição\"",
    "description=\"Update your WhatsApp display name.\"": "description=\"Atualize seu nome de exibição no WhatsApp.\"",
    "title=\"My privacy\"": "title=\"Minha privacidade\"",
    "description=\"Your current privacy settings.\"": "description=\"Suas configurações atuais de privacidade.\"",
    "title=\"My contacts\"": "title=\"Meus contatos\"",
    "description=\"Contacts synced to this device.\"": "description=\"Contatos sincronizados com este dispositivo.\"",
    ">Lookup type<": ">Tipo de consulta<",
    "\n              My profile\n": "\n              Meu perfil\n",
    "\n              Lookup\n": "\n              Consultar\n",
    "\n          Lookup\n": "\n          Consultar\n"
  },
  "src/pages/misc.tsx": {
    "title=\"Channels & Calls\"": "title=\"Canais e chamadas\"",
    "description=\"Follow and find channels, read their posts and engagement, and handle calls.\"": "description=\"Siga e encontre canais, consulte publicações e interações e gerencie chamadas.\"",
    "title=\"Newsletters\"": "title=\"Canais\"",
    "description=\"Channels this device follows.\"": "description=\"Canais que este dispositivo segue.\"",
    "title=\"Live updates\"": "title=\"Atualizações ao vivo\"",
    "description=\"Counter subscriptions GOWA keeps renewing until stopped or restarted.\"": "description=\"Inscrições em contadores renovadas pelo GOWA até serem interrompidas ou reiniciadas.\"",
    "title=\"Find channels\"": "title=\"Encontrar canais\"",
    "description=\"Browse WhatsApp's channel directory or search it by name.\"": "description=\"Explore o diretório de canais do WhatsApp ou pesquise pelo nome.\"",
    "title=\"Look up channel\"": "title=\"Consultar canal\"",
    "description=\"Get a channel's details by ID or invite link, without following it.\"": "description=\"Consulte detalhes de um canal pelo ID ou link de convite, sem segui-lo.\"",
    "title=\"Reject call\"": "title=\"Rejeitar chamada\"",
    "description=\"Reject an incoming call using the caller JID and call ID from the webhook.\"": "description=\"Rejeite uma chamada usando o JID do contato e o ID da chamada recebidos pelo webhook.\"",
    "\n              Following\n": "\n              Seguindo\n",
    "\n              Discover\n": "\n              Descobrir\n",
    "\n              Calls\n": "\n              Chamadas\n"
  },
  "src/pages/settings.tsx": {
    "title=\"Settings\"": "title=\"Configurações\"",
    "description=\"Dashboard connection, server info and health, and appearance.\"": "description=\"Conexão do painel, informações e saúde do servidor e aparência.\"",
    "placeholder=\"Theme\"": "placeholder=\"Tema\"",
    ">Connection<": ">Conexão<",
    ">Where this dashboard sends its requests<": ">Destino das solicitações deste painel<",
    ">Server<": ">Servidor<",
    ">Reported by GET /app/info<": ">Informado por GET /app/info<",
    ">Appearance<": ">Aparência<",
    ">Light<": ">Claro<",
    ">Dark<": ">Escuro<",
    ">System<": ">Sistema<",
    "\n              Disconnect\n": "\n              Desconectar\n"
  },
  "src/pages/messaging.tsx": {
    "label: 'Text'": "label: 'Texto'",
    "label: 'Image'": "label: 'Imagem'",
    "label: 'Video'": "label: 'Vídeo'",
    "label: 'File'": "label: 'Arquivo'",
    "label: 'Audio'": "label: 'Áudio'",
    "label: 'Sticker'": "label: 'Figurinha'",
    "label: 'Contact'": "label: 'Contato'",
    "label: 'Location'": "label: 'Localização'",
    "label: 'Poll'": "label: 'Enquete'",
    "label: 'Forward'": "label: 'Encaminhar'",
    "label: 'Message'": "label: 'Mensagem'",
    "label: 'Media'": "label: 'Mídia'",
    "label: 'Rich'": "label: 'Recursos avançados'",
    "label: 'Interactive'": "label: 'Interativo'",
    "label: 'Presence'": "label: 'Presença'",
    "label: 'Chat presence'": "label: 'Presença na conversa'",
    "label: 'Watch presence'": "label: 'Monitorar presença'",
    "label: 'React'": "label: 'Reagir'",
    "label: 'Edit text'": "label: 'Editar texto'",
    "label: 'Mark as read'": "label: 'Marcar como lida'",
    "label: 'Mark audio as played'": "label: 'Marcar áudio como reproduzido'",
    "label: 'Star / Unstar'": "label: 'Favoritar / Desfavoritar'",
    "label: 'Revoke (delete for everyone)'": "label: 'Apagar para todos'",
    "label: 'Delete (for me)'": "label: 'Apagar para mim'",
    "title=\"Messaging\"": "title=\"Mensagens\"",
    ">Message type<": ">Tipo de mensagem<",
    ">Message ID<": ">ID da mensagem<",
    ">Action<": ">Ação<"
  },
  "src/pages/scheduled.tsx": {
    "label: 'Text'": "label: 'Texto'",
    "label: 'Image'": "label: 'Imagem'",
    "label: 'Video'": "label: 'Vídeo'",
    "label: 'File'": "label: 'Arquivo'",
    "label: 'Audio'": "label: 'Áudio'",
    "label: 'Sticker'": "label: 'Figurinha'",
    "label: 'Contact'": "label: 'Contato'",
    "label: 'Location'": "label: 'Localização'",
    "label: 'Poll'": "label: 'Enquete'",
    "label: 'Forward'": "label: 'Encaminhar'",
    "label: 'All'": "label: 'Todos'",
    "label: 'Active'": "label: 'Ativo'",
    "label: 'Running'": "label: 'Em execução'",
    "label: 'Paused'": "label: 'Pausado'",
    "label: 'Completed'": "label: 'Concluído'",
    "label: 'Failed'": "label: 'Falhou'",
    "label: 'Cancelled'": "label: 'Cancelado'",
    "title=\"Scheduled\"": "title=\"Agendamentos\"",
    "description=\"Delayed and recurring WhatsApp sends for the selected device.\"": "description=\"Envios agendados e recorrentes do WhatsApp para o dispositivo selecionado.\"",
    "placeholder=\"Search recipient or message\"": "placeholder=\"Buscar destinatário ou mensagem\"",
    "aria-label=\"Message type\"": "aria-label=\"Tipo de mensagem\"",
    "title=\"No schedules\"": "title=\"Nenhum agendamento\"",
    ">All types<": ">Todos os tipos<",
    "\n              Previous\n": "\n              Anterior\n",
    "\n              Next\n": "\n              Próximo\n"
  },
  "src/components/layout/theme-toggle.tsx": {
    ">Light<": ">Claro<",
    ">Dark<": ">Escuro<",
    ">System<": ">Sistema<"
  },
  "src/components/layout/device-switcher.tsx": {
    "placeholder=\"Select device\"": "placeholder=\"Selecionar dispositivo\""
  },
  "src/features/devices/create-device-dialog.tsx": {
    "`Device ${device.id} added`": "`Dispositivo ${device.id} adicionado`",
    ">Add device<": ">Adicionar dispositivo<",
    "\n          Add device\n": "\n          Adicionar dispositivo\n",
    "\n              Add device\n": "\n              Adicionar dispositivo\n",
    "Registers a device slot. Pair it with a phone afterwards via QR or pairing code.": "Cadastra um dispositivo. Depois, vincule um celular via QR Code ou código de pareamento.",
    ">Device ID (optional)<": ">ID do dispositivo (opcional)<",
    ">Webhook URL (optional)<": ">URL do webhook (opcional)<",
    ">Webhook secret (optional)<": ">Segredo do webhook (opcional)<",
    "placeholder=\"auto-generated when empty\"": "placeholder=\"gerado automaticamente se estiver vazio\""
  },
  "index.html": {
    "<html lang=\"en\">": "<html lang=\"pt-BR\">"
  }
}
'@
$rules = $rulesJson | ConvertFrom-Json
$utf8 = New-Object System.Text.UTF8Encoding($false)
$edits = @()
$missing = @()
foreach ($file in $rules.PSObject.Properties) {
    $path = Join-Path $Root $file.Name
    if (!(Test-Path -LiteralPath $path -PathType Leaf)) { throw "Arquivo nao encontrado: $($file.Name). Nenhum arquivo foi alterado." }
    $original = [IO.File]::ReadAllText($path)
    $crlf = $original.Contains("`r`n")
    $updated = $original.Replace("`r`n", "`n")
    foreach ($rule in $file.Value.PSObject.Properties) {
        $old = $rule.Name; $new = [string]$rule.Value
        if ($updated.Contains($old)) { $updated = $updated.Replace($old, $new) }
        elseif (!$updated.Contains($new)) { $missing += "$($file.Name): $old" }
    }
    if ($crlf) { $updated = $updated.Replace("`n", "`r`n") }
    if ($original -cne $updated) { $edits += [PSCustomObject]@{Path=$path; Name=$file.Name; Text=$updated} }
}
if ($missing.Count -gt 0) { Write-Warning 'Alguns textos nao coincidem com a versao consultada. Confira os itens nao traduzidos:'; $missing | ForEach-Object { Write-Host $_ } }
foreach ($edit in $edits) {
    $backup = $edit.Path + '.ptbr-backup'
    if (!(Test-Path -LiteralPath $backup)) { Copy-Item -LiteralPath $edit.Path -Destination $backup }
    [IO.File]::WriteAllText($edit.Path, $edit.Text, $utf8)
    Write-Host "Traduzido: $($edit.Name)"
}
Write-Host "Arquivos alterados: $($edits.Count). Traducao inicial; revise git diff e execute npm run build."
if ($Build) {
    Push-Location -LiteralPath $Root
    try {
        if (!(Test-Path -LiteralPath 'node_modules')) {
            npm ci
            if ($LASTEXITCODE -ne 0) { throw 'npm ci falhou.' }
        }
        npm run build
        if ($LASTEXITCODE -ne 0) { throw 'npm run build falhou.' }
        $files = @(Get-ChildItem -LiteralPath 'dist' -Recurse -File -Force)
        if ($files.Count -ne 1 -or !(Test-Path -LiteralPath 'dist/index.html' -PathType Leaf)) { throw 'Build nao respeita o contrato de HTML unico.' }
        Write-Host ('HTML compilado: ' + (Resolve-Path -LiteralPath 'dist/index.html').Path)
        Write-Host ('SHA256: ' + (Get-FileHash -LiteralPath 'dist/index.html' -Algorithm SHA256).Hash.ToLowerInvariant())
    } finally { Pop-Location }
}
