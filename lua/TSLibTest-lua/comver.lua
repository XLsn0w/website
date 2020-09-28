--Test
--comver.lua

-- Create By TouchSpriteStudio on 18:48:56
-- Copyright © TouchSpriteStudio . All rights reserved.
require("TSLib")
local m = TSVersions()
if m <= "1.2.8" then
    dialog("请使用 v1.2.9 及其以上版本 TSLib")
     luaExit()
end
--注意：仅支持 TSLib v1.2.9 及其以上版本
dialog(compareVersion("0.3.5","1.1"))
