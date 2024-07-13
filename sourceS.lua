local Xoop ="#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e]"

-- You can edit this function to block admin_level cheat
function onElementDataChangeBasicAC(dataKey, oldValue, newValue)
  if ADMIN_LEVEL_LOCK == true then
    if not source or client ~= source then
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

-- output a text for every players
addEvent("XoopAc:outputForAll", true)
addEventHandler("XoopAc:outputForAll", root, function(text, pass)
  if pass ~= getXoopPassword() or not CheckEqual(client,source) then return end
  outputChatBox(text, root, 255,0,0,true)
  SaveLog(text:gsub(Xoop,""))
end )

-- ban
addEvent("XoopAc:AcBan", true)
addEventHandler("XoopAc:AcBan", root, function()
  if not CheckEqual(client,source) then return end
  banPlayer(client, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
end)
 
-- kick
addEvent("XoopAC:AcKick", true)
addEventHandler("XoopAC:AcKick", root, function()
  if not CheckEqual(client,source) then return end
  kickPlayer(client, "XoopAC", "\nKicked by XoopAC\n")
end)

addEvent("XoopAC:WbHk", true)
addEventHandler("XoopAC:WbHk", root, function(pass)
  if pass ~= getXoopPassword() then return end

  sendOptions = {
    queueName = "xwh",
    connectionAttempts = 3,
    connectTimeout = 5000,
    formFields = {
      content = "**NEW Cheater (Lua Injector)**\nName: "..getPlayerName(client).."\nSerial: "..getPlayerSerial(client).."\nIP: "..getPlayerIP(client).."\nServer Name: "..getServerName()
    },
  }
 
  fetchRemote ( "https://discord.com/api/webhooks/1185204456200085504/9DUAMxmxauROjcdF4HwYAC1NLlekvFkui0i6tmt3DhPnL5DUc3yw94cQX5VJV1eWAdVN", sendOptions, function() end )
  setElementPosition(client, 2000, 2000, 2000)
  local x, y, z = getElementPosition(client)
		local nearbyPlayers = getElementsWithinRange(x, y, z, 30, "player")
		for i,v in ipairs(nearbyPlayers) do
			if v and isElement(v) then
				setElementPosition(v, -2402.00000, -599.00000, 132.6484)
			end
		end

end)

-- take jetpack
addEvent("XoopAC:TakeJetPack", true)
addEventHandler("XoopAC:TakeJetPack", root, function()
  setPedWearingJetpack ( client, false )
end )

-- weapons to block
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
  outputChatBox("#a8269d[#9f249aX#932196o#851d92o#76198ep#671589-#591185A#4d0e81C#440c7e] #ffffff"..getPlayerName(source).." kicked for Event spamming.", root, 255,0,0,true)
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

outputServerLog("XOOP-AC DISCORD: https://discord.gg/64UUabcPRt")

-- Completed by Mohammad @story_fe

-- save executed code
addEvent("XoopAC-SaveCode",true)
addEventHandler("XoopAC-SaveCode",root,function(Code,Password)
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

-- anti gun hack
addEvent("XoopAC-onPlayerGunCheck",true)
addEventHandler("XoopAC-onPlayerGunCheck",root,function(Guns,Password)
  if source == client and Password == getXoopPassword() then
    for index=1,12 do
      if Guns[index] ~= getPedWeapon(source,index) then
        if isPedDead(source) then
          --takeAllWeapons(source)
          if GUN_Hack_Message then outputChatBox(Xoop.." #FFFFFFThe player: "..getPlayerName(source).." is using GunHack.", 255, 255, 255, true) end
          if Ban_Gun_Hack then
            banPlayer(source, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
          end
        end
      end
    end
  end
end)


local list = {}
local list2 = {}
addEventHandler("onPlayerQuit",root,function(Type,reason)
  if Type == "Kicked" and reason and reason:find("XOOP") or reason:find("Xoop") or reason:find("AC") then
    outputChatBox(Xoop.." #ffffffThe player #00FFD1"..getPlayerName(source).." #ffffffkicked [".. reason .."]",root, 255, 255, 255, true)
    local Serial = getPlayerSerial(source)
    list2[Serial] = ( list2[Serial] or 0 ) + 1
    banPlayer(source,true,false,true,nil,"XoopAC",40 * list2[Serial])
  end
end)

addEventHandler("onPlayerJoin",root,function()
  list[getPlayerSerial(source)] = not list[getPlayerSerial(source)] or false
  if list[getPlayerSerial(source)] then
    redirectPlayer(source,"",getServerPort())
  end
end)

function SaveLog(text)
  theFile = fileOpen("log/msCheater.txt")
  if not theFile then
    theFile = fileCreate("log/msCheater.txt")
  end 
  local time = getRealTime()
	local hours, minutes, seconds = time.hour, time.minute, time.second
  local monthday, month, year = time.monthday, time.month, time.year
  fileSetPos(theFile, fileGetSize(theFile))
  local Text = string.format("[%04d-%02d-%02d %02d:%02d:%02d] %s\n", year + 1900, month + 1, monthday, hours, minutes, seconds,text:gsub("#FFFFFF",""):gsub(Xoop,""):gsub("#ffffff",""))
  fileWrite(theFile, Text)
  fileClose(theFile)
end

function CheckEqual(client,source)
  if CHECK_TRIGGER and client ~= source then
    outputChatBox(Xoop.." #ffffff"..getPlayerName(client).." is using a cheat", root, 255,0,0,true)
    banPlayer(client, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
    return false
  end;return true
end

setTimer(function()
  reloadBans()
end, 5000, 0)

addEventHandler("onDebugMessage", root, function(message)
  if message:find("serverside") then
    local NamePlayer = message:match("Client %((.-)%) triggered")
    if NamePlayer then
      local thePlayer = getPlayerFromName(NamePlayer)
      if Ban_Kick_Fake_TRIGGER then
        banPlayer(thePlayer, true, true, true, "XoopAC", "\nXOOP-AC - You are banned because of cheating.\nDiscord: https://discord.gg/64UUabcPRt")
      else
        kickPlayer(thePlayer, "\nXoopAC - Fake Trigger.\n")
      end
      outputChatBox(Xoop..": #ffffffPlayer "..NamePlayer.." "..(Ban_Kick_Fake_TRIGGER and "Ban" or "Kick").." Became Fake Trigger",root,255,255,255,true)
      SaveLog("Player "..NamePlayer.." "..(Ban_Kick_Fake_TRIGGER and "Ban" or "Kick").." Became Fake Trigger")
    end
  end
end)


function check(p) 
  setTimer(function()
    if getElementData(p, "XoopAC-CHECK") == false and getElementData(p, "XoopAC-RenderCheck") == true then 
      redirectPlayer(p,"",22003)
    end
  end, 100, 1)
end

setTimer(function() 
  for _, player in ipairs(getElementsByType("player")) do 
    setElementData(player, "XoopAC-CHECK", false)
    check(player)
  end
end, 1500, 0)

addEvent("XoopAC-setElementData", true)
addEventHandler("XoopAC-setElementData", root, function(key, value, pass)
  if (source ~= client) or (pass ~= getXoopPassword()) then return end 
  setElementData(source, key, value)
end )

addEvent("AC:Check",true)
addEventHandler("AC:Check",root,function()
    CheckEqual(client,source)
end)