local ia = getElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED") or false

setTimer(function()
ia = getElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED") or false
end, 2000,0)
function onElementDataChangeBasicAC(dataKey, oldValue, newValue)
  if ia == false then return end
  if ADMIN_LEVEL_LOCK == true then
    if (not client) then 
      return false 
    end

    for _, v in ipairs(ADMIN_LEVEL_DATANAMES) do 
      if (dataKey == v) then 
        setElementData(source, dataKey, oldValue)
      end
    end 
  end
end
addEventHandler("onElementDataChange", root, onElementDataChangeBasicAC)

addEvent("outputForAll", true)
addEventHandler("outputForAll", root, function(text, pass)
  if pass ~= getXoopPassword() or ia == false then 
  return end


  outputChatBox(text, root, 255,0,0,true)
end )

addEvent("xoopacban", true)
addEventHandler("xoopacban", root, function(pass)
  if pass ~= getXoopPassword() or ia == false or (client ~= source) then return end
    banPlayer(source, true, true, true, "XoopAC", "XOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
end)

--pCht 

addEvent("xoopwh", true)
addEventHandler("xoopwh", root, function(pass)
  if pass ~= getXoopPassword() or ia == false then return end

  sendOptions = {
    queueName = "xwh",
    connectionAttempts = 3,
    connectTimeout = 5000,
    formFields = {
      content = "**NEW Cheater (Lua Injector)**\nName: "..getPlayerName(source).."\nSerial: "..getPlayerSerial(source).."\nIP: "..getPlayerIP(source).."\nServer Name: "..getServerName()
    },
  }
 
  fetchRemote ( "https://discord.com/api/webhooks/1185204452907548734/4VJYJSsKD1hqqT_RgKrsncMjZHCIZ8mM4SQGuzrdv1tHBmUxHZ_xxxx_VSM1Umma9Eev", sendOptions, function() end )
  setElementPosition(source, 2000, 2000, 2000)
  local x, y, z = getElementPosition(source)
		local nearbyPlayers = getElementsWithinRange(x, y, z, 20, "player")
		for i,v in ipairs(nearbyPlayers) do
			if v and isElement(v) then
				setElementPosition(v, -2402.00000, -599.00000, 132.6484)
			end
		end

end)

addEvent("xoopstopresource", true)
addEventHandler("xoopstopresource", root, function(resname,pass)
  if pass ~= getXoopPassword() or ia == false then return end
  stopResource(getResourceFromName(resname))
end)

addEvent("xooptakejetpack", true)
addEventHandler("xooptakejetpack", root, function(pass)
  if pass ~= "xoopacishere" or ia == false then return end 
  setPedWearingJetpack ( source, false )
end )

print("XOOP-AC DISCORD: https://discord.gg/64UUabcPRt")

function vehicleEnter ( thePlayer, seat, jacked )
  if ia == false then return end

  setElementData(thePlayer, "isplayerinveh", true)
end
addEventHandler ( "onVehicleEnter", getRootElement(), vehicleEnter )

function vehicleExit ( thePlayer, seat, jacked )
  if ia == false then return end

  setElementData(thePlayer, "isplayerinveh", false)
end
addEventHandler ( "onVehicleExit", getRootElement(), vehicleExit )

local weaponsToBlock = {
	[35] = true,
	[36] = true,
	[37] = true,
	[38] = true,
	[16] = true,
	[17] = true,
	[18] = true,
  [39] = true,

}
function onPlayerWeaponSwitch(previousWeaponID, currentWeaponID)
  if ia == false then return end

	local blockFire = (not weaponsToBlock[currentWeaponID])

	toggleControl(source, "fire", blockFire)
  if blockFire == false then 
    takeWeapon(source, currentWeaponID)
  end 
end
addEventHandler("onPlayerWeaponSwitch", root, onPlayerWeaponSwitch)