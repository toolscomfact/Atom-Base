// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
globalvar Promise, Waterfall;

Promise = function() constructor{
	
	ReturnStruct =  {
		_method_callstack : 0,
		_methods : ds_list_create(),
		_method_catch : 0,
		ReturnStruct : -1,
		
		TNCallback : function(){
			show_debug_message("[WARNING!] There is no more methods!");
		},
		
		Callback : function(param){
			_method_callstack ++;
						
			var nextMethod = noone;
			if (_method_callstack < ds_list_size(_methods)){
				nextMethod = _methods[| _method_callstack];
			}else{
				TNCallback();
			}
						
			if (nextMethod != noone){
				nextMethod(Callback, param);
			}
		},
		
		Then : function (_method){
			ds_list_add(_methods, _method);
		
			return ReturnStruct;
		},
		Catch : function (_catch){
			_method_catch = _catch;
			
			return ReturnStruct;
		},
		Go : function (){
			var nowMethod = _methods[|_method_callstack];

			if (_method_catch != 0){
				try{
					nowMethod(Callback);
				}catch (except){
					_method_catch(except);
				}
			}else{
				nowMethod(Callback);
			}
		}
	};
	
	ReturnStruct.ReturnStruct = ReturnStruct;
	Then = ReturnStruct.Then;
}

Waterfall = function(methods) constructor {
	struct = {
		_methods : methods,
		
		callback_done : 0,
		callback_count : array_length(methods),
		complete : noone,
		struct : noone,
		
		Then : function(_method){
			complete = _method;	
			
			return struct;
		},
		
		Go : function(){
			for (var i=0; i<array_length(_methods); i++){
				_method = _methods[i];
				_method(
					function(){
						callback_done ++;
						
						if (callback_done >= callback_count){
							complete();
						}
					}
				);
			}
		}
	}
	
	struct.struct = struct;
	Then = struct.Then;
	Go = struct.Go;
}