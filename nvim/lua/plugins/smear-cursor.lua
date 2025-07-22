return {
  'sphamba/smear-cursor.nvim',
  opts = {
    smear_between_buffers = true,

    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    min_horizontal_distance_smear = 0,
    min_vertical_distance_smear = 0,

    smear_horizontally = true,
    smear_vertically = true,
    smear_diagonally = true,

    smear_to_cmd = true,

    scroll_buffer_space = true,

    legacy_computing_symbols_support = false,
    legacy_computing_symbols_support_vertical_bars = false,

    vertical_bar_cursor = false,

    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
    vertical_bar_cursor_insert_mode = true,

    smear_replace_mode = true,

    smear_terminal_mode = true,

    -- Set to `true` if your cursor is a horizontal bar in replace mode.
    horizontal_bar_cursor_replace_mode = true,

    -- Set to `true` to prevent the smear from overlapping the target character, hiding it until the animation is over.
    never_draw_over_target = false,

    -- Do not set to `true` if `never_draw_over_target` is `false`.
    hide_target_hack = false,

    -- Number of windows that stay open for rendering.
    max_kept_windows = 50,

    -- Adjust to have the smear appear above or below other floating windows
    windows_zindex = 300,

    -- List of filetypes where the plugin is disabled.
    filetypes_disabled = {},

    time_interval = 17, -- milliseconds

    -- Disable smear in the current buffer if the animation is stuck for at least this amount of time.
    -- Set to nil to disable this feature.
    delay_disable = nil, -- milliseconds

    delay_event_to_smear = 1, -- milliseconds

    -- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
    delay_after_key = 5, -- milliseconds

    -- How fast the smear's head moves towards the target.
    -- 0: no movement, 1: instantaneous
    stiffness = 0.6,

    -- How fast the smear's tail moves towards the target.
    -- 0: no movement, 1: instantaneous
    trailing_stiffness = 0.4,

    -- Initial velocity factor in the direction opposite to the target
    anticipation = 0.2,

    -- Velocity reduction over time. O: no reduction, 1: full reduction
    damping = 0.65,

    -- Controls if middle points are closer to the head or the tail.
    -- < 1: closer to the tail, > 1: closer to the head
    trailing_exponent = 2,

    -- Stop animating when the smear's tail is within this distance (in characters) from the target.
    distance_stop_animating = 0.1,

    -- Set of parameters for insert mode
    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.5,
    damping_insert_mode = 0.7,
    trailing_exponent_insert_mode = 1,
    distance_stop_animating_vertical_bar = 0.05, -- Can be decreased (e.g. to 0.1) if using legacy computing symbols

    -- When to switch between rasterization methods
    max_slope_horizontal = 0.5,
    min_slope_vertical = 2,

    color_levels = 16, -- Minimum 1, don't set manually if using cterm_cursor_colors
    gamma = 2.2, -- For color blending
    max_shade_no_matrix = 0.75, -- 0: more overhangs, 1: more matrices
    matrix_pixel_threshold = 0.7, -- 0: all pixels, 1: no pixel
    matrix_pixel_threshold_vertical_bar = 0.3, -- 0: all pixels, 1: no pixel
    matrix_pixel_min_factor = 0.5, -- 0: all pixels, 1: no pixel
    volume_reduction_exponent = 0.3, -- 0: no reduction, 1: full reduction
    minimum_volume_factor = 0.7, -- 0: no limit, 1: no reduction
    max_length = 25, -- Maximum smear length
    max_length_insert_mode = 1,

    logging_level = vim.log.levels.INFO,
    -- Set trailing_stiffness to 0 for debugging
  },
}
