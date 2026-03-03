FROM nginx:1.29.1-alpine

WORKDIR /frontend-nginx

# Step 1: Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Step 2: Copy nginx configurations (default = HTTP; entrypoint switches to SSL when certs exist)
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx-ssl.conf /etc/nginx/conf.d/nginx-ssl.conf

# Step 3: Entrypoint enables HTTPS automatically when certs are mounted
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Step 4: Copy dist files
COPY dist /usr/share/nginx/html/

EXPOSE 80 443

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]