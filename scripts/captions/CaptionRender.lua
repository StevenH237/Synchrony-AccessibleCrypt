local Event           = require "necro.event.Event"
local GFX             = require "system.gfx.GFX"
local UI              = require "necro.render.UI"
local SettingsStorage = require "necro.config.SettingsStorage"
local Settings        = require "necro.config.Settings"

Event.renderUI.add("renderCaptions", "subtitles", function(ev)
  local font = UI.Font.SMALL -- config option

  local topRow = 7
  local rightCol = 2

  local uiScale = SettingsStorage.get("video.hud.scaleFactor", Settings.Layer.USER)

  local maxWidth = 70 -- maybe a config option?
  local fontSize = font.size -- height of the font
  local gapX = 5 -- maybe a config option?
  local gapY = 2 -- maybe a config option?

  local scaledSpacingX = (maxWidth + gapX) * uiScale
  local originX = (GFX.getWidth() - (scaledSpacingX) * rightCol) / 2

  local scaledSpacingY = (fontSize + gapY) * uiScale
  local originY = (GFX.getHeight() - (gapY + fontSize) * uiScale)

  -- config option
  local outline = true
  local outlineColor = 0
  local shadowColor = 0

  if outline then
    outlineColor = 0xFF000000
  else
    shadowColor = 0xFF000000
  end

  for col = 0, rightCol do
    for row = 0, topRow do
      UI.drawText {
        font             = UI.Font.SMALL,
        text             = "Caption slot " .. (col * 5 + row),
        size             = fontSize * uiScale,
        alignX           = 0.5,
        alignY           = 1,
        x                = originX + scaledSpacingX * col,
        y                = originY - scaledSpacingY * row,
        maxWidth         = maxWidth * uiScale,
        opacity          = 1,
        outlineThickness = 1,
        outlineColor     = outlineColor,
        shadowColor      = shadowColor
      }
    end
  end
end)
