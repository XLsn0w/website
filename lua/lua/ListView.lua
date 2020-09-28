require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "com.androlua.*"

local f=File("/sdcard/AndroLua/IDE/")
local fs=f.listFiles()
Arrays.sort(fs)
local t={"../"}
for n=0,#fs-1 do
    if fs[n].isDirectory() then
        table.insert(t,fs[n].getName().."/")
        end
    end
for n=0,#fs-1 do
    local name=fs[n].getName()
    if fs[n].isFile() and name:find("lua$") then
        table.insert(t,name)
        end
    end

local listview=ListView(activity)
local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(t))

listview.setAdapter(adapter)

listview.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
        Toast.makeText(activity, mStrings[pos],
        Toast.LENGTH_SHORT).show();
        end
    })

activity.setContentView(listview)
