package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.ManagersMap;
	
	public class TipBox extends Box
	{
		private var word1:Image;
		private var word2:Image;
		private var bg:Box;
		private var type:int = 0;
		public function TipBox()
		{
			super();
		}
		
		public function init():void
		{
			word1 = getChildByName("word1") as Image;
			word2 = getChildByName("word2") as Image;
			bg = getChildByName("bg") as Box;
		}
		
		public function reset():void
		{
			Tween.clearAll(word1);
			Tween.clearAll(word2);
			Tween.clearAll(bg);
			this.visible = false;
		}
		
		/**@param type: 1 请下注 2 买定离手*/
		public function show(type:int):void
		{
			reset();
			this.type = type;
			this.visible = true;
			word1.visible = word2.visible = false;
			var word:Image;
			if(type == 1)
			{
				word = word1;
			}
			else
			{
				word = word2;
			}
			word.visible = true;
			word.x = 0;
			word.alpha = 0;
			bg.scaleY = 0;
			Tween.to(word,{x:(800-word.width)/2,alpha:1},400,null,Handler.create(this,wordIn,[word]),200);
			Tween.to(bg,{scaleY:1},600,null,Handler.create(this,bgIn,[bg]));
		}
		
		private function wordIn(word:Image):void
		{
			Tween.to(word,{x:800,alpha:0},400,null,null,1000);
		}
		
		private function bgIn(bg:Image):void
		{
			Tween.to(bg,{scaleY:0},600,null,Handler.create(this,bgOut),1000);
		}
		
		private function bgOut():void
		{
			this.visible = false;
			if(type == 1)
			{
				ManagersMap.mainPanelManager.mainPanelBottom.canBetting = true;
				ManagersMap.mainPanelManager.clockBox.countDown(1,3000);
			}
			else
			{
				ManagersMap.mainPanelManager.kaiZhong();
			}
		}
	}
}