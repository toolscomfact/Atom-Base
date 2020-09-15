/// @description Insert description here
// You can write your code in this editor

var i = 0;

while(true){
	if (i >= ds_list_size(ui_list)){
		break;
	}
	
	if (!instance_exists(ui_list[|i])){
		with (ui_list[|i]){
			instance_destroy();
		}
		
		ds_list_delete(ui_list, i);
		i = -1;
	}else{
		var is_always_top = false;
		
		with (ui_list[|i]){
			depth = -100 - i;
			
			is_always_top = always_top;
		}
		
		if (is_always_top){
			if (i != ds_list_size(ui_list)-1){
				var inst = ui_list[|i];
				
				ds_list_delete(ui_list, i);
				ds_list_add(ui_list, inst);
			}
		}
	}
	
	i ++;
}