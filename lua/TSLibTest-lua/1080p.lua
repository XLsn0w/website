function daily()
	multiColTap({{  471,  818, 0xece2ed},{  647,  820, 0xece2ed},{  647,  755, 0x86cc4a},{  565, 1192, 0xffffff}})--离线奖励
	multiColTap({{  503, 1251, 0xff547b},{ 572, 1250, 0xff547b},{ 506, 1308, 0xff547b},{  567, 1304, 0xff547b}})--签到
	multiColTap({{ 1038, 1033, 0xd1e926},{ 1048, 1041, 0xd3ea26},{ 1071, 1016, 0xcce326},{  730, 1232, 0x7d7d85},{  754, 1220, 0x808188}})--发现隐藏的鱼C
	multiColTap({{  634, 1548, 0xffae00},{  647, 1548, 0xffae00},{  737, 1546, 0xffae00},{  737, 1552, 0xffae00},{  377, 1554, 0x66686a}})--关闭宝箱
end

function collect()
	x,y = findMultiColorInRegionFuzzy( 0xd965ab, "5|-1|0xd966ab,2|3|0xd964ab", 80, 6, 276, 1070, fh)--鱼红心泡泡
	if x ~= -1 then
		tap(x,y)
		toast("找到一颗心233")
	end
end

function festival()
	x,y = findMultiColorInRegionFuzzy( 0xff60b7, "1|-10|0xff70bf,4|4|0xff6cbd,21|-6|0xc03989", 85, 112, 269, 1061, fh)--2017 情人节活动
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xff5bae, "2|-2|0xff64ba,10|-6|0xff78ce,15|-4|0xfe8ada", 85, 112, 269, 1061, fh)
		if x ~= -1 then
			tap(x,y)
			toast("情人节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xc03889, "-1|2|0xc23c8b,-5|7|0xff87d7,-19|8|0xff61b8", 85,112, 269, 1061, fh)
			if x ~= -1 then
				tap(x,y)
				toast("情人节快乐哦~")
			end
		end
	end
	--[[x,y = findMultiColorInRegionFuzzy( 0xfeffff, "-5|-4|0xff608a,-10|-20|0xffffff,10|10|0xfefeff", 85, 112, 269, 1061, fh)--2017 圣诞节活动
	if x ~= -1 then
		tap(x,y)
		toast("圣诞节快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfeffff, "11|21|0xfeffff,15|2|0xffffff,21|31|0xfefeff,-10|12|0x51c6b8", 85, 112, 269, 1061, fh)
		if x ~= -1 then
			tap(x,y)
			toast("圣诞节快乐哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xff608a, "-17|-5|0x4ec9b7,-5|-17|0xffffff,5|4|0xfeffff", 85,112, 269, 1061, fh)
			if x ~= -1 then
				tap(x,y)
				toast("圣诞节快乐哦~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0x45e1ff, "-2|6|0x3fe1ff,-4|10|0x49dcff", 85, 112, 269, 1061, fh)--2017 万圣节活动
	if x ~= -1 then
		tap(x,y)
		toast("糖果 +1 啦~")
	else
		x,y = findMultiColorInRegionFuzzy( 0x6df2ff, "-4|0|0x6cf1ff,3|-2|0x6eefff,24|36|0x38bcff", 85, 112, 269, 1061, fh)
		if x ~= -1 then
			tap(x,y)
			toast("糖果 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0x38bcff, "-8|-28|0x45e0ff,-24|-36|0x6df2ff", 85,112, 269, 1061, fh)
			if x ~= -1 then
				tap(x,y)
				toast("糖果 +1 哦~")
			end
		end
	end--]]
--[[x,y = findMultiColorInRegionFuzzy( 0xee9187, "2|12|0xe2807d,4|10|0xe5827e,1|-2|0xef928a", 85, 112, 269, 1061, fh)--秋季活动
	if x ~= -1 then
		tap(x,y)
		toast("枫叶 +1 啦~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfa736e, "0|2|0xf8726d,4|13|0xf06666,-17|19|0xf9926a", 85, 112, 269, 1061, fh)
		if x ~= -1 then
			tap(x,y)
			toast("枫叶 +1 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xff8a49, "-1|9|0xff783a,-14|10|0xffb848,-8|15|0xffa446,-15|-2|0xff9837", 80,112, 269, 1061, fh)
			if x ~= -1 then
				tap(x,y)
				toast("枫叶 +1 哦~")
			end
		end--]]

--[[x,y = findMultiColorInRegionFuzzy( 0xee6890, "-5|5|0xffffff,-7|7|0xffffff,-11|11|0xffffff,-13|11|0xffffff,-7|10|0xffffff,-3|9|0xffffff,3|8|0xfff9ff", 85, 112, 269, 1061, 956)--周年庆
	if x ~= -1 then
		tap(x,y)
		toast("生日快乐呀~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "-3|3|0xffffff,-6|4|0xffffff,-6|5|0xffffff,1|4|0xffffff,4|3|0xffffff,1|13|0xffe0ff,-2|14|0xffe3ff", 85, 112, 269, 1061, 956)
		if x ~= -1 then
			tap(x,y)
			toast("生日快乐(*@ο@*) 哇～")
		else
			x,y = findMultiColorInRegionFuzzy( 0xffffff, "-1|2|0xffffff,-3|2|0xffffff,-6|5|0xffffff,5|3|0xffffff,-1|12|0xffe8ff,6|-6|0xed6a90",85,112, 269, 1061, 956)
			if x ~= -1 then
				tap(x,y)
				toast("生日快乐哦~")
			end
		end
	end--]]
--[[x,y = findMultiColorInRegionFuzzy( 0xffffff, "6|6|0xffffff,5|15|0xffffff,24|-1|0xffffff,17|4|0xffffff,18|15|0xffffff",99, 112, 269, 1061, 956)--春天的蝴蝶
	if x ~= -1 then
		tap(x,y)
		toast("春天在哪里呀？")
	else
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "9|7|0xffffff,6|18|0xffffff,28|2|0xffffff,21|8|0xffffff,23|18|0xffffff",99, 112, 269, 1061, 956)
		if x ~= -1 then
			tap(x,y)
			toast("春天在哪里呢？")
		else
			x,y = findMultiColorInRegionFuzzy( 0xffffff, "7|6|0xffffff,6|16|0xffffff,25|-1|0xffffff,20|5|0xffffff,20|15|0xffffff",99, 112, 269, 1061, 956)
			if x ~= -1 then
				tap(x,y)
				toast("春天在这里哦~")
			end
		end
	end--]]
--[[x,y = findMultiColorInRegionFuzzy( 0xf7e9ed, "3|0|0xf9eae6,2|2|0xf9eaeb,11|0|0xf8e9f0,-6|12|0xf9e4e6,16|15|0xf3e4ec,18|12|0xf3dbe3,-3|27|0x73456b",90, 18, 269, 1061, 926)--情人节巧克力
	if x ~= -1 then
		tap(x,y)
		toast("情人节快乐哦~")
	else
		x,y = findMultiColorInRegionFuzzy( 0xf8e6ed, "1|1|0xf9e9ef,2|0|0xfae8ea,4|4|0xf2e3e7,10|0|0xfae9ef,-4|13|0xf9dfe6,15|13|0xf5dfe6,-2|25|0x734369",90, 18, 269, 1061, 926)
		if x ~= -1 then
			tap(x,y)
			toast("情人节快乐哟~")
		else
			x,y = findMultiColorInRegionFuzzy( 0x75456e, "5|3|0x73446a,10|4|0x74446c,23|-18|0x946b89,8|-21|0xf8e8ee,10|-21|0xfaeaeb",90, 18, 269, 1061, 926)
			if x ~= -1 then
				tap(x,y)
				toast("情人节快乐哇~")
			end
		end
	end
	x,y = findMultiColorInRegionFuzzy( 0x47dfff, "26|27|0x3ad8ff,20|31|0x18b6ff,-5|4|0x19b0ff", 90, 18, 269, 1061, 926)--万圣节糖果
	if x ~= -1 then
		tap(x,y)
		toast("找到一颗糖")
	end
	x,y = findMultiColorInRegionFuzzy( 0x69bccc, "0|5|0x6fc8c9,8|-9|0xffffff,9|0|0xffebff", 80, 4, 159, 1070,  982)
	if x ~= -1 then
		tap(x,y)
		--toast("圣诞节快乐~")
	else
		x,y = findMultiColorInRegionFuzzy( 0x4cbeae, "2|4|0x59c7ab,10|-8|0xffffff,19|-8|0xfffdff", 80, 4, 159, 1070,  982)
		if x ~= -1 then
			tap(x,y)
			--toast("圣诞节快乐~")
		end
	end]]
end

function expand()
	if multiColor({
			{   33, 1020, 0xbe516a},
			{   48, 1019, 0xbe516a},
			{   43, 1027, 0xbe516a},
			{   49, 1087, 0xffffff},
			{  795, 1088, 0xffffff},
			}) == false then
		tap(989, 1844)
		if multiColor({
				{  509, 1809, 0xffffff},
				{  544, 1810, 0xffffff},
				{  544, 1842, 0xffffff},
				{  510, 1841, 0xffffff},
				}) == false then--扩张未开
			tap(544, 1842)
		end
	end
end

function stonemove()
	if multiColor({{   95, 1833, 0xffffff},{  106, 1807, 0xffffff},{  119, 1836, 0xffffff}}) == false then--石头未开
		tap(106, 1807)
		nLog("打开石头")
	else
		x,y = findMultiColorInRegionFuzzy( 0xfeffff, "0|8|0xffffff,14|-2|0xffffff,13|14|0xfeffff", 90, 497, 1188, 565, 1232)
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function menu()
	if multiColor({
			{   33, 1020, 0xbe516a},
			{   48, 1019, 0xbe516a},
			{   43, 1027, 0xbe516a},
			{   49, 1087, 0xffffff},
			{  795, 1088, 0xffffff},
			}) == false then
		tap(989, 1844)
	else
		stonemove()
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "2|5|0xffffff,-13|5|0x55bbbb,10|16|0x55bbbb", 90, 768, 1784, 870, 1901)--活动广告
		if x ~= -1 then
			tap(x,y)
		end
		if (isColor( 821, 1814, 0xffffff, 85) or 
			isColor( 823, 1830, 0xffffff, 85) or 
			isColor( 816, 1842, 0xffffff, 85) or 
			isColor( 793, 1832, 0xffffff, 85)) then
			if multiColor({
					{   16, 1188, 0xcc4466},
					{   55, 1187, 0xcc4466},
					{   16, 1231, 0xcc4466},
					}) == false--免费广告左上角标
			then
				moveTo(w/2,h-400,w/2,h-200,10)
			else
				x,y = findMultiColorInRegionFuzzy( 0x1095b4, "10|45|0x1095b4,84|-58|0x44ccdd,86|-29|0x44ccdd,-258|-21|0xffffff", 90, 694, 1180, 1079, 1344)--接收看广告
				if x ~= -1 then
					tap(x,y)
				end
				tadsstart = os.time()
				adtime = 1
				tadend = os.time()
				if tadend - tadsstart > 20 then
					adtime = 0
				end
			end
		end
	end
end

function shutmenu()
	if multiColor({
			{   33, 1020, 0xbe516a},
			{   48, 1019, 0xbe516a},
			{   43, 1027, 0xbe516a},
			{   49, 1087, 0xffffff},
			{  795, 1088, 0xffffff},
			}) == true then
		tap(973, 1833)
	end
end

function farmmove()
	if multiColor({{  248, 1845, 0xffffff},{  226, 1821, 0xffffff},{  247, 1833, 0xffffff},}) == false then--珊瑚未开
		tap(226, 1821)
	else
		x,y = findMultiColorInRegionFuzzy( 0x1c2935, "9|-12|0x1c2935,75|-24|0x1c2935,106|12|0x1c2935,71|10|0xffffff", 90, 31, 1188, 179, 1339)--海带农场
		if x == -1 then
			moveTo(w/2,h-400,w/2,h-200,10)
		end
	end
end

function farm()
	x,y = findMultiColorInRegionFuzzy( 0x2c2885, "0|10|0x30228c,4|18|0x30218d", 90, 91, 699, 130, 730)--半屏海胆
	if x ~= -1 then
		tap(x,398)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x5ab866, "-9|7|0x58b96a,-15|15|0x55bb71,-10|21|0x45a37e,-3|14|0x419f7a,6|5|0x3b976b", 90, 152, 238, 244, 321)--半屏海带
	if x ~= -1 then
		tap(x,360)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae6e8, "2|9|0xfafffd,7|7|0xfafffd,10|6|0xfafffd,5|11|0xfafffd,13|16|0xdae6e9", 90, 839, 264, 924, 339)--半屏贝壳
	if x ~= -1 then
		tap(x,398)
		mSleep(500)
		toast("收割贝壳~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x2c2885, "0|10|0x30228c,4|18|0x30218d", 90, 91, 699, 130, 730)--全屏海胆
	if x ~= -1 then
		tap(x,823)
		mSleep(500)
		toast("收割海胆~")
	end
	x,y = findMultiColorInRegionFuzzy( 0x55bb72, "8|-7|0x58b96b,16|-14|0x5bb867,22|-10|0x3b9769,14|-2|0x409e7a,7|5|0x44a280", 90, 177, 627, 251, 698)--全屏海带
	if x ~= -1 then
		tap(x,747)
		mSleep(500)
		toast("收割海带~")
	end
	x,y = findMultiColorInRegionFuzzy( 0xdae6e9, "-1|8|0xfafffd,5|8|0xfafffd,7|7|0xfafffd,0|12|0xfafffd,9|16|0xdae6e9", 90, 829, 643, 903, 715)--全屏贝壳
	if x ~= -1 then
		tap(x,773)
		mSleep(500)
		toast("收割贝壳~")
	end
	--[[if multiColor({{   58, 1026, 0xbe516a},{   66, 1025, 0xbe516a},{   49, 1077, 0xbe516a},{   65, 1089, 0xffffff},{  227, 1078, 0xbe516a},}) == false then
	tap(989, 1844)
else
	farmmove()
end
if multiColor({{  954,  978, 0xfaaf3f},{  990, 1016, 0xfaaf3f},{ 1016,  973, 0xfaaf3f},}) == false then --农场未开
	multiColTap({{ 1002, 1004, 0xfcfcfc},{ 1022,  992, 0xffffff},{  980,  989, 0xffa466},})--点击农场
else
	x,y = findMultiColorInRegionFuzzy( 0xb5dc43, "71|-2|0xb7de45,38|61|0xb6dd44", 99, 744, 1185, 1046, 1773)--查找收割绿色
	if x ~= -1 then
		tap(x,y)
		mSleep(1500)
		toast("完成收割！",1)
	end
end]]
end

function stoneup()
	x,y = findMultiColorInRegionFuzzy( 0xfbae17, "108|0|0xfbae17,-2|101|0xfbae17,111|101|0xfbae17", 90, 33, 1179, 174, 1774)--获取升级奖励
	if x ~= -1 then
		tap(x,y)
	end
	multiColTap({{93, 1538, 0xf7f1fe},{  802, 1577, 0x0099bc},{  831, 1588, 0xffffff},{  886, 1612, 0x0099bc}})--升级珊瑚石（蓝色）
	multiColTap({{93, 1538, 0xf7f1fe},{  802, 1577, 0xe8972d},{  886, 1612, 0xe8972d},{  831, 1588, 0xffffff}})--升级珊瑚石（黄色）
end


function stoneskill()
	multiColTap({
			{  155, 1322, 0xf9f9f9},
			{  180, 1322, 0xf9f9f9},
			{  208, 1322, 0xf9f9f9},
		})--火山爆发
	multiColTap({
			{  625, 1340, 0x2f7496},
			{  615, 1396, 0x172e3f},
			{  607, 1360, 0xececec},
		})--月之歌
	multiColTap({
			{  406, 1311, 0xe9566e},
			{  410, 1326, 0xe9566e},
			{  433, 1314, 0xdb4964},
		})--海鲜大餐
end