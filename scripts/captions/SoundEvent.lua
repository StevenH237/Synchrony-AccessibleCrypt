local Camera       = require "necro.render.Camera"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local GFX          = require "system.gfx.GFX"
local Render       = require "necro.render.Render"

local CaptionBank    = require "AccessibleCrypt.captions.CaptionBank"
local CaptionStorage = require "AccessibleCrypt.captions.CaptionStorage"

local sounds = {}

Event.soundPlay.add("soundGroup", { order = "play", sequence = -1 }, function(ev)
  if ev.ui then return end

  local captionGroup = ev.group
  local caption = CaptionBank[captionGroup]

  if type(caption) == "table" then
    captionGroup = caption.group or captionGroup
    caption = caption[1]
  end

  if type(caption) == "function" then
    caption = caption()
  end

  if type(caption) == "string" then
    local output = caption
    local pos = not not (ev.x and ev.y)
    local direction = 0

    if pos then
      local x, y = Camera.transformPoint(Render.tileCenter(ev.x, ev.y))

      local xPct = x / GFX.getWidth()

      if xPct < 1 / 3 then direction = -1
      elseif xPct > 2 / 3 then direction = 1
      end
    end

    local captionData = {
      text = caption,
      soundType = captionGroup,
      timeAppear = ev.time,
      timeFadeStart = ev.time + 5,
      timeFadeEnd = ev.time + 7,
      direction = direction
    }

    CaptionStorage.add(captionData)
  end
end)
