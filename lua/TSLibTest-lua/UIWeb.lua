require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
UINew()
--引擎版本：仅支持 Android v3.1.3、专业版 iOS v3.0.6 及其以上版本
--版本：仅支持 TSLib  v1.2.9 及其以上版本
UILabel("显示触动官网",15,"center","255,0,0",-1,0) 
UIWeb("http://www.touchsprite.com/",1900,1600)
UIShow()
