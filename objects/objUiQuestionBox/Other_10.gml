/// @description 길이 계산

text = string_enter_size(text, text_font, text_size, text_width_min-outline_margin*4);

var size = string_get_size(text, text_font, text_size);

width = text_width_min;
height = max(text_height_min, size.height+outline_margin*3+bottom_margin);

text_height = size.height;