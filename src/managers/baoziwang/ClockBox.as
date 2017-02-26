package managers.baoziwang
{
	import customUI.BmpFontLabel;
	
	import laya.media.SoundManager;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Browser;
	
	import managers.ManagersMap;
	
	public class ClockBox extends Box
	{
		private var clockNumLabel:BmpFontLabel;
		private var xzImage:Image;
		private var ddImage:Image;
		
		private var endTime:int;
		
		private var type:int;
		
		private var _endSoundCount:int = 0;
		public function ClockBox()
		{
			super();
		}
		
		public function init():void
		{
			clockNumLabel = getChildByName("clockNumLabel") as BmpFontLabel;
			xzImage = getChildByName("xzImage") as Image;
			ddImage = getChildByName("ddImage") as Image;
		}
		
		public function reset():void
		{
			Laya.timer.clearAll(this);
			this.visible = false;
		}
		
		/**@param type: 1 请下注 2 请等待*/
		public function countDown(type:int,time:int = 15000):void
		{
			this.type = type;
			endTime = Browser.now() + time;
			Laya.timer.frameLoop(1,this,countLoop);
			countLoop();
			this.visible = true;
			if(type == 1)
			{
				xzImage.visible = true;
				ddImage.visible = false;
			}
			else
			{
				xzImage.visible = false;
				ddImage.visible = true;
			}
		}
		
		private function countLoop():void
		{
			var leftTime:int = endTime - Browser.now();
			if(leftTime < 0)
			{
				countEnd();
				return;
			}
			var num:int = Math.floor((endTime - Browser.now())/1000);
			clockNumLabel.text = String(num);
			if(type == 1)
			{
				endSoundCount = num;
			}
		}
		
		private function countEnd():void
		{
			Laya.timer.clear(this,countLoop);
			this.visible = false;
			if(type == 1)
			{
				SoundManager.playSound("music/ttz_time_out.mp3");
			}
		}
		
		private function set endSoundCount(value:int):void
		{
			if(_endSoundCount == value)return;
			_endSoundCount = value;
			if(_endSoundCount <= 3)
			{
				SoundManager.playSound("music/ttz_time_run.mp3");
			}
		}
	}
}