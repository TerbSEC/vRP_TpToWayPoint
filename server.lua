--#####################################################--
--               SCRIPT MADE BY TERBIUM                --
--#####################################################--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_TpToWaypoint")

local groups = {"superadmin", "admin"};

RegisterServerEvent('vRP-TpToWaypoint:AdminCheck')
AddEventHandler('vRP-TpToWaypoint:AdminCheck', function()
    local source = source    
    local user_id = vRP.getUserId({source})

    local found = false;
    for k,v in ipairs(groups) do
        if vRP.hasGroup({user_id,v}) then
            TriggerClientEvent("vRP-TpToWayPoint:Success", source)
            found = true;
            break;
        end
    end    
    if found == false then
        CancelEvent()
    end
end)
