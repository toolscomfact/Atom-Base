/// @description 드로우

uiStep();

var director = uiGetStep();

var GuiWidth = display_get_gui_width();
var GuiHeight = display_get_gui_height();

var text_y = GuiHeight/2+height/2-outline_margin*1.5-bottom_margin - (height-outline_margin*2-bottom_margin)/2;
var button_y = GuiHeight/2+height/2-outline_margin-bottom_margin/2;

draw_set_color(c_black);
draw_set_alpha(0.5 * director);

draw_rectangle(0, 0, GuiWidth, GuiHeight, false);

draw_set_color(c_white);

drawNinepatch(sprUiMessageBoxNinepatch, GuiWidth/2, GuiHeight/2, width * director, height * director, 0.5, 0.5, 1, c_white);

if (uiDone()){

	draw_set_valign(fa_center);
	draw_set_halign(fa_middle);

	draw_text_size(GuiWidth/2, text_y , text, text_font, text_size);

	drawButtonShadow(GuiWidth/2-150,button_y, sprUiButton, function(){
		doneparam = 0;
		
		if (uiGet() == id){
			uiDestroy();
		}
	});

	drawButtonShadow(GuiWidth/2+150,button_y, sprUiButton, function(){
		doneparam = 1;
		
		if (uiGet() == id){
			uiDestroy();
		}
	});

	draw_text_size(GuiWidth/2 - 150, button_y, "YES", text_font, 24);

	draw_text_size(GuiWidth/2 + 150, button_y, "NO", text_font, 24);
}

if (uiDestroied()){
	if (doneparam == 0){
		if (onok != noone){
			if (!done){
				done = true;
				onok();
			}
		}
	}else{
		if (onno != noone){
			if (!done){
				done = true;
				onno();
			}
		}
	}
}