QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('evlilikyuzugu', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if item.info.teklifeden == nil then
        TriggerClientEvent('tq-married:client:FirstStep', source)
        TriggerClientEvent('tq-married:client:Anim', source, true, false)
    else
        if xPlayer.PlayerData.citizenid == item.info.teklifeden then
            tPlayer = QBCore.Functions.GetPlayerByCitizenId(item.info.teklifalan)
            if tPlayer ~= nil then
                coords = GetEntityCoords(GetPlayerPed(tPlayer.PlayerData.source))
                TriggerClientEvent("tq-married:client:SecondStep", source, {x = coords.x, y = coords.y})
            else
                -- eşin oyunda değil
                TriggerClientEvent("QBCore:Notify", source, "Eşin şehirde değil!", "error")
            end
        elseif xPlayer.PlayerData.citizenid == item.info.teklifalan then
            tPlayer = QBCore.Functions.GetPlayerByCitizenId(item.info.teklifeden)
            if tPlayer ~= nil then
                coords = GetEntityCoords(GetPlayerPed(tPlayer.PlayerData.source))
                TriggerClientEvent("tq-married:client:SecondStep", source, {x = coords.x, y = coords.y})
            else
                -- eşin oyunda değil
                TriggerClientEvent("QBCore:Notify", source, "Eşin şehirde değil!", "error")
            end
        else
            -- yüzük sana ait değil aq çocu
            TriggerClientEvent("QBCore:Notify", source, "Yüzük sana ait değil.", "error")
        end
    end
    -- exports.xng_parsingtable:ParsingTable_sv(item)
end)

RegisterServerEvent("tq-married:server:FirstStep")
AddEventHandler("tq-married:server:FirstStep",function(ply, ben)
    TriggerClientEvent("tq-married:client:openMenu", ply, ben)
end)

RegisterServerEvent("tq-married:server:Particle")
AddEventHandler("tq-married:server:Particle",function(cid)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    local src = source
    TriggerClientEvent("tq-married:client:Particle", -1, GetEntityCoords(GetPlayerPed(src)))
    TriggerClientEvent("tq-married:client:Particle", -1, GetEntityCoords(GetPlayerPed(xPlayer.PlayerData.source)))
    TriggerClientEvent('tq-married:client:Anim', xPlayer.PlayerData.source, false, false)
end)

RegisterServerEvent("tq-married:server:Anim")
AddEventHandler("tq-married:server:Anim",function(cid)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    local src = source
    TriggerClientEvent('tq-married:client:Anim', xPlayer.PlayerData.source, false, false)
    TriggerClientEvent('tq-married:client:Anim', src, false, true)

end)

RegisterServerEvent("tq-married:server:SecondStep")
AddEventHandler("tq-married:server:SecondStep", function(cid)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local zPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    local aile2 = xPlayer.PlayerData.charinfo.firstname .. " " ..xPlayer.PlayerData.charinfo.lastname .. " & " .. zPlayer.PlayerData.charinfo.firstname .. " " .. zPlayer.PlayerData.charinfo.lastname
    local info = {
        teklifeden = cid,
        teklifalan = xPlayer.PlayerData.citizenid,
        aile = aile2,
        tarih = os.date("!%d-%m-%Y"),
    }
    
    if zPlayer.Functions.RemoveItem("evlilikyuzugu", 1) then
        xPlayer.Functions.AddItem("evlilikyuzugu", 1, false, info)
        zPlayer.Functions.AddItem("evlilikyuzugu", 1, false, info)
    end
end)