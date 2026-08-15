-- Give application windows a translucent, frosted-glass appearance.
-- Fullscreen windows stay opaque for video playback and presentations.

hl.config({
  decoration = {
    rounding = 12,
    active_opacity = 0.80,
    inactive_opacity = 0.72,
    fullscreen_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 18,
      render_power = 3,
      color = "rgba(00000066)",
    },

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      new_optimizations = true,
      ignore_opacity = false,
      xray = false,
      noise = 0.02,
      contrast = 1.05,
      brightness = 0.95,
      vibrancy = 0.15,
      vibrancy_darkness = 0.1,
    },
  },
})
