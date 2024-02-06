#!/bin/zsh

declare -A dtoc=([north]=prev [south]=next [west]=prev [east]=next)
case "$(jq -r '.layout' < <(bspc query -T -d))" in
    tiled) t="${2}.local";;
    monocle) t="${dtoc[$2]}.local.window.!hidden";;
    *) exit 1;;
esac
bspc node "$1" "$t"
