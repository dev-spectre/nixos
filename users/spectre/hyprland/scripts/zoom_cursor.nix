{ pkgs }:
pkgs.writeShellScriptBin "zoom_cursor" ''
  get_zoom() {
    ${pkgs.hyprland}/bin/hyprctl getoption -j cursor:zoom_factor | ${pkgs.jq}/bin/jq '.float'
  }

  clamp() {
    local val="$1"
    ${pkgs.gawk}/bin/awk "BEGIN {
      v = $val;
      if (v < 1.0) v = 1.0;
      if (v > 3.0) v = 3.0;
      print v;
    }"
  }

  set_zoom() {
    local value="$1"
    clamped=$(clamp "$value")
    ${pkgs.hyprland}/bin/hyprctl keyword cursor:zoom_factor "$clamped"
  }

  case "$1" in
    reset) set_zoom 1.0 ;;
    increase)
      [[ -z "$2" ]] && exit 1
      current=$(get_zoom)
      new=$(${pkgs.gawk}/bin/awk "BEGIN { print $current + $2 }")
      set_zoom "$new"
      ;;
    decrease)
      [[ -z "$2" ]] && exit 1
      current=$(get_zoom)
      new=$(${pkgs.gawk}/bin/awk "BEGIN { print $current - $2 }")
      set_zoom "$new"
      ;;
    *) exit 1 ;;
  esac
''
