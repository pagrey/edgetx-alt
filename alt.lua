-- OpenTX Lua script
-- Alt TELEMETRY
-- Place this file in SD Card copy on your computer > /SCRIPTS/TELEMETRY/
--
-- https://github.com/pagrey
--

local SensorOne = "Alt"
local SensorTwo = "Alt-"

local alt_id, alt_l
local AltVal, AltMin

local function init()
  if (getFieldInfo(SensorOne).id ~= nil) then
    alt_id = getFieldInfo(SensorOne).id 
    alt_l = getFieldInfo(SensorTwo).id 
    AltVal = getValue(alt_id)
    AltMin = getValue(alt_l)
  end
end

local function background()
  if (getFieldInfo(SensorOne).id ~= nil) then
    AltVal = getValue(alt_id)
    AltMin = getValue(alt_l)
  end
end

local function run(event)
  lcd.clear()
  if (getFieldInfo(SensorOne).id ~= nil) then
    if model.getGlobalVariable(0,0) <  (AltVal-AltMin) then
      model.setGlobalVariable(0,0,AltVal-AltMin)
    end
    lcd.drawText(1,1,"Alt:")
    lcd.drawNumber(lcd.getLastPos(),1,AltVal-AltMin)
    lcd.drawText(lcd.getLastPos(),1," Flight Max:")
    lcd.drawNumber(lcd.getLastPos(),1,model.getGlobalVariable(0,0))
  else
    lcd.drawText(1,1,"Waiting for telemetry...")
  end
end

return { run = run, background = background, init = init }
