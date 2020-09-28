require "import"
require "http"
import "android.widget.*"
import "android.view.*"
import "android.text.*"
import "android.text.method.*"
activity.setTitle('百度贴吧')
activity.setTheme(android.R.style.Theme_Holo_Light)

local pd=nil
function login(username,password,data,code)
    local str,cookie
    local uri='http://wappass.baidu.com/passport/login'
    if data==nil then
        str,cookie=http. get('http://wappass.baidu.com/passport/?login&bd_page_type=0&tpl=tb')
        data={}
        for n,v in str:gmatch('name=\"([^\"]+)\" *value=\"([%w%._%%]+)\"') do
            table.insert(data,n..'='..v)
            end
        end
    table.insert(data,'username='..username)
    table.insert(data,'password='..password)
    if code then
        table.insert(data,'verifycode='..code)
        end
    local postdata=table.concat(data,'&')
    str,cookie,c,h=http.post(uri,postdata,cookie)
    
    local _,start,code=str:find('验证码：<img src=\"([^\"]+)\"')
    if code then
        data={}
        for n,v in str:gmatch('name=\"([^\"]+)\" *value=\"([%w%._%%]+)\"') do
            table.insert(data,n..'='..v)
            end
        return nil,data,code
        end
    return cookie
    end

layout={
    login={
        LinearLayout,
        orientation=1,
        paddingLeft=20,
        {
            TextView,
            text="用户名"
            },
        {
            EditText,
            id="username",
            text="",
            layout_width="fill",
            singleLine=true,
            },
        {
            TextView,
            text="密码"
            },
        {
            EditText,
            id="password",
            text="",
            layout_width="fill",
            singleLine=true,
            },
        {
            TextView,
            text="验证码"
            },
        {
            ImageView,
            id="vfimg",
            },
        {
            EditText,
            id="vfcode",
            layout_width="fill",
            singleLine=true,
            },
        {
            Button,
            text="确定",
            layout_width="fill",
            onClick="click"
            },
        {
            TextView,
            id="status"
            }
        }
    }
function click()
    local un=username.getText().toString()
    local pw=password.getText().toString()
    local vf=vfcode.getText().toString()
    if #vf<1 then
        vf=nil
        end
    cookie,pd,code=login(un,pw,pd,vf)
    if code then
        task([[require "import" return loadbitmap(...)]],code,
        function(bmp)
            vfimg.setImageBitmap(bmp)
            vfimg.setLayoutParams(LinearLayout.LayoutParams(bmp.getWidth()*4,bmp.getHeight()*4))
            end)
        else
        print(cookie)
        end
    end

activity.setContentView(loadlayout(layout.login))
password.setInputType(InputType.TYPE_TEXT_VARIATION_PASSWORD);
password.setTransformationMethod(PasswordTransformationMethod.getInstance());
