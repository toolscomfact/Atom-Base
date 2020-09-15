// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RoomGotoFade(roomTarget){
	var ins = instance_create_depth(0, 0, -1, libRoomFade);
	ins.room_target = roomTarget;
}