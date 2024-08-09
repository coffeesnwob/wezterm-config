-- for pulling wezterm api
local wezterm = require 'wezterm'

-- holding my configuration
local config = wezterm.config_builder()

-- font
config.font = wezterm.font_with_fallback({
    { family = 'Hack Nerd Font' },
    { family = 'Hack Nerd Font Mono' },
    { family = 'DejaVu Sans Mono' },
})

-- appearance
config = {
    color_scheme = 'Neon',
    window_background_opacity = 0.9,
    window_decorations = 'RESIZE',
    window_close_confirmation = 'AlwaysPrompt',
    scrollback_lines = 3000,
    default_workspace = 'home',
}

-- inactive pane
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5,
}

return config
