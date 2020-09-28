require "import"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "android.graphics.*"

layout={
    LinearLayout ,
    id="mylayout",
    Orientation=0,
    {
        TextView,
        id="mymove",
        textSize=20,
        text="移动",
        backgroundColor="#999999FF",
        },
    {
        TextView,
        id="mystop",
        textSize=20,
        textColor="#FFFFFFff",
        text="移除",
        backgroundColor="#999999FF",
        onClick="close"
        },
    {
        TextView,
        id="myexit",
        textSize=20,
        text="关闭",
        backgroundColor="#99999900",
        onClick="exit"
        },
    }

function exit()
    os.exit()--停止
    end

function close()
    wm.removeView(mylayout)--关闭悬浮窗
    -- os.exit()
    end


wm=activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
lp=WindowManager.LayoutParams()
lp.format = PixelFormat.RGBA_8888
lp.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
lp.type=WindowManager.LayoutParams.TYPE_PHONE
lp.width=WindowManager.LayoutParams.WRAP_CONTENT
lp.height=WindowManager.LayoutParams.WRAP_CONTENT
wm.addView(loadlayout(layout),lp )

lastX=0
lastY=0
vx=0
vy=0

obj=luajava.bindClass("com.android.internal.R$dimen")()
h=activity.getResources().getDimensionPixelSize( obj.status_bar_height )--获取状态栏高度

mymove.setOnTouchListener(View.OnTouchListener{onTouch=function(v,e)
        ry=e.getRawY()--获取触摸绝对Y位置
        rx=e.getRawX()--获取触摸绝对X位置
        if e.getAction() == MotionEvent.ACTION_DOWN then
            vy=ry-e.getY()--获取视图的Y位置
            vx=rx-e.getX()--获取视图的X位置
            lastY=ry--记录按下的Y位置
            lastX=rx--记录按下的X位置
            elseif e.getAction() == MotionEvent.ACTION_MOVE then
            lp.gravity=Gravity.LEFT|Gravity.TOP  --调整悬浮窗口至左上角
            lp.x=vx+(rx-lastX)--移动的相对位置
            lp.y=vy+(ry-lastY)-h--移动的相对位置
            wm.updateViewLayout(mylayout,lp)--调整悬浮窗至指定的位置
            end
        return true
        end})
