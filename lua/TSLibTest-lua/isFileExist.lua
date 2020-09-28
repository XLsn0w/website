require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
local file = userPath().."/res/test.txt"
local bool,type = isFileExist(file)
if bool  then
--注意：type 参数仅 TSLib v1.2.8 及其以上版本支持
    if type then
        dialog("文件")
    else
        dialog("文件夹")
    end
else
    dialog("文件路径不存在")
end