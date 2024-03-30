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
