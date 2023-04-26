local showPlayerBlips = false
local ignorePlayerNameDistance = true
local playerNamesDist = 50
local displayIDHeight = 1.5 
local red = 255
local green = 255
local blue = 255
local group
local ShowIDs = true
local perse = false

RegisterNetEvent('idt')
AddEventHandler('idt', function()
	perse = not perse
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function ()
    while true do
		if perse then
			for id = 1, 255 do
				if NetworkIsPlayerActive( id ) then

						ped = GetPlayerPed( id )
		 
						x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
						x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
						distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))


						if ((distance < playerNamesDist)) then
								red = 255
								green = 255
								blue = 255
								Draw3DText(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id) .. " - " .. GetPlayerName(id))
						end
				end
			end
		else
			Citizen.Wait(500)
		end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('Hulabaloo12')
AddEventHandler('Hulabaloo12', function()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local handle, ped = FindFirstPed()
	local playerPos = GetEntityCoords(ped, true)
		repeat
		success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
				if DoesEntityExist(ped)then
					local pedType = GetPedType(ped)
						if distance <= 2 and IsPedDeadOrDying(ped) and IsPedInAnyVehicle(ped) == false and IsPedAPlayer(ped) == false then
							TaskStartScenarioInPlace(player, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -10, true)
							Wait(10000)
							NetworkRequestControlOfEntity(ped)
							while not NetworkHasControlOfEntity(ped) do
								Citizen.Wait(1)
							end
							ResurrectPed(ped)
							Wait(10)
							ClearPedTasksImmediately(ped)
							Wait(10)
							SetPedAsNoLongerNeeded(ped)
							Wait(500)
							ClearPedTasks(player)
						end
				end 
		until not success
		EndFindPed(handle)
end)