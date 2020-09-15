// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function uiInit(){
	if (!instance_exists(libUiObj)){
		instance_create_depth(0, 0, -1, libUiObj);
	}
}

function uiCreate(){
	with (libUiObj){
		ds_list_add(ui_list, other.id);
	}
	
	director_speed = 3;
	director_step = 0;
	director_status = 0;
	
	always_top = false;
}

function uiSetAlwaysTop(top){
	always_top = top;
}

function uiSetSpeed(spd){
	director_speed = spd;
}

function uiGet(){
	
	with (libUiObj){
		if (ds_list_size(ui_list) > 0){
			return ui_list[|ds_list_size(ui_list) - 1];
		}else{
			return noone;
		}
	}
}

function uiStep(){
	if (director_status == 0){
		director_step += (1 - director_step)/director_speed;
	}else{
		director_step += (0 - director_step)/director_speed;
	
		if (director_step < 0.01){
			instance_destroy();
		}
	}
}

function uiDestroy(){
	director_status = 1;
}

function uiGetStep(){
	return clamp(director_step, 0, 1);
}

function uiDone(){
	return (director_step > 0.99);
}

function uiDestroied(){
	return (director_status == 1) && (director_step <= 0.1);
}

function showMessage(text, callback){
	var ins = instance_create_depth(0, 0, -1, objUiMessageBox);
	ins.text = text;
	ins.text_font = font;
	ins.text_size = 24;
	if (!is_undefined(callback)){
		ins.onok = callback;
	}
	
	with (ins){
		event_user(0);
	}
}

function showQuestion(text, onyes, onno){
	var ins = instance_create_depth(0, 0, -1, objUiQuestionBox);
	ins.text = text;
	ins.text_font = font;
	ins.text_size = 24;
	if (!is_undefined(onyes)){
		ins.onok = onyes;
	}
	if (!is_undefined(onno)){
		ins.onno = onno;
	}
	
	with (ins){
		event_user(0);
	}
}

function showPanel(text){
	var ins = instance_create_depth(0, 0, -1, objUiMessage);
	ins.text = text;
	ins.text_font = font;
	ins.text_size = 24;
	
	with (ins){
		event_user(0);
	}
	
	return ins;
}

function drawNinepatch(sprite, xx, yy, _width, _height, pivotx, pivoty, _alpha, _color){
	/// @description  scr_draw_resizable_lite(sprite_index, x, y, width, height, pivot_x, pivot_y)
	/// @param sprite_index
	/// @param  x
	/// @param  y
	/// @param  width
	/// @param  height
	/// @param  pivot_x
	/// @param  pivot_y
	/// @param  alpha
	/// @param  color
	/*
	스프라이트, 드로우할 좌표, 너비, 정점(0~1)을 입력받습니다.
	스프라이트를 리사이즈 해서 그리므로 가볍습니다.
	*/

	// Set current sprite
	var __s = sprite; 
	var __tw = sprite_get_width(__s), __th = sprite_get_height(__s);

	// Set variables from arguments
	var width = floor(_width);
	var height = floor(_height);
	var pivot_x = abs(pivotx);
	var pivot_y = abs(pivoty);
	var alpha = abs(_alpha);
	var color = abs(_color);



	// Set double width and height
	var double_width = 2 * __tw;
	var double_height = 2 * __th;

	// Check for minimal width and height
	if ( width < double_width) width = double_width;
	if ( height < double_height) height = double_height;

	// Calculate side width and height
	var side_width = (width - double_width) / __tw;
	var side_height = (height - double_height) / __th;

	// Calculate offset for right and bottom sides
	var offset_right = width - __tw;
	var offset_bottom = height - __th;

	// Offset calculations
	xx = floor(xx - pivot_x * width);
	yy = floor(yy - pivot_y * height);

	// 1 draw top left corner
	draw_sprite_ext(
	    __s, 0,
	    xx, yy,
		1, 1,
		0, color, alpha
	);

	// 2 draw top center side
	draw_sprite_ext(
	    __s, 1,
	    xx + __tw, yy,
	    side_width, 1,
	    0, color, alpha
	);

	// 3 draw top right corner
	draw_sprite_ext(
	    __s, 2,
	    xx + offset_right, yy,
		1, 1,
		0, color, alpha
	);

	// 4 draw middle left side
	draw_sprite_ext(
	    __s, 3,
	    xx, yy + __th,
	    1, side_height,
	    0, color, alpha
	);

	// 5 draw middle center core
	draw_sprite_ext(
	    __s, 4,
	    xx + __tw, yy + __th,
	    side_width, side_height,
	    0, color, alpha
	);

	// 6 draw middle right side
	draw_sprite_ext(
	    __s, 5,
	    xx + offset_right, yy + __th,
	    1, side_height,
	    0, color, alpha
	);

	// 7 draw bottom left corner
	draw_sprite_ext(
	    __s, 6,
	    xx, yy + offset_bottom,
		1, 1,
		0, color, alpha
	);

	// 8 draw bottom center side
	draw_sprite_ext(
	    __s, 7,
	    xx + __tw, yy + offset_bottom,
	    side_width, 1,
	    0, color, alpha
	);

	// 9 draw bottom right corner
	draw_sprite_ext(
	    __s, 8,
	    xx + offset_right, yy + offset_bottom,
		1, 1,
		0, color, alpha
	);

	draw_set_color(c_white);
	draw_set_alpha(1);
}

function drawPanel(xx, yy, width, height){
	drawNinepatch(sprUiMessageBoxNinepatch, xx, yy, width, height, 0.5, 0.5, 1, c_white);
}

function drawUnvisibleButton(x1, y1, x2, y2, onClick){
	for (var i=0; i<5; i++){
		if (device_mouse_check_button_released(i, mb_left)){
			var mx = device_mouse_x_to_gui(i);
			var my = device_mouse_y_to_gui(i);
			
			if (point_in_rectangle(mx, my, x1, y1, x2, y2)){
				if (uiGet() == id){
					onClick();
				}
			}
		}
	}
}

function drawButton(drawX, drawY, sprite, onClick){
	var pressed = false;
	var clicked = false;
		
	var x1 = drawX - sprite_get_xoffset(sprite);
	var y1 = drawY - sprite_get_yoffset(sprite);
	var x2 = x1 + sprite_get_width(sprite);
	var y2 = y1 + sprite_get_height(sprite);

	for (var i=0; i<5; i++){
		if (device_mouse_check_button(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				if (uiGet() == id){
					pressed = true;
				}
			}
		}
		
		if (device_mouse_check_button_released(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				if (uiGet() == id){
					clicked = true;
				}
			}
		}
	}
	
	if (clicked){
		onClick();
	}
	
	draw_sprite(sprite, pressed, drawX, drawY);	
}

function drawButtonShadow(drawX, drawY, sprite, onClick){
	var pressed = false;
	var clicked = false;
		
	var x1 = drawX - sprite_get_xoffset(sprite);
	var y1 = drawY - sprite_get_yoffset(sprite);
	var x2 = x1 + sprite_get_width(sprite);
	var y2 = y1 + sprite_get_height(sprite);

	for (var i=0; i<5; i++){
		if (device_mouse_check_button(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				pressed = true;
			}
		}
		
		if (device_mouse_check_button_released(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				clicked = true;
			}
		}
	}
	
	if (clicked){
		if (uiGet() == id){
			onClick();
		}
	}
	
	draw_sprite(sprite, 0, drawX, drawY);
	
	if (pressed && (uiGet() == id)){
		draw_sprite_ext(sprite, 0, drawX, drawY, 1, 1, 0, c_black, 0.7);
	}
}

function drawButtonScaleShadow(drawX, drawY, sprite, scale, onClick){
	var pressed = false;
	var clicked = false;
		
	var x1 = drawX - sprite_get_xoffset(sprite) * scale;
	var y1 = drawY - sprite_get_yoffset(sprite) * scale;
	var x2 = x1 + sprite_get_width(sprite) * scale;
	var y2 = y1 + sprite_get_height(sprite) * scale;

	for (var i=0; i<5; i++){
		if (device_mouse_check_button(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				pressed = true;
			}
		}
		
		if (device_mouse_check_button_released(i, mb_left)){
			if (point_in_rectangle(
				device_mouse_x_to_gui(i),
				device_mouse_y_to_gui(i),
				x1, y1, x2, y2
			)){
				clicked = true;
			}
		}
	}
	
	if (clicked){
		if (uiGet() == id){
			onClick();
		}
	}
	
	draw_sprite_ext(sprite, 0, drawX, drawY, scale, scale, 0, c_white, 1);
	
	if (pressed && (uiGet() == id)){
		draw_sprite_ext(sprite, 0, drawX, drawY, scale, scale, 0, c_black, 0.7);
	}
}


function clickZone(xx, yy, width, height, onClick, param){
	for (var i=0; i<5; i++){
		if (device_mouse_check_button_released(i, mb_left)){
			var mx = device_mouse_x_to_gui(i);
			var my = device_mouse_y_to_gui(i);
			
			if (point_in_rectangle(mx, my, xx - width/2, yy - height/2, xx + width/2, yy + height/2)){
				if (!is_undefined(onClick)){
					if (uiGet() == id){
						onClick(param);
					}
				}
			}
		}
	}
};

function drawText(drawX, drawY, text, _font, size, callback, param){
	draw_text_size(drawX, drawY, text, _font, size);
	
	var width_halign = 
		((draw_get_halign() == fa_left) * 0) + 
		((draw_get_halign() == fa_middle) * 0.5) + 
		((draw_get_halign() == fa_right) * 1);
	var height_valign = 
		((draw_get_valign() == fa_top) * 0) + 
		((draw_get_valign() == fa_center) * 0.5) + 
		((draw_get_valign() == fa_bottom) * 1);
	
	var _size = string_get_size(text, _font, size);

	var left_x = _size.width * width_halign;
	var top_y = _size.height * height_valign;
	
	for (var i=0; i<5; i++){
		if (device_mouse_check_button_released(i, mb_left)){
			var mx = device_mouse_x_to_gui(i);
			var my = device_mouse_y_to_gui(i);
			
			if (point_in_rectangle(mx, my, 
				drawX - left_x,
				drawY - top_y, 
				drawX - left_x + _size.width, 
				drawY - top_y + _size.height)){
				if (!is_undefined(callback)){
					if (uiGet() == id){
						callback(param);
					}
				}
			}
		}
	}
}
	
function screenChange(callback, param_){
	with (instance_create_depth(0, 0, 0, objScreenChanger)){
		target = callback;
		param = param_;
	}
}
	
function screenChangeV2(callback, param_){
	with (instance_create_depth(0, 0, 0, objScreenChanger)){
		target = callback;
		param = param_
	}
}