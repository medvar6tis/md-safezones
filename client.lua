local function inSafeZone()
    DisablePlayerFiring(PlayerId(), true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
end

local function outSafeZone()
    DisablePlayerFiring(PlayerId(), false)
    DisableControlAction(0, 24, false)
    DisableControlAction(0, 25, false)
    DisableControlAction(0, 140, false)
    DisableControlAction(0, 141, false)
    DisableControlAction(0, 142, false)
end

CreateThread(function()
    for _, zone in ipairs(Config.safezones) do
        lib.zones.sphere({
            coords = zone.center,
            radius = zone.radius,
            debug = Config.debug,
            inside = inSafeZone,
            onEnter = inSafeZone,
            onExit = outSafeZone
        })
        
        local blip = AddBlipForRadius(zone.center.x, zone.center.y, zone.center.z, zone.radius)
        SetBlipColour(blip, zone.blipColor or 2)
        SetBlipAlpha(blip, zone.blipAlpha or 120)
    end
end)