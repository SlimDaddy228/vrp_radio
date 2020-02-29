local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local cfg = module("vrp_radio", "config")

local function ch_delete(player, choice)
  for k,v in pairs(cfg.name) do
    local name = v
  vRPclient.removeAudioSource(-1,name)
  end
end

local function ch_rapclassic(player,choice)
	local name = "rap="
	local url = "http://air2.radiorecord.ru:9003/rapclassics_320" -- url radio
	local x,y,z = vRPclient.getPosition(player)
  vRPclient.setAudioSource(-1,name, url, 0.3, x, y, z, 85)
end

local function ch_80x(player,choice)
	local name = "80x="
	local url = "http://air2.radiorecord.ru:9003/1980_320" -- url radio
	local x,y,z = vRPclient.getPosition(player)
  vRPclient.setAudioSource(-1,name, url, 0.3, x, y, z, 85)
end


local function ch_deep(player,choice)
	local name = "deep="
	local url = "http://air2.radiorecord.ru:9003/deep_320"  -- url radio
	local x,y,z = vRPclient.getPosition(player)
  vRPclient.setAudioSource(-1,name, url, 0.3, x, y, z, 85)
end

local function ch_electric(player,choice) 
	local name = "deep="
	local url = "http://air2.radiorecord.ru:9003/elect_320"  -- url radio
	local x,y,z = vRPclient.getPosition(player)
  vRPclient.setAudioSource(-1,name, url, 0.3, x, y, z, 85)
end

local menu_pc = {name="Радио",css={top="75px",header_color="#9167dd"}}

menu_pc["Deep"] = {ch_deep}
menu_pc["Rap classic"] = {ch_rapclassic}
menu_pc["80х"] = {ch_80x}
menu_pc["Electric"] = {ch_electric}
menu_pc["Delete"] = {ch_delete}


local function pc_enter(source,area)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.openMenu(source,menu_pc)
  end
end

local function pc_leave(source,area)
  vRP.closeMenu(source)
end

local function build_client_points(source)
  -- PC
  for k,v in pairs(cfg.marker) do
    local x,y,z = table.unpack(v)
    vRPclient._addMarker(source,x,y,z-1,0.7,0.7,0.5,0,125,255,125,150)
    vRP.setArea(source,"vRP:police:pc"..k,x,y,z,1,1.5,pc_enter,pc_leave)
  end
end

-- build police points
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_points(source)
  end
end)

