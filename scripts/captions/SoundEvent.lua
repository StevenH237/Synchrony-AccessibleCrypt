local Camera       = require "necro.render.Camera"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local GFX          = require "system.gfx.GFX"
local Render       = require "necro.render.Render"

local CaptionBank = require "AccessibleCrypt.captions.CaptionBank"

local sounds = {}

Event.soundPlay.add("soundGroup", { order = "play", sequence = -1 }, function(ev)
  if ev.ui then return end

  local caption = CaptionBank[ev.group]
  if type(caption) == "string" then
    local output = caption
    local pos = not not (ev.x and ev.y)
    if pos then
      local x, y = Camera.transformPoint(Render.tileCenter(ev.x, ev.y))

      local xPct = x / GFX.getWidth()

      if xPct < 1 / 3 then output = "<= " .. output
      elseif xPct > 2 / 3 then output = output .. " =>"
      end
    end

    print(output)
  end
end)
