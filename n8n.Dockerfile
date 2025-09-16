FROM n8nio/n8n:latest

# Configuração para Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV N8N_LOG_LEVEL=info

# Porta padrão do n8n
EXPOSE 5678

# Comando de inicialização
CMD ["n8n", "start"]