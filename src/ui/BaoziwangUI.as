/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 
	import managers.baoziwang.ClockBox;
	import customUI.BmpFontLabel;
	import managers.baoziwang.PortraitCell;
	import managers.baoziwang.MainPanelBottom;
	import managers.baoziwang.ChipCell;
	import managers.baoziwang.LaoPaoWang;
	import managers.baoziwang.MainPanelTop;
	import managers.baoziwang.TipBox;
	import managers.baoziwang.DiceCupBox;

	public class BaoziwangUI extends View {
		public var table:Image;
		public var clockBox:ClockBox;
		public var playerList:List;
		public var mainPanelBottom:MainPanelBottom;
		public var myPortraitImage:Image;
		public var myNameLabel:Label;
		public var myMoneyLabel:Label;
		public var laoPaoWang:LaoPaoWang;
		public var mainPanelTop:MainPanelTop;
		public var tipBox:TipBox;
		public var diceCupBox:DiceCupBox;

		public static var uiView:Object ={"type":"View","props":{"width":800,"height":600,"centerY":0,"centerX":0},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"table","skin":"ui/common/yb_bj.png"}},{"type":"Box","props":{"y":70,"x":163,"visible":false,"var":"clockBox","runtime":"managers.baoziwang.ClockBox"},"child":[{"type":"Image","props":{"y":17,"x":43,"skin":"ui/baseUI/yb_nz_dk.png"}},{"type":"Image","props":{"y":5,"x":0,"skin":"ui/baseUI/ttz_clock.png"}},{"type":"Image","props":{"y":22,"x":52,"skin":"ui/baseUI/yb_nz_qxz.png","name":"xzImage"}},{"type":"Image","props":{"y":22,"x":52,"skin":"ui/baseUI/yb_nz_qdd.png","name":"ddImage"}},{"type":"Label","props":{"y":18,"x":6,"width":41,"text":"0","runtime":"customUI.BmpFontLabel","name":"clockNumLabel","height":30,"font":"sgj_nz","align":"center"}}]},{"type":"List","props":{"y":123,"x":22,"var":"playerList","spaceY":-4,"spaceX":608,"repeatY":4,"repeatX":2},"child":[{"type":"Box","props":{"y":6,"x":8,"width":84,"runtime":"managers.baoziwang.PortraitCell","renderType":"render","height":84},"child":[{"type":"Image","props":{"width":61,"visible":true,"skin":"ui/baseUI/lob_men_1.jpg","name":"portrait","height":61,"centerY":0.5,"centerX":0.5},"child":[{"type":"Image","props":{"y":2.5,"x":2.5,"width":56,"visible":true,"skin":"ui/baseUI/game_user_head_zz.png","renderType":"mask","height":56}}]},{"type":"Image","props":{"width":84,"visible":true,"skin":"ui/baseUI/game_user_head_box_1.png","height":84}},{"type":"Image","props":{"y":60,"skin":"ui/baseUI/ttz_head_player_bg.png","centerX":0},"child":[{"type":"Label","props":{"y":0,"x":13,"text":"我是名字","color":"#f4f3ec"}},{"type":"Label","props":{"y":15,"x":15,"text":"123456","color":"#f2eacb"}}]}]}]},{"type":"Box","props":{"width":718,"var":"mainPanelBottom","runtime":"managers.baoziwang.MainPanelBottom","height":64,"centerX":0,"bottom":0},"child":[{"type":"Image","props":{"y":50,"x":182,"visible":true,"skin":"ui/baseUI/ttz_board_2.png","name":"chipsBg"},"child":[{"type":"List","props":{"y":4,"x":49,"spaceX":11,"repeatX":5,"name":"chips"},"child":[{"type":"Box","props":{"y":0,"width":58,"scaleY":0.95,"scaleX":0.95,"runtime":"managers.baoziwang.ChipCell","renderType":"render","pivotY":29.5,"pivotX":29,"height":59},"child":[{"type":"Image","props":{"y":-5.000000000000092,"x":-14.000000000000021,"visible":false,"skin":"ui/baseUI/ttz_chip_d_light.png","name":"chipLight","centerX":0}},{"type":"Image","props":{"y":0,"x":0,"skin":"ui/baseUI/ttz_chip_d_01.png","name":"chip"}}]}]}]},{"type":"Image","props":{"skin":"ui/baseUI/ttz_board_1.png"}},{"type":"Button","props":{"y":9,"x":570,"stateNum":"2","skin":"ui/baseUI/ttz_bt_xy.png","name":"autoBettingBtn","disabled":true}},{"type":"Box","props":{"y":-5,"x":-4,"width":84,"scaleY":0.9,"scaleX":0.9,"runtime":"managers.baoziwang.PortraitCell","height":84},"child":[{"type":"Image","props":{"width":61,"visible":true,"var":"myPortraitImage","skin":"ui/baseUI/lob_men_1.jpg","height":61,"centerY":0.5,"centerX":0.5},"child":[{"type":"Image","props":{"y":2.5,"x":2.5,"width":56,"visible":false,"skin":"ui/baseUI/game_user_head_zz.png","renderType":"mask","height":56}}]},{"type":"Image","props":{"width":84,"skin":"ui/baseUI/game_user_head_box_1.png","height":84}}]},{"type":"Label","props":{"y":16,"x":77,"var":"myNameLabel","text":"我是名字","color":"#5b2e1f","bold":true}},{"type":"Label","props":{"y":35,"x":78,"var":"myMoneyLabel","text":"123456","color":"#5b2e1f","bold":true}}]},{"type":"Animation","props":{"y":125,"x":411,"var":"laoPaoWang","source":"ani/yb_rdh_idle.ani","runtime":"managers.baoziwang.LaoPaoWang","autoPlay":true}},{"type":"Box","props":{"width":630,"var":"mainPanelTop","runtime":"managers.baoziwang.MainPanelTop","height":71,"centerX":0.5},"child":[{"type":"Image","props":{"y":0,"skin":"ui/common/yb_bj_zsdt.png","centerX":0}},{"type":"Image","props":{"y":3,"x":170,"skin":"ui/baseUI/yb_bt_gd.png"}},{"type":"Button","props":{"y":2,"x":518,"stateNum":"2","skin":"ui/baseUI/ttz_bt_sz.png"}},{"type":"Button","props":{"y":2,"x":520,"stateNum":"2","skin":"ui/baseUI/ttz_bt_sz1.png"}},{"type":"Button","props":{"y":3,"x":519,"stateNum":"1","skin":"ui/baseUI/ttz_bt_sz4.png"}},{"type":"Image","props":{"y":2,"x":386,"skin":"ui/baseUI/yb_tx_lpt.png"}},{"type":"Label","props":{"y":14,"x":460,"text":"老炮王","color":"#f4f3ec"}},{"type":"Label","props":{"y":37,"x":468,"text":"10亿","color":"#f2eacb"}},{"type":"Image","props":{"y":24,"x":-18,"skin":"ui/baseUI/ttz_bt_help.png"}},{"type":"List","props":{"y":32,"x":52.5,"spaceX":6,"repeatX":6},"child":[{"type":"Image","props":{"skin":"ui/baseUI/yb_bj_zs_03.png","renderType":"render"}}]}]},{"type":"Box","props":{"y":240,"width":800,"var":"tipBox","runtime":"managers.baoziwang.TipBox","centerX":0},"child":[{"type":"Box","props":{"y":65,"x":0,"width":800,"pivotY":62.5,"name":"bg"},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"ui/baseUI/game_com_tip_bg.png"}},{"type":"Image","props":{"y":0,"x":799.5,"skin":"ui/baseUI/game_com_tip_bg.png","scaleX":-1}}]},{"type":"Image","props":{"y":22,"x":294,"skin":"ui/baseUI/ttz_ts_01.png","name":"word1"}},{"type":"Image","props":{"y":19,"x":264,"skin":"ui/baseUI/ttz_ts_02.png","name":"word2"}}]},{"type":"Box","props":{"y":333,"x":415,"width":1,"visible":false,"var":"diceCupBox","runtime":"managers.baoziwang.DiceCupBox","height":1},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"ui/baseUI/yb_z_1.png","pivotY":65,"pivotX":117,"name":"tray"}},{"type":"Image","props":{"y":0,"x":0,"skin":"ui/baseUI/yb_z_2.png","pivotY":185,"pivotX":85,"name":"cap"}},{"type":"Image","props":{"y":-334,"x":0,"skin":"ui/baseUI/yb_gx_hd.png","scaleY":2.5,"scaleX":2.5,"pivotX":71.5,"name":"light"}},{"type":"Image","props":{"y":39,"x":-131,"skin":"ui/baseUI/yb_d_sm.png","name":"pointBox"},"child":[{"type":"Label","props":{"y":44,"x":89,"width":50,"text":"18","runtime":"customUI.BmpFontLabel","name":"numLabel","font":"yb_sz_ds","anchorY":0.5,"anchorX":0.5,"align":"right"}},{"type":"Image","props":{"y":46,"x":139,"width":38,"skin":"ui/baseUI/yb_wz_d.png","pivotY":21,"pivotX":18,"name":"point","height":38}},{"type":"Image","props":{"y":44,"x":196,"width":65,"skin":"ui/baseUI/yb_wz_dd.png","pivotY":36,"pivotX":33,"name":"dx","height":69}}]}]}]};
		override protected function createChildren():void {
			View.regComponent("managers.baoziwang.ClockBox",ClockBox);
			View.regComponent("customUI.BmpFontLabel",BmpFontLabel);
			View.regComponent("managers.baoziwang.PortraitCell",PortraitCell);
			View.regComponent("managers.baoziwang.MainPanelBottom",MainPanelBottom);
			View.regComponent("managers.baoziwang.ChipCell",ChipCell);
			View.regComponent("managers.baoziwang.LaoPaoWang",LaoPaoWang);
			View.regComponent("managers.baoziwang.MainPanelTop",MainPanelTop);
			View.regComponent("managers.baoziwang.TipBox",TipBox);
			View.regComponent("managers.baoziwang.DiceCupBox",DiceCupBox);
			super.createChildren();
			createView(uiView);
		}
	}
}