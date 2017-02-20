package managers.baoziwang
{
	import laya.display.Animation;
	import laya.ui.Box;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class ChipCell extends Box
	{
		private var _selected:Boolean = false;
		
		public function ChipCell()
		{
			super();
		}
		
		public function set selected(value:Boolean):void
		{
			if(_selected == value)return;
			_selected = value;
			var chipLight:Animation = getChildByName("chipLight") as Animation;
			if(_selected)
			{
				Tween.to(this,{scaleX:1.05,scaleY:1.05},300,null,null,0,true);
				chipLight.visible = true;
				lightIn();
			}
			else
			{
				Tween.to(this,{scaleX:0.95,scaleY:0.95},300,null,null,0,true);
				chipLight.visible = false;
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		private function lightIn():void
		{
			var chipLight:Animation = getChildByName("chipLight") as Animation;
			chipLight.alpha = 1;
			Tween.to(chipLight,{alpha:0},500,null,Handler.create(this,lightOut),0,true);
		}
		
		private function lightOut():void
		{
			var chipLight:Animation = getChildByName("chipLight") as Animation;
			chipLight.alpha = 0;
			Tween.to(chipLight,{alpha:1},500,null,Handler.create(this,lightIn),0,true);
		}
	}
}