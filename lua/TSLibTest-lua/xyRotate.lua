require("TSLib")
w,h = getScreenSize()
dialog(w..","..h)
for var= 1, 4 do
x,y = xyRotate(100,100,var-1);
dialog(x..","..y)
end
