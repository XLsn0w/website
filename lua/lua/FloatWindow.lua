require "import"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "android.graphics.*"

layout={
    TextView,
    id="tv",
    textSize=20,
    text="AndroLua+",
    backgroundColor="#88888888",
    onClick="click"
    }

function click(v)
    --lp.x=100
   -- wm.updateViewLayout(tv,lp)
    wm.removeView(v)
    print("已移除悬浮窗")
    end


wm=activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
lp=WindowManager.LayoutParams()
lp.format = PixelFormat.RGBA_8888
lp.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
lp.type=WindowManager.LayoutParams.TYPE_PHONE
lp.width=WindowManager.LayoutParams.WRAP_CONTENT
lp.height=WindowManager.LayoutParams.WRAP_CONTENT
wm.addView(loadlayout(layout),lp)

