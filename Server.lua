local token = "PUT_YOUR_TOKEN"  ---PUT YOUR TOKEN
local FormattedToken = "Bot " ..token

local ESX = exports['es_extended']:getSharedObject()

local function GetDiscordName(user)
    local discordId = nil
    local DiscordName = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then
        local endpoint = ("users/%s"):format(discordId)
        local member = GetInfoFromDiscord("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then
                DiscordName = data.username .. "#" .. data.discriminator;
            end
        else
        	print("An error ocurred.")
        end
    end
    return DiscordName
end

local function GetAvatar(user)
    local discordId = nil
    local DiscordImg = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
	end
	if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = GetInfoFromDiscord("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil and data.avatar ~= nil then 
                if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
                    DiscordImg = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif?";
                else 
                    DiscordImg = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png?"
                end
            end
        else 
            print("An error ocurred.")
        end
	else 
		print("The player don't have discord.")
	end
    return DiscordImg;
end

local function getBanner(user)
    local discordId = nil
    local bannerImg = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
	end
	if discordId then
        local endpoint = ("users/%s"):format(discordId)
        local member = GetInfoFromDiscord("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil and data.avatar ~= nil then 
                if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
                    bannerImg = "https://cdn.discordapp.com/banners/" .. discordId .. "/" .. data.banner .. ".gif?size=1024";
                else
                    bannerImg = "https://cdn.discordapp.com/banners/" .. discordId .. "/" .. data.banner .. ".png?size=1024"
                end
            end
        else
            print("An error ocurred.")
        end
	else
		print("The player don't have discord.")
	end
    return bannerImg
end

local function GetInfoFromDiscord(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

RegisterCommand(Config.CommandPanel, function(source)
    local playerId <const> = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local data = {
            jobs = {
                police = #ESX.GetExtendedPlayers('job', 'police') or 0,
                ems = #ESX.GetExtendedPlayers('job', 'ambulance') or 0,
                mechanic = #ESX.GetExtendedPlayers('job', 'mechanic') or 0
            },
            accounts = {
                money = xPlayer.getAccount(Config.MoneyAccount).money or 0,
                bank = xPlayer.getAccount(Config.BankAccount).money or 0,
                black = xPlayer.getAccount(Config.BlackAccount).money or 0
            },
            playerData = {
                banner = getBanner(src) or Config.DefaultBanner,
                avatar = Config.DefaultAvatar,
                job = xPlayer.getJob(),
                players = GetNumPlayerIndices() or 0,
                maxPlayers = GetCon
            }
        }

        TriggerClientEvent('Roda_InfoPanel', playerId, data)
    end
end)

RegisterNetEvent('Roda_InfoPanel:FromServer')
AddEventHandler('Roda_InfoPanel:FromServer', function()
    local accountsmoney = {}
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local banner = getBanner(src)
    local ava = GetAvatar(src)
    local job = xPlayer.getJob()

    local connectdPlayers = GetNumPlayerIndices()

    accountsmoney = {money = money,bank = bank,black = black}
    if banner and ava then 
        TriggerClientEvent('Roda_InfoPanel', src, banner, ava, accountsmoney, job, connectdPlayers)
    elseif banner and not ava then 
        TriggerClientEvent('Roda_InfoPanel', src, banner, Config.DefaultAvatar, accountsmoney, job, connectdPlayers)
    elseif ava and not banner then 
        TriggerClientEvent('Roda_InfoPanel', src, Config.DefaultBanner, ava, accountsmoney, job, connectdPlayers)
    elseif not banner and not ava then 
        TriggerClientEvent('Roda_InfoPanel', src, Config.DefaultBanner, Config.DefaultAvatar, accountsmoney, job, connectdPlayers)
    end
end)