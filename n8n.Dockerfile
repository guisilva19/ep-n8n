FROM n8nio/n8n:latest

# Configuração para Railway
USER root

# Instalar dependências se necessário
RUN npm install -g npm@latest

# Voltar para usuário n8n
USER node

# Configurar variáveis de ambiente para Railway
ENV N8N_PORT=${PORT:-5678}
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV N8N_LOG_LEVEL=info

# Porta que o Railway vai usar (dinâmica)
EXPOSE ${PORT:-5678}

# Comando de inicialização
CMD ["sh", "-c", "n8n start --port=${PORT:-5678}"]