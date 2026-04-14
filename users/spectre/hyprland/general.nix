{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";

    general = {
      gaps_in  = 4;
      gaps_out = 5;
      gaps_workspaces = 50;
      border_size = 1;
      "col.active_border"   = "rgba(0DB7D455)";
      "col.inactive_border" = "rgba(31313600)";
      resize_on_border    = true;
      no_focus_fallback   = true;
      allow_tearing       = true;
      snap = {
        enabled      = true;
        window_gap   = 4;
        monitor_gap  = 5;
        respect_gaps = true;
      };
    };

    decoration = {
      rounding_power = 2;
      rounding       = 18;
      active_opacity = 0.95;
      inactive_opacity = 0.93;
      dim_inactive   = true;
      dim_strength   = 0.05;
      dim_special    = 0.2;

      blur = {
        enabled          = true;
        xray             = true;
        special          = false;
        new_optimizations = true;
        size             = 10;
        passes           = 3;
        brightness       = 1;
        noise            = 0.05;
        contrast         = 0.89;
        vibrancy         = 0.5;
        vibrancy_darkness = 0.5;
        popups           = false;
        popups_ignorealpha = 0.6;
        input_methods      = true;
        input_methods_ignorealpha = 0.8;
      };

      shadow = {
        enabled        = true;
        ignore_window  = true;
        range          = 50;
        offset         = "0 4";
        render_power   = 10;
        color          = "rgba(00000027)";
      };
    };

    input = {
      kb_layout           = "us";
      numlock_by_default  = true;
      repeat_delay        = 250;
      repeat_rate         = 35;
      follow_mouse        = 1;
      off_window_axis_events = 2;

      touchpad = {
        natural_scroll        = true;
        disable_while_typing  = false;
        clickfinger_behavior  = true;
        scroll_factor         = 0.7;
      };
    };

    misc = {
      disable_hyprland_logo      = true;
      disable_splash_rendering   = true;
      vfr                        = 1;
      vrr                        = 1;
      mouse_move_enables_dpms    = true;
      key_press_enables_dpms     = true;
      animate_manual_resizes     = false;
      animate_mouse_windowdragging = false;
      enable_swallow             = false;
      swallow_regex              = "(foot|kitty|allacritty|Alacritty)";
      focus_on_activate          = true;
      force_default_wallpaper    = 0;
      allow_session_lock_restore = true;
      session_lock_xray          = true;
      initial_workspace_tracking = false;
    };

    cursor = {
      zoom_factor      = 1;
      zoom_rigid       = false;
      zoom_disable_aa  = true;
      hotspot_padding  = 1;
    };

    gesture = [
      "3, swipe, move,"
      "3, pinch, float"
      "4, horizontal, workspace"
      "4, vertical, dispatcher, exec, ambxst run dashboard"
    ];

    gestures = {
      workspace_swipe_distance           = 700;
      workspace_swipe_cancel_ratio       = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock     = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new         = true;
    };
  };
}
