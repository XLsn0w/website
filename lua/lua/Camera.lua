require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.hardware.Camera"
import "android.graphics.*"
import "java.io.*"
import "android.content.*"
import "android.text.format.DateFormat"

activity.setTitle('AndroLua')
function save(data)
    require "import"
    import "android.graphics.*"
    import "java.io.*"
    import "android.content.*"
    import "android.text.format.DateFormat"
    --用BitmapFactory.decodeByteArray()方法可以把相机传回的裸数据转换成Bitmap对象
    mBitmap = BitmapFactory.decodeByteArray(data, 0, #data);
    --接下来的工作就是把Bitmap保存成一个存储卡中的文件
    file = File("/sdcard/androlua/IMG_" .. DateFormat().format("yyyyMMdd_hhmmss", Calendar.getInstance(Locale.CHINA)) .. ".jpg");
    file.createNewFile();
    os = BufferedOutputStream(FileOutputStream(file));
    mBitmap.compress(Bitmap.CompressFormat.JPEG, 100, os);
    os.flush();
    os.close();
    return tostring(file)
    end

pictureCallback = Camera.PictureCallback
{
    onPictureTaken=function(data,  camera)
        Toast.makeText(activity, "正在保存……", Toast.LENGTH_LONG).show();
        task(save,data,function(file)
            Toast.makeText(activity, "图片保存完毕，"..tostring(file), Toast.LENGTH_LONG).show();
            end)
        mCamera.startPreview();
        end
    }
autoFocus=Camera.AutoFocusCallback{
    onAutoFocus=function( success, camera)
        --success为true表示对焦成功
        if (success) then
            if (camera ~= nil) then
                --停止预览
                --camera.stopPreview();
                -- 拍照
                camera.takePicture(nil, nil, pictureCallback);
                end
            end
        end
    }

sureface = SurfaceView(activity);
callback=SurfaceHolder_Callback{
    surfaceChanged=function(holder,format,width,height)
        --开始预览
        parameters = mCamera.getParameters();
        --设置格式
        parameters.setPictureFormat(PixelFormat.JPEG);
        --设置预览大小，这里我的测试机是Milsstone所以设置的是854x480
        parameters.setPreviewSize(640, 480);
        --设置自动对焦
        parameters.setFocusMode("auto");
        --设置图片保存时的分辨率大小
        --parameters.setPictureSize(1600, 1200);
        --给相机对象设置刚才设定的参数
        mCamera.setDisplayOrientation(90)
        mCamera.setParameters(parameters);
        mCamera.startPreview();
        end,
    surfaceCreated=function(holder)
        --当预览视图创建的时候开启相机
        mCamera = Camera.open();
        --设置预览
        mCamera.setPreviewDisplay(holder);
        end,
    surfaceDestroyed=function(holder)
        mCamera.stopPreview();
        --释放相机资源并置空
        mCamera.release();
        mCamera = null;
        end
    }
holder=sureface.getHolder()
holder.addCallback(callback)
holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
activity.setContentView(sureface)
function onKeyDown3()
    mCamera.takePicture(nil, nil, pictureCallback);
    end

local function shape_1()
    local GD_= "android.graphics.drawable.GradientDrawable"
    import(GD_ ) import(GD_ .. "_Orientation" )
    import "android.graphics.Color"
    import "android.R_attr" local C= Color()
    
    local colors= int { C.RED, C.GRAY, C.CYAN, }
    local gd= GradientDrawable()
    --GradientDrawable_Orientation.TOP_BOTTOM, colors )
    gd.setCornerRadius(60 )
    gd.setColor(C.parseColor("#88ffffff" ) )
    --gd.setOrientation(GradientDrawable_Orientation.TOP_BOTTOM )
    --gd.setColors(colors )
    --gd.setGradientType(1 )
    return gd
    end

bg=shape_1()
layout={
    Button,
    id="tv",
    textSize=20,
    text="确定",
    background="bg",
    onClick="click"
    }

function click(v)
    mCamera.autoFocus(autoFocus)
    
    --mCamera.takePicture(nil, nil, pictureCallback);
    end


wm=activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
lp=WindowManager.LayoutParams()
lp.format = PixelFormat.RGBA_8888
lp.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
lp.type=WindowManager.LayoutParams.TYPE_PHONE
lp.width=WindowManager.LayoutParams.WRAP_CONTENT
lp.height=WindowManager.LayoutParams.WRAP_CONTENT
lp.gravity=Gravity.BOTTOM|Gravity.CENTER
lp.y=50
vv=loadlayout(layout)
--wm.addView(vv,lp)

function onResume()
    wm.addView(vv,lp)
    end
function onPause()
    wm.removeView(vv)
    end

lasttime=0
function onKeyDown(code,event)
    local now=os.time()
    if (code== KeyEvent.KEYCODE_BACK)then
        if now-lasttime>1 then
            Toast.makeText(activity,"再按一次退出",1000).show()
            lasttime=now
            return true
            else
            --os.exit()
            return false
            end
        end
    end

