ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('Roda_InfoPanel')
AddEventHandler('Roda_InfoPanel', function(banner, img, accounts, job, players)
    local player = PlayerId()
    local name = GetPlayerName(player)
    ESX.TriggerServerCallback('Roda_InfoPanel:GetJobCount', function(ems, police, mech)
        SendNUIMessage({
            trans = true;
            img = banner;
            pp = img;
            ems = ' '..ems;
            police = police;
            mech = mech;
            name = 'ID: <span style = "color:red;">'.. GetPlayerServerId(player)..' </span> '..name;
            money = accounts;
            job = job;
            players = players..'/'..Config.MaxSvPlayers;
        })
       
    end)
end)


RegisterCommand(Config.CommandPanel, function (source)
        TriggerServerEvent('Roda_InfoPanel:FromServer')
end)

if Config.UseKey then 
    RegisterKeyMapping(Config.CommandPanel, 'Show Info from Roda_InfoPanel', 'keyboard', Config.OpenPanel)
end