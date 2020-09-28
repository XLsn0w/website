require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.*"
layout={
    LinearLayout,
    orientation="vertical",
    {
        EditText,
        id="edit",
        layout_width="fill",
        background="draw"
        },
    {
        Button,
        text="按钮",
        layout_width="fill",
        onClick="click"
        }
    }

function click()
    Toast.makeText(activity, edit.getText().toString(), Toast.LENGTH_SHORT ).show()
    end

function draw(canvas,paint)
    local l=0
    paint.setTextSize(20)
    for n=edit.getPaddingTop(),1000,edit.getLineHeight() do
        canvas.drawText(tostring(l),1,n,paint)
        canvas.drawLine(1,n,1000,n,paint)
        l=l+1
        end
    end
activity.setContentView(loadlayout(layout))

