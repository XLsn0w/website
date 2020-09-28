require "TSLib"

--glSettings({switch = "0000", x1 = 100, y1 = 100, x2 = 400, y2 = 150,tsp_switch = false})
--1 nLog
nLog("[DATE] 1 - 实时显示调试日志")
--2 fwShowTextView
fwShowWnd("wid",200,200,800,400,1);
fwShowTextView("wid","textid","2 - 文本视图","center","FFffff","000000",15,0,0,0,300,100,0.5);
mSleep(3000)
--3 toast
toast("3 - 固定位置显示")
--4 wLog
initLog("test", 1);                
wLog("test","[DATE] 4 - 本地日志"); 
mSleep(1000)


