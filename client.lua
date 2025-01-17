QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

RegisterNetEvent("tq-married:client:openMenu")
AddEventHandler("tq-married:client:openMenu", function(kisi)
    SendNUIMessage({display = true, isim = kisi.charinfo.firstname .. " " .. kisi.charinfo.lastname, kimlik = kisi.citizenid})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('accept', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({display = false})
    TriggerServerEvent("tq-married:server:SecondStep", data.forring)
    TriggerServerEvent("tq-married:server:Particle", data.forring)
    TriggerEvent('tq-married:client:changename', data.forring)
    cb("ok")
end)

RegisterNetEvent("tq-married:client:Particle")
AddEventHandler("tq-married:client:Particle", function(coords)
    local particleDictionary = "scr_xs_celebration"
    local particleName = "scr_xs_confetti_burst"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local particle = StartParticleFxLoopedAtCoord(particleName, coords.x, coords.y, coords.z-0.9, 0.0, 0.0, 0.0, 1.0, 0, 0, 0, 0)
    Citizen.Wait(5000)
    StopParticleFxLooped(particle, true)
end)

RegisterNetEvent("tq-married:client:Particle2")
AddEventHandler("tq-married:client:Particle2", function(coords)
    local particleDictionary = "scr_xs_celebration"
    local particleName = "scr_xs_confetti_burst"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local particle = StartParticleFxLoopedAtCoord(particleName, coords.x, coords.y, coords.z-0.9, 0.0, 0.0, 0.0, 1.0, 0, 0, 0, 0)
    Citizen.Wait(5000)
    StopParticleFxLooped(particle, true)
end)

RegisterNUICallback('denied', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({display = false})
    TriggerServerEvent("tq-married:server:Anim", data.forring)

    cb("ok")
end)

RegisterNetEvent("tq-married:client:FirstStep")
AddEventHandler("tq-married:client:FirstStep", function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('tq-married:server:FirstStep', GetPlayerServerId(player), QBCore.Functions.GetPlayerData())
    else
        print("adam yok")
    end
end)

RegisterNetEvent("tq-married:client:SecondStep")
AddEventHandler("tq-married:client:SecondStep", function(coords)
    QBCore.Functions.Notify("Eşin haritada işaretlendi.")
    SetNewWaypoint(coords.x, coords.y)    
end)

RegisterNetEvent("tq-married:client:Anim")
AddEventHandler("tq-married:client:Anim", function(animstart, kadin)
    if animstart then
        if kadin == false then
            QBCore.Shared.RequestAnimDict("amb@world_human_bum_wash@male@low@idle_a", function()
                TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 8.0, 8.0, 30000, 1, 1, false, false, false)		
            end)
        end
    else
        if kadin == true then
            QBCore.Shared.RequestAnimDict("anim@heists@ornate_bank@chat_manager", function()
                TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@chat_manager", "fail", 8.0, 8.0, 3000, 1, 1, false, false, false)		
            end)
        else
            ClearPedTasksImmediately(PlayerPedId())
        end
    end
end)