require "import"
import "http"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
url="http://www.xingbo4.link/pcqfhj-63-1.aspx"

function showList(str)
    local regex="<a href=\"([^\'\"]+)\" target=\"_blank\"><span>%d*%-%d*</span>([^><]+)</a>"
    ns={}
    ls={}
    for u,n in str:gmatch(regex) do
        n=n:gsub("棒棒冰%-","")
        ls[n]=u
        table.insert(ns,n)
        end
    local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(ns))
    listview.setAdapter(adapter)
    end

listview=ListView(activity)

listview.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
         task(getHtml,base..ls[v.getText()],showBmp)
        end
    })

activity.setContentView(listview)

W=activity.getWindowManager().getDefaultDisplay().getWidth();

layout={
    LinearLayout,
    layout_width="fill",
    {
        ScrollView,
        layout_width="fill",
        {
            LinearLayout,
            layout_width="fill",
            orientation=1,
            id="list"
            }
        }
    }

dlg=Dialog(activity,android.R.style.Theme_Holo_Light_NoActionBar)
dlg.setContentView(loadlayout(layout))
list.removeAllViews()

base="http://www.xingbo4.link"
getHtml=[[
local http=require "http"
url=...
str=http.get(url)
return str
]]

getBmp=[[
require "import"
url=...
bmp=loadbitmap(url)
return bmp
]]

showBmp=function(str)
    list.removeAllViews()
    dlg.show()
    local regex="<img data%-original=\"([^\'\"]+)\""
    for s in str:gmatch(regex) do
        local img=ImageView(activity)
        list.addView(img)
        task(
        getBmp,
        s,
        function(bmp)
            if bmp then
                img.setImageBitmap(bmp)
                img.setLayoutParams(LinearLayout.LayoutParams(W,W*bmp.getHeight()/bmp.getWidth()))
                end
            end
        )
        end
    end
task(getHtml,url,showList)


