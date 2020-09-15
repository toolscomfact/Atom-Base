// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function httpasync_log(log){
	show_debug_message("[httpasync] " + log);
}

function httpasync_init(){
	if (!instance_exists(libHttpHandleObj)){
		instance_create_depth(0, 0, -1, libHttpHandleObj);
	}
}

function httpasync_request_async(http_url, http_method, body, callback){
	with (libHttpHandleObj){
		var header_map = ds_map_create();
		ds_map_add(header_map, "Authorization","Basic YWRtaW46M2ZtUmY4YndVeGQ1MkdlcENtV0V3RFFK");
		ds_map_add(header_map, "Content-Type", "application/json");
		ds_map_add(header_map, "Content-Length", string_length(body));
		ds_map_add(header_map, "Accept", "*/*");

		var use_index = http_request(http_url, http_method, header_map, body);
		ds_map_destroy(header_map);

		callMap[? use_index] = {
			http_url : http_url,
			http_method : http_method,
			body : body,
			
			callback_method : callback,
			retry : 0
		};
		

		return use_index;
	}
}

function httpasync_get_file_async(http_url, dest, callback){
	with (libHttpHandleObj){
		
		var use_index = http_get_file(http_url, dest);
		
		callMap[? use_index] = {
			http_url : http_url,
			http_method : "FILE",
			http_dest : dest,
			
			callback_method : callback,
			retry : 0
		}
	}
}/**/