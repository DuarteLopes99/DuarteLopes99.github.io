#!/usr/bin/env bash
# Render cv.html to assets/cv/Duarte_Lopes_CV.pdf with headless Chrome,
# then check that the PDF is two pages and list the links it contains.
#
# Usage (from anywhere):  ./tools/build_cv.sh
# Needs Google Chrome or Chromium. Set CHROME=/path/to/chrome to override.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/cv.html"
OUT="$ROOT/assets/cv/Duarte_Lopes_CV.pdf"

if [ -z "${CHROME:-}" ]; then
  for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
           "$(command -v google-chrome || true)" \
           "$(command -v chromium || true)" \
           "$(command -v chromium-browser || true)"; do
    if [ -n "$c" ] && [ -x "$c" ]; then CHROME="$c"; break; fi
  done
fi
[ -n "${CHROME:-}" ] || { echo "error: Chrome not found, set CHROME=/path/to/chrome"; exit 1; }
[ -f "$SRC" ] || { echo "error: $SRC not found"; exit 1; }
mkdir -p "$(dirname "$OUT")"

# Fonts load over http, not file://, so serve the site for the render.
PORT=8799
python3 -m http.server "$PORT" --directory "$ROOT" >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER 2>/dev/null || true' EXIT
sleep 1

"$CHROME" --headless --disable-gpu --no-sandbox --no-pdf-header-footer \
  --print-to-pdf="$OUT" --virtual-time-budget=8000 \
  "http://127.0.0.1:$PORT/cv.html" 2>/dev/null

python3 - "$OUT" <<'PY'
import re, sys
pdf = open(sys.argv[1], 'rb').read()
pages = len(re.findall(rb'/Type\s*/Page[^s]', pdf))
links = sorted({u.decode('latin1') for u in re.findall(rb'/URI\s*\((.*?)\)', pdf)})
print(f"pages: {pages}")
for link in links:
    print(f"  link: {link}")
if pages != 2:
    print(f"warning: expected 2 pages, got {pages}. Shorten cv.html.")
    sys.exit(1)
PY
echo "built: $OUT"
