/// @description 드로우

uiStep();

var director = uiGetStep();

var GuiWidth = display_get_gui_width();
var GuiHeight = display_get_gui_height();

var text_y = GuiHeight/2;

draw_set_color(c_black);
draw_set_alpha(0.5 * director);

draw_rectangle(0, 0, GuiWidth, GuiHeight, false);

draw_set_color(c_white);

drawNinepatch(sprUiMessageBoxNinepatch, GuiWidth/2, GuiHeight/2, width * director, height * director, 0.5, 0.5, 1, c_white);

if (uiDone()){

	draw_set_valign(fa_center);
	draw_set_halign(fa_middle);

	draw_text_size(GuiWidth/2, text_y , text, text_font, text_size);

}