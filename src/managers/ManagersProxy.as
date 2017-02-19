package managers
{
	public class ManagersProxy
	{
		private static var _instance:ManagersProxy;
		
		public static function getInstance():ManagersProxy
		{
			if(!_instance)
			{
				_instance = new ManagersProxy();
			}
			return _instance;
		}
		
		public function ManagersProxy()
		{
			
		}
		
		public function execute(cmd:String,data:Object):void
		{
			switch(cmd)
			{
				case ManagersDefine.MESSAGE_FROM_SERVER:
					messageHanlder(data);
					break;
			}
		}
		
		/**obj.header
		 * obj.body*/
		private function messageHanlder(obj:Object):void
		{
			switch(obj.header)
			{
				case "2_104":
					ManagersMap.loginManager.roomListRec(obj.body);
					break;
				case "1_100":
					ManagersMap.loginManager.loginSuccessRec(obj.body);
					break;
				case "21_102":
					ManagersMap.loginManager.roomLoginFinishRec(obj.body);
					break;
				case "24_100":
					ManagersMap.loginManager.tableStatusRec(obj.body);
					break;
			}
		}
	}
}