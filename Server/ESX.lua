if GetResourceState('es_extended') == 'started' then 
    
local ESX = exports['es_extended']:getSharedObject()

local avatar, banner, meca, police, ems, job, grade, jobdata, totalplayers
local money, bank, black = 0,0,0
local data = {}
RegisterNetEvent('Roda_InfoPanel:ReceiveCommand')
AddEventHandler('Roda_InfoPanel:ReceiveCommand', function ()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    jobdata = xPlayer.getJob()
    job = jobdata.label
    grade = jobdata.grade_label
    money = xPlayer.getAccount('money').money
    bank = xPlayer.getAccount('bank').money
    black = xPlayer.getAccount('black_money').money
    avatar = GetAvatar(src)
    banner = getBanner(src)
    totalplayers = GetNumPlayerIndices()
    meca = #ESX.GetExtendedPlayers('job', 'mechanic') 
    ems = #ESX.GetExtendedPlayers('job', 'ambulance') 
    police = #ESX.GetExtendedPlayers('job', 'police')

    data = {avatar = avatar, banner = banner, meca = meca, ems = ems, police = police, money = money, bank = bank, black = black, job = job, grade = grade, totalplayers = totalplayers}
    TriggerClientEvent('Roda_InfoPanel:SendDataNui', src, data)
end)


end