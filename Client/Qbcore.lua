if GetResourceState('qb-core') == 'started' then 
  
local QBCore = exports['qb-core']:GetCoreObject()
  
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