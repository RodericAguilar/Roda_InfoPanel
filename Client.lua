RegisterNetEvent('Roda_InfoPanel', function(data)
    if data and type(data) == "table" then
        SendNUIMessage({trans = data})
    end
end)