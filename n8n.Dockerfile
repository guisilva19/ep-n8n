FROM n8nio/n8n:latest

# Configuração para Railway
USER root

# Instalar dependências se necessário
RUN npm install -g npm@latest

# Voltar para usuário n8n
USER node

# Porta que o Railway vai usar
EXPOSE 5678

# Comando de inicialização
CMD ["n8n", "start"]