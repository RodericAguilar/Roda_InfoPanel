if GetResourceState('qb-core') == 'started' then 

    local QBCore = exports['qb-core']:GetCoreObject()
        
    local avatar, banner, job, grade, jobdata, totalplayers
    local money, bank, black = 0, 0, 0
    local data = {}
    RegisterNetEvent('Roda_InfoPanel:ReceiveCommand')
    AddEventHandler('Roda_InfoPanel:ReceiveCommand', function ()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        jobdata = Player.PlayerData.job
        job = jobdata.label
        grade = jobdata.grade.name
        money = Player.Functions.GetMoney('cash')
        bank = Player.Functions.GetMoney('bank')
        black = 0 -- Idk if qbcore has black money
        avatar = GetAvatar(src)
        banner = getBanner(src)
        totalplayers = GetNumPlayerIndices()
        local meca, police, ems =  0, 0, 0
        for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
            if v.PlayerData.job.name == "police"  then
                police = police + 1
            end
    
            if v.PlayerData.job.name == "ambulance" then
                ems = ems + 1
            end

            if v.PlayerData.job.name == "mechanic"  then
                meca = meca + 1
            end
        end
    
        data = {avatar = avatar, banner = banner, meca = meca, ems = ems, police = police, money = money, bank = bank, black = black, job = job, grade = grade, totalplayers = totalplayers}
        TriggerClientEvent('Roda_InfoPanel:SendDataNui', src, data)
    end)
    
end