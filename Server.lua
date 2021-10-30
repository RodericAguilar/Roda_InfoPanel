local token = "PUT_YOUR_TOKEN"  ---PUT YOUR TOKEN
local FormattedToken = "Bot " ..token


function GetDiscordName(user) 
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
    return DiscordName;
end

function GetAvatar(user) 
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



RegisterNetEvent('Roda_InfoPanel:FromServer')
AddEventHandler('Roda_InfoPanel:FromServer', function()
    local accountsmoney = {}
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local banner = getBanner(src)
    local ava = GetAvatar(src)
    local job = xPlayer.getJob()
    local money = xPlayer.getAccount(Config.MoneyAccount).money
    local bank = xPlayer.getAccount(Config.BankAccount).money
    local black = xPlayer.getAccount(Config.BlackAccount).money

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



function getBanner(user) 
    local discordId = nil
    local bannerImg = nil;
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
    return bannerImg;
end




function GetInfoFromDiscord(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Roda_InfoPanel:GetJobCount', function(source, cb)

    local _police = exports['playertables']:getPlayers("police") 
    local _ems = exports['playertables']:getPlayers("ambulance") 
    local _mechanic = exports['playertables']:getPlayers("mechanic")
    EMSConnected = 0
	PoliceConnected = 0
	MechanicConnected = 0

    for k, v in pairs(_police) do -- Iterate table of players with job
        PoliceConnected = PoliceConnected + 1
    end

    for k, v in pairs(_mechanic) do -- Iterate table of players with job
        MechanicConnected = MechanicConnected + 1
    end

    for k, v in pairs(_ems) do -- Iterate table of players with job
        EMSConnected = EMSConnected + 1
    end

  cb(EMSConnected, PoliceConnected, MechanicConnected)
  
end)