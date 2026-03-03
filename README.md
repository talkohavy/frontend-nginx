# Frontend NGINX

Production-grade NGINX server for serving static frontend files with optimal performance and caching.

## 🎯 Features

### **Performance Optimizations**

- ✅ **Gzip Compression** - Reduces file sizes by up to 70%
- ✅ **Aggressive Caching** - Hashed assets cached for 1 year
- ✅ **Static File Serving** - NGINX native performance
- ✅ **SPA Support** - Proper fallback routing for client-side apps

### **Security Headers**

- ✅ **Content Security Policy** - XSS protection
- ✅ **X-Frame-Options** - Clickjacking protection
- ✅ **X-Content-Type-Options** - MIME sniffing protection
- ✅ **Referrer Policy** - Privacy protection

### **Caching Strategy**

- 🔄 **Hashed JS/CSS** - `expires 1y` (immutable)
- 🔄 **Images/Fonts** - `expires 30d`
- 🔄 **HTML Files** - No cache (SPA routing)
- 🔄 **Source Maps** - `expires 1d` (debugging)

### **Environment Configuration**

- 🔄 **API URL Substitution** - Runtime environment configuration
- 🔄 **Docker Support** - Production-ready containerization
- 🔄 **Health Checks** - Built-in monitoring

## 📁 Project Structure

```
frontend-nginx/
├── dist/                    # Static files to serve
│   ├── index.html          # Main SPA entry point
│   └── assets/             # JS, CSS, images, fonts
├── scripts/                # Container scripts
│   └── container-api-substitution.sh
├── nginx.conf              # NGINX configuration
├── Dockerfile              # Container definition
└── package.json            # Project metadata
```

## 🚀 Usage

### **Local Development**

```bash
# Run with custom API URL
npm run docker:run:dev
```

### **Docker Commands**

```bash
# Run with environment-specific API URL
docker run -p 3000:80 -e API_URL="https://api.luckylove.co.il/api" talkohavy/luckylove-frontend-nginx
```

### **Access**

- **Frontend**: http://localhost:3000
- **Health Check**: http://localhost:3000/health

## 🔧 Environment Configuration

The container supports runtime API URL substitution:

```bash
# Development
API_URL="http://localhost:8000/api"

# Staging
API_URL="https://staging-api.luckylove.co.il/api"

# Production
API_URL="https://luckylove.co.il"
```

## 🛠️ Customization

### **Modify Caching Rules**

Edit `nginx.conf` cache control headers:

```nginx
location ~* \.(js|css)$ {
    expires 1y;  # Change cache duration
    add_header Cache-Control "public, immutable";
}
```

### **Add Custom Routes**

Add new location blocks in `nginx.conf`:

```nginx
location /api {
    proxy_pass http://backend-service;
}
```

### **Security Headers**

Modify CSP and other security headers in `nginx.conf`.
