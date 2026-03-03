# Frontend NGINX

A simple server that hosts your frontend files and can do HTTPS with certificates.

---

## 1. How to start the project

### Step 1: Put your website in `dist/`

Place your built website (e.g. `index.html` and your JS/CSS/images) inside the **`dist/`** folder.  
If `dist/` is empty or missing, the Docker build will still run, but you’ll have nothing to serve.

### Step 2: Build the Docker image

In the project folder, run:

```bash
docker build -t frontend-nginx .
```

### Step 3: Run the container

**Without HTTPS (just HTTP):**

```bash
docker run -p 80:80 frontend-nginx
```

**With HTTPS (see section 3 first to create certificates):**

```bash
docker run -p 80:80 -p 443:443 -v "$(pwd)/certs:/etc/nginx/ssl:ro" frontend-nginx
```

- **HTTP:** open [http://localhost](http://localhost)
- **HTTPS (when certs are mounted):** open [https://localhost](https://localhost) (your browser will warn about the certificate if it’s self-signed—that’s normal for local/dev).

---

## 2. How to check it started properly

1. **Health check in the browser**  
   Open: [http://localhost/health](http://localhost/health)  
   You should see the word: **healthy**

2. **Health check in the terminal**

   ```bash
   curl http://localhost/health
   ```

   You should see: **healthy**

---

## 3. How to add certificates (HTTPS)

The server uses two files:

- **Certificate:** `fullchain.pem`
- **Private key:** `privkey.pem`

They must be in a folder that you mount into the container as `/etc/nginx/ssl/`.  
We use a **`certificates`** folder in this project.

### Option A: Create certificates with the included script (easiest)

From the project root, run:

```bash
./scripts/create-certificates.sh
```

This creates **`certs/fullchain.pem`** and **`certs/privkey.pem`** (self-signed, good for local/dev).  
Then run the container with the certs mounted:

```bash
docker run -p 80:80 -p 443:443 -v "$(pwd)/certs:/etc/nginx/ssl:ro" frontend-nginx
```

### Option B: Use your own certificate and key

1. Put your certificate (full chain) in a file named **`fullchain.pem`**.
2. Put your private key in a file named **`privkey.pem`**.
3. Put both files in the **`certs/`** folder (or any folder you want to use).
4. Run Docker with that folder mounted:

   ```bash
   docker run -p 80:80 -p 443:443 -v "/path/to/your/certs:/etc/nginx/ssl:ro" frontend-nginx
   ```

If the names from your CA are different (e.g. `cert.pem` and `key.pem`), copy or rename them to `fullchain.pem` and `privkey.pem` in that folder.
