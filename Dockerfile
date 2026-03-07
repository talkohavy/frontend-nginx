FROM nginx:1.29.1-alpine

WORKDIR /frontend-nginx

# Remove default nginx config and use SSL config only
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx-ssl.conf /etc/nginx/conf.d/default.conf

# Copy dist files
COPY dist /usr/share/nginx/html/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]