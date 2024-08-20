
-- Developed by Xoop Team
-- Mohammad @story_fe

local Xoop ="#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e]"

for m, v in pairs(_G) do
  if not m then
    triggerServerEvent("XoopAC:Kick", localPlayer)
  end
end

addDebugHook("preFunction", function(sourceResource)
  if sourceResource == getThisResource()  then return end
  return "skip"
end,{"addDebugHook"})

addEventHandler("onClientResourceStop", resourceRoot, function(arg)
    if string.lower(getResourceName(arg)) == string.lower(getThisResource().name) then
      triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFStop Resource [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
      if STOP_RESOURCE_BAN_KICK then
        triggerServerEvent("XoopAC:Ban", localPlayer)
      else
        triggerServerEvent("XoopAC:Kick", localPlayer)
      end
    end
end)

-- Save Injected Code
function SaveCode(code)
  if SAVE_INJECTED_CODE then 
    triggerServerEvent("XoopAC-SaveCode",localPlayer, code, getXoopPassword())
  end
end

-- Gun Hack
if Check_Gun_Hack then 
  setTimer(function()
    local Ary = {}
    for i=1,12 do
      Ary[i] = getPedWeapon(localPlayer,i)
    end 
    triggerServerEvent("XoopAC-onPlayerGunCheck",localPlayer,Ary,getXoopPassword())
  end,7000,0)
end

function clientCheatScan()
  if isWorldSpecialPropertyEnabled("aircars") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffAIRCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("hovercars") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffHOVERCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("extrabunny") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffEXTRA BUNNY  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("extrajump") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffEXTRA JUMP  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  if getGameSpeed() > 1 then 
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffGAMESPEED CHEAT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  if ( doesPedHaveJetPack (localPlayer) and DISABLE_JETPACK == true ) then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffJETPACK CHEAT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if getLocalPlayer().vehicle then
    if (Vector3(getElementVelocity(getLocalPlayer().vehicle)) * 180).length > 500 then
      triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffCAR SPEED MORE THEN 500 [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    end
  else
    if getPedMoveState(localPlayer) ~= "fall" and (Vector3(getElementVelocity(localPlayer)) * 50).length > 20 then
      triggerServerEvent("XoopAc:outputForAll", localPlayer, Xoop.." #ffffffSPEED CHEAT [ " ..getPlayerName(localPlayer).. " ]", getXoopPassword())
      triggerServerEvent("XoopAC:Ban", localPlayer)
    end
  end
end
setTimer(clientCheatScan, 1000, 0)

function clientCheat()
  local worldSpecialProperties = {
  ["hovercars"] = false,
  ["aircars"] = false,
  ["extrabunny"] = false,
  ["extrajump"] = false,
  ["randomfoliage"] = true,
  ["snipermoon"] = false,
  ["extraairresistance"] = true,
  ["underworldwarp"] = true,
  ["vehiclesunglare"] = false,
  ["coronaztest"] = true,
  ["watercreatures"] = true,
  ["burnflippedcars"] = true,
  ["fireballdestruct"] = true,
  }
  setGameSpeed(1)
  if (DISABLE_JETPACK) then
    triggerServerEvent("XoopAC:TakeJetPack", localPlayer)
  end
  for propertyName, propertyState in pairs(worldSpecialProperties) do
    setWorldSpecialPropertyEnabled(propertyName, propertyState)
  end
end

function CheckLuaFile(FileName)
  if type(FileName:find(".lua")) == "nil" and FileName ~= "[string \"...\"]" and FileName ~= "[string \"?\"]" then
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFLua Execute [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
    return true
  end
  return false
end

DebugHook = addDebugHook("preFunction", function(_,_, _, arg, _, ...)
  if CheckLuaFile(arg) then
    return "skip"
  end
end,{"addDebugHook","removeDebugHook","triggerServerEvent"})

if not DebugHook then
  triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFDebugHook Skip [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  triggerServerEvent("XoopAC:Kick", localPlayer)
end

local blockedFunctions = {
  'outputChatBox',
  'getAllElementData',
  'function',
  'triggerEvent',
  'triggerClientEvent',
  'triggerServerEvent',
  'setElementData',
  'addEvent',
  'addEventHandler',
  'addDebugHook',
  'createExplosion',
  'createProjectile',
  'setElementPosition',
  'createVehicle',
  'setElementHealth',
  'setPedArmor',
}

addDebugHook( "preFunction", function( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  if CheckLuaFile(luaFilename) then return end
  SaveCode( ({...})[1] ) 
  triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFLua Execute [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  triggerServerEvent("XoopAC:WbHk", localPlayer, getXoopPassword())
  if (CODE_INJECTOR_BAN ~= false) then
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." banned.", getXoopPassword())
    triggerServerEvent("XoopAC:Ban", localPlayer)
  end
  return "skip"
end, {"loadstring", "pcall", "load"} )

local SPEED_LAST_X ,SPEED_LAST_Y ,SPEED_LAST_Z = 0 , 0, 0
local lastTime , check = 0, 0;
setTimer(function() check = 0 end, 800, 0)
function detectAirBrake()
  if (not isPedOnGround(localPlayer) and not getPedContactElement(localPlayer)) and (getPedMoveState(localPlayer) == 'fall') then return end
  if (Vector3(getElementPosition(getLocalPlayer())).z < 2000) then
    if not (getTickCount() - lastTime == 0) then
      local fSpeedRatio = getDistanceBetweenPoints3D(SPEED_LAST_X,SPEED_LAST_Y,SPEED_LAST_Z,Vector3(getElementPosition(getLocalPlayer())).x,Vector3(getElementPosition(getLocalPlayer())).y,Vector3(getElementPosition(getLocalPlayer())).z);
      if fSpeedRatio < 0 then
        fSpeedRatio = - fSpeedRatio;
      end
      if (fSpeedRatio > 1.35 and fSpeedRatio < 8) then
        check = check + 1
        if check >= 15 or (check >= 10 and getElementCollisionsEnabled(localPlayer) == false) then       
          triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffNOCLIP [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
          check = 0
        end 
      end
      SPEED_LAST_X, SPEED_LAST_Y, SPEED_LAST_Z = fPx , fPy , fPz
      lastTime = getTickCount();
    end
  end
end
addEventHandler("onClientPreRender", root, detectAirBrake)

function projectileCreation( creator )
  if getElementType(creator) == "player" then
	  local projectileType = getProjectileType( source )
		local x, y, z = getElementPosition ( source )
    setElementPosition(source, x,y,z-5000)
    destroyElement(source)    
    
    triggerServerEvent("XoopAc:outputForAll", creator, Xoop.." #ffffff"..getPlayerName(creator).." created a Projectile", getXoopPassword())
  end
end
addEventHandler( "onClientProjectileCreation", root, projectileCreation )

addEventHandler("onClientGUIChanged", root, function(element) 
  local text = guiGetText(element)
  local injecting = false
  for _, v in ipairs(blockedFunctions) do
    if (string.find(text,v)) then 
      injecting = true
    end
  end
  if (injecting == true ) then

  triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFLUA INJECT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  
  triggerServerEvent("XoopAC:WbHk", localPlayer, getXoopPassword())

  
  if (CODE_INJECTOR_BAN ~= false) then
    triggerServerEvent("XoopAC:Ban", localPlayer)
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." banned.", getXoopPassword())
  end  
  cancelEvent()
end
end)

function cancel( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  return "skip"
end
addDebugHook( "preFunction", cancel,{"setPedOnFire","createProjectile","blowVehicle"})

function getBonePosition( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  if DISABLE_GET_BONEPOSITION == false then return end
  return "skip"
end
addDebugHook( "preFunction", getBonePosition,{"getPedBonePosition"})

addEventHandler ( "onClientVehicleExplode", getRootElement(), cancelEvent )

-- Godmode
local PlayerHealth = getElementHealth(localPlayer)
addEventHandler("onClientPlayerDamage", localPlayer, function (attacker, weapon, bodypart)
  setTimer(function()
    local NewPlayerHealth = getElementHealth(localPlayer)
    if (NewPlayerHealth == PlayerHealth) and NewPlayerHealth > 0 then 
      triggerServerEvent("XoopAc:outputForAll", localPlayer, Xoop.." #FFFFFFGODMODE [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    end
    PlayerHealth = NewPlayerHealth
  end,10,1)
end)

--[[
  Anti aimbot was added from here:
  https://github.com/ruip005/mta_anticheat/blob/source/v2.3.0.03/cMain.lua
]]

Cache = {}
function AntiAimBot(attacker, weapon, bodypart, loss)
    if attacker == getLocalPlayer() then
        if bodypart == 9 then
          for _, v in ipairs(ADMIN_LEVEL_DATANAMES) do
            local adminlevel = getElementData(localPlayer, v) or 0 
            if (adminlevel > 0) or (isPedInVehicle(localPlayer) == true) then return end 
          end 
          if not Cache.Numbers then
              Cache.Numbers = 0
          end
          if Cache then
              Cache.Numbers = Cache.Numbers + 1
              setTimer(function()
                  Cache.Numbers = 0
              end, 3000, 1)
              if Cache.Numbers == 5 then
                triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." is using the aim_bot cheat.", getXoopPassword())
              end
          end
        end
    end
end
addEventHandler('onClientPedDamage', getRootElement(), AntiAimBot)
addEventHandler('onClientPlayerDamage', getRootElement(), AntiAimBot)

addEventHandler("onClientPaste", root, function(text)
  for index , blockedFunction in ipairs(blockedFunctions) do
    if text:find(blockedFunction) then
      triggerServerEvent("XoopAC:Ban", localPlayer)
      triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFPaste Lua Code [ ".. getPlayerName(localPlayer) .." ]", getXoopPassword())
    end
  end
end)
