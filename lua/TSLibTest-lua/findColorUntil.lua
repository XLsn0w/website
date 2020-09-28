require("TSLib")
init(0)
bool =  findColorUntil(1041,  433, 0xf98dae,false,90,400,10) 
if bool then
    dialog("没找到")
else
    dialog("找到啦")
end

