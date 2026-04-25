#!/usr/bin/env bash
set -euo pipefail

CNCJS_INDEX="/usr/lib/node_modules/cncjs/dist/cncjs/app/index.hbs"
BACKUP_DIR="/opt/cncjs-darkmode-backup"
STAMP="$(date +%Y%m%d-%H%M%S)"

echo "== CNCjs Dark Mode Patch =="

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo:"
  echo "sudo bash cncjs-darkmode-patch.sh"
  exit 1
fi

if [[ ! -f "$CNCJS_INDEX" ]]; then
  echo "ERROR: CNCjs index.hbs not found at:"
  echo "$CNCJS_INDEX"
  exit 1
fi

echo "Backing up original file..."
mkdir -p "$BACKUP_DIR"
cp "$CNCJS_INDEX" "$BACKUP_DIR/index.hbs.$STAMP.bak"

echo "Applying patch..."

python3 - <<'PY'
from pathlib import Path
import re

p = Path("/usr/lib/node_modules/cncjs/dist/cncjs/app/index.hbs")
s = p.read_text()

# Remove existing patch if present
s = re.sub(
    r'/\* Norgan CNCjs Dark Mode Patch START \*/.*?/\* Norgan CNCjs Dark Mode Patch END \*/',
    '',
    s,
    flags=re.S
)

patch = r'''
<script>
/* Norgan CNCjs Dark Mode Patch START */
window.addEventListener('load', function(){
  setTimeout(function(){

    var style=document.createElement('style');
    style.innerHTML=`

html,body,#app,[class*="App__main"],[class*="App__content"],
.workspace,.container,.container-fluid{
  background:#121212!important;
  color:#e0e0e0!important;
}

[class*="widget"],[class*="panel"],[class*="card"]{
  background:#1a1a1a!important;
  color:#e0e0e0!important;
  border-color:#333!important;
}

input,textarea,select,button{
  background:#2a2a2a!important;
  color:#fff!important;
  border:1px solid #333!important;
}

canvas{
  background:#0f0f0f!important;
}

[class*="Console"],.xterm,.xterm-rows{
  background:#050505!important;
  color:#e6e6e6!important;
}

.xterm *{
  color:#e6e6e6!important;
}

`;
    document.head.appendChild(style);

    function darken(el){
      el.style.backgroundColor='#1a1a1a';
      el.style.color='#e0e0e0';
      el.style.borderColor='#333';
    }

    function runPatch(){
      document.querySelectorAll('*').forEach(el=>{
        if(el.style && el.style.backgroundColor==='white'){
          darken(el);
        }
      });
    }

    runPatch();
    setInterval(runPatch,1000);

  },1200);
});
/* Norgan CNCjs Dark Mode Patch END */
</script>
'''

if "</body>" not in s:
    raise SystemExit("ERROR: </body> not found")

s = s.replace("</body>", patch + "\n</body>")
p.write_text(s)
PY

echo "Patch applied successfully."

if systemctl list-unit-files | grep -q '^cncjs\.service'; then
  echo "Restarting CNCjs..."
  systemctl restart cncjs
fi

echo "Done."
