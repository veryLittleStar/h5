/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 
	import managers.baoziwang.PortraitCell;

	public class chatCellUI extends View {

		public static var uiView:Object ={"type":"View","props":{"width":280,"height":250},"child":[{"type":"Image","props":{"y":34,"x":72,"width":200,"skin":"ui/baseUI/ttz_talk_bg_4.png","sizeGrid":"23,6,10,10","name":"chatBg","height":178}},{"type":"Box","props":{"y":0,"x":0,"width":84,"visible":true,"scaleY":0.9,"scaleX":0.9,"runtime":"managers.baoziwang.PortraitCell","name":"portraitBox","height":84},"child":[{"type":"Image","props":{"width":61,"visible":true,"skin":"ui/baseUI/lob_men_1.jpg","name":"portraitImage","height":61,"centerY":0.5,"centerX":0.5},"child":[{"type":"Image","props":{"y":2.5,"x":2.5,"width":56,"visible":true,"skin":"ui/baseUI/game_user_head_zz.png","renderType":"mask","height":56}}]},{"type":"Image","props":{"width":84,"visible":true,"skin":"ui/baseUI/game_user_head_box_1.png","name":"portraitBg","height":84}}]},{"type":"Label","props":{"y":40,"x":84,"wordWrap":true,"width":182,"text":"sdfasdf","name":"chatLabel","height":0,"fontSize":15,"color":"#cab094"}},{"type":"Label","props":{"y":12,"x":82,"width":190,"text":"请你吃胖胖吃胖胖 20:40:36","name":"nameLabel","height":19,"fontSize":15,"color":"#669594"}}]};
		override protected function createChildren():void {
			View.regComponent("managers.baoziwang.PortraitCell",PortraitCell);
			super.createChildren();
			createView(uiView);
		}
	}
}