addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
  local file = fileOpen("enter_license_key_here.txt") or false
  if not file then
    print("\n------------------------------------\n~ Xoop-AC - enter_license_key_here.txt file could not be found!\n------------------------------------")
    cancelEvent()
    return
  end
  local count = fileGetSize(file) 
  local license = fileRead(file, count) 
  fileClose(file) 
  local time = getRealTime()
  local year = time.year + 1900
  local month = time.month + 1
  local day = time.monthday

  license = string.gsub(license, "[\n\r]", "")
  license = string.gsub(license, " ", "")

  if license == "" then 
    print("\n------------------------------------\n~ Xoop-AC - File enter_license_key_here.txt Ro Kamel Konid.\n------------------------------------")
    cancelEvent()
    return
  end
  print("~ Xoop-AC - Checking Licensekey ...")
  fetchRemote("https://upbeat-panini-iobva64zx.liara.run/xac-checklicense/"..license, function(responseData, error)
    if string.find(responseData, "Confirmed") then 
      print("~ Xoop-AC - Confirmed")
      setElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED", true)
    else 
      print("\n------------------------------------\n~ Xoop-AC - "..responseData.."\n------------------------------------")
      stopResource(getThisResource())
    end 
  end )

end)

function finishedCallback( responseData, error )
  if string.find(responseData, "Confirmed") then 
    print("~ Xoop-AC - Confirmed")
    setElementData(getResourceRootElement(getThisResource()), "XAC_42AK1YUHAC_IS_ACTIVE_vTyfcQv41b_AND_LICENSE_Z9orj7X0Lx_IS_CONFIRMED", true)
  else 
    print("\n------------------------------------\n~ Xoop-AC - "..responseData.."\n------------------------------------")
    stopResource(getThisResource())
  end 
end

keys = {
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R","S", "T", "U", "V", "W", "X", "Y", "Z",
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r","s", "t", "u", "v", "w", "x", "y", "z",
  "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
}

XoopPass = ""
function generatePass()
  local password = ''
  local n = 0
  while true do
    n = n + 1
    local randomNum = math.random(1,#keys)
    password = password..(keys[randomNum])
    if n == 30 then break end
  end
  password = string.gsub(password, " ", "")
  XoopPass = password
  setElementData(getResourceRootElement(getThisResource()),"0x0x1223#@The1523dwdS252Xoop15asd282Pass@#!", password)
  return true
end

generatePass()

setTimer(function()
  generatePass()
end, 1000, 0)

function getXoopPassword()
  return getElementData(getResourceRootElement(getThisResource()),"0x0x1223#@The1523dwdS252Xoop15asd282Pass@#!")
end 
