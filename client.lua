RegisterNetEvent('vRP-TpToWayPoint:Success')
AddEventHandler('vRP-TpToWayPoint:Success', function()
	local targetPed = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(targetPed))then
		targetPed = GetVehiclePedIsUsing(targetPed)
	end

	if(not IsWaypointActive())then
		TriggerEvent("pNotify:SendNotification",{text = "You have not set any waypoint",type = "error",timeout = (1500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer=true})
		return
	end

	local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 



	-- Ensure Entity teleports above the ground
	local ground
	local groundFound = false
	local groundCheckHeights = {0.0, 50.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}


	for i,height in ipairs(groundCheckHeights) do
		RequestCollisionAtCoord(x, y, height)
		Wait(0)
		SetEntityCoordsNoOffset(targetPed, x,y,height, 0, 0, 1)
		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if(ground) then
			z = z + 3
			groundFound = true
			break;
		end
	end

	if(not groundFound)then
		z = 1000
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- Parachute
	end

	SetEntityCoordsNoOffset(targetPed, x,y,z, 0, 0, 1)

	TriggerEvent("pNotify:SendNotification",{text = "You have been teleported to the Waypoint",type = "error",timeout = (1500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer=true})
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        	if IsControlJustPressed(0, 170) then
        		TriggerServerEvent("vRP-TpToWaypoint:AdminCheck")
           end
	    end
	end)