require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.R_*"
import "java.io.*"
import "android.R_*"
activity.setTheme(style.Theme_Holo_Wallpaper_NoTitleBar);

activity.setTitle('AndroLua')

function additem(scroll)
    function click(s)
        activity.newActivity(dir..s.getText())
        end
    local layout=LinearLayout(activity)
    layout.setOrientation(LinearLayout.VERTICAL)
    scroll.addView(layout)

    local param=LinearLayout_LayoutParams(-1,-2)
    local param2=LinearLayout_LayoutParams(-1,-1)

    local listener=View_OnClickListener {onClick = click}
    local n=0
    return function(t)
        n=n+1
        task([[
        require "import"
        import "android.app.*"
        import "android.os.*"
        import "android.widget.*"
        import "android.view.*"
        import "android.graphics.*"
        import "com.androlua.R_*"
        import "java.io.*"
        activity,n, param, param2 ,listener ,t=...
        local line=LinearLayout(activity)

        line.setLayoutParams(param)
        if n%2==0 then
            line.setBackgroundColor(Color.argb(64,255,255,255))
            end
        img=ImageView(activity)
        img.setImageResource(drawable.icon)
        line.addView(img)
        local text=TextView(activity)
        text.setLayoutParams(param2)
        text.setTextColor(Color.BLACK)
        text.setTextSize(20)
        text.setText(t)
        text.setX(20)
        text.setOnClickListener(listener)
        line.addView(text)
        return line
        ]],activity,n, param, param2 ,listener, t,function(line) layout.addView(line)end)
        end
    end

function list(dir)
    f=File(dir)
    l=f.list()
    for n=1,#l do
        local p= l[n-1]
        if p:find("%.lua$") then
            add(p)
            end
        end
    end

dir="/sdcard/AndroLua/"
scroll=ScrollView(activity)
add=additem(scroll)
activity.setContentView(scroll)
list(dir)