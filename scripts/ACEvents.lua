local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local Music        = require "necro.audio.Music"
local TimeScale    = require "necro.audio.TimeScale"

local ACSettings = require "AccessibleCrypt.ACSettings"

Event.levelLoad.add("slowdown", {order="music", sequence=2}, function(ev)
  -- Ignore in lobby levels
  if CurrentLevel.isLobby() then return end

  -- Get current song BPM
  local beatmap = Music.getBeatmap()
  local tpb = beatmap[2] - beatmap[1]
  local bpm = 60 / tpb

  -- Fixed percentage slowdown
  local scale = ACSettings.SlowdownSpeed

  -- Max BPM slowdown
  if ACSettings.SlowdownMaximum and (scale * bpm) > ACSettings.SlowdownBpm then
    scale = scale * ACSettings.SlowdownBpm / bpm
  end

  -- Add the slowdown
  TimeScale.addInfiniteRegion(0, scale, 0)
end)

