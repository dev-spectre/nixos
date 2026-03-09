{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    $mainMod = SUPER
    
    bind = $mainMod, Q, killactive

    binde = $mainMod, Semicolon, splitratio, -0.1
    binde = $mainMod, Apostrophe, splitratio, +0.1
    bind = $mainMod+Alt, Space, togglefloating,
    bind = $mainMod+Shift, D, fullscreen, 1
    bind = $mainMod+Shift, F, fullscreen, 0
    bind = $mainMod+Alt, F, fullscreenstate, 0 3
    bind = $mainMod, P, pin

    # Workspace Actions
    bind = $mainMod+ALT, code:10, exec, workspace_action movetoworkspacesilent 1
    bind = $mainMod+ALT, code:11, exec, workspace_action movetoworkspacesilent 2
    bind = $mainMod+ALT, code:12, exec, workspace_action movetoworkspacesilent 3
    bind = $mainMod+ALT, code:13, exec, workspace_action movetoworkspacesilent 4
    bind = $mainMod+ALT, code:14, exec, workspace_action movetoworkspacesilent 5
    bind = $mainMod+ALT, code:15, exec, workspace_action movetoworkspacesilent 6
    bind = $mainMod+ALT, code:16, exec, workspace_action movetoworkspacesilent 7
    bind = $mainMod+ALT, code:17, exec, workspace_action movetoworkspacesilent 8
    bind = $mainMod+ALT, code:18, exec, workspace_action movetoworkspacesilent 9
    bind = $mainMod+ALT, code:19, exec, workspace_action movetoworkspacesilent 10

    bind = $mainMod+Alt, code:87, exec, workspace_action movetoworkspacesilent 1
    bind = $mainMod+Alt, code:88, exec, workspace_action movetoworkspacesilent 2
    bind = $mainMod+Alt, code:89, exec, workspace_action movetoworkspacesilent 3
    bind = $mainMod+Alt, code:83, exec, workspace_action movetoworkspacesilent 4
    bind = $mainMod+Alt, code:84, exec, workspace_action movetoworkspacesilent 5
    bind = $mainMod+Alt, code:85, exec, workspace_action movetoworkspacesilent 6
    bind = $mainMod+Alt, code:79, exec, workspace_action movetoworkspacesilent 7
    bind = $mainMod+Alt, code:80, exec, workspace_action movetoworkspacesilent 8
    bind = $mainMod+Alt, code:81, exec, workspace_action movetoworkspacesilent 9
    bind = $mainMod+Alt, code:90, exec, workspace_action movetoworkspacesilent 10

    bind = $mainMod+Shift, mouse_down, movetoworkspace, r-1
    bind = $mainMod+Shift, mouse_up, movetoworkspace, r+1
    bind = $mainMod+Alt, mouse_down, movetoworkspace, -1
    bind = $mainMod+Alt, mouse_up, movetoworkspace, +1

    bind = $mainMod+Alt, Page_Down, movetoworkspace, +1
    bind = $mainMod+Alt, Page_Up, movetoworkspace, -1
    bind = $mainMod+Shift, Page_Down, movetoworkspace, r+1
    bind = $mainMod+Shift, Page_Up, movetoworkspace, r-1
    bind = Ctrl+$mainMod+Shift, Right, movetoworkspace, r+1
    bind = Ctrl+$mainMod+Shift, Left, movetoworkspace, r-1

    bind = $mainMod+Alt, S, movetoworkspacesilent, special
    bind = Ctrl+$mainMod, S, togglespecialworkspace,

    # Switching Workspaces
    bindp = $mainMod, code:87, exec, workspace_action workspace 1
    bindp = $mainMod, code:88, exec, workspace_action workspace 2
    bindp = $mainMod, code:89, exec, workspace_action workspace 3
    bindp = $mainMod, code:83, exec, workspace_action workspace 4
    bindp = $mainMod, code:84, exec, workspace_action workspace 5
    bindp = $mainMod, code:85, exec, workspace_action workspace 6
    bindp = $mainMod, code:79, exec, workspace_action workspace 7
    bindp = $mainMod, code:80, exec, workspace_action workspace 8
    bindp = $mainMod, code:81, exec, workspace_action workspace 9
    bindp = $mainMod, code:90, exec, workspace_action workspace 10

    bind = Ctrl+$mainMod, Right, workspace, r+1
    bind = Ctrl+$mainMod, Left, workspace, r-1
    bind = Ctrl+$mainMod+Alt, Right, workspace, m+1
    bind = Ctrl+$mainMod+Alt, Left, workspace, m-1
    bind = $mainMod, Page_Down, workspace, +1
    bind = $mainMod, Page_Up, workspace, -1
    bind = Ctrl+$mainMod, Page_Down, workspace, r+1
    bind = Ctrl+$mainMod, Page_Up, workspace, r-1
    bind = $mainMod, mouse_up, workspace, +1
    bind = $mainMod, mouse_down, workspace, -1
    bind = Ctrl+$mainMod, mouse_up, workspace, r+1
    bind = Ctrl+$mainMod, mouse_down, workspace, r-1

    bind = $mainMod, mouse:275, togglespecialworkspace,
    bind = Ctrl+$mainMod, BracketLeft, workspace, -1
    bind = Ctrl+$mainMod, BracketRight, workspace, +1
    bind = Ctrl+$mainMod, Up, workspace, r-5
    bind = Ctrl+$mainMod, Down, workspace, r+5

    # Session
    bindld = $mainMod+Shift, L, Suspend system, exec, systemctl suspend || loginctl suspend
    bindd = Ctrl+Shift+Alt+$mainMod, Delete, Shutdown, exec, systemctl poweroff || loginctl poweroff

    # Zoom
    binde = $mainMod, Minus, exec, zoom_cursor decrease 0.3
    binde = $mainMod, Equal, exec, zoom_cursor increase 0.3

    # Media
    bindl = $mainMod+Shift, N, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
    bindl = ,XF86AudioNext, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
    bindl = ,XF86AudioPrev, exec, playerctl previous
    bind = $mainMod+Shift+Alt, mouse:275, exec, playerctl previous
    bind = $mainMod+Shift+Alt, mouse:276, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
    bindl = $mainMod+Shift, B, exec, playerctl previous
    bindl = $mainMod+Shift, P, exec, playerctl play-pause

    # Apps
    bind = $mainMod, Return, exec, launch_first_available "''${TERMINAL}" "kitty -1" "foot" "alacritty" "wezterm" "konsole" "kgx" "uxterm" "xterm"
    bind = $mainMod, T, exec, launch_first_available "''${TERMINAL}" "kitty -1" "foot" "alacritty" "wezterm" "konsole" "kgx" "uxterm" "xterm"
    bind = Ctrl+Alt, T, exec, launch_first_available "''${TERMINAL}" "kitty -1" "foot" "alacritty" "wezterm" "konsole" "kgx" "uxterm" "xterm"
    bind = $mainMod, E, exec, launch_first_available "dolphin" "nautilus" "nemo" "thunar" "''${TERMINAL}" "kitty -1 fish -c yazi"
    bind = $mainMod, W, exec, launch_first_available "vivaldi" "brave" "google-chrome-stable" "zen-browser" "firefox" "chromium" "microsoft-edge-stable" "opera" "librewolf"
    bind = $mainMod, C, exec, launch_first_available "code" "codium" "zed" "zedit" "zeditor" "kate" "gnome-text-editor" "emacs" "command -v nvim && kitty -1 nvim" "command -v micro && kitty -1 micro"
    bind = $mainMod+Shift, C, exec, launch_first_available "antigravity" "cursor" "zed" "zedit" "zeditor" "kate" "gnome-text-editor" "emacs" "command -v nvim && kitty -1 nvim" "command -v micro && kitty -1 micro"
    bind = Ctrl+$mainMod+Shift+Alt, W, exec, launch_first_available "wps" "onlyoffice-desktopeditors" "libreoffice"
    bind = $mainMod, X, exec, launch_first_available "kate" "gnome-text-editor" "emacs"
    bind = Ctrl+$mainMod, V, exec, launch_first_available "pavucontrol-qt" "pavucontrol"
    bind = $mainMod, I, exec, XDG_CURRENT_DESKTOP=gnome launch_first_available "qs -p ~/.config/quickshell/$qsConfig/settings.qml" "systemsettings" "gnome-control-center" "better-control"
    bind = Ctrl+Shift, Escape, exec, launch_first_available "gnome-system-monitor" "plasma-systemmonitor --page-name Processes" "command -v btop && kitty -1 fish -c btop"
    bind = Ctrl+$mainMod, Backslash, resizeactive, exact 640 480
  '';
}
