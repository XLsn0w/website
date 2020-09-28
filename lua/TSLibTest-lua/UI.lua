--Test
--UI.lua

-- Create By TouchSpriteStudio on 17:53:37
-- Copyright © TouchSpriteStudio . All rights reserved.
require "TSLib"--使用函数库一定要在最前面调用并将函数库文件发送到手机 lua 目录
w,h = getScreenSize()
UINew(2,"第一页,第二页","开始","取消","uiconfig.dat",0,120,w*0.8,h*0.8,"221,240,237","88,210,232")
UIImage(2,"http://www.baidu.com/img/bdlogo.png")
UILabel({text="单选组合设置："})
UIRadio({id="radio",list="单选1,单选2,单选3,单选4,单选5,单选6"})
UILabel(2,"下拉框设置：")
UICombo({num=2,id="combo",list="下拉框1,下拉框2,下拉框3,下拉框4,下拉框5,下拉框6","1",400,1,true})
UILabel("多选组合设置：")
UICheck("check1,check2,check3,check4,check5,check6","多选1,多选2,多选3,多选4,多选5,多选6")
UILabel("联动框设置：")
UIComboRlt("comborle,comborles","选项1,选项2,选项3","子选项1,子选项2,子选项3,子选项4#子选项5,子选项6,子选项7#子选项8,子选项9","test")
UILabel("关联框设置：")
UIComboRlts("comborles","test")
UIShow()
dialog("单选组合选择："..radio.."\n".."下拉框选择："..combo.."\n".."联动框选择："..comborle.."\n".."关联框选择："..comborles, 0)
dialog("多选组合结果:".."\ncheck1="..tostring(check1).."\ncheck2="..tostring(check2).."\ncheck3="..tostring(check3).."\ncheck4="..tostring(check4).."\ncheck5="..tostring(check5).."\ncheck6="..tostring(check6), 0)