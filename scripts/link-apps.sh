#!/usr/bin/env bash
# 在 fuyuji_robot/apps/ 下建立指向平级业务仓的软链（apps/ 已 gitignore）。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PARENT="$(cd "$ROOT/.." && pwd)"
APP_DIR="$ROOT/apps"

mkdir -p "$APP_DIR"

link_app() {
  local name="$1"
  local repo="$2"
  local target="$PARENT/$repo"
  if [[ ! -d "$target" ]]; then
    echo "skip $name: $target 不存在"
    return 0
  fi
  ln -sfn "../../$repo" "$APP_DIR/$name"
  echo "ok   $name -> $target"
}

link_app ios DiguProject
link_app android fuyuji-android-module
link_app web dailyhole-web
link_app backend dailyhole
