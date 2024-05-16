local XoopPass,PassWord = "", ""
function generatePass(character)
  for i = 1, character do
    local PassWordNew = string.char( math.random(97, 122) )
    PassWord = PassWord..PassWordNew
  end
  setElementData(getResourceRootElement(getThisResource()),"0x0x1223#@The1523dwdS252Xoop15asd282Pass@#!", PassWord)
end

generatePass(30)

setTimer(function()
  generatePass(30)
end, 1000, 0)

function getXoopPassword()
  return getElementData(getResourceRootElement(getThisResource()),"0x0x1223#@The1523dwdS252Xoop15asd282Pass@#!")
end 
