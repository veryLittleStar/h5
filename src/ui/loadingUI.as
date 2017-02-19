/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class loadingUI extends View {
		public var dice:Animation;

		public static var uiView:Object ={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Box","props":{"y":0,"x":0,"width":75,"height":98},"child":[{"type":"Animation","props":{"y":0,"x":13,"width":50,"var":"dice","source":"ani/game_loading.ani","height":51}},{"type":"Label","props":{"y":82,"x":0,"text":"资源加载中","fontSize":15,"color":"#f4f3ec"}},{"type":"Image","props":{"y":62,"x":18,"skin":"animation/game_loading/game_loading_17.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}