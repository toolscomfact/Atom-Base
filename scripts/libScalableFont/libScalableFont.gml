globalvar ScalableFont;

ScalableFont = function(fontName, fontOrigin) constructor{
	thisFontName = fontName;
	thisFontAsset = noone;
	thisFontOrigin = fontOrigin;
	
	static LoadFont = function (){
		font_texture_page_size = 2048;
		thisFontAsset = font_add(thisFontName, thisFontOrigin, true, false, $673A, $6A5F);
	}
}


function draw_text_size(xx, yy, str, _font, size){
	var originFont = draw_get_font();
		
	draw_set_font(_font.thisFontAsset);
	//draw_set_font(Font1);
	
	if (size == _font.thisFontOrigin){
		draw_text(xx, yy, str);
	}else{
		draw_text_transformed(xx, yy, str, size / _font.thisFontOrigin, size / _font.thisFontOrigin, 0);
	}
		
	draw_set_font(originFont);
}

function string_get_size(str, _font, size){
	var originFont = draw_get_font();
	draw_set_font(_font.thisFontAsset);
	
	var sizeRatio = size / _font.thisFontOrigin;
	var _width = string_width(str) * sizeRatio;
	var _height = string_height(str) * sizeRatio;
	
	draw_set_font(originFont);
	
	return {
		width : _width,
		height : _height
	};
}
	
function string_enter_size(str, _font, size, width){
	var originFont = draw_get_font();
	draw_set_font(_font.thisFontAsset);
	
	var sizeRatio = size / _font.thisFontOrigin;
	var strConvert = "";
	var strWidth = 0;
	
	for (var i=1; i<=string_length(str); i++){
		var char = string_char_at(str, i);
		var charWidth = string_width(char) * sizeRatio;
		
		if (char == "\n"){
			strWidth = 0;
		}else{
			if (strWidth + charWidth > width){
				strConvert += "\n";
				strWidth = 0;
			}
		}
		
		strWidth += charWidth;
		strConvert += char;
	}
	
	draw_set_font(originFont);
	
	return strConvert;
}