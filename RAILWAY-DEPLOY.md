# 🚀 Deploy no Railway - Passo a Passo

## 📋 **Pré-requisitos:**
- Conta no Railway (railway.app)
- Projeto commitado no Git (GitHub)

## 🏗️ **Passo 1: Criar Projeto no Railway**

1. Acesse [railway.app](https://railway.app)
2. Conecte com GitHub
3. Crie novo projeto
4. Conecte ao seu repositório `n8n-waza`

## 🎯 **Passo 2: Deploy Redis (Primeiro)**

1. No Railway, clique **"+ New"**
2. Selecione **"Database"**
3. Escolha **"Redis"**
4. Nome: `redis-n8n`
5. ✅ **Anote as credenciais geradas**

## 🔧 **Passo 3: Deploy N8N**

### **Criar serviço N8N:**
1. Clique **"+ New"** 
2. Selecione **"GitHub Repo"**
3. Escolha seu repositório
4. **Settings** > **Build**:
   - Dockerfile Path: `n8n.Dockerfile`

### **❌ ERRO 502 - CORREÇÕES APLICADAS:**

**Problemas identificados:**
1. ✅ **Porta**: Corrigida para usar `${PORT}` do Railway
2. ✅ **Host**: Configurado para `0.0.0.0` 
3. ✅ **Protocol**: Configurado para `https`

### **Variáveis de ambiente N8N (ATUALIZADAS):**
```env
# ⚠️  IMPORTANTE: Use essas variáveis no Railway
# Basic Config
N8N_HOST=0.0.0.0
N8N_PROTOCOL=https
GENERIC_TIMEZONE=America/Sao_Paulo
N8N_LOG_LEVEL=info
N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true

# Database (SQLite é mais simples para Railway)
DB_TYPE=sqlite

# Redis (OPCIONAL - só se precisar de cache/queue)
# N8N_REDIS_HOST=${{Redis.REDIS_HOST}}
# N8N_REDIS_PORT=${{Redis.REDIS_PORT}}
# N8N_REDIS_PASSWORD=${{Redis.REDIS_PASSWORD}}
# N8N_REDIS_DB=0

# ⚠️  Configure APÓS o primeiro deploy
# WEBHOOK_URL=https://sua-url-gerada.railway.app
```

### **🔧 Passos para corrigir o 502:**
1. **Redeploy** com o Dockerfile corrigido
2. **Configure as variáveis** no painel Railway
3. **Após deploy, adicione WEBHOOK_URL** com a URL gerada
4. **Redeploy** novamente

## 📱 **Passo 4: Deploy WAHA**

### **Criar serviço WAHA:**
1. Clique **"+ New"**
2. Selecione **"GitHub Repo"** 
3. Escolha seu repositório
4. **Settings** > **Build**:
   - Dockerfile Path: `waha.Dockerfile`

### **Variáveis de ambiente WAHA:**
```env
# WhatsApp Config
WHATSAPP_DEFAULT_ENGINE=GOWS
WHATSAPP_HOOK_EVENTS=message

# Webhook URL (conectar ao N8N)
WHATSAPP_HOOK_URL=${{N8N_SERVICE.RAILWAY_STATIC_URL}}/webhook/webhook
```

## 🔗 **Passo 5: Conectar Serviços**

### **No WAHA, adicionar:**
```env
WHATSAPP_HOOK_URL=https://SEU-N8N-URL.railway.app/webhook/webhook
```

### **Obter URLs:**
- **N8N**: `https://seu-n8n-xxx.railway.app`
- **WAHA**: `https://seu-waha-xxx.railway.app`

## ✅ **Passo 6: Teste**

1. **Acesse N8N**: Sua URL do N8N
2. **Configure WAHA**: 
   - API: `https://seu-waha-xxx.railway.app`
   - Criar sessão via API
   - Escanear QR Code

## 💰 **Custo estimado:**
- **Redis**: ~$5/mês
- **N8N**: Grátis (plano hobby)
- **WAHA**: Grátis (plano hobby)
- **Total**: ~$5/mês

## 🔧 **Comandos úteis:**

### **Criar sessão WAHA:**
```bash
curl -X POST https://seu-waha-xxx.railway.app/api/sessions/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "default",
    "config": {
      "webhooks": [{
        "url": "https://seu-n8n-xxx.railway.app/webhook/webhook",
        "events": ["message"]
      }]
    }
  }'
```

### **Obter QR Code:**
```bash
curl https://seu-waha-xxx.railway.app/api/sessions/default/auth/qr
```

---

**🎉 Pronto! Sua stack N8N + WAHA está no Railway!**