ESX = exports['es_extended']:getSharedObject()

function onEnter(self)
    -- print('entered zone', self.id)
    -- print('entered zone', self.__type)
    TriggerServerEvent("one-codes:HeatMap:SV:EnterZone", self.__type..""..self.id, GetPlayerServerId(PlayerId()), self.coords)
end

-- function inside(self)
--     print('entered zone', self.id)
--     print('entered zone', self.__type)
-- end

function onExit(self)
    -- print('exited zone', self.id)
    -- print('exited zone', self.__type)
    TriggerServerEvent("one-codes:HeatMap:SV:LeaveZone", self.__type..""..self.id, GetPlayerServerId(PlayerId()), self.coords)
end

local box = lib.zones.sphere({
    coords = vec3(11.3663, -1736.7295, 29.3029),
    radius = 52,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(163.4269, -1299.4639, 29.3217),
    radius = 100,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(38.4111, -407.8099, 45.2336),
    radius = 80,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(53.6140, 160.6600, 105.7782),
    radius = 100,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(-810.5789, 182.0556, 74.7523),
    radius = 100,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(-730.0594, -732.5278, 33.9921),
    radius = 100,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local box = lib.zones.sphere({
    coords = vec3(-457.5182, -941.6425, 24.5772),
    radius = 100,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})

local hotZoneBlips = {}

RegisterNetEvent('one-codes:HeatMap:CL:ZoneFull')
AddEventHandler('one-codes:HeatMap:CL:ZoneFull', function(zoneName, coords)
    print(coords)
    if hotZoneBlips[zoneName] then
        RemoveBlip(hotZoneBlips[zoneName])
    end

    hotZoneBlips[zoneName] = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(hotZoneBlips[zoneName], 442)
    SetBlipDisplay(hotZoneBlips[zoneName], 4)
    SetBlipScale(hotZoneBlips[zoneName], 1.0)
    SetBlipColour(hotZoneBlips[zoneName], 17)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Hot Zone")
    EndTextCommandSetBlipName(hotZoneBlips[zoneName])
end)

RegisterNetEvent('one-codes:HeatMap:CL:ZoneNotHot')
AddEventHandler('one-codes:HeatMap:CL:ZoneNotHot', function(zoneName)
    if hotZoneBlips[zoneName] then
        RemoveBlip(hotZoneBlips[zoneName])
        hotZoneBlips[zoneName] = nil
    end
end)

