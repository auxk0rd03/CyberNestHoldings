/**
 * CyberNest Holdings LLC - Cloudflare Edge Security Proxy Worker
 * Proxies GitHub Pages traffic and injects required HTTP security headers
 * to achieve 0/100 Surface Risk Score on CyberNest Labs BlackRoute-Web audits.
 */

const ORIGIN_URL = "https://auxk0rd03.github.io/CyberNestHoldings";

const SECURITY_HEADERS = {
  "Content-Security-Policy": "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data: https:; font-src 'self'; connect-src 'self'; form-action 'self' https://docs.google.com https://forms.gle; frame-ancestors 'none'; base-uri 'self'; object-src 'none';",
  "X-Frame-Options": "DENY",
  "X-Content-Type-Options": "nosniff",
  "Referrer-Policy": "strict-origin-when-cross-origin",
  "Permissions-Policy": "camera=(), microphone=(), geolocation=(), payment=(), usb=()",
  "Strict-Transport-Security": "max-age=31536000; includeSubDomains; preload"
};

export default {
  async fetch(request) {
    const url = new URL(request.url);
    const targetUrl = new URL(url.pathname + url.search, ORIGIN_URL);

    // Forward request to origin (GitHub Pages)
    const response = await fetch(targetUrl.toString(), {
      method: request.method,
      headers: request.headers,
    });

    // Clone and append missing security response headers
    const newHeaders = new Headers(response.headers);
    for (const [key, value] of Object.entries(SECURITY_HEADERS)) {
      newHeaders.set(key, value);
    }

    return new Response(response.body, {
      status: response.status,
      status_text: response.statusText,
      headers: newHeaders,
    });
  }
};
