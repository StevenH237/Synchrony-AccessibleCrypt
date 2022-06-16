local Settings = require "necro.config.Settings"

Slowdown = Settings.group{
  name = "Slowdown",
  id = "slowdown",
  order = 0
}

SlowdownSpeed = Settings.shared.percent {
  name = "Game speed",
  id = "slowdown.speed",
  order = 0,
  default = 1,
  step = 0.05,
  minimum = 0.5,
  maximum = 1,
  editAsString = true
}

SlowdownMaximum = Settings.shared.bool {
  name = "Use maximum BPM",
  id = "slowdown.maximum",
  order = 1,
  default = false
}

SlowdownBpm = Settings.shared.number {
  name = "Maximum BPM",
  id = "slowdown.bpm",
  order = 2,
  default = 175,
  step = 5,
  minimum = 60,
  maximum = 300,
  editAsString = true
}

return setmetatable({}, {
  __index = function(table, ind) return _G[ind] end
})