{ config, ... }:
let
  small = config.gman.smallscreen.enable;
  fontsize = if small then "14" else "24";
in
''
  conky.config = {
    alignment = "top_left",
    background = false,
    border_width = 1,
    cpu_avg_samples = 2,
    default_color = "purple",
    default_outline_color = "white",
    default_shade_color = "white",
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = true,
    draw_outline = false,
    draw_shades = false,
    extra_newline = false,
    font = "Pixel Code:size=${fontsize}",
    gap_x = 60,
    gap_y = 60,
    minimum_height = 5,
    minimum_width = 5,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_ncurses = false,
    out_to_stderr = false,
    out_to_wayland = true,
    out_to_x = false,
    own_window = true,
    own_window_class = "Conky",
    own_window_type = "normal",
    own_window_hints = "undecorated,sticky,below,skip_taskbar,skip_pager",
    show_graph_range = false,
    show_graph_scale = false,
    stippled_borders = 0,
    update_interval = 1.0,
    uppercase = false,
    use_spacer = "none",
    use_xft = true,
  }

  conky.text = [[
  ''${color purple}System
  $hr
  ''${color grey}$sysname - $kernel $nodename $machine
  ''${color grey}Uptime: $uptime
  ''${color grey}Frequency (in GHz):$color $freq_g
  ''${color grey}RAM Usage:$color $mem/$memmax - $memperc% ''${membar 4}
  ''${color grey}Swap Usage:$color $swap/$swapmax - $swapperc% ''${swapbar 4}
  ''${color grey}CPU Usage:$color $cpu% ''${cpubar 4}
  ''${color grey}Processes:$color $processes  ''${color grey}Running:$color $running_processes

  ''${color purple}File systems
  $hr
   / $color''${fs_used /}/''${fs_size /} ''${fs_bar 6 /}

  ''${color}Networking
  $hr
  Up:$color ''${upspeed} ''${color grey} - Down:$color ''${downspeed}

  ''${color purple}4 horsemen of Bloat   PID    CPU%   MEM%
  ''${color lightgrey} ''${top name 1} ''${top pid 1} ''${top cpu 1} ''${top mem 1}
  ''${color lightgrey} ''${top name 2} ''${top pid 2} ''${top cpu 2} ''${top mem 2}
  ''${color lightgrey} ''${top name 3} ''${top pid 3} ''${top cpu 3} ''${top mem 3}
  ''${color lightgrey} ''${top name 4} ''${top pid 4} ''${top cpu 4} ''${top mem 4}
  ]]
''
