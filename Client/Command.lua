RegisterCommand(Config.OptionCommand['command'], function ()
    TriggerServerEvent('Roda_InfoPanel:ReceiveCommand')
end)

RegisterCommand(Config.OptionCommand['movecommand'], function ()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'move'
    })
end)

if Config.OptionCommand['usekey'] == true then 
    RegisterKeyMapping(Config.OptionCommand['command'], 'Open Info Panel', 'keyboard', Config.OptionCommand['key'])
end

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'stopmove'
    })
end)