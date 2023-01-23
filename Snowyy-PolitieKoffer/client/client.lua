ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
        Citizen.Wait(0)

		TriggerEvent(Config.ESXSharedObject, function(obj) ESX = obj end)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	ESX.PlayerData.job = job
end)

local Menu = {}
local showText = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for i=1, #Config.Jobs, 1 do
            if ESX.PlayerData.job.name == Config.Jobs[i] then
                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 4.0, 0, 127)

                if vehicle then
                    if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
                        local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                        local trunk = GetEntityBoneIndexByName(vehicle, "boot")
                        local coords = GetWorldPositionOfEntityBone(vehicle, trunk)

                        for i=1, #Config.Autos, 1 do
                            if vehicleName:lower() == Config.Autos[i] then
                                DrawText3D(coords, Config.Locales["TextOverTrunk"]) 

                                ESX.ShowHelpNotification(Config.Locales["HelpNotification"])

                                if IsControlJustReleased(0, 38) then
                                    OpenCloakroomMenu(vehicle)

                                    showText = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

function OpenCloakroomMenu(vehicle, menu)
    ESX.UI.Menu.CloseAll()

    local elements = {}

    Menu.Elements = {
        { label = Config.Locales["BlackMask"], value = "BlackMask" },
        { label = Config.Locales["Bulletproof"], value = "Bulletproof" },
        { label = Config.Locales["BulletproofHelmet"], value = "BulletproofHelmet" }
    }

    for i=1, #Menu.Elements, 1 do
        table.insert(elements, {
            label = Menu.Elements[i].label,
            value = Menu.Elements[i].value
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Snowyy-PolitieKoffer", {
        title = Config.Locales["Title"],
        align = "top-right",
        elements = elements
    }, function(data, menu)
        local value = data.current.value

        if value == "BlackMask" then
            BlackMask()
        elseif value == "Bulletproof" then
            Bulletproof()
        elseif value == "BulletproofHelmet" then
            BulletproofHelmet()
        end
    end, function(data, menu) 
        menu.close()

        SetVehicleDoorShut(vehicle, 5)

        showText = true
    end)

    SetVehicleDoorOpen(vehicle, 5)
end

function BlackMask()
    TriggerEvent("skinchanger:getSkin", function(skin)
        if skin.mask_1 == Config.Kleren.BlackMask["mask_1"] then
            TriggerEvent("skinchanger:loadClothes", skin, { ["mask_1"] = -1 }) 
        else
            TriggerEvent("skinchanger:loadClothes", skin, Config.Kleren.BlackMask) 
        end
    end)
end

function Bulletproof()
    TriggerEvent("skinchanger:getSkin", function(skin)
        if skin.bproof_1 == Config.Kleren.Bulletproof["bproof_1"] then
            SetPedArmour(GetPlayerPed(-1), 0)
            TriggerEvent("skinchanger:loadClothes", skin, { ["bproof_1"] = -1 }) 
        else
            SetPedArmour(GetPlayerPed(-1), 100)
            TriggerEvent("skinchanger:loadClothes", skin, Config.Kleren.Bulletproof) 
        end
    end)
end

function BulletproofHelmet()
    TriggerEvent("skinchanger:getSkin", function(skin)
        if skin.helmet_1 == Config.Kleren.BulletproofHelmet["helmet_1"] then
            TriggerEvent("skinchanger:loadClothes", skin, { ["helmet_1"] = -1 }) 
        else
            TriggerEvent("skinchanger:loadClothes", skin, Config.Kleren.BulletproofHelmet) 
        end
    end)
end

function DrawText3D(coords, text)
    if showText == false then
        return
    end

    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    
    AddTextComponentString(text)    
end