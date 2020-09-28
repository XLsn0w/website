require "TSLib"


--仅支持 TSLib v1.3.1 以及以上版本
glSettings({switch = "1011", x1 = 100, y1 = 100, x2 = 400, y2 = 50,tsp_switch = false})
while true do
	mLog(frontAppBid())
	mSleep(3000)
	if frontAppBid() ~= "com.dfg.dftb" then
		mLog("不是爱淘金")
		runApp("com.dfg.dftb")
		mSleep(2000)
	else
		mLog("已启动爱淘金")
		mSleep(2000)
	end
end
--Test
--bid.lua

-- Create By TouchSpriteStudio on 20:55:04
-- Copyright © TouchSpriteStudio . All rights reserved.
--仅支持 TSLib v1.3.1 以及以上版本
glSettings({switch = "1011", x1 = 100, y1 = 100, x2 = 400, y2 = 50,tsp_switch = false})
while true do
	mLog(frontAppBid())
	mSleep(3000)
	if frontAppBid() ~= "com.dfg.dftb" then
		mLog("不是爱淘金")
		runApp("com.dfg.dftb")
		mSleep(2000)
	else
		mLog("已启动爱淘金")
		mSleep(2000)
	end
end
