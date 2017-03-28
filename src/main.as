package {
	import laya.display.Stage;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Loader;
	import laya.ui.Label;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.webgl.WebGL;
	
	import managers.ManagersMap;
	
	import net.NetDefine;
	import net.NetProxy;
	import net.NetTest;
	import net.messages.CMD_GameServer;
	
	import system.Loading;
	import system.Offline;
	import system.UILayer;
	
	public class main {
		////////////////////////////////////////////////
		
		////////////////////////////////////////////////
		
		
		public function main() {
			//初始化引擎
			Laya.init(800,600,WebGL);
			Laya.stage.screenMode = Stage.SCREEN_HORIZONTAL;
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_TOP;
			Laya.stage.bgColor = "#333333";
			
			UILayer.init();
			ManagersMap.init();
			Loading.getInstance().openMe();
			var resArr:Array = [
				{url: "res/atlas/animation/ybao_human.json", type: Loader.ATLAS},
				{url: "res/atlas/animation/ybao_human_big.json", type: Loader.ATLAS},
				{url: "res/atlas/ui/baseUI.json", type: Loader.ATLAS},
			];
			Laya.loader.load(resArr, Handler.create(this, baseUILoaded));
			Laya.stage.on(Event.KEY_UP,this,key_up);
		}
		
		private function baseUILoaded():void
		{
			Loading.getInstance().closeMe();
			if(Browser.window.location.search == "")
			{
				ManagersMap.serverLoginManager.openMe();
			}
			else
			{				
				ManagersMap.baoziwangManager.openMe();
				ManagersMap.serverLoginManager.connectLoginServer();
			}
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
					
					break;
			}
		}
		
	}
}