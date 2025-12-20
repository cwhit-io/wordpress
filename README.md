# WordPress (Docker)

A small Docker Compose setup for a self-hosted WordPress stack (MySQL, Redis, PHP-FPM, Nginx).

## 🚀 Quick start

1. Copy or generate a `.env` file:

   - Option 1: Generate a secure `.env` with random passwords:
     ```bash
     python scripts/generate_env.py
     ```
     To overwrite an existing `.env`, add `--force`.

   - Option 2: Copy the example and edit manually:
     ```bash
     cp .env.example .env
     # then edit .env to set DB_PASSWORD and DB_ROOT_PASSWORD
     ```

2. Start the stack:

   ```bash
   docker-compose up -d
   ```

3. Visit http://localhost (or set `HOST_PORT` in `.env`).

## 🔒 Secrets & security

- `.env` is ignored by Git (`.gitignore`) — **do not commit it**.
- `scripts/generate_env.py` creates strong, URL-safe random secrets for:
  - `DB_ROOT_PASSWORD` (MySQL root password)
  - `DB_PASSWORD` (WordPress DB user password)

You can control entropy with `--root-length` and `--db-length` (bytes of randomness).

## 🧩 Project files

- `docker-compose.yml` — service definitions (wordpress, db, redis, nginx)
- `.env.example` — example environment variables
- `scripts/generate_env.py` — generate `.env` with random secrets
- `scripts/README.md` — usage notes for the generator
- `nginx.conf`, `custom-php.ini` — service configs

## 🛠️ Tips

- Regenerate passwords (careful):
  ```bash
  python scripts/generate_env.py --force
  ```
  Regenerating will replace `DB_PASSWORD` and `DB_ROOT_PASSWORD`, which may require re-initializing or migrating your database.

- On Windows, run the script with the Python available in your environment (`py -3` or `python`).

## ❓ Need anything else?

If you'd like I can add a PowerShell helper to generate `.env` on Windows, or add a `Makefile`/npm script for one-step setup. ✨
