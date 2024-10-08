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

-- terminal appearance
config = {
    color_scheme = 'Neon',
    window_background_opacity = 0,
    window_decorations = 'RESIZE',
    window_close_confirmation = 'NeverPrompt',
    scrollback_lines = 3000,
    default_workspace = 'home',
    default_cursor_style = 'BlinkingBlock',
    win32_system_backdrop = 'Mica', -- for windows 11 and 10

    -- Tab bar
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
}

wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = "#f7768e"
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = "#7dcfff"
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = "#bb9af7"
    end

    local basename = function(s)
        -- Nothing a little regex can't fix
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end

    -- Current working directory
    local cwd = pane:get_current_working_dir()
    if cwd then
        if type(cwd) == "userdata" then
            -- Wezterm introduced the URL object in 20240127-113634-bbcac864
            cwd = basename(cwd.file_path)
        else
            -- 20230712-072601-f4abf8fd or earlier version
            cwd = basename(cwd)
        end
    else
        cwd = ""
    end

    -- Current command
    local cmd = pane:get_foreground_process_name()
    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
    cmd = cmd and basename(cmd) or ""

    -- Time
    local time = wezterm.strftime("%H:%M")

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Foreground = { Color = stat_color } },
        { Text = "  " },
        { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
        { Text = " |" },
    }))

    -- Right status
    window:set_right_status(wezterm.format({
        -- Wezterm has a built-in nerd fonts
        -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html

        { Text = wezterm.nerdfonts.fa_linux .. "  " .. cwd },
        -- { Text = " | " },
        -- { Foreground = { Color = "#e0af68" } },
        -- { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
        -- "ResetAttributes",
        -- { Text = " | " },
        -- { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
        -- { Text = "  " },
    }))
end)

-- inactive pane
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5,
}

return config
