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
	import system.UILayer;
	
	public class main {
		private var progressLabel:Label;
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
//			initRes();
			initNet();
			Laya.stage.on(Event.KEY_UP,this,key_up);
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
					ManagersMap.baoziwangManager.openOrClose();
					break;
			}
		}
		
		private function initNet():void
		{
			Loading.getInstance().openMe();
			var data:Object = {};
			data.host = Browser.window.initConfig.loginHost;
			data.port = Browser.window.initConfig.loginPort;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		private function initRes():void
		{
			var resArr:Array = [
				{url: "res/atlas/animation/ybao_human.json", type: Loader.ATLAS},
				{url: "res/atlas/animation/ybao_human_big.json", type: Loader.ATLAS},
				{url: "res/atlas/ui/baseUI.json", type: Loader.ATLAS}
			];
			Laya.loader.load(resArr, Handler.create(this, resLoaded),Handler.create(this,resProgress));
			progressLabel = new Label();
			Laya.stage.addChild(progressLabel);
		}
		
		private function resProgress(progress:Number):void
		{
			progressLabel.text = "资源加载中："+progress*100+"%";
			progressLabel.centerX = 0;
			progressLabel.centerY = 0;
		}
		
		private function resLoaded():void
		{
			progressLabel.text = "资源加载中：100%";
		}
		
	}
}