ESX = exports['es_extended']:getSharedObject()

local data = {
    zones = {}
}

local function updatePlayerCount(zoneName, playerId, increment)
    for _, zone in ipairs(data.zones) do
        if zone.name == zoneName then
            if increment > 0 then
                table.insert(zone.players, playerId)
            else
                for i, id in ipairs(zone.players) do
                    if id == playerId then
                        table.remove(zone.players, i)
                        break
                    end
                end
            end

            if #zone.players > 9 then
                TriggerClientEvent('one-codes:HeatMap:CL:ZoneFull', -1, zoneName, zone.coords)
            elseif #zone.players < 7 then
                TriggerClientEvent('one-codes:HeatMap:CL:ZoneNotHot', -1, zoneName)
            end

            return true
        end
    end
    return false
end

local function insertOrUpdateZone(zoneName, playerId, coords)
    local zoneExists = false

    for _, zone in ipairs(data.zones) do
        if zone.name == zoneName then
            for _, id in ipairs(zone.players) do
                if id == playerId then
                    return
                end
            end
            table.insert(zone.players, playerId)
            zoneExists = true
            break
        end
    end

    if not zoneExists then
        table.insert(data.zones, { name = zoneName, players = { playerId }, coords = coords })
    end

    for _, zone in ipairs(data.zones) do
        if #zone.players > 7 then
            TriggerClientEvent('one-codes:HeatMap:CL:ZoneFull', -1, zone.name, zone.coords)
        elseif #zone.players < 5 then
            TriggerClientEvent('one-codes:HeatMap:CL:ZoneNotHot', -1, zone.name)
        end
    end
end

RegisterServerEvent('one-codes:HeatMap:SV:EnterZone')
AddEventHandler('one-codes:HeatMap:SV:EnterZone', function(zoneid, playerid, coords)
    insertOrUpdateZone(zoneid, playerid, coords)
    -- print("------")
    -- for _, zone in ipairs(data.zones) do
    --     print(zone.name, #zone.players)
    -- end
    -- print(json.encode(data.zones))
    --TriggerClientEvent('one-codes:HeatMap:CL:GotInfo', -1, zoneid)
end)

RegisterServerEvent('one-codes:HeatMap:SV:LeaveZone')
AddEventHandler('one-codes:HeatMap:SV:LeaveZone', function(zoneid, playerid, coords)
    updatePlayerCount(zoneid, playerid, -1)
    -- for _, zone in ipairs(data.zones) do
    --     print(zone.name, #zone.players)
    -- end    
    -- print(json.encode(data.zones))
    --TriggerClientEvent('one-codes:HeatMap:CL:GotInfo', -1, zoneid)
end)

RegisterNetEvent('esx:playerDropped')
AddEventHandler('esx:playerDropped', function(playerId, reason)
    for _, zone in ipairs(data.zones) do
        updatePlayerCount(zone.name, playerId, -1)
    end
end)
