package managers.baoziwang
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.maths.Matrix;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import ui.BaoziwangUI;
	
	public class MainPanelManager extends BaoziwangUI
	{
		public function MainPanelManager()
		{
			super();
			Laya.stage.addChild(this);
			Laya.stage.on(Event.KEY_UP,this,key_up);
			tipBox.visible = false;
			mainPanelBottom.init();
			clockBox.init();
			diceCupBox.init();
			tipBox.init();
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
					clockBox.countDown(1,3000);
					break;
				case Keyboard.B:
					tipBox.show(2);
					break;
				case Keyboard.S:
					yaoTouzi();
					break;
				case Keyboard.D:
					kaiZhong();
					break;
			}
		}
		
		private function yaoTouzi():void
		{
			laoPaoWang.changeMotion("yao",false);
			Laya.timer.once(2500,tipBox,tipBox.show,[1]);
		}
		
		/**买定离手*/
		public function maiDingLiShou():void
		{
			tipBox.show(2);
			mainPanelBottom.canBetting = false;
		}
		
		/**开盅*/
		public function kaiZhong():void
		{
			clockBox.countDown(2,5000);
			diceCupBox.openDiceCup([3,5,3]);
			laoPaoWang.changeMotion("open",false);
		}
		
		private function xxx():void
		{
			diceCupBox.openDiceCup([1,6,6]);
		}
		
		public function gameStartRec(obj:Object):void
		{
			
		}
		
		public function gameFreeRec(obj:Object):void
		{
			
		}
		
		public function userStatusRec(obj:Object):void
		{
			var obj:Object = {};
			obj.header = "100_1";
			var body:Object = {};
			obj.body = body;
			body.cbAllowLookon = 0;
			body.dwFrameVersion = 0;
			body.dwClientVersion = 0;
			NetProxy.getInstance().execute(NetDefine.SEND_TO_SERVER,obj);
		}
	}
}