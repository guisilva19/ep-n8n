FROM n8nio/n8n:latest

# Configurações mínimas para Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=${PORT}
ENV N8N_PROTOCOL=https

# Expor porta
EXPOSE ${PORT}

# Comando simples
CMD ["n8n", "start"]