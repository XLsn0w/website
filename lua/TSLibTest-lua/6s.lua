function daily()
	multiColTap({{  326,  570, 0xece2ed},{  451,  569, 0xece2ed},{  434,  559, 0x95dd4a},{  366,  816, 0xffffff}})--离线奖励
	multiColTap({{   346,  871, 0xff547b},{  401,  873, 0xff547b},{  374,  911, 0xff547b}})--签到
	x,y = findMultiColorInRegionFuzzy( 0xffae00, "0|5|0xffae00,0|12|0xffae00,15|4|0xffae00,25|10|0xffae00", 90, 313, 784, 432, 823)--关掉宝箱
	if x ~= -1 then
		tap(270, 1074)
	end
end

function collect()
	x,y = findMultiColorInRegionFuzzy( 0xdb5da9, "5|0|0xdb5da9,2|4|0xdb5ea9", 80, 54, 205, 696, fh)--鱼红心泡泡
	if x ~= -1 then
		tap(x,y)
		toast("找到一颗心233")
	end
end

function festival()
		x,y = findMultiColorInRegionFuzzy( 0xad2f78, "-11|6|0xff69b8,-2|8|0xf252a6",85, 87, 62, 626,  fh)--2018情人节活动
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xc4378b, "8|-6|0xad2f78,1|-3|0xff75c3",85, 87, 62, 626,  fh)
		if x ~= -1 then
			tap(x,y)
			toast("情人节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xda49a3, "-4|7|0xe74aa5,1|11|0xf252a6",85,87, 62, 626,  fh)
			if x ~= -1 then
				tap(x,y)
				toast("情人节快乐哦~")
			end
		end
	end
	--[[x,y = findMultiColorInRegionFuzzy( 0x43c2ad, "13|5|0xf4f1f2,18|10|0xf1f0f2,8|-7|0xf5f3f3",85, 87, 62, 626,  fh)--2017万圣节活动
	if x ~= -1 then
		tap(x,y)
		toast("圣诞节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfe7694, "-3|1|0xf5f3f3,2|13|0xf4f1f2,7|18|0xf1f0f2",85, 87, 62, 626,  fh)
		if x ~= -1 then
			tap(x,y)
			toast("圣诞节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0x43c2ad, "4|-4|0x5ccfbb,13|5|0xf4f1f2,18|10|0xf1f0f2",85,87, 62, 626,  fh)
			if x ~= -1 then
				tap(x,y)
				toast("圣诞节快乐哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0x2acefd, "0|3|0x2acefd,9|13|0x58e4ff,-10|-5|0x58e4ff",85, 87, 62, 626,  fh)--2017万圣节活动
	if x ~= -1 then
		tap(x,y)
		toast("糖果 +1 呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xbd4261, "6|-6|0x2acefa,6|-3|0x2acefa,5|-1|0x2acefa",85, 87, 62, 626,  fh)
		if x ~= -1 then
			tap(x,y)
			toast("糖果 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0x2ccefa, "-6|0|0x2bcefa,-6|-3|0x2acefa,-5|-5|0x2acefa,-5|-7|0x2acefa",85,87, 62, 626,  fh)
			if x ~= -1 then
				tap(x,y)
				toast("糖果 +1 哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0xff6867, "0|3|0xff6566,3|10|0xfb5f64,-15|14|0xfe8868",85, 87, 62, 626,  fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("枫叶 +1 呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfd8a69, "3|0|0xfd8769,6|-1|0xfe8569,10|2|0xfd8169",85, 87, 62, 626,  fh)
		if x ~= -1 then
			tap(x,y)
			toast("枫叶 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xf3765f, "2|1|0xf67762,4|4|0xf47561,12|1|0xff6666",85,87, 62, 626,  fh)
			if x ~= -1 then
				tap(x,y)
				toast("枫叶 +1 哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0xfa688d, "-4|5|0xffffff,-6|7|0xffffff,-9|9|0xffffff,-4|8|0xffffff,-1|7|0xffffff",90, 87, 62, 626,  529)--生日蛋糕
	if x ~= -1 then
		tap(x,y)
		toast("生日快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffe7ff, "-1|-9|0xffffff,-3|-7|0xffffff,-6|-5|0xffffff,-1|-6|0xffffff,2|-7|0xffffff,-2|0|0xffebff",90, 87, 62, 626,  529)
		if x ~= -1 then
			tap(x,y)
			toast("生日快乐(*@ο@*) 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xffffff, "-2|-1|0xffffff,-4|1|0xffffff,-7|3|0xffffff,-2|2|0xffffff,1|1|0xffffff,-2|1|0xffffff,-4|1|0xffffff,-5|2|0xffffff,-7|3|0xffffff",90,87, 62, 626,  529)
			if x ~= -1 then
				tap(x,y)
				toast("生日快乐哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy(0xffffff, "3|4|0xffffff,3|6|0xffffff,12|1|0xffffff,10|5|0xffffff,11|8|0xffffff",99, 87, 62, 734, 566)--春天蝴蝶
	if x ~= -1 then
		tap(x,y)
		toast("春天在哪里呀？")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "3|4|0xffffff,3|6|0xffffff,12|0|0xffffff,10|4|0xffffff,11|7|0xffffff",99, 87, 62, 734, 566)
		if x ~= -1 then
			tap(x,y)
			toast("春天在哪里呢？")
		else
			x,y = findMultiColorInRegionFuzzy(0xffffff, "2|5|0xffffff,10|0|0xffffff,9|3|0xffffff,9|6|0xffffff",99,87, 62, 734, 566)
			if x ~= -1 then
				tap(x,y)
				toast("春天在这里哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0xf4ebe8, "1|0|0xf5ece9,6|-1|0xf1e7e5,-4|7|0xf1e9e7,8|8|0xebe1e0,-2|15|0x70476a",90, 66, 91, 727, 664)--情人节巧克力
if x ~= -1 then
	tap(x,y)
	toast("情人节快乐哦~")
else
	x,y = findMultiColorInRegionFuzzy( 0xf1f6ec, "1|1|0xf1f6ec,6|0|0xeff4ea,-6|5|0xf0f5ec,9|8|0xe9ede5,-4|15|0x6c516d,0|16|0x6c506d",90, 66, 91, 727, 664)
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐哟~")
	end
end
x,y = findMultiColorInRegionFuzzy( 0xf3ffff, "15|14|0xf4ffff,-7|7|0xf2ffff,7|22|0xeeffff", 90, 66, 91, 727, 664)--万圣节糖果
	if x ~= -1 then
		tap(x,y)
		toast("找到一颗糖")
	end
x,y = findMultiColorInRegionFuzzy( 0x3ec5ab, "6|-6|0xffffff,1|4|0x43d5aa,13|-5|0xffffff", 85, 66, 91, 727, 664)
if x ~= -1 then
	tap(x,y)
	toast("圣诞节快乐~")
else
	x,y = findMultiColorInRegionFuzzy( 0x3ec5ab, "1|4|0x43d5aa,7|-5|0xffffff,11|5|0xffffff", 85, 66, 91, 727, 664)
	if x ~= -1 then
		tap(x,y)
		toast("圣诞节快乐~")
	end
end]]
end

function expand()
	if multiColor({{   40,  711, 0xbe516a},{   45,  713, 0xbe516a},{   31,  748, 0xbe516a},{   43,  757, 0xffffff},{  156,  747, 0xbe516a},}) == false then
		tap(686, 1280)
		if multiColor(
			{
				{  303, 1072, 0xffffff},
				{  320, 1070, 0xffffff},
				{  301, 1090, 0xffffff},
				{  321, 1090, 0xffffff},
				}) == false then--扩张未开
			tap(321, 1090)
		end
	end
end

function stonemove()
	if multiColor({{   65, 1276, 0xffffff},{   82, 1275, 0xffffff},{   73, 1256, 0xffffff}}) == false then--石头未开
		tap(82, 1275)
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "-10|8|0xffffff,0|5|0xffffff,0|12|0xffffff,15|11|0xffffff", 90, 339, 816, 411, 862) --向上滑动（技能）
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function menu()
	if multiColor({{   40,  711, 0xbe516a},{   45,  713, 0xbe516a},{   31,  748, 0xbe516a},{   43,  757, 0xffffff},{  156,  747, 0xbe516a},}) == false then
		tap(686, 1280)
	else
		stonemove()
	end
end

function shutmenu()
	if multiColor({{   40,  711, 0xbe516a},{   45,  713, 0xbe516a},{   31,  748, 0xbe516a},{   43,  757, 0xffffff},{  156,  747, 0xbe516a},}) == true then
		tap(675, 1271)
	end
end

function farmmove()
	if multiColor({{  172, 1282, 0xffffff},{  156, 1265, 0xffffff},{  171, 1274, 0xffffff},}) == false then--珊瑚未开
		tap(156, 1265)
	else
		x,y = findMultiColorInRegionFuzzy( 0x1c2935, "19|-24|0x1c2935,46|-4|0x1c2935,69|17|0x1c2935,41|15|0xffffff", 90, 22, 827, 125, 933)--海带农场
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function farm()
	x,y = findMultiColorInRegionFuzzy( 0x2b267c, "3|7|0x311f85,5|12|0x331f87", 90, 43, 215, 85, 252)--半屏海胆
	if x ~= -1 then
		tap(x,323)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x55bb72, "4|-5|0x58b96a,13|-6|0x3b976b,8|-2|0x409e79,3|4|0x45a37f", 90, 95, 139, 139, 186)--半屏海带
	if x ~= -1 then
		tap(x,252)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae5e9, "-1|6|0xfafffd,2|4|0xfafffd,4|3|0xfafffd,0|6|0xfafffd,6|9|0xdae5e9", 90, 496, 152, 545, 203)--半屏贝壳
	if x ~= -1 then
		tap(x,274)
		mSleep(500)
		toast("收割贝壳~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x2d2689, "5|0|0x31228e,9|4|0x351f92", 90, 53, 470, 101, 513)--全屏海胆
	if x ~= -1 then
		tap(x,579)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x55bc73, "5|-5|0x58b86a,10|-10|0x5bb867,13|-6|0x3b976c,9|-1|0x409e7b,4|3|0x44a280", 90, 105, 371, 147, 412)--全屏海带
	if x ~= -1 then
		tap(x,516)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae6e9, "1|5|0xfafffd,4|3|0xfafffd,6|3|0xfafffd,2|6|0xfafffd,6|9|0xdae6e9", 90, 492, 381, 533, 421)--全屏贝壳
	if x ~= -1 then
		tap(x,537)
		mSleep(500)
		toast("收割贝壳~")
	end
	--[[if multiColor({{   40,  711, 0xbe516a},{   45,  713, 0xbe516a},{   31,  748, 0xbe516a},{   43,  757, 0xffffff},{  156,  747, 0xbe516a},}) == false then
		tap(686, 1280)
		nLog("菜单没打开")
	else
		farmmove()
	end
	if multiColor({{  662,  680, 0xfaaf3f},{  685,  706, 0xfaaf3f},{  704,  676, 0xfaaf3f},}) == false then --农场未开
		multiColTap({{  690,  659, 0x5cb63a},{  708,  689, 0xffffff},{  678,  686, 0xffa466},})--点击农场
	else
		x,y = findMultiColorInRegionFuzzy( 0xb5dc43, "45|2|0xb7de45,22|45|0xb6dd44", 99, 516, 826, 727, 1231)--查找收割绿色
		if x ~= -1 then
			tap(x,y)
			mSleep(1500)
			toast("完成收割！",1)
		end
	end]]
end

function stoneup()
	x,y = findMultiColorInRegionFuzzy( 0xfbae17, "72|0|0xfbae17,-1|74|0xfbae17,76|75|0xfbae17", 90, 21, 821, 121, 1236)--获取升级奖励
	if x ~= -1 then
		tap(x,y)
	end
	multiColTap({
			{   70, 1067, 0xeeeef5},
			{  529, 1060, 0x0099bc},
			{  531, 1087, 0x0099bc},
			{  571, 1103, 0xffffff},
		})--升级珊瑚石（蓝色）
	multiColTap({
			{   70, 1067, 0xeeeef5},
			{  529, 1060, 0xe8972d},
			{  531, 1087, 0xe8972d},
		})--升级珊瑚石（黄色）
end

function stoneskill()
	multiColTap({
			{  106,  918, 0xf9f9f9},
			{  124,  916, 0xf9f9f9},
			{  142,  916, 0xf9f9f9},
		})--火山爆发
	multiColTap({
			{  433,  926, 0x2f7496},
			{  420,  945, 0xececec},
			{  427,  970, 0x172e3f},
		})--月之歌
	multiColTap({
			{  277,  910, 0xe9566e},
			{  284,  920, 0xe9566e},
			{  300,  910, 0xdb4964},
		})--海鲜大餐
end

function skillinit()
	local inittime = os.time() - skilltime
	local adtime = os.time()
	if inittime > 300 then
		if multiColor({{  525,  762, 0xffb32c},{  524,  771, 0xffb32c},{  529,  777, 0xffb32c}}) == true then
			ad = 1
			toast("技能初始化")
			tap(525,  801)
			while true do
				if multiColor({{  579,   38, 0xffffff},{  583,   43, 0xffffff},{  597,   37, 0xffffff},{  595,   57, 0xffffff},{  579,   58, 0xffffff}}) == true then --右上角关闭广告
					tap(584, 52)
					break
				end	
				if os.time() - adtime > 35 then
					toast("ad = 0")
					ad = 0
				else
					toast("技能冷却中")
				end
			end
		end
	end
end

function skillinit()
	x,y = findMultiColorInRegionFuzzy( 0xffb40d, "2|0|0xffb40d", 100, 105, 744, 409, 753)--三技能区域内查找倒计时黄圈
	if x == - 1 then
		x,y = findMultiColorInRegionFuzzy( 0xffb32c, "-2|8|0xffb32c,3|15|0xffb32c", 90, 507, 748, 546, 802)--闪电
		if x ~= -1 then
			ad = 1
			nLog("技能初始化")
			tap(525,  801)
		end
	end
	if a == 1 then
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "5|6|0xffffff,13|15|0xffffff,16|-1|0xffffff,3|14|0xffffff,-2|18|0xffffff", 100, 567, 25, 611, 74) --右上角关闭广告
		if x ~= -1 then
			ad = 0
			nLog("技能初始化广告结束")
			tap(586,   47)
		end
	end
end

function box()
	x,y = findMultiColorInRegionFuzzy( 0x504960, "14|2|0x5c5063,32|22|0x754b62", 90, 313, 284, 370, 334)--箱子
	if x ~= -1 then
		ad = 1
		tap(337,  307)
		nLog("点击宝箱")
	end
	x,y = findMultiColorInRegionFuzzy( 0xffae00, "7|-1|0xffae00,30|3|0xfead00,45|2|0xffae00,45|-7|0xffae00,60|-1|0xffae00,61|2|0xffae00", 90, 344, 884, 476, 943)--开启宝箱
	if x ~= -1 then
		ad = 1
		tap(405,  914)
		nLog("开启宝箱")
	end
	if ad == 1 then
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "6|6|0xffffff,16|16|0xffffff,3|18|0xffffff,16|3|0xffffff", 100, 568, 27, 608, 70)--右上角关闭广告
		if x ~= -1 then
			ad = 0
			tap(586,   47)
			nLog("开宝箱广告结束")
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0xffa300, "16|-1|0xffa300,47|3|0xffa300,87|6|0xffa300,87|-4|0xffa300,87|-6|0xffa300,87|-7|0xffa300", 90, 265, 670, 373, 702)--生命奖励
	if x ~= -1 then
		tap(344,  907)
	end
	x,y = findMultiColorInRegionFuzzy( 0x9ea0a0, "-5|-1|0x9ea0a0,-12|5|0x9e9fa0,11|9|0x9ea0a0,19|5|0x9ea0a0", 90, 288, 895, 352, 932)--确认
	if x ~= -1 then
		tap(344,  907)
	end
end