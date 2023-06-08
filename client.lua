local forcehide = false
local playerloaded = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if playerloaded == true then
            if forcehide == false then
                if IsPauseMenuActive() then
                    SendNUIMessage({action = "hideHUD"})     
                else
                    SendNUIMessage({action = "showHUD"})
                end
            end
        end
    end
end)

RegisterCommand("hideHUD", function()
    forcehide = true
    SendNUIMessage({action = "hideHUD"})
end,false)

RegisterCommand("showHUD", function()
    forcehide = false
    SendNUIMessage({action = "showHUD"})
end,false)

RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index, availableVoiceRanges)
    SendNUIMessage({action = "setVoice", voice = tonumber(index) + 1})
end)


RegisterNetEvent("rb_hud:updateRanzcoins")
AddEventHandler("rb_hud:updateRanzcoins",function(amount)
    SendNUIMessage({action = "setBank", bankmoney = amount})
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerEvent("reward:toggle", false)
    playerloaded = true
    SendNUIMessage({action = "showHUD"})
	ESX.TriggerServerCallback('rb_hud:getrc', function(rcoins)
		SendNUIMessage({action = "setBank", bankmoney = rcoins})
        SendNUIMessage({action = "setID", id = GetPlayerServerId(PlayerId())})
	end)
    local data = xPlayer
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(500)
				for k,v in pairs(ESX.GetPlayerData().accounts) do
					if v.name == 'money' and v.money ~= nil then
						SendNUIMessage({action = "Setmoney", money = v.money})
					end
				end
			end
		end)
	end
end)

--[[
Citizen.CreateThread(function()
    TriggerEvent("reward:toggle", false)
    SendNUIMessage({action = "showHUD"})
	ESX.TriggerServerCallback('rb_hud:getrc', function(rcoins)
		SendNUIMessage({action = "setBank", bankmoney = rcoins})
        SendNUIMessage({action = "setID", id = GetPlayerServerId(PlayerId())})
	end)
    local data = ESX.GetPlayerData()
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(500)
				for k,v in pairs(ESX.GetPlayerData().accounts) do
					if v.name == 'money' and v.money ~= nil then
						SendNUIMessage({action = "Setmoney", money = v.money})
					end
				end
			end
		end)
	end
end)]]

CreateThread(function()
	while true do
		Wait(2000)
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped) - 100
		local armour = GetPedArmour(ped)

		SendNUIMessage({action = 'setHealth', health = health})
        SendNUIMessage({action = 'setShield', shield = armour})
	end
end)

Citizen.CreateThread(function()
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            per = 100 / 1000000 * status.val
            SendNUIMessage({action = 'setFood', hunger = per})
        end)
    
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            per = 100 / 1000000 * status.val
            SendNUIMessage({action = 'setWater', water = per})
        end)
        Citizen.Wait(2000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local hours = GetClockHours()
        if hours > 19 then
            SendNUIMessage({action = 'setTheme', theme = "white", shadow = "rgb(247, 54, 54"})
        else
            SendNUIMessage({action = 'setTheme', theme = "white", shadow = "rgb(104,0,0)"})
        end
        Citizen.Wait(10000)
    end 
end)


local shouldshow = nil
AddEventHandler("SaltyChat_VoiceRangeChanged", function(voiceRange, index, availableVoiceRanges)
    shouldshow = voiceRange
    Citizen.Wait(300)
    shouldshow = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if shouldshow ~= nil then
            local pedCoords = GetEntityCoords(PlayerPedId())
            DrawMarker(1, pedCoords.x, pedCoords.y, pedCoords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, shouldshow * 2.0, shouldshow * 2.0, 1.0, 104, 0, 0, 150, false, false, 2, false, nil, nil, false)
        end
    end
end)