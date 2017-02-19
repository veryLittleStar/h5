package managers
{
	import system.UILayer;
	
	import laya.net.Loader;
	import laya.ui.View;
	import laya.utils.Handler;
	
	import resource.ResLoader;
	import resource.ResType;

	public class ManagerBase
	{
		private var _uiClass:Class;
		private var _uiAtlas:String;
		private var _view:View;
		private var _isOpen:Boolean = false;
		public function ManagerBase(uiClass:Class = null, uiAtlas:String = null)
		{
			_uiClass = uiClass;
			_uiAtlas = uiAtlas;
			initManager();
		}
		
		protected function initManager():void
		{
			
		}
		
		protected function initPanel():void
		{
			
		}
		
		public function openMe():void
		{
			if(!_uiClass)return;
			if(!beforeOpen())
			{
				return;
			}
			_isOpen = true;
			checkCreateView();
			checkOpen();
		}
		
		public function closeMe():void
		{
			_isOpen = false;
		}
		
		public function openOrClose():void
		{
			
		}
		
		public function beforeOpen():Boolean
		{
			return true;
		}
		
		public function afterOpen():void
		{
			
		}
		
		private function checkCreateView():void
		{
			if(!_view)
			{
				if(!_uiAtlas || _uiAtlas == "")
				{
					createView();
				}
				else
				{
					var url:String = ResLoader.getResUrl(ResType.UI,_uiAtlas);
					if(Laya.loader.getRes(url))
					{
						createView();
					}
					else
					{
						Laya.loader.load(url,Handler.create(this,createView),null,Loader.ATLAS);
					}
				}
			}
		}
		
		private function createView():void
		{
			if(_view)return;
			_view = new _uiClass() as View;
			initPanel();
			checkOpen();
		}
		
		private function checkOpen():void
		{
			if(_view && _isOpen)
			{
				UILayer.layerMain.addChild(_view);
				afterOpen();
			}
		}
	}
}