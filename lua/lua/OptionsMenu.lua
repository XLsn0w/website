require "import"
import "com.androlua.*"
import "android.app.*"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
activity.setTheme(android.R.style.Theme_Holo_Light)
items={"运行","撤销","重做","打开","保存","新建", "格式化","查错","编译","打包","帮助","手册",["新建"]={"新建文件","新建文件夹","新建工程","打开示例"}}
function onCreateOptionsMenu(menu)
    for k,v in ipairs(items) do
        if items[v] then
            local m=menu.addSubMenu(v)
            for k,v in ipairs(items[v]) do
                m.add(v)
                end
            else
            local m=menu.add(v)
            m.setShowAsActionFlags(1)
            end
        end
    end

function onMenuItemSelected(id,item)
    if func[item.getTitle()] then
        func[item.getTitle()]()
        else
        print(item,"功能开发中。。。")
        end
    end

func={}
func["撤销"]=function()
    editor.undo()
    end

func["重做"]=function()
    editor.redo()
    end
editor=LuaEditor(activity)
activity.setContentView(editor)
