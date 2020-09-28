require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
UINew()
UILabel("分割线1",15,"center","255,0,0",-1,0) 
--引擎版本：仅支持 Android v3.1.3、专业版 iOS v3.0.6 及其以上版本
--版本：仅支持 TSLib  v1.2.9 及其以上版本
UILine("center",500,10,"ff00ff")
UILabel("分割线2",15,"center","255,0,0",-1,0)
UILine("center",600,100,"208,208,208")
UIShow()
