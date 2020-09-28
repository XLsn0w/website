require("TSLib")
local ts = require("ts")
local json = ts.json
local tb = toTableType(0xffffff,"10|5|0xffffff,30|400|0xffffff,100|95|0xf9ae08",900,600)
--把 table 转换成 json 字符串
local jsonstring = json.encode(tb)
dialog(jsonstring, 0)
nLog(jsonstring)
