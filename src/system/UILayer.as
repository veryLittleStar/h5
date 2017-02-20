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
			layerMain.width = Laya.stage.width;
			layerMain.height = Laya.stage.height;
			layerMain.mouseEnabled = true;
			Laya.stage.addChild(layerMain);
			
			layerLoading = new Sprite();
			layerLoading.width = Laya.stage.width;
			layerLoading.height = Laya.stage.height;
			layerLoading.mouseEnabled = true;
			Laya.stage.addChild(layerLoading);
			
			layerMsgBox = new Sprite();
			layerMsgBox.width = Laya.stage.width;
			layerMsgBox.height = Laya.stage.height;
			layerMsgBox.mouseEnabled = true;
			Laya.stage.addChild(layerMsgBox);
			
			layerAlert = new Sprite();
			layerAlert.width = Laya.stage.width;
			layerAlert.height = Laya.stage.height;
			layerAlert.mouseEnabled = false;
			Laya.stage.addChild(layerAlert);
			
		}
	}
}