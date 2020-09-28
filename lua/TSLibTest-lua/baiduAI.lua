require "TSLib"
local m = TSVersions()
local ts = require("ts")
local a = ts.version()
local json = ts.json
local API  = "WeGGMoi1fT1u4hzpjmrvdBDK"
local Secret  = "jACH00e4jY3ts3OKjg4PVaSMZFZM18Zy"
local tp = getDeviceType()
if m <= "1.2.7" then
    dialog("请使用 v1.2.8 及其以上版本 TSLib")
end
if  tp >= 0  and tp <= 2 then
    if a <= "1.3.9" then
        dialog("请使用 iOS v1.4.0 及其以上版本 ts.so")
    end
elseif  tp >= 3 and tp <= 4 then
    if a <= "1.1.0" then
        dialog("请使用安卓 v1.1.1 及其以上版本 ts.so")
    end
end
--iOS 需要下载 v1.4.0 及其以上版本 ts.so，Android 需要下载 v1.1.1 及其以上版本 ts.so，否则无法调用成功
snapshot("baidu.png",0,0,1000,1000)
local code1,access_token = getAccessToken(API,Secret)
if code1 then
	local pic_name = userPath() .. "/res/baiduAI.jpg"
    snapshot(pic_name, 0,0,900,900) 
    local code2, body = baiduAI(access_token,pic_name)
    if code2 then
        local tmp = json.decode(body)
        for i=1,#tmp.words_result,1 do
            dialog(tmp.words_result[i].words)
        end
    else
        dialog("识别失败\n" .. body)
    end 
else
    dialog("识别失败\n" .. access_token)
end
