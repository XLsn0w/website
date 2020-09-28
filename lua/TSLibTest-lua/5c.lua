function adtimes()
	adtime = 1
	tap(583,  769)--接收广告
	mSleep(35*1000)
	multiColTap({{  585,   45, 0xffffff},{  589,   50, 0xffffff},})--UnityAds 右上角叉叉
	x,y = findMultiColorInRegionFuzzy( 0xffffff, "5|6|0xffffff,14|16|0xffffff,-3|16|0xffffff,14|-4|0xffffff,5|7|0xffffff", 90, 535, 9, 637, 89)--UnityAds 右上角叉叉
	if x ~= -1 then
		tap(x,y)
	end
	x,y = findMultiColorInRegionFuzzy( 0xcccbcc, "11|0|0xbababa,12|12|0xbbbaba,0|11|0xcdcccc,6|5|0xbfbfbf", 90, 5, 5, 86, 78)--ADColony 左上角叉叉
	if x ~= -1 then
		tap(x,y)
	end
	adtime = 0
end

function ads()
	x,y = findMultiColorInRegionFuzzy( 0xffffff, "-9|-1|0x5bb3b5,1|-9|0x5bb3b5,2|9|0x5bb3b5", 90, 316, 1054, 522, 1089)--菜单栏播放按钮
	if x ~= -1 then
		tap(x-20,y+15)
		mSleep(1000)
		adtimes()
	end
	if multiColor({{  707, 1220, 0xffffff},{  707, 1225, 0xffffff},{  988, 1234, 0x0099bc},{  988, 1288, 0x0099bc},}) then--顶部播放按钮
		adtimes()
	end
end

function daily()--日常弹窗检测
	multiColTap({{  197,  431, 0xdfdfdf},{  191,  659, 0xdfdfdf},{  387,  686, 0xdfdfdf},{  461,  689, 0x007aff}})--推送通知
	multiColTap({{  292,   31, 0x000000},{  298,   31, 0x000000},{   71,   38, 0x5856d6},{   30,   50, 0x5856d6}})--取消GC
	multiColTap({{  234,  458, 0xdfdfdf},{  384,  465, 0xdfdfdf},{  328,  656, 0x007aff},{  321,  666, 0xdfdfdf}})--游戏中心登录失败
	multiColTap({{  558,   91, 0xf1ecfa},{  573,   91, 0xefebfb},{  583,   98, 0xf1eefb},{  542,   94, 0xf1ecfa}})--略过教学
	multiColTap({{  542,   94, 0xf0eefd},{  558,   91, 0xf0effe},{  564,   92, 0xf1f1ff},{  574,   92, 0xf0effd},{  584,   98, 0xefeefd}})--略过教学
	multiColTap({{  307, 1039, 0x000000},{  330, 1041, 0x000000},{  318, 1039, 0xffffff},{  321, 1040, 0xffffff}})--教学：请点击按键
	multiColTap({{  299,  954, 0x99ff36},{  312,  967, 0x99ff36},{  329,  951, 0x99ff36},{  320,  960, 0x99ff36}})--教学：绿色圆圈对勾1
	multiColTap({{  299,  944, 0xf9b500},{  309,  955, 0xf9b500},{  335,  949, 0xf9b400},{  335,  959, 0xf9b400}})--教学：确定
	multiColTap({{  300,  845, 0x99ff36},{  312,  856, 0x99ff36},{  327,  842, 0x99ff36}})--教学：绿色圆圈对勾2
	multiColTap({{  299,  839, 0xf9b500},{  309,  837, 0xf9b500},{  335,  843, 0xf9b400},{  334,  848, 0xf9b400}})--教学：确定2
	multiColTap({{  139, 1004, 0xffffff},{  150, 1004, 0xffffff},{  144, 1014, 0xffffff},{  138, 1032, 0xffffff},{  147, 1036, 0xffffff},{  144, 1087, 0x6390c4}})--教学：珊瑚
	multiColTap({{  400,  743, 0xffffff},{  417,  742, 0xffffff},{  404,  753, 0xffffff},{  430,  746, 0xffffff},{  502,  758, 0xffffff},{  481,  741, 0xe8972d}})--教学：解锁珊瑚
	multiColTap({{  299,  834, 0xf9b400},{  299,  839, 0xf9b400},{  341,  834, 0xf9b500},{  341,  838, 0xf9b500}})--教学：下一步
	multiColTap({{  397,  742, 0xffffff},{  399,  753, 0xffffff},{  431,  747, 0xffffff},{  502,  759, 0xffffff},{  481,  747, 0x0099bc}})--教学：升级珊瑚
	--multiColTap({{  221, 1006, 0xffffff},{  233, 1008, 0xffffff},{  228, 1026, 0xffffff},{  227, 1038, 0xffffff},{  230, 1083, 0x6692c5}})--教学：鱼
	--multiColTap({{  396,  740, 0xffffff},{  430,  745, 0xffffff},{  499,  759, 0xffffff},{  480,  746, 0x0099bc}})--教学：买蓝色小丑鱼
	--multiColTap({{  396,  844, 0xffffff},{  432,  849, 0xffffff},{  500,  862, 0xffffff},{  480,  844, 0x0099bc}})--教学：买红色小丑鱼
	multiColTap({{  285,  527, 0xffb32c},{  285,  520, 0xffb32c},{  312,  522, 0xffb32c},{  330,  532, 0xffb32c},{  355,  524, 0xffb32c},{  334,  674, 0xaaaab0}})--创造出了新鱼
	multiColTap({{  271,  369, 0xff2c53},{  270,  374, 0xff2c53},{  275,  380, 0xff2c53},{  312,  684, 0x7e7e86}})--发现隐藏鱼
	multiColTap({{  277,  485, 0xece2ed},{  378,  437, 0x7fc140},{  385,  486, 0xece2ed},{  312,  702, 0xffffff}})--离线奖励
	multiColTap({{  290,  815, 0xff547b},{  317,  846, 0xff547b},{  350,  827, 0xff547b},{  335,  832, 0xffffff}})--签到
	multiColTap({{  376,  915, 0xffae00},{  383,  916, 0xffae00},{  421,  914, 0xfead00},{  436,  918, 0xffae00},{  224,  918, 0x686b6c}})--关闭宝箱
end

function collect()
	x,y = findMultiColorInRegionFuzzy( 0xd66db0, "-4|0|0xd66db0,1|5|0xd66db0,5|1|0xd66db0", 80, 11, 69, 625, fh)
	if x ~= -1 then
		tap(x,y)
		toast("找到一颗心哦~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xd964ab, "5|0|0xd964ab,9|3|0xd964ab,3|4|0xd964ab", 80, 11, 69, 625, fh)
		if x ~= -1 then
			tap(x,y)
			toast("找到一颗心哟~")
		else
			x,y = findMultiColorInRegionFuzzy( 0xdc5ca8, "5|0|0xdc5ca8,9|1|0xdc5ca8,5|5|0xdc5ca8", 80, 11, 69, 625, fh)
			if x ~= -1 then
				tap(x,y)
				toast("找到一颗心呢~")
			end
		end
	end
end


function festival()
	x,y = findMultiColorInRegionFuzzy( 0xff6dbb, "-2|0|0xff58a7,8|-4|0xc24893,5|-1|0xff80cb",85,  87, 278, 634, fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xff77c4, "-4|2|0xff66b4,2|2|0xff80cb,5|5|0xff6fbb",85,  87, 278, 634, fh)
		if x ~= -1 then
			tap(x,y)
			toast("情人节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xff58a7, "5|1|0xcc4091,8|-1|0xff80cb,4|-4|0xff50a0",85, 87, 278, 634, fh)
			if x ~= -1 then
				tap(x,y)
				toast("情人节快乐哦~")
			end
		end
	end
	--[[x,y = findMultiColorInRegionFuzzy( 0xffffff, "-2|11|0xfdffff,3|15|0xfeffff,1|13|0xff647e",85,  87, 278, 634, fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("圣诞节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xff6d8a, "4|2|0xffffff,0|10|0xff617b,7|18|0xfcffff",85,  87, 278, 634, fh)
		if x ~= -1 then
			tap(x,y)
			toast("圣诞节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xff6d8a, "0|10|0xff617b,4|15|0xff6984,-10|8|0x4cd2b9",85, 87, 278, 634, fh)
			if x ~= -1 then
				tap(x,y)
				toast("圣诞节快乐哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0x44e0ff, "0|2|0x44e0ff,-1|4|0x44e0ff,5|6|0x44e0ff",85,  87, 278, 634, fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("糖果 +1 呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xd754a1, "-4|-11|0x74f5ff,16|8|0x71f6ff,6|-4|0x44e0ff,6|-1|0x44e0ff",85,  87, 278, 634, fh)
		if x ~= -1 then
			tap(x,y)
			toast("糖果 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0x71f6ff, "-19|-19|0x74f5ff,-11|-10|0x44e0ff,-9|-12|0x44e0ff",85, 87, 278, 634, fh)
			if x ~= -1 then
				tap(x,y)
				toast("糖果 +1 哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0xf76261, "-11|7|0xfc8b69,2|4|0xf55b60,-4|8|0xfc8469",85,  87, 278, 634, fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("枫叶 +1 呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfd9067, "2|0|0xfd8c66,3|0|0xfd8a66,5|0|0xfd8667",85,  87, 278, 634, fh)
		if x ~= -1 then
			tap(x,y)
			toast("枫叶 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xfc8c69, "3|0|0xfc8a69,8|2|0xfc8569",85, 87, 278, 634, fh)
			if x ~= -1 then
				tap(x,y)
				toast("枫叶 +1 哦~")
			end
		end
	end
x,y = findMultiColorInRegionFuzzy( 0xea768d, "-4|4|0xfeffff,-7|6|0xffffff,-10|8|0xffffff,-4|12|0xfff8ff,-3|9|0xffffff,4|6|0xfdffff", 85, 87, 278, 634, 566)--周年庆
	if x ~= -1 then
		tap(x,y)
		toast("生日快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "2|-2|0xffffff,5|-3|0xffffff,6|-2|0xffffff,4|-1|0xffffff,8|-7|0xff5b8a,4|4|0xffe2ff", 85, 87, 278, 634, 566)
		if x ~= -1 then
			tap(x,y)
			toast("生日快乐(*@ο@*) 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xffffff, "2|-2|0xffffff,5|-4|0xffffff,8|-7|0xff589b,5|3|0xffdaff",85,87, 278, 634, 566)
			if x ~= -1 then
				tap(x,y)
				toast("生日快乐哦~")
			end
		end
	end
x,y = findMultiColorInRegionFuzzy(0xffffff, "3|3|0xffffff,2|6|0xffffff,12|-1|0xffffff,9|2|0xffffff,9|6|0xffffff",99, 87, 62, 634, 566)--春天蝴蝶
	if x ~= -1 then
		tap(x,y)
		toast("春天在哪里呀？")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "4|4|0xffffff,3|6|0xffffff,13|1|0xffffff,10|5|0xffffff,12|8|0xffffff",99, 87, 62, 634, 566)
		if x ~= -1 then
			tap(x,y)
			toast("春天在哪里呢？")
		else
			x,y = findMultiColorInRegionFuzzy(0xffffff, "2|5|0xffffff,10|0|0xffffff,9|3|0xffffff,9|6|0xffffff",99,87, 62, 634, 566)
			if x ~= -1 then
				tap(x,y)
				toast("春天在这里哦~")
			end
		end
	end
x,y = findMultiColorInRegionFuzzy( 0x6f4a6b, "3|3|0x70496a,7|-13|0xf4ebe9,9|-12|0xf5ece9,4|3|0x70486a", 90, 3, 62, 634, 855)--情人节巧克力
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐哦~")
	else
		x,y = findMultiColorInRegionFuzzy( 0x6f496b, "3|2|0x70486a,5|3|0x6f486b,6|-14|0xf4ebe9,7|-13|0xf5ece9", 90, 58, 71, 610, 568)
		if x ~= -1 then
			tap(x,y)
			toast("情人节快乐哟~")
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0x32adff, "16|16|0x2faeff,6|9|0x3dabff", 90, 3, 62, 634, 855)--万圣节糖果
	if x ~= -1 then
		tap(x,y)
		toast("万圣节快乐")
	end
	x,y = findMultiColorInRegionFuzzy( 0x3ec6ab, "-2|0|0x40c7ac,5|-6|0xffffff,11|-5|0xffffff", 80, 58, 71, 610, 568)
	if x ~= -1 then
		tap(x,y)
		toast("圣诞节快乐~")
	else
		x,y = findMultiColorInRegionFuzzy( 0x33d8ac, "-1|-1|0x32d8ad,5|-5|0xf4ffff,5|0|0xf1ffff", 80, 58, 71, 610, 568)
		if x ~= -1 then
			tap(x,y)
			toast("圣诞节快乐~")
		else
			x,y = findMultiColorInRegionFuzzy( 0x65bbc6, "5|-5|0xffffff,9|3|0xfffbff,1|3|0x68d1c8",80, 58, 71, 610, 568)
			if x ~= -1 then
				tap(x,y)
				toast("圣诞节快乐~")
			end
		end
	end]]
end

function expand()
	if multiColor({{   34,  605, 0xbe516a},{   38,  608, 0xbe516a},{   29,  637, 0xbe516a},{   38,  644, 0xffffff},{  134,  637, 0xbe516a},}) == false then--左上角区域红心白手套
		tap(584, 1090)
		if multiColor({
				{  302, 1071, 0xffffff},
				{  323, 1070, 0xffffff},
				{  322, 1090, 0xffffff},
				{  302, 1091, 0xffffff},
				}) == false then--扩张未开
			tap(310, 1079)
		end
	end
end

function stonemove()
	if multiColor({{   63, 1069, 0xffffff},{   54, 1085, 0xffffff},{   70, 1086, 0xffffff}}) == false then--石头未开
		tap(54, 1085)
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "0|5|0xffffff,8|0|0xffffff,8|9|0xffffff", 90, 287, 700, 343, 729)--技能
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function menu()
	if multiColor({{   34,  605, 0xbe516a},{   38,  608, 0xbe516a},{   29,  637, 0xbe516a},{   38,  644, 0xffffff},{  134,  637, 0xbe516a},}) == false then--左上角区域红心白手套
		tap(584, 1090)
	else
		stonemove()
	end
end

function shutmenu()
	if multiColor({{   34,  605, 0xbe516a},{   38,  608, 0xbe516a},{   29,  637, 0xbe516a},{   38,  644, 0xffffff},{  134,  637, 0xbe516a},}) == true then
		tap(574, 1082)
	end
end

function farmmove()
	if multiColor({{  146, 1093, 0xffffff},{  146, 1085, 0xffffff},{  150, 1072, 0xffffff}}) == false then--珊瑚未开
		tap(146, 1085)
	else
		x,y = findMultiColorInRegionFuzzy( 0x1c2935, "15|-24|0x1c2935,39|-10|0x1c2935,59|13|0x1c2935,29|-3|0xffffff,54|24|0xffffff", 90, 24, 705, 105, 796)--海带农场
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function farm()
	x,y = findMultiColorInRegionFuzzy( 0x2b267c, "5|8|0x341f89,-3|6|0x2d237e", 90, 42, 190, 66, 212)--半屏海胆
	if x ~= -1 then
		tap(x,263)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x5ab866, "-5|5|0x58b96a,-10|10|0x55bc72,-6|13|0x45a37f,-1|9|0x419f7a,4|4|0x3b976b", 90, 92, 140, 142, 189)--半屏海带
	if x ~= -1 then
		tap(x,216)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae6e9, "3|-1|0xdae6e9,7|-2|0xdae6e9,9|2|0xfafffd,6|4|0xfafffd,3|5|0xfafffd,1|7|0xfafffd,7|10|0xdae6e9,9|8|0xdae6e9,11|7|0xdae6e9", 90, 498, 156, 545, 203)--半瓶贝壳
	if x ~= -1 then
		tap(x,244)
		mSleep(500)
		toast("收割贝壳~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x2e2885, "5|5|0x31208e,3|8|0x341f92", 90, 53, 414, 77, 436)--全屏海胆
	if x ~= -1 then
		tap(x,487)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x5ab866, "-5|5|0x58b96a,-9|10|0x55bb71,-6|14|0x45a47f,-1|9|0x419f7a,4|4|0x3b976b", 90, 94, 142, 142, 187)--全屏海带
	if x ~= -1 then
		tap(x,439)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae6e9, "3|-1|0xdae6e9,1|6|0xfafffd,4|4|0xfafffd,7|3|0xfafffd,2|7|0xfafffd,7|11|0xdae6e9,9|9|0xdae6e9", 90, 500, 157, 544, 199)--全屏贝壳
	if x ~= -1 then
		tap(x,447)
		mSleep(500)
		toast("收割贝壳~")
	end


	--[[if multiColor({{   34,  605, 0xbe516a},{   38,  608, 0xbe516a},{   29,  637, 0xbe516a},{   38,  644, 0xffffff},{  134,  637, 0xbe516a},}) == false then--左上角区域红心白手套
	tap(584, 1090)
	nLog("菜单没打开")
else
	farmmove()
end
if multiColor({{  565,  579, 0xfaaf3f},{  602,  576, 0xfaaf40},}) == false then --农场未开
	multiColTap({{  596,  559, 0x3b933a},{  597,  569, 0x419a51},{  580,  583, 0xffa466},})--点击农场
else
	x,y = findMultiColorInRegionFuzzy( 0xb5dc43, "0|10|0xb7dd44,-1|44|0xb6dd44,-2|57|0xb5dd44", 99, 442, 700, 616, 1046)--查找收割绿色
	if x ~= -1 then
		tap(x,y)
		mSleep(1500)
		toast("完成收割！",1)
	end
end--]]
end

function stoneup()
	x,y = findMultiColorInRegionFuzzy( 0xfbae17, "63|1|0xfbae17,-2|60|0xfbae17,63|59|0xfbae17", 90, 11, 695, 109, 1052)--获取升级奖励
	if x ~= -1 then
		tap(x,y)
	end
	multiColTap({
			{   28,  896, 0x223042},
			{   61,  910, 0xe7e8ef},
			{  465,  936, 0x0099bc},
			{  529,  957, 0x0099bc},
		})--升级珊瑚石（蓝色）
	multiColTap({
			{   28,  896, 0x223042},
			{   61,  910, 0xe7e8ef},
			{  465,  936, 0xe8972d},
			{  529,  957, 0xe8972d},
		})--升级珊瑚石（黄色）
	multiColTap({
			{  279,  365, 0xffae00},
			{  289,  365, 0xffae00},
			{  288,  373, 0xffae00},
			{  301,  373, 0xffae00},
			{  311,  684, 0xa6aab0},
		})--获得技能
end

function stoneskill()
	multiColTap({
			{   93,  782, 0xf9f9f9},
			{  109,  781, 0xf9f9f9},
			{  122,  779, 0xf9f9f9},
			{  108,  829, 0xececec},
		})--火山爆发
	multiColTap({
			{  365,  825, 0x172e3f},
			{  413,  825, 0x172f3f},
			{  388,  826, 0xececec},
			{  359,  805, 0xececec},
		})--月之歌
	multiColTap({
			{  235,  774, 0xe9566e},
			{  243,  790, 0xe9566e},
			{  244,  778, 0xe9566e},
			{  249,  828, 0xececec},
		})--海鲜大餐
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