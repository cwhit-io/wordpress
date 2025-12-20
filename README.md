# WordPress (Docker)

A small Docker Compose setup for a self-hosted WordPress stack (MySQL, Redis, PHP-FPM, Nginx).

## 🚀 Quick start

1. Create a `.env` file (required):

   ```bash
   cp .env.example .env
   # then edit .env to set the required values
   ```

   Required variables to set in `.env`:
   - `HOST_PORT` — port to bind nginx (e.g. `80`)
   - `DB_PASSWORD` — password for the WordPress database user

   You can either set `DB_ROOT_PASSWORD` for a fixed MySQL root password, or set `MYSQL_RANDOM_ROOT_PASSWORD=yes` in your `.env` to have the MySQL image generate a random root password during initialization (the generated password will be printed to the database container's logs on first startup). If you use a random root password, capture it from the database container logs when the DB initializes (e.g., `docker-compose logs db --tail=200`).

2. Start the stack:

   ```bash
   docker-compose up -d
   ```

3. Visit http://localhost (or `http://localhost:${HOST_PORT}` if you changed the port).

## 🔒 Secrets & security

- `.env` is ignored by Git (`.gitignore`) — **do not commit it**.
- Keep `DB_PASSWORD` and `DB_ROOT_PASSWORD` secret; store them securely in your environment or a secrets manager.

## 🧩 Project files

- `docker-compose.yml` — service definitions (wordpress, db, redis, nginx)
- `.env.example` — example environment variables (edit before use)
- `scripts/README.md` — notes about helpers in `scripts/`
- `nginx.conf`, `custom-php.ini` — service configs

## 🛠️ Helpful commands

- Start the stack: `docker-compose up -d`
- View logs: `docker-compose logs -f`
- Stop and remove: `docker-compose down`
