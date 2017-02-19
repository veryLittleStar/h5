package customUI
{
	import laya.display.BitmapFont;
	import laya.display.Text;
	import laya.net.Loader;
	import laya.ui.Label;
	import laya.utils.Handler;
	
	public class BmpFontLabel extends Label
	{
		public function BmpFontLabel(text:String="")
		{
			super(text);
		}
		
		override public function set font(value:String):void
		{
			var path:String = "font/"+value + ".fnt";
			if(Loader.getRes(path))
			{
				_tf.font = value;
			}
			else
			{
				var mBitmapFont:BitmapFont = new BitmapFont();
				//这里不需要扩展名，外部保证fnt与png文件同名
				mBitmapFont.loadFont(path,new Handler(this,onLoaded));
				
				function onLoaded():void
				{
					Text.registerBitmapFont(value, mBitmapFont);
					_tf.font = value;
				}
			}
		}
	}
}