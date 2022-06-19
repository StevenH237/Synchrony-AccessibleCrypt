local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local Music        = require "necro.audio.Music"
local TimeScale    = require "necro.audio.TimeScale"

local ACSettings = require "AccessibleCrypt.Settings"

Event.levelLoad.add("slowdown", { order = "music", sequence = 2 }, function(ev)
  -- Ignore in lobby levels
  if CurrentLevel.isLobby() then return end

  -- Get current song BPM
  local beatmap = Music.getBeatmap()

  local deltas = {}
  local lastTimes = { 0, 0, 0 }
  for i, v in ipairs(beatmap) do
    deltas[#deltas + 1] = v - lastTimes[1]
    table.remove(lastTimes, 1)
    table.insert(lastTimes, v)
  end

  table.sort(deltas)
  local tpb = deltas[math.ceil(#deltas / 2)]
  local bpm = (#lastTimes * 60) / tpb

  -- Fixed percentage slowdown
  local scale = ACSettings.SlowdownSpeed

  -- Max BPM slowdown
  if ACSettings.SlowdownMaximum and (scale * bpm) > ACSettings.SlowdownBpm then
    scale = scale * ACSettings.SlowdownBpm / bpm
  end

  -- Add the slowdown
  TimeScale.addInfiniteRegion(0, scale, 0)
end)
