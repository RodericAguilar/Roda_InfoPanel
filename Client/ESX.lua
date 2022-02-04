if GetResourceState('es_extended') == 'started' then 
    
local ESX = exports['es_extended']:getSharedObject()
local player, pname, pid

RegisterNetEvent('Roda_InfoPanel:SendDataNui')
AddEventHandler('Roda_InfoPanel:SendDataNui', function (data)
        player = PlayerId()
        pname = GetPlayerName(player)
        pid = GetPlayerServerId(player)
        SendNUIMessage({
            action = 'showData',
            pid = pid,
            pname = pname, 
            dato = data,
            maxp = Config.MaxPlayers
        })
end)



end