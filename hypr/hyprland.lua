-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.autostart")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.input")
require("hypr.monitors")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
-- require("hypr.overrides")
hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true})
hl.workspace_rule({ workspace = "2", monitor = "DP-3"})
hl.workspace_rule({ workspace = "3", monitor = "DP-1"})
hl.workspace_rule({ workspace = "0", monitor = "HDMI-A-1"})
