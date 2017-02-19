package system
{
	import laya.display.Sprite;

	public class UILayer
	{
		/**0主要游戏层*/
		public static var layerMain:Sprite;
		
		/**1加载层，显示加载提示或者加载动画的层*/
		public static var layerLoading:Sprite;
		
		/**2弹框层*/
		public static var layerMsgBox:Sprite;
		
		/**3信息提示层*/
		public static var layerAlert:Sprite;
		
		public function UILayer()
		{
		}
		
		public static function init():void
		{
			layerMain = new Sprite();
			layerMain.mouseEnabled = true;
			Laya.stage.addChild(layerMain);
			
			layerLoading = new Sprite();
			layerLoading.mouseEnabled = true;
			Laya.stage.addChild(layerLoading);
			
			layerMsgBox = new Sprite();
			layerMsgBox.mouseEnabled = true;
			Laya.stage.addChild(layerMsgBox);
			
			layerAlert = new Sprite();
			layerAlert.mouseEnabled = false;
			Laya.stage.addChild(layerAlert);
			
		}
	}
}