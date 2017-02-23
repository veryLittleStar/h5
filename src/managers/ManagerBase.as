package managers
{
	import laya.net.Loader;
	import laya.ui.View;
	import laya.utils.Handler;
	
	import resource.ResLoader;
	import resource.ResType;
	
	import system.Loading;
	import system.UILayer;

	public class ManagerBase
	{
		private var _uiClass:Class;
		private var _resLoading:Boolean = false;
		protected var _view:View;
		private var _isOpen:Boolean = false;
		public function ManagerBase(uiClass:Class = null)
		{
			_uiClass = uiClass;
			initManager();
		}
		
		protected function initManager():void
		{
			
		}
		
		protected function initPanel():void
		{
			
		}
		
		protected function getResList():Array
		{
			return null;
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
			_view.removeSelf();
		}
		
		public function openOrClose():void
		{
			if(_isOpen)
			{
				closeMe();
			}
			else
			{
				openMe();
			}
		}
		
		protected function beforeOpen():Boolean
		{
			return true;
		}
		
		protected function afterOpen():void
		{
			
		}
		
		private function checkCreateView():void
		{
			if(!_view)
			{
				var _resArr:Array = getResList();
				if(!_resArr || !_resArr.length)
				{
					createView();
				}
				else
				{
					if(_resLoading == false)
					{
						_resLoading = true;
						Loading.getInstance().openMe("资源加载中...");
						Laya.loader.load(_resArr, Handler.create(this, resComplete));
					}
				}
			}
		}
		
		private function resComplete(e:* = null):void
		{
			_resLoading = false;
			createView();
		}
		
		private function createView():void
		{
			if(_view)return;
			_view = new _uiClass() as View;
			Loading.getInstance().closeMe();
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