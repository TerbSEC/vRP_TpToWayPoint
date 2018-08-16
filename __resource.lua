--#####################################################--
--               SCRIPT MADE BY TERBIUM                --
--#####################################################--


description "vRP TpToWaypoint"

dependency "vrp"

client_script "client.lua"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
