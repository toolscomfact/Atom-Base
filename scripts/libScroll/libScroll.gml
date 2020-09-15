// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrollInit(){
	scroll_x = 0;
	scroll_y = 0;
	scroll_hspeed = 0;
	scroll_vspeed = 0;
	
	scroll_click_pressed = false;
	scroll_click_deviceid = 0;
	
	scroll_click_x = 0;
	scroll_click_y = 0;

	scroll_range_x1 = 0;
	scroll_range_y1 = 0;
	scroll_range_x2 = 0;
	scroll_range_y2 = 0;
	
	scroll_width = 0;
	scroll_height = 0;
	
	scroll_first_x = 0;
	scroll_first_y = 0;
	
	scroll_enable = false;
}

function scrollSetRange(x1, y1, x2, y2){
	scroll_range_x1 = x1;
	scroll_range_y1 = y1;
	scroll_range_x2 = x2;
	scroll_range_y2 = y2;
}

function scrollSetSize(width, height){
	scroll_width = width;
	scroll_height = height;
}

function scrollStep(){
	for (var i=0; i<5; i++){
		if (device_mouse_check_button_pressed(i, mb_left)){
			if (!scroll_click_pressed){
				var guix = device_mouse_x_to_gui(i);
				var guiy = device_mouse_y_to_gui(i);
				
				if (point_in_rectangle(guix, guiy, scroll_range_x1, scroll_range_y1, scroll_range_x2, scroll_range_y2)){
					scroll_click_pressed = true;
					scroll_click_deviceid = i;
			
					scroll_click_x = device_mouse_x_to_gui(i);
					scroll_click_y = device_mouse_y_to_gui(i);
					
					scroll_first_x = scroll_click_x;
					scroll_first_y = scroll_click_y;
					
					scroll_enable = false;
				}
			}
		}
	}

	if (scroll_click_pressed){
		var xdiff = device_mouse_x_to_gui(scroll_click_deviceid) - scroll_click_x;
		var ydiff = device_mouse_y_to_gui(scroll_click_deviceid) - scroll_click_y;
		scroll_click_x = device_mouse_x_to_gui(scroll_click_deviceid);
		scroll_click_y = device_mouse_y_to_gui(scroll_click_deviceid);
	
		scroll_hspeed = xdiff;
		scroll_vspeed = ydiff;
		
		if (abs(scroll_first_x - scroll_click_x) > 100 or abs(scroll_first_y - scroll_click_y) > 100){
			scroll_enable = true;
		}
	
		if (scroll_enable){
		#region Y
		var y_amount = 1;
		
		if (scroll_height != 0){
			if (scroll_y > 0 || scroll_y < -scroll_height){
				if (scroll_y < -scroll_height){
					y_amount = max(1, (-scroll_height - scroll_y)/3);
				}else{
					y_amount = max(1, scroll_y/3);
				}
			}
		}
		
		scroll_y += ydiff / (y_amount);
		
		if (scroll_height == 0){
			scroll_y = clamp(scroll_y, -scroll_height, 0);
		}
		#endregion

		#region X
		var x_amount = 1;
		
		if (scroll_width != 0){
			if (scroll_x > 0 || scroll_x < -width){
				if (scroll_x < -width){
					x_amount = (-width - scroll_x)/3;
				}else{
					x_amount = scroll_x/3;
				}
			}
		}
		
		scroll_x += xdiff / (x_amount);
		
		if (scroll_width == 0){
			scroll_x = clamp(scroll_x, -scroll_width, 0);
		}
		#endregion
		}
		
		if (device_mouse_check_button_released(scroll_click_deviceid, mb_left)){
			scroll_click_pressed = false;
		}
	}else{
		scroll_hspeed /= 1.1;
		scroll_vspeed /= 1.1;
	}

	if (!scroll_click_pressed){
		//menu_y = clamp(menu_y, -goods_height - abs(menu_vspeed), abs(menu_vspeed));
		
		#region Y
		if (scroll_y > 0 || scroll_y < -scroll_height){
			var target = 0;
		
			if (scroll_y < -scroll_height){
				target = -scroll_height;
			}
		
			scroll_y += (target - scroll_y) / 8;
		}else{
			scroll_y += scroll_vspeed;
		}
		#endregion
		
		#region X
		if (scroll_x > 0 || scroll_x < -scroll_width){
			var target = 0;
		
			if (scroll_x < -scroll_width){
				target = -scroll_width;
			}
		
			scroll_x += (target - scroll_x) / 8;
		}else{
			scroll_x += scroll_hspeed;
		}
		#endregion
	}
}
	
function scrollIsUnmovoed(){
	return scroll_enable == false;
}
	
function scrollGetClicked(){
	return scroll_click_pressed;
}
	
function scrollGetX(){
	return scroll_x;
}

function scrollGetY(){
	return scroll_y;
}

function scrollSetY(yy){
	scroll_y = yy;
}