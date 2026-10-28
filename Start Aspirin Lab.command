#!/bin/bash
# Double-click to run Aspirin Lab without internet: serves this folder on this computer and opens it in Chrome.
cd "$(dirname "$0")" || exit 1

PORT=8765
while lsof -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; do PORT=$((PORT + 1)); done

python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER=$!
trap 'kill "$SERVER" 2>/dev/null' EXIT INT TERM
sleep 1

URL="http://localhost:$PORT/"
open -a "Google Chrome" "$URL" 2>/dev/null || open "$URL"

echo ""
echo "  Aspirin Lab is running at $URL"
echo "  Keep this window open while you present."
echo "  Close it (or press Ctrl-C) when you're done."
echo ""
wait "$SERVER"
