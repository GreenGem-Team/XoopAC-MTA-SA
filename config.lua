--[[

  Xoop-Anticheat
  Discord: https://discord.gg/64UUabcPRt

]]

-- if you enable this, setElementData(player, "admin_level") will be overridden
ADMIN_LEVEL_LOCK = false

CODE_INJECTOR_BAN = false

DISABLE_JETPACK = false

SAVE_INJECTED_CODE = true

Ban_Gun_Hack = false
Check_Gun_Hack = true

--trigger
Ban_Kick_Fake_TRIGGER = false -- [true = Ban ,false = kick]

STOP_RESOURCE_BAN_KICK = true -- [true = Ban ,false = kick]

WHITE_LIST_RESOURCES_FOR_LOADSTRING = {
  "resourcename",
  "resourcename2",
}

ADMIN_LEVEL_DATANAMES = {
  "admin_level","supporter_level", "scripter_level", "vct_level" -- if admin_level > 0 then, the player is a admin.
}

DISABLE_GET_BONEPOSITION = true

