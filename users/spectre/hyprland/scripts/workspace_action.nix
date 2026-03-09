{ pkgs }:
pkgs.writeShellScriptBin "workspace_action" ''
  curr_workspace="$(${pkgs.hyprland}/bin/hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq -r '.id')"
  dispatcher="$1"
  shift 

  if [[ -z "$dispatcher" || "$dispatcher" == "--help" || "$dispatcher" == "-h" || -z "$1" ]]; then
    echo "Usage: $0 <dispatcher> <target>"
    exit 1
  fi

  if [[ "$1" == *"+"* || "$1" == *"-"* ]]; then 
    ${pkgs.hyprland}/bin/hyprctl dispatch "$dispatcher" "$1" 
  elif [[ "$1" =~ ^[0-9]+$ ]]; then 
    target_workspace=$((((curr_workspace - 1) / 10 ) * 10 + $1))
    ${pkgs.hyprland}/bin/hyprctl dispatch "$dispatcher" "$target_workspace"
  else
    ${pkgs.hyprland}/bin/hyprctl dispatch "$dispatcher" "$1" 
    exit 1
  fi
''
