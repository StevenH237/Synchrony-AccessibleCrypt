local Timer = require "system.utils.Timer"

local module = {}

local CaptionList = {}
local CaptionPositions = {}
local UnusedPositions = {}
local FutureCaptions = {}

function module.add(data)
  local now = Timer.getGlobalTime()

  table.insert(CaptionList, data)
  table.sort(CaptionList, function(left, right) return left.timeAppear < right.timeAppear end)
end
