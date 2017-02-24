package managers.baoziwang
{
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class TableLightBtn extends Image
	{
		private var shineCount:int = 0;
		public function TableLightBtn(skin:String=null)
		{
			super(skin);
			this.alpha = 0;
		}
		
		public function shine():void
		{
			alpha = 0;
			shineCount = 3;
			shineIn();
		}
		
		private function shineIn():void
		{
			if(shineCount > 0)
			{
				shineCount--;
				Tween.to(this,{alpha:1},500,null,Handler.create(this,shineOut),0,true);
			}
		}
		
		private function shineOut():void
		{
			Tween.to(this,{alpha:0},500,null,Handler.create(this,shineIn),0,true);
		}
	}
}