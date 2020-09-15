// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function date_from_unixtimestamp(unixtimestamp){
	return unixtimestamp / 24 / 60 / 60 + 25569;
}

function unixtimestamp_from_date(date){
	return (date-25569) * 60 * 60 * 24;
}

function paramed_function(func, param){
	var paramedObject = {
		param : param,
		origin : func,
		func : function(){
			origin(param);
		}
	}
	
	return paramedObject.func;
}

function array_include(array, element){
	for (var i=0; i<array_length(array); i++){
		if (array[i] == element){
			return true;
		}
	}
	
	return false;
}

function ds_map_clone(origin){
	return json_decode(json_encode(origin));
}
	
#region UI

function resolution_init(){
	#region 화면 크기 조정
	var base_w = 1080;
	var base_h = 1920;
	var aspect = base_w / base_h ; // get the GAME aspect ratio

	var var_width = 
	   display_get_width() * (os_type == os_android) +
	   room_width * (os_type == os_windows);
	var var_height = 
	   display_get_height() * (os_type == os_android) +
	   room_height * (os_type == os_windows);
	aspect = var_width / var_height;

	if (var_width < var_height){
	   //portrait
	   var ww = min(base_w, var_width);
	   var hh = ww / aspect;
	}else{
	   //landscape
	   var hh = min(base_h, var_height);
	   var ww = hh * aspect;
	}

	surface_resize(application_surface, ww, hh);
	display_set_gui_size(ww, hh);
	#endregion
}

#endregion