-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- ============================================================
-- Personal Hyprland / Omarchy keybinding overrides
-- ============================================================

local scriptsDir = os.getenv("HOME") .. "/.dotfiles/scripts"


-- ============================================================
-- Window Management
-- ============================================================

-- Reserve SUPER + HJKL for Vim-style window navigation
--
-- Omarchy defaults removed:
--   SUPER + J            Toggle window split
--   SUPER + K            Show key bindings
--   SUPER + L            Toggle workspace layout
--   SUPER SHIFT + HJKL   Window manipulation defaults

hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")

-- Focus windows
o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Move windows
o.bind("SUPER + SHIFT + H", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + SHIFT + J", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))
o.bind("SUPER + SHIFT + K", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + SHIFT + L", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))


-- ============================================================
-- Resize Windows
-- ============================================================

-- Replace Omarchy's -/= resize bindings with
-- easier-to-reach Dactyl-friendly comma/period bindings.

hl.unbind("SUPER + code:20")
hl.unbind("SUPER + code:21")
hl.unbind("SUPER + SHIFT + code:20")
hl.unbind("SUPER + SHIFT + code:21")
hl.unbind("SUPER + COMMA")
hl.unbind("SUPER + PERIOD")
hl.unbind("SUPER + SHIFT + COMMA")
hl.unbind("SUPER + SHIFT + PERIOD")

o.bind("SUPER + COMMA", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + PERIOD", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind("SUPER + SHIFT + COMMA", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
o.bind("SUPER + SHIFT + PERIOD", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))


-- ============================================================
-- Application Shortcuts
-- ============================================================

-- Jira + Zendesk search scripts
hl.unbind("SUPER + SHIFT + J")
o.bind("SUPER + SHIFT + J", "Jira search", scriptsDir .. "/JiraSearch.sh")
hl.unbind("SUPER + SHIFT + Z")
o.bind("SUPER + SHIFT + Z", "Zendesk search", scriptsDir .. "/ZendeskSearch.sh")

-- Browser
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + B", "Browser (private)", { omarchy = "browser --private" })


-- File manager / window state

hl.unbind("SUPER + T")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + ALT + SHIFT + F")

o.bind("SUPER + SHIFT + F", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + T", "File manager", { omarchy = "nautilus" })


-- ============================================================
-- Screenshots
-- ============================================================

hl.unbind("PRINT")
hl.unbind("SUPER + CTRL + PRINT")
hl.unbind("SUPER + SHIFT + S")

o.bind("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")
o.bind("SUPER + SHIFT + CTRL + S", "Extract text (OCR) from screenshot", "omarchy-capture-text")


-- ============================================================
-- System Actions
-- ============================================================

-- Re-bind kill to SUPER + Q
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())


-- Re-bind lock to CTRL + ALT + L
hl.unbind("SUPER + CTRL + L")
o.bind("CTRL + ALT + L", "Lock system", "omarchy-system-lock")


-- ============================================================
-- Menus
-- ============================================================

-- Reclaim SUPER + / from monitor scaling
hl.unbind("SUPER + SLASH")
hl.unbind("SUPER + ALT + SLASH")
hl.unbind("SUPER + SHIFT + SLASH")
hl.unbind("SUPER + ALT + K")  -- 'SUPER + K' unbound by tiling movement
o.bind("SUPER + SLASH", "Show key bindings", "omarchy-menu-keybindings")
o.bind("SUPER + SHIFT + SLASH", "Show key bindings", "omarchy-menu-tmux-keybindings")


-- Re-bind wallpaper/theme background menu to SUPER + W
hl.unbind("SUPER + CTRL + SPACE")
o.bind("SUPER + W", "Theme background menu", "omarchy-menu toggle background")


-- Re-bind Omarchy menu to SUPER + ESCAPE
hl.unbind("SUPER + ALT + SPACE")
hl.unbind("SUPER + ESCAPE")
o.bind("SUPER + ESCAPE", "Apps menu", "omarchy-menu toggle apps")


-- Re-bind Omarchy emoji menu to SUPER + PERIOD
hl.unbind("SUPER + CTRL + E")
o.bind("SUPER + SHIFT + PERIOD", "Emojis", "omarchy-shell shell toggle omarchy.emojis")

