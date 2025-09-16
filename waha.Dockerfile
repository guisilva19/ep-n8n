FROM devlikeapro/waha:latest

# Variáveis de ambiente específicas do WAHA
ENV WHATSAPP_DEFAULT_ENGINE=GOWS
ENV WHATSAPP_HOOK_EVENTS=message
ENV WHATSAPP_SWAGGER_ENABLED=true
ENV WHATSAPP_SWAGGER_USERNAME=admin
ENV WHATSAPP_SWAGGER_PASSWORD=admin
ENV WHATSAPP_START_SESSION=default

# Configurar porta corretamente
ENV PORT=3000
ENV HOST=0.0.0.0

# Porta que o Railway vai usar
EXPOSE 3000

# Criar diretórios para persistência
RUN mkdir -p /app/.sessions /app/.media

# Healthcheck mais simples
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://0.0.0.0:3000/api || exit 1

# Comando padrão - usar o comando nativo do WAHA
CMD ["node", "dist/main.js"]