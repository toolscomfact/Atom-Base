/// @description Insert description here
// You can write your code in this editor

fade ++;

draw_set_alpha((-abs(fade - 7))/7+1);

draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(c_white);

if (fade == 7){
	room_goto(room_target);
}

if (fade == 14){
	instance_destroy();
}