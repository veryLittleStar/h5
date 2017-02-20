package system
{
	import laya.display.Animation;
	import laya.net.Loader;
	import laya.utils.Handler;
	
	import resource.ResLoader;
	import resource.ResType;
	
	import ui.LoadingUI;

	public class Loading extends LoadingUI
	{
		private static var _ins:Loading;
		public static function getInstance():Loading
		{
			if(!_ins)
			{
				_ins = new Loading();
			}
			return _ins;
		}
		////////////////////////////////////////////////
		private var isOpen:Boolean = false;
		private var init:Boolean = false;
		public function Loading()
		{
			if(_ins)
			{
				throw new Error("GameLoading 是单例啊");
			}
			Laya.loader.load(ResLoader.getResUrl(ResType.ANI_RES,"game_loading"),Handler.create(this,onResComplete),null,Loader.ATLAS);
		}
		
		private function onResComplete():void
		{
			init = true;
			createView(uiView);
			checkOpen();
		}
		
		override protected function createView(uiView:Object):void
		{
			if(init == false)return;
			super.createView(uiView);
		}
		
		public function openMe():void
		{
			isOpen = true;
			checkOpen();
		}
		
		private function checkOpen():void
		{
			if(isOpen && init)
			{
				trace(x,y);
				UILayer.layerLoading.addChild(this);
				dice.play(0,true);
				trace(x,y);
				this.centerX = 0;
				this.centerY = 0;
				trace(x,y);
			}
		}
		
		public function closeMe():void
		{
			isOpen = false;
			this.removeSelf();
			if(dice)dice.stop();
		}
		
	}
}