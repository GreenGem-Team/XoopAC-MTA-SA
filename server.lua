
function onElementDataChangeBasicAC(dataKey, oldValue, newValue)
  if ADMIN_LEVEL_LOCK == true then
    if not client or client != source then 
      setElementData(source, dataKey, oldValue)
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
  if pass ~= getXoopPassword() then 
  return end
  outputChatBox(text, root, 255,0,0,true)
end )

addEvent("xoopacban", true)
addEventHandler("xoopacban", root, function(pass)
  if pass ~= getXoopPassword() or (client ~= source) then return end
  banPlayer(source, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
end)

addEvent("xoopwh", true)
addEventHandler("xoopwh", root, function(pass)
  if pass ~= getXoopPassword() then return end

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
  if pass ~= getXoopPassword() then return end
  stopResource(getResourceFromName(resname))
end)

addEvent("xooptakejetpack", true)
addEventHandler("xooptakejetpack", root, function(pass)
  if pass ~= getXoopPassword() then return end 
  setPedWearingJetpack ( source, false )
end )

print("XOOP-AC DISCORD: https://discord.gg/64UUabcPRt")

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
	local blockFire = (not weaponsToBlock[currentWeaponID])

	toggleControl(source, "fire", blockFire)
  if blockFire == false then 
    takeWeapon(source, currentWeaponID)
  end 
end
addEventHandler("onPlayerWeaponSwitch", root, onPlayerWeaponSwitch)

function processPlayerTriggerEventThreshold()
  outputChatBox("#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffff"..getPlayerName(source).." was kicked for Event spamming.", root, 255,0,0,true)
  kickPlayer(source, "\nXoopAC - Spam event.\n")
end
addEventHandler("onPlayerTriggerEventThreshold", root, processPlayerTriggerEventThreshold)