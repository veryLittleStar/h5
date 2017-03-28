/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class offlineUI extends View {

		public static var uiView:Object ={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Label","props":{"text":"您已断开和服务器的连接，请刷新页面重新登录","fontSize":20,"color":"#f6f1f1","centerY":0,"centerX":0}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}