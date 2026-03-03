FROM nginx:1.29.1-alpine

WORKDIR /frontend-nginx

# Step 1: Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Step 2: Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/

# Step 3: Copy dist files
COPY dist /usr/share/nginx/html/

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]