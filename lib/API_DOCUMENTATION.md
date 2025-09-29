# Documentação da API - Secret Santa (Amigo Secreto)

Esta documentação descreve todos os endpoints disponíveis na API do sistema de Amigo Secreto, suas funcionalidades, parâmetros de entrada e respostas.

## Índice

1. [Grupos (Groups)](#grupos-groups)
2. [Participantes (Participants)](#participantes-participants)
3. [Mensagens (Messages)](#mensagens-messages)
4. [Pagamentos (Payments)](#pagamentos-payments)
5. [WhatsApp Webhook](#whatsapp-webhook)
6. [Middlewares](#middlewares)
7. [Códigos de Resposta](#códigos-de-resposta)

## Base URL

```
/api
```

## Autenticação

A API utiliza middlewares de validação:
- **AdminValidationMiddleware**: Valida se o usuário tem permissões de administrador
- **ParticipantValidationMiddleware**: Valida se o usuário é um participante válido
- **Access-Key**: Header usado para identificar administradores através de chave criptografada

---

## Grupos (Groups)

### Criar Grupo
**POST** `/groups`

Cria um novo grupo de amigo secreto com administrador.

#### Parâmetros de Entrada
```json
{
    "name": "string (required) - Nome do grupo",
    "description": "string (optional) - Descrição do grupo",
    "draw_date": "datetime (optional) - Data do sorteio",
    "location": "string (optional) - Local da troca",
    "min_gift_value": "decimal (optional) - Valor mínimo do presente",
    "max_gift_value": "decimal (optional) - Valor máximo do presente",
    "admin": {
        "name": "string (required) - Nome do administrador",
        "email": "string (optional) - Email do administrador",
        "phone": "string (optional) - Telefone do administrador",
        "user_id": "string (optional) - ID do usuário"
    }
}
```

#### Resposta
```json
{
    "name": "string",
    "code": "string",
    "short_code": "string",
    "token": "string",
    "participants": [...]
}
```

---

### Listar Grupos
**GET** `/groups` *(Requer AdminValidationMiddleware)*

Lista grupos com filtros opcionais.

#### Parâmetros de Query
- `status` (optional): Filtrar por status (active, archived)
- `type` (optional): Filtrar por tipo

#### Resposta
Paginação com lista de grupos.

---

### Visualizar Grupo
**GET** `/groups/{group}` *(Requer AdminValidationMiddleware)*

Retorna detalhes de um grupo específico.

#### Resposta
```json
{
    "id": "uuid",
    "name": "string",
    "code": "string",
    "status": "string",
    "participants": [...]
}
```

---

### Atualizar Grupo
**PUT** `/groups/{group}` *(Requer AdminValidationMiddleware)*

Atualiza informações de um grupo.

#### Parâmetros de Entrada
```json
{
    "name": "string (optional)",
    "description": "string (optional)",
    "draw_date": "datetime (optional)",
    "location": "string (optional)",
    "min_gift_value": "decimal (optional)",
    "max_gift_value": "decimal (optional)"
}
```

---

### Deletar Grupo
**DELETE** `/groups/{group}` *(Requer AdminValidationMiddleware)*

Remove um grupo permanentemente.

#### Resposta
Status 204 (No Content)

---

### Operações de Grupo

#### Arquivar Grupo
**POST** `/groups/{group}/archive` *(Requer AdminValidationMiddleware)*

Altera status do grupo para "archived".

#### Desarquivar Grupo
**POST** `/groups/{group}/unarchive` *(Requer AdminValidationMiddleware)*

Altera status do grupo para "active".

#### Refazer Sorteio
**POST** `/groups/{group}/redraw` *(Requer AdminValidationMiddleware)*

Permite refazer o sorteio dentro de 24 horas, se mais de 50% dos participantes votaram a favor.

**Validações:**
- Só pode ser feito dentro de 24 horas após o sorteio
- Requer maioria dos votos dos participantes

#### Realizar Sorteio
**POST** `/groups/{group}/raffle` *(Requer AdminValidationMiddleware)*

Executa o sorteio do grupo e envia emails para todos os participantes.

**Funcionalidades:**
- Realiza o algoritmo de sorteio
- Envia emails com resultado para cada participante
- Marca o grupo como sorteado

#### Importar CSV
**POST** `/groups/{group}/import-csv` *(Requer AdminValidationMiddleware)*

Importa participantes via arquivo CSV.

#### Parâmetros de Entrada
```
csv_file: arquivo CSV com colunas: nome,email,ddi,telefone
```

**Formato CSV esperado:**
```csv
nome,email,ddi,telefone
João Silva,joao@email.com,55,11999999999
Maria Santos,maria@email.com,55,11888888888
```

---

### Participantes do Grupo

#### Listar Participantes
**GET** `/groups/{group}/participants`

Retorna lista pública de participantes do grupo.

#### Entrar no Grupo
**POST** `/groups/{group}/join`

Permite que uma pessoa entre no grupo.

#### Parâmetros de Entrada
```json
{
    "name": "string (required)",
    "email": "string (optional)",
    "phone": "string (optional)"
}
```

**Validações:**
- Email OU telefone obrigatório
- Nome único no grupo
- Grupo não pode estar já sorteado

#### Ver Resultado do Sorteio
**GET** `/groups/{group}/participant-result` *(Requer ParticipantValidationMiddleware)*

Retorna o resultado do sorteio para o participante autenticado.

#### Resposta
```json
{
    "group": {
        "name": "string",
        "draw_date": "datetime",
        "location": "string"
    },
    "participant": {
        "name": "string",
        "raffled_participant": {
            "name": "string",
            "wishlist": "string",
            "dislikes": "string"
        }
    }
}
```

#### Deletar Mensagens do Grupo
**DELETE** `/groups/{group}/messages` *(Requer ParticipantValidationMiddleware)*

Soft delete de todas as mensagens do grupo.

---

### Recuperação de Grupos

#### Enviar Lista para Admin
**POST** `/admin/send-group-list`

Envia por email lista de grupos onde o usuário é administrador.

#### Parâmetros de Entrada
```json
{
    "email": "string (required)"
}
```

#### Recuperar Grupos Completos
**POST** `/groups/recover`

Envia por email lista completa de grupos (como admin e participante).

#### Parâmetros de Entrada
```json
{
    "email": "string (required)"
}
```

---

## Participantes (Participants)

### Listar Participantes
**GET** `/participants`

Lista todos os participantes com paginação.

### Criar Participante
**POST** `/participants`

Cria um novo participante em um grupo.

#### Parâmetros de Entrada
```json
{
    "group_code": "string (required)",
    "name": "string (required)",
    "email": "string (optional)",
    "phone": "string (optional)",
    "role": "string (optional) - participant|observer",
    "is_participant": "boolean (optional)"
}
```

### Visualizar Participante
**GET** `/participants/{participant}`

Retorna detalhes de um participante específico.

### Atualizar Participante
**PUT** `/participants/{participant}`

Atualiza dados de um participante.

### Deletar Participante
**DELETE** `/participants/{participant}`

Remove um participante (soft delete).

---

### Operações de Participante

#### Atualizar Preferências
**PUT** `/participants/{participant}/update-preferences` *(Requer ParticipantValidationMiddleware)*

Atualiza preferências do participante.

#### Parâmetros de Entrada
```json
{
    "wishlist": "string (optional)",
    "dislikes": "string (optional)",
    "sizes": "string (optional)"
}
```

#### Alterar Papel
**POST** `/participants/{participant}/change-role`

Altera o papel de um participante no grupo.

#### Votar para Refazer Sorteio
**POST** `/participants/{participant}/vote-redraw`

Registra voto do participante para refazer o sorteio.

#### Marcar Presente como Comprado
**POST** `/participants/{participant}/purchased-gift`

Marca que o participante comprou o presente.

#### Retirar Participante
**POST** `/participants/{participant}/withdraw`

Remove participante do grupo (altera status para "withdrawn").

#### Reenviar Email
**POST** `/participants/{participant}/resend-email` *(Requer AdminValidationMiddleware)*

Reenvia email com resultado do sorteio para o participante.

#### Alternar Participação
**PUT** `/participants/{participant}/toggle-participation` *(Requer AdminValidationMiddleware)*

Alterna se o participante faz parte do sorteio ou é apenas observador.

#### Parâmetros de Entrada
```json
{
    "is_participant": "boolean (required)"
}
```

---

### Rotas Anônimas de Participante

#### Obter Dados do Participante Atual
**GET** `/me`

Retorna dados do participante baseado no Access-Key.

#### Atualizar Dados Próprios
**PUT** `/participants/me` *(Requer ParticipantValidationMiddleware)*

Permite que participante atualize seus próprios dados.

#### Votar para Refazer (Anônimo)
**POST** `/participant/vote-redraw` *(Requer ParticipantValidationMiddleware)*

Versão anônima do voto para refazer sorteio.

---

## Mensagens (Messages)

### Listar Mensagens
**GET** `/participants/{participant}/messages` *(Requer ParticipantValidationMiddleware)*
**GET** `/messages` *(Requer ParticipantValidationMiddleware)*

Lista mensagens entre participantes.

#### Parâmetros de Query
- `role` (required): "giver" ou "receiver"

#### Resposta
```json
[
    {
        "id": "uuid",
        "content": "string",
        "created_at": "datetime",
        "read": "boolean",
        "is_mine": "boolean",
        "participant_role": "string"
    }
]
```

### Enviar Mensagem
**POST** `/participants/{participant}/messages` *(Requer ParticipantValidationMiddleware)*
**POST** `/messages` *(Requer ParticipantValidationMiddleware)*

Envia uma mensagem.

#### Parâmetros de Entrada
```json
{
    "content": "string (required)",
    "role": "string (required) - giver|receiver"
}
```

### Marcar como Lida
**PUT** `/participants/{participant}/messages/read` *(Requer ParticipantValidationMiddleware)*
**PUT** `/messages/read` *(Requer ParticipantValidationMiddleware)*

Marca mensagens como lidas.

#### Parâmetros de Query
- `role` (required): "giver" ou "receiver"

### Contar Não Lidas
**GET** `/participants/{participant}/messages/unread-count` *(Requer ParticipantValidationMiddleware)*
**GET** `/messages/unread-count` *(Requer ParticipantValidationMiddleware)*

Retorna contagem de mensagens não lidas.

#### Resposta
```json
{
    "giver_unread": "integer",
    "receiver_unread": "integer",
    "total_unread": "integer"
}
```

---

## Pagamentos (Payments)

### Habilitar WhatsApp para Grupo
**POST** `/payments/enable-group-whatsapp`

Habilita funcionalidade WhatsApp para um grupo após pagamento.

#### Parâmetros de Entrada
```json
{
    "reference": "string (required) - Código do grupo"
}
```

#### Resposta
```json
{
    "success": "boolean",
    "message": "string",
    "group": {
        "code": "string",
        "whatsapp_enabled_at": "datetime"
    }
}
```

---

## WhatsApp Webhook

### Verificação de Webhook
**GET** `/webhooks/whatsapp`

Endpoint para verificação do webhook do WhatsApp.

#### Parâmetros de Query
- `hub.mode`: Modo de verificação
- `hub.verify_token`: Token de verificação
- `hub.challenge`: Challenge do WhatsApp

### Receber Mensagens
**POST** `/webhooks/whatsapp`

Recebe mensagens do WhatsApp e processa comandos.

**Funcionalidades:**
- Reconhece comandos de consulta de resultado
- Suporte para múltiplos grupos por usuário
- Interface interativa com botões e listas
- Normalização de números de telefone brasileiros
- Cache de sessão para seleção de grupos
- Comando de reiniciar conversa

**Comandos reconhecidos:**
- "resultado", "sorteio", "amigo secreto", "quem tirei", etc.
- "recomeçar", "reiniciar", "começar novamente", etc.

---

## Middlewares

### AdminValidationMiddleware
Valida se o usuário possui permissões de administrador através do header `Access-Key`.

### ParticipantValidationMiddleware
Valida se o usuário é um participante válido do sistema.

---

## Códigos de Resposta

### Sucesso
- **200**: OK - Operação realizada com sucesso
- **201**: Created - Recurso criado com sucesso
- **204**: No Content - Operação de delete realizada com sucesso

### Erro do Cliente
- **400**: Bad Request - Dados inválidos ou malformados
- **401**: Unauthorized - Não autorizado
- **403**: Forbidden - Sem permissão para a operação
- **404**: Not Found - Recurso não encontrado
- **409**: Conflict - Conflito (ex: participante já existe)
- **422**: Unprocessable Entity - Dados válidos mas com regras de negócio violadas

### Erro do Servidor
- **500**: Internal Server Error - Erro interno do servidor
- **501**: Not Implemented - Funcionalidade não implementada

---

## Observações Importantes

### Validações de Negócio
1. **Grupos já sorteados**: Muitas operações são bloqueadas após o sorteio
2. **Período de refazer sorteio**: Limitado a 24 horas após o sorteio original
3. **Votação para refazer**: Requer maioria simples (>50%) dos participantes
4. **Nomes únicos**: Participantes devem ter nomes únicos dentro do grupo
5. **Email ou telefone**: Pelo menos um meio de contato é obrigatório

### Recursos de Email
- Envio automático de emails em várias operações
- Templates personalizados para diferentes situações
- Links criptografados para acesso seguro

### Funcionalidades WhatsApp
- Integração completa com WhatsApp Business API
- Suporte para mensagens interativas (botões e listas)
- Normalização inteligente de números brasileiros
- Sistema de sessão para conversas complexas
- Fallback para mensagens de texto quando necessário

### Segurança
- Tokens criptografados para acesso
- Validação de permissões em múltiplas camadas
- Soft delete para preservar histórico
- Logs detalhados para auditoria
