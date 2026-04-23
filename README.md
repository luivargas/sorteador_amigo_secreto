# Sorteador de Amigo Secreto

Organize grupos de amigo secreto de forma simples e rapida. Crie grupos, adicione participantes, realize o sorteio e notifique todos automaticamente.

---

## Funcionalidades

### Autenticacao

- Login por email com codigo de verificacao de 6 digitos (OTP)
- Suporte a colar o codigo automaticamente a partir da area de transferencia
- Sessao persistida localmente — nao e necessario fazer login toda vez
- Logout com confirmacao

---

### Grupos

- **Criar grupo** com nome, nome do administrador, email e telefone
- **Visualizar** detalhes do grupo: local do evento, faixa de valor de presente, data/hora, descricao e participantes
- **Editar** todas as informacoes do grupo a qualquer momento antes do sorteio
- **Excluir** grupo com confirmacao
- **Status do grupo**: Pendente (aguardando sorteio) ou Sorteado
- **Filtrar grupos** por: Todos, Pendentes, Sorteados
- **Buscar grupos** pelo nome
- **Atualizar lista** com gesto de puxar para recarregar

---

### Participantes

- **Adicionar manualmente** com nome, email e telefone (com seletor de codigo do pais)
- **Importar contatos** diretamente da agenda do celular
  - Busca por nome na lista de contatos
  - Selecao multipla de contatos
  - Deteccao automatica do codigo do pais pelo numero de telefone
  - Suporte a contatos com multiplos telefones ou emails
  - Exibicao de fotos dos contatos
- **Revisar contatos** antes de adicionar — edite email e telefone se necessario
- **Visualizar** detalhes do participante
- **Editar** informacoes do participante
- **Excluir** participante (exceto o administrador)
- **Reenviar email** ao participante
- **Buscar participantes** por nome, email ou telefone
- Apos o sorteio, nao e possivel adicionar novos participantes

---

### Sorteio

- Realizacao do sorteio com pelo menos 2 participantes
- Animacao de confete ao concluir o sorteio
- Status do grupo atualizado automaticamente para "Sorteado"
- Os participantes recebem notificacao por email com o resultado

---

### Compartilhamento

- Compartilhe o link de convite do grupo com qualquer app instalado (WhatsApp, Telegram, etc.)
- O link permite que novos participantes entrem no grupo diretamente

---

### Interface e Experiencia

- Design limpo com cartoes coloridos para cada grupo
- Badges de status (Pendente / Sorteado)
- Animacoes suaves nas transicoes de telas
- Banners de sucesso e erro contextuais
- Dialogo de confirmacao para acoes destrutivas
- Puxar para recarregar com animacao de gota d'agua
- Suporte a orientacao retrato

---

## Idiomas Suportados

O app detecta automaticamente o idioma do dispositivo e exibe o conteudo no idioma correspondente.

| Idioma     | Codigo |
|------------|--------|
| Portugues  | pt     |
| Ingles     | en     |
| Espanhol   | es     |
| Italiano   | it     |

---

## Permissoes

| Permissao       | Motivo                                                                 |
|-----------------|------------------------------------------------------------------------|
| Contatos        | Importar participantes diretamente da agenda do celular                |
| Internet        | Comunicacao com a API para criacao de grupos e realizacao do sorteio   |
| Armazenamento   | Acesso a fotos dos contatos (Android)                                  |

---

## Tecnologias Utilizadas

- **Flutter** — framework principal
- **BLoC / Cubit** — gerenciamento de estado
- **GoRouter** — navegacao
- **Dio** — requisicoes HTTP
- **flutter_contacts** — acesso a agenda de contatos
- **share_plus** — compartilhamento nativo
- **confetti** — animacao de sorteio
- **flutter_animate** — animacoes de interface
- **phone_form_field** — campo de telefone com codigo de pais
- **flutter_localizations / intl** — internacionalizacao

---

## Plataformas

- Android
- iOS
