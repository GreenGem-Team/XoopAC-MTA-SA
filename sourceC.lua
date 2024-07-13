
-- Developed by Xoop Team
-- Special thanks to Mohammad @story_fe

local Xoop ="#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e]"

addDebugHook("preFunction", function(sourceResource,fun, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  if sourceResource == getThisResource()  then return end
  return "skip"
end,{"addDebugHook"})

-- anti stop resource
addEventHandler("onClientResourceStop", resourceRoot, function(_ARG_0_)
  if string.lower(getResourceName(_ARG_0_)) == string.lower(getThisResource().name) then
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player [ "..getPlayerName(localPlayer).." ] tried to stop anticheat", getXoopPassword())
    if RESOURCE_STOP_BAN_KICK then
      triggerServerEvent("XoopAc:AcBan", localPlayer)
    else
      triggerServerEvent("XoopAC:AcKick", localPlayer)
    end
  end
end)

-- Save executed lua codes
function SaveCode(code)
  if SAVE_INJECTED_CODE then 
    triggerServerEvent("XoopAC-SaveCode",localPlayer, code, getXoopPassword())
  end
end

-- Gun hack check
if Check_Gun_Hack then 
  setTimer(function()
    local Ary = {}
    for i=1,12 do
      Ary[i] = getPedWeapon(localPlayer,i)
    end 
    triggerServerEvent("XoopAC-onPlayerGunCheck",localPlayer,Ary,getXoopPassword())
  end,7000,0)
end

-- Check the player for some cheats
function clientCheatScan()
  if isWorldSpecialPropertyEnabled("aircars") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffAIRCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("hovercars") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffHOVERCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("extrabunny") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffEXTRA BUNNY  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
  end
  if isWorldSpecialPropertyEnabled("extrajump") then
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffEXTRA JUMP  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
  end
  if getGameSpeed() > 1 then 
    clientCheat()
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #ffffffGAMESPEED CHEAT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
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
    if getPedMoveState(localPlayer) ~= "fall" and (Vector3(getElementVelocity(localPlayer)) * 50).length > 15 then
      triggerServerEvent("XoopAc:outputForAll", localPlayer, Xoop.." #ffffffSPEED CHEAT [ " ..getPlayerName(localPlayer).. " ]", getXoopPassword())
      triggerServerEvent("XoopAc:AcBan", localPlayer)
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
  triggerServerEvent("XoopAC:TakeJetPack", localPlayer)
  for propertyName, propertyState in pairs(worldSpecialProperties) do
    setWorldSpecialPropertyEnabled(propertyName, propertyState)
  end
end

-- don't edit here
function CheckLuaFile(FileName)
  if type(FileName:find(".lua")) == "nil" and FileName ~= "[string \"...\"]" and FileName ~= "[string \"?\"]" then
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFLua Execute [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
    return true
  end
  return false
end
DebugHook = addDebugHook("preFunction", function(_ARG_0_,_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  if CheckLuaFile(_ARG_3_) then
    return "skip"
  end
end,{"addDebugHook","removeDebugHook","triggerServerEvent"})
if not DebugHook then
  triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFDebugHook Skip [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  triggerServerEvent("XoopAC:AcKick", localPlayer)
end

-- list of blocked functions
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

-- anti loadstring
addDebugHook( "preFunction", function( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  if CheckLuaFile(luaFilename) then return end
  SaveCode( ({...})[1] ) 
  triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFLua Execute [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  triggerServerEvent("XoopAC:WbHk", localPlayer, getXoopPassword())
  if (CODE_INJECTOR_BAN ~= false) then
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." banned.", getXoopPassword())
    triggerServerEvent("XoopAc:AcBan", localPlayer)
  end
  return "skip"
end, {"loadstring", "pcall", "load"} )

-- anti fly ( you can edit here and add your admins for whitelist )
SPEED_LAST_X = 0;
SPEED_LAST_Y = 0;
SPEED_LAST_Z = 0;
lastTime = 0;
local check = 0;
setTimer(function()
  check = 0
end, 800, 0)
function isElementInAir(element)
  return not isPedOnGround(element) and not getPedContactElement(element)
end
function detectAirBrake()
  if (not isElementInAir(localPlayer)) and (getPedMoveState(localPlayer) == 'fall') then return end
  for _, v in ipairs(ADMIN_LEVEL_DATANAMES) do
    local adminlevel = getElementData(localPlayer, v) or 0 
    if (adminlevel > 0) or (isPedInVehicle(localPlayer) == true) then 
      return
    end 
  end
  local fPx, fPy, fPz = getElementPosition(getLocalPlayer());
  local fVx, fVy, fVz = getElementVelocity(getLocalPlayer());
  if (fPz < 2000) then 
    local time = getTickCount() - lastTime;
    if not (time == 0) then
      local fmVz = (fPz - SPEED_LAST_Z) / time;
      local fMSpeed = getDistanceBetweenPoints3D(SPEED_LAST_X,SPEED_LAST_Y,SPEED_LAST_Z,fPx,fPy,fPz);
      local fVelocity = getDistanceBetweenPoints3D(0,0,0, fVx, fVy, fVz);
      local fSpeedRatio = fMSpeed
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
      SPEED_LAST_X = fPx;
      SPEED_LAST_Y = fPy;
      SPEED_LAST_Z = fPz;
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
    triggerServerEvent("XoopAc:AcBan", localPlayer)
    triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." banned.", getXoopPassword())
  end  
  cancelEvent()
end
end)

-- skip some functions
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

-- anti godmode
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
  Anti aimbot added from here:
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
                triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player: "..getPlayerName(localPlayer).." is using a aim_bot cheat.", getXoopPassword())
              end
          end
        end
    end
end
addEventHandler('onClientPedDamage', getRootElement(), AntiAimBot)
addEventHandler('onClientPlayerDamage', getRootElement(), AntiAimBot)

-- detect lua code after paste a text
addEventHandler("onClientPaste", root, function(text)
  for index , MethodBlock in ipairs(blockedFunctions) do
    if text:find(MethodBlock) then
      triggerServerEvent("XoopAc:AcBan", localPlayer)
      triggerServerEvent("XoopAc:outputForAll", localPlayer,Xoop.." #FFFFFFThe player [ ".. getPlayerName(localPlayer) .." ] pasted a cheat code!", getXoopPassword())
    end
  end
end)

triggerEvent = triggerServerEvent("AC:Check",localPlayer)
if not triggerEvent then
    triggerServerEvent("XoopAC:AcKick",localPlayer)
end

-- anti stop resource
local loaded = false 
addEventHandler("onClientRender", getRootElement(), function()
  if loaded == false then 
    loaded = true 
    triggerServerEvent("XoopAC-setElementData",localPlayer, "XoopAC-RenderCheck", true, getXoopPassword())
  end 
end )

function check(theKey, oldValue, newValue)
  if (getElementType(source) == "player") and (theKey == "XoopAC-CHECK") and (newValue == false) then
    triggerServerEvent("XoopAC-setElementData", getLocalPlayer(), theKey, true, getXoopPassword())  
  end
end
addEventHandler("onClientElementDataChange", root, check)

triggerServerEvent("XoopAC-setElementData", getLocalPlayer(), "XoopAC-CHECK", true, getXoopPassword())

-- Don't change anticheat name for support us ;D