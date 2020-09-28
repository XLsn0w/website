require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
local tb = {tstab=1,bid={"com.abc.mm","com.bcd.mm"}}
clearAllKeyChains(tb)
