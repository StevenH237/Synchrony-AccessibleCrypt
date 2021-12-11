local Event        = require "necro.event.Event"

Event.tileSchemaBuild.add("accessify", {order="modify"}, function(ev)
  -- Change stairs tiles to elevators
  ev.LobbyLockedStairs.texture = "mods/AccessibleCrypt/gfx/stairs_locked.png"
  ev.LockedStairs.texture = "mods/AccessibleCrypt/gfx/stairs_locked_miniboss.png"
  ev.Stairs.texture = "mods/AccessibleCrypt/gfx/stairs.png"
  ev.StairsDiamond3.texture = "mods/AccessibleCrypt/gfx/stairs_locked_diamond3.png"
  ev.StairsDiamond9.texture = "mods/AccessibleCrypt/gfx/stairs_locked_diamond9.png"
end)