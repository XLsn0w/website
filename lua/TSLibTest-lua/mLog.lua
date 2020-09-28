require "TSLib"
--仅支持 TSLib v1.3.1 以及以上版本
--lua 脚本显示 nLog 日志及 wlog 函数内容但是加密成 TSP 脚本后不显示
--glSettings({switch = "1111", x1 = 100, y1 = 100, x2 = 400, y2 = 150,tsp_switch = true})--1 IDE  设备日志
--glSettings({x1 = 500, y1 = 100, x2 = 800, y2 = 200,switch = "0100", tsp_switch = true})--2 文本视图
--glSettings({ tsp_switch = true,switch = "0010"})--3 面包屑
--glSettings({switch = "0001", tsp_switch = true})--本地 log 日志
glSettings({ x2 = 800, y2 = 200,tsp_switch = true,x1 = 500, y1 = 100,switch = "1111"})
while true do
	mLog("显示文字")
	mSleep(2000)
end
