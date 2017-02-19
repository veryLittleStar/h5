package managers.mainPanel
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.maths.Matrix;
	
	import ui.mainPanelUI;
	
	public class MainPanelManager extends mainPanelUI
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
		
		
	}
}