local Timer     = require "system.utils.Timer"
local Utilities = require "system.utils.Utilities"

local module = {}

local CaptionList = {}
local CaptionPositions = {}
local UnusedPositions = {}
local FutureCaptions = {}

function module.add(data)
  local now = Timer.getGlobalTime()

  if now < data.timeAppear then
    module.addFuture(data)
  else
    module.addLive(data)
  end
end

function module.addFuture(data)
  -- Add to the future captions list
  table.insert(FutureCaptions, data)

  -- Sort by decreasing imminence (so the next sound to play should be FutureCaptions[1])
  table.sort(FutureCaptions, function(left, right) return left.timeAppear > right.timeAppear end)
end

function module.addCurrent(data)
  -- Get the group
  local group = data.group

  -- Remove any matching captions of that group (if any)
  Utilities.removeIf(CaptionList, function(itm) return itm.group == group end)

  -- Get the position of this new caption
  local pos = CaptionPositions[group]

  -- Is that position available?

  -- (this isn't on that comment)
  table.insert(CaptionList, 1, data)
end
