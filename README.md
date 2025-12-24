# WordPress Docker Container

A custom WordPress container with nginx and PHP-FPM, optimized for performance and Cloudflare integration.

## Features

- WordPress with PHP-FPM
- nginx web server with FastCGI caching
- WP-CLI pre-installed
- Cloudflare configuration support
- Optimized PHP settings for WordPress
- Auto-update capability for WordPress core

## Quick Start

```bash
docker-compose up -d
```

Access WordPress at http://localhost:8080

## Container Build

The container is automatically built and pushed to Docker Hub using GitHub Actions.

### Workflow Triggers

The build workflow runs on:
- Push to `main` branch (when Dockerfile or related files change)
- Pull requests to `main` branch
- Manual trigger via GitHub Actions UI

### Required Secrets

To enable automatic builds and pushes to Docker Hub, configure these repository secrets:

- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub password or access token

### Tagging Strategy

The workflow automatically creates the following tags:
- `latest`: Latest build from main branch
- `main`: Latest build from main branch
- `<branch>-<sha>`: Branch name with commit SHA
- Semantic version tags (if using version tags)

### Multi-Platform Support

The container is built for:
- linux/amd64
- linux/arm64

## Development

To build the container locally:

```bash
docker build -t cwhitio/wordpress:local .
```

To test the container:

```bash
docker-compose -f docker-compose.local.yml up
```
