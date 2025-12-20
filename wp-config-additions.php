<?php
/**
 * WordPress configuration additions for Cloudflare Tunnel
 * Add this to your wp-config.php or use WP_AUTO_UPDATE_CORE constant
 */

// Handle HTTPS when behind Cloudflare Tunnel
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

// Force SSL for admin if coming through HTTPS
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    define('FORCE_SSL_ADMIN', true);
}

// Trust Cloudflare proxy headers
if (isset($_SERVER['HTTP_CF_CONNECTING_IP'])) {
    $_SERVER['REMOTE_ADDR'] = $_SERVER['HTTP_CF_CONNECTING_IP'];
}
