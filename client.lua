local ia = getElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED") or false

setTimer(function()
ia = getElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED") or false

end, 3000,0)

function clientCheatScan()
  if ia == false then return end
  glp = getLocalPlayer()
  if isWorldSpecialPropertyEnabled("aircars") then
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffAIRCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if isWorldSpecialPropertyEnabled("hovercars") then
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffHOVERCARS  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if isWorldSpecialPropertyEnabled("extrabunny") then
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffEXTRA BUNNY  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if isWorldSpecialPropertyEnabled("extrajump") then
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffEXTRA JUMP  [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if getGameSpeed() > 1 then 
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffGAMESPEED CHEAT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  if ( doesPedHaveJetPack (localPlayer) and DISABLE_JETPACK == true ) then
    clientCheat()
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffJETPACK CHEAT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
end
setTimer(clientCheatScan, 2000, 0)

function clientCheat()
  if ia == false then return end

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
  triggerServerEvent("xooptakejetpack", localPlayer, "xoopacishere")

  for propertyName, propertyState in pairs(worldSpecialProperties) do
  setWorldSpecialPropertyEnabled(propertyName, propertyState)
  end
  setTimer(clientCheat, 200, 1)
  
end

local blockedFunctions = {
  'outputChatBox',
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

function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, text )
  if ia == false then return end

  cheat = true
  resname = getResourceName(sourceResource) or "CHEAT=TRUE."
  for _, v in ipairs(WHITE_LIST_RESOURCES_FOR_LOADSTRING) do
    if resname == v then 
      cheat = false
    end 
  end 
  
  if (cheat == false) then return end 
  local name = getPlayerName(localPlayer)
  triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFLUA INJECT [ "..name.." ]", getXoopPassword())
  
  triggerServerEvent("xoopwh", localPlayer, getXoopPassword())

  
  if (CODE_INJECTOR_BAN ~= false) then
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFThe player: "..name.." banned.", getXoopPassword())

      triggerServerEvent("xoopacban", localPlayer, getXoopPassword())
  end

  triggerServerEvent("xoopstopresource", localPlayer, resname, getXoopPassword())
  triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFThe resource: "..resname..", Stoped.", getXoopPassword())

  return "skip"
  
  
end
addDebugHook( "preFunction", onPreFunction, {"loadstring"} )

SPEED_LAST_X = 0;
SPEED_LAST_Y = 0;
SPEED_LAST_Z = 0;
lastTime = 0;
local iFrameCount = 0;

local check = 0;

setTimer(function()
  check = 0
end, 800, 0)

function isElementInAir(element)
  return not (isPedOnGround(element) or getPedContactElement(element))
end

function detectAirBrake()
  if ia == false or not isElementInAir(localPlayer) then return end


  for _, v in ipairs(ADMIN_LEVEL_DATANAMES) do
    local adminlevel = getElementData(localPlayer, v) or 0 
    if (adminlevel > 0) or (getElementData(localPlayer, "isplayerinveh") == true) then 
      return
    end 
  end 
  iFrameCount = iFrameCount + 1;
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
  outputDebugString(tostring(fSpeedRatio));
  end
  if (fSpeedRatio > 1.35 and fSpeedRatio < 8) then
    check = check + 1
    if check >= 15 or (check >= 10 and getElementCollisionsEnabled(localPlayer) == false) then       
      triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffffNOCLIP [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
      check = 0
    end 
  end
  

  SPEED_LAST_X = fPx;
  SPEED_LAST_Y = fPy;
  SPEED_LAST_Z = fPz;
  lastTime = getTickCount();
  spam = true;
      end
    end
end
addEventHandler("onClientPreRender", root, detectAirBrake)
local bombTimer

function projectileCreation( creator )
  if ia == false then return end

  if getElementType(creator) == "player" then
	  local projectileType = getProjectileType( source )
		local x, y, z = getElementPosition ( source )
		
    setElementPosition(source, x,y,z-5000)
    destroyElement(source)    
    
    triggerServerEvent("outputForAll", creator,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffff"..getPlayerName(creator).." created a Projectile", getXoopPassword())
  end
end
addEventHandler( "onClientProjectileCreation", root, projectileCreation )


addEventHandler("onClientGUIChanged", root, function(element) 
  if ia == false then return end

  local text = guiGetText(element)
  -- if (string.find(text,"loadstring") or string.find(text,"triggerEvent") or string.find(text,"triggerServerEvent") or string.find(text,"triggerClientEvent") or string.find(text,"blowVehicle") or string.find(text,"outputChatBox") or string.find(text,"setElementHealth") or string.find(text,"setElementData") or string.find(text,"setPedArmor")) then
  local injecting = false
  for _, v in ipairs(blockedFunctions) do
    if (string.find(text,v)) then 
      injecting = true
    end
  end
  if (injecting == true ) then

  triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFLUA INJECT [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  
  triggerServerEvent("xoopwh", localPlayer, getXoopPassword())

  
  if (CODE_INJECTOR_BAN ~= false) then
      triggerServerEvent("xoopacban", localPlayer, getXoopPassword())
      triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFThe player: "..getPlayerName(localPlayer).." banned.", getXoopPassword())
  end  
  cancelEvent()

end
end)

function cancel( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  if ia == false then return end

  return "skip"
end
addDebugHook( "preFunction", cancel,{"setPedOnFire","createProjectile","blowVehicle"})

function getBonePosition( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
  if ia == false or DISABLE_GET_BONEPOSITION == false then return end

  return "skip"
end
addDebugHook( "preFunction", getBonePosition,{"getPedBonePosition"})

addEventHandler ( "onClientVehicleExplode", getRootElement(), cancelEvent )


local PlayerHealth = getElementHealth(localPlayer)

function godmodeFunction(attacker, weapon, bodypart)
  setTimer(function()
  local NewPlayerHealth = getElementHealth(localPlayer)
  if (NewPlayerHealth == PlayerHealth) and NewPlayerHealth > 0 then 
    triggerServerEvent("outputForAll", localPlayer,"#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #FFFFFFGODMODE [ "..getPlayerName(localPlayer).." ]", getXoopPassword())
  end
  PlayerHealth = NewPlayerHealth
  end,10,1)
end
addEventHandler("onClientPlayerDamage", localPlayer, godmodeFunction)
