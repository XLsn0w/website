require "import"
import "com.androlua.*"
import "android.text.*"
import "android.widget.*"
import "android.app.*"
import "android.view.*"
local W=activity.getWindowManager().getDefaultDisplay().getWidth()
offset=0
activity.setTheme(android.R.style.Theme_Holo_Light)
local layout=FrameLayout(activity)

linear=LinearLayout(activity)
editor=EditText(activity)
editor.setGravity(0)

layout.addView(editor)
list=ListView(activity)
list.setVisibility(View.GONE)

linear.addView(list,LinearLayout.LayoutParams(W/2,-2))
layout.addView(linear)
list.setX(W/4)
list.setBackgroundColor(0xcccccc-0x1000000)
list.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
        editor.getText().insert(editor.getSelectionEnd(),v.getText():sub(offset+1))
        list.setVisibility(View.GONE)
        end
    })

function show(s,t)
    if type(s)=="string" and type(t)=="table" then
        local buf={}
        offset=#s
        for k in pairs(t) do
            if k:find("^"..s) then
                table.insert(buf,k)
                end
            end
        if #buf > 0 then
            local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(buf))
            list.setAdapter(adapter)
            local layout=editor.getLayout();
            local SelectionLine=layout.getLineForOffset(editor.getSelectionEnd());
            local selectionLineBottom = layout.getLineBottom(SelectionLine);
            local top=selectionLineBottom - editor.getScrollY();
            if top > editor.getHeight() / 2 then
                top = top - list.getMeasuredHeight() - editor.getLineHeight();
                end
            list.setY(top)
            list.setVisibility(View.VISIBLE)
            else
            list.setVisibility(View.GONE)
            end
        end
    end

editor.addTextChangedListener(TextWatcher
{
    onTextChanged=function(s, start, before, count)
        local e=start + count
        s=s.subSequence(0, e).toString()
        local p,d,s=s:match("(%w+)(%.?)(%w*)$")
        if p==nil then
            list.setVisibility(View.GONE)
            return
            end
        
        if type(_G[p])=="table" and #d==1 then
            show(s,_G[p])
            elseif #p>0 and #s==0 and #d==0 then
            show(p,_G)
            else
            list.setVisibility(View.GONE)
            end
        end
    })
activity.setContentView(layout)
