package system
{
	import laya.display.Sprite;
	
	import ui.offlineUI;
	
	public class Offline extends offlineUI
	{
		private static var _ins:Offline;
		public static function getInstance():Offline
		{
			if(!_ins)
			{
				_ins = new Offline();
			}
			return _ins;
		}
		
		public function Offline()
		{
			super();
			var sp:Sprite = new Sprite();
			sp.graphics.drawRect(0,0,Laya.stage.width,Laya.stage.height,"#000000");
			sp.alpha = 0.8;
			addChildAt(sp,0);
			sp.mouseEnabled = true;
			this.mouseEnabled = true;
		}
		
		public function openMe():void
		{
			this.width = Laya.stage.width;
			this.height = Laya.stage.height;
			Laya.stage.addChild(this);
		}
	}
}