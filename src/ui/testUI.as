/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 
	import managers.baoziwang.PortraitCell;

	public class testUI extends View {

		public static var uiView:Object ={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Box","props":{"y":-33,"x":3},"child":[{"type":"Image","props":{"y":-14,"x":1,"width":330,"skin":"ui/baseUI/ttz_talk_bg_1.png","sizeGrid":"0,52,0,0"}},{"type":"Image","props":{"y":134,"x":303,"skin":"ui/baseUI/ttz_talk_txt_01.png"}},{"type":"Image","props":{"y":231,"x":304,"skin":"ui/baseUI/ttz_talk_txt_02.png"}},{"type":"Image","props":{"y":274,"x":306,"width":12,"skin":"ui/baseUI/ttz_talk_j2.png","height":12}},{"type":"Image","props":{"y":179,"x":304,"skin":"ui/baseUI/ttz_talk_j2.png"}},{"type":"Image","props":{"y":-2,"x":8,"width":279,"skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"10,10,10,10","height":417}}]},{"type":"Image","props":{"y":-2,"x":80,"width":200,"skin":"ui/baseUI/ttz_talk_bg_4.png","sizeGrid":"23,6,10,10","height":178}},{"type":"Label","props":{"y":4,"x":92,"wordWrap":true,"width":182,"text":"我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字我是标准的八个字","height":126,"fontSize":15,"color":"#af8e6b"}},{"type":"Box","props":{"y":-34,"x":11,"width":84,"visible":true,"scaleY":0.9,"scaleX":0.9,"runtime":"managers.baoziwang.PortraitCell","name":"portraitBox","height":84},"child":[{"type":"Image","props":{"width":61,"visible":true,"skin":"ui/baseUI/lob_men_1.jpg","name":"portraitImage","height":61,"centerY":0.5,"centerX":0.5},"child":[{"type":"Image","props":{"y":2.5,"x":2.5,"width":56,"visible":true,"skin":"ui/baseUI/game_user_head_zz.png","renderType":"mask","height":56}}]},{"type":"Image","props":{"width":84,"visible":true,"skin":"ui/baseUI/game_user_head_box_1.png","name":"portraitBg","height":84}}]},{"type":"Label","props":{"y":-24,"x":90,"width":190,"text":"请你吃胖胖吃胖胖 20:40:36","height":19,"fontSize":15,"color":"#669594"}},{"type":"TextInput","props":{"y":337,"x":86,"text":"TextInput"}}]};
		override protected function createChildren():void {
			View.regComponent("managers.baoziwang.PortraitCell",PortraitCell);
			super.createChildren();
			createView(uiView);
		}
	}
}