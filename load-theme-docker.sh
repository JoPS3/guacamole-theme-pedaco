#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || -z $1 ]]; then
    printf 'Uso: %s <nome-ou-id-do-container-guacamole>\n' "$0" >&2
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    printf '%s\n' "Erro: Docker é necessário para instalar a extensão." >&2
    exit 1
fi

container=$1
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

running=$(docker inspect --format '{{.State.Running}}' "$container")
if [[ $running != true ]]; then
    printf 'Erro: o contêiner "%s" não está em execução.\n' "$container" >&2
    exit 1
fi

guacamole_home=$(docker exec "$container" sh -c 'printf "%s" "${GUACAMOLE_HOME:-/etc/guacamole}"')
extensions_dir="${guacamole_home%/}/extensions"

cd "$script_dir"
./build-theme.sh

docker exec --user 0 "$container" mkdir -p -- "$extensions_dir"
docker cp dist/pedaco-guacamole-theme.jar "$container:$extensions_dir/pedaco-guacamole-theme.jar"
docker restart "$container"

printf '%s\n' "Tema instalado. Atualize a página no navegador limpando o cache (Ctrl+F5)."
