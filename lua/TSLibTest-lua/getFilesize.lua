require("TSLib")
--注意：仅 TSLib v1.2.8 及其以上版本支持
local size = getFileSize(userPath().."/res/baiduAI.jpg")
dialog(size.."B")