local FormattedToken = "Bot " ..Server.TokenBot

--Get response from discord--

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


--This get the user avatar--
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
                elseif data.avatar == nil then
                    DiscordImg = Config.DefaultDiscordAvatar
				end
			else 
				print("An error ocurred, check your Config.")
			end
	end
    return DiscordImg;
end

--Get user Banner--

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
				if data ~= nil and data.banner ~= nil then 
					if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
						bannerImg = "https://cdn.discordapp.com/banners/" .. discordId .. "/" .. data.banner .. ".gif?size=1024";
					else 
						bannerImg = "https://cdn.discordapp.com/banners/" .. discordId .. "/" .. data.banner .. ".png?size=1024"
					end
                elseif data.banner == nil then 
                    bannerImg = Config.DefaultBanner
				end
			else 
				print("An error ocurred.")
			end
	else 
		print("The player don't have discord.")
	end
    return bannerImg;
end
