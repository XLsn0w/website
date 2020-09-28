require("TSLib")
init(0)
result =  findColorsUntil(0xf98dae, "-54|82|0xeff3f6,19|91|0xecf0f5,15|141|0xd04d74",90,949, 410, 1138, 599, { orient = 0 },200,10)
if result == true then
    dialog("找到啦")
else
    dialog("没找到")
end