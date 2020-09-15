/// @description Insert description here
// You can write your code in this editor

uiInit();

httpasync_init();

resolution_init(); // 화면 크기를 조정합니다.

/*

	화면의 가로크기 display_get_gui_width
	화면의 세로크기 display_get_gui_height

*/

// 폰트 로딩
new Promise()
.Then(
	function(callback) { // 폰트 가져오기 시작 
		if (file_exists("font.otf")){
			httpasync_log("Font File Exists.")
			callback();
		}else{
			httpasync_log("Start Download..");
	
			httpasync_get_file_async("https://mildtini.s3.ap-northeast-2.amazonaws.com/NotoSansCJKjp-Bold.otf", "font.otf", callback);
		}
	}
)
.Then(
	function(callback){ // 폰트 가져오기 성공
		globalvar font;
		
		font = new ScalableFont("font.otf", 32);
		font.LoadFont();
	
		font_load_done = true;
		httpasync_log("Font Load Done.");
		
		callback();
	}
)
.Then(
	function(callback){ // 로딩 끝
		show_debug_message("폰트 로딩 끝");
		
		uiCreate();
		
		showMessage("반갑습니다.", function(){
			showMessage("제 이름은...", function(){
				showMessage("『 니코니코니 . 』");
			});
		});
	}
)
.Go();