RegisterNetEvent('receiveBlips')
AddEventHandler('receiveBlips', function(blips)
    for _, coords in ipairs(blips) do
        local blip = AddBlipForCoord(coords.x, coords.y, 0.0)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 4)
    end
end)


RegisterCommand('showblips', function()
    TriggerServerEvent('sendBlipsToClients')
end)


RegisterNetEvent('showBlipCreatedNotification')
AddEventHandler('showBlipCreatedNotification', function()
    SetNotificationTextEntry('STRING')
    AddTextComponentString("Blip wurde erfolgreich erstellt")
    DrawNotification(false, false)

    TriggerServerEvent('sendBlipCreatedNotification')
end)


RegisterCommand('createblip', function(source, args, rawCommand)
    if #args < 2 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Fehler", "Verwendung: /createblip [X-Koordinate] [Y-Koordinate]"}
        })
        return
    end

    local x = tonumber(args[1])
    local y = tonumber(args[2])

    if x and y then
        local blip = AddBlipForCoord(x, y, 0.0)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 4)

        TriggerServerEvent('showBlipCreatedNotification')
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Fehler", "Ungültige Koordinaten"}
        })
    end
end)
