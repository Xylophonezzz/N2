#!/bin/zsh

run() {
  if ! "$@"; then
    echo
    echo "Sync stopped. Resolve the error above, then run this file again."
    read -r
    exit 1
  fi
}

export PATH="$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
cd "${0:A:h}"

if [[ -d "$HOME/Desktop/N2真题" ]]; then
  run rsync -a --update "$HOME/Desktop/N2真题/" "资料/N2真题/"
fi

run git add -A
if ! git diff --cached --quiet; then
  run git commit -m "Sync N2 notes $(date '+%Y-%m-%d %H:%M')"
fi

run git pull --rebase origin main
run git push origin main

echo
echo "GitHub sync complete. Press Enter to close."
read -r
