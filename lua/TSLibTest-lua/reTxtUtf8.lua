require "TSLib"
local ts = require("ts")
function downFile(url, path)
    status, headers, body = ts.httpGet(url)
    if status == 200 then
        file = io.open(path, "wb")
        if file then
            file:write(body)
            file:close()
            return status;
        else
            return -1;
        end
    else
        return status;
    end
end
downFile("http://video.touchsprite.com/公开分享/cs.txt", userPath().."/res/cs.txt")
local file = io.open(userPath().."/res/cs.txt",r)
if type(file) ~= "boolean"  then 
    a=file:read("*a")
    --文件内容
    dialog("文件内容："..a)
    --未过滤前的字符串长度
    dialog("未过滤的字符串长度："..string.len(a))
    --过滤后的字符串长度
    str = reTxtUtf8(a,3)
    dialog("过滤后的字符串长度："..string.len(str))
end
