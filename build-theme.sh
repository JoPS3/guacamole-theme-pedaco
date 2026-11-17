#!/bin/sh
set -eu

output="dist/pedaco-guacamole-theme.jar"

if ! command -v python3 >/dev/null 2>&1; then
    printf '%s\n' "Erro: Python 3 é necessário para gerar a extensão." >&2
    exit 1
fi

python3 - <<'PY'
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

output = Path("dist/pedaco-guacamole-theme.jar")
output.parent.mkdir(parents=True, exist_ok=True)

with ZipFile(output, "w", ZIP_DEFLATED) as archive:
    for path in (
        "guac-manifest.json",
        "css/theme.css",
        "translations/en.json",
        "translations/pt.json",
        "images/icon-64.png",
        "images/icon-144.png",
    ):
        archive.write(path)

print(f"Extensão criada: {output}")
PY
