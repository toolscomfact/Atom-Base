/// @description http 처리

var http_id = async_load[? "id"];

if (ds_map_exists(callMap, http_id)){
	var callData = callMap[? http_id];
	
	if (async_load[? "status"] == 0){
		ds_map_delete(callMap, http_id);
	
		callData.callback_method(async_load[?"result"]);
	}else if (async_load[? "status"] < 0){
		ds_map_delete(callMap, http_id);
		
		callData.retry ++;
		
		if (callData.retry <= MAX_REQUEST_COUNT){
			if (callData.http_method == "FILE"){
				var use_index = http_get_file(callData.http_url, callData.http_dest);
				
				callMap[? use_index] = callData;
			}else{
				var header_map = ds_map_create();
				ds_map_add(header_map, "Content-Type", "application/json");
				ds_map_add(header_map, "Content-Length", string_length(body));
				ds_map_add(header_map, "Accept", "*/*");

				var use_index = http_request(http_url, http_method, header_map, body);
				ds_map_destroy(header_map);
			
				callMap[? use_index] = callData;
			}
		}
	}
}else{
	httpasync_log("Invalid HTTP ID");
}

if (ds_map_exists(callFileMap, http_id)){
	
}