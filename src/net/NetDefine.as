package net
{
	import laya.utils.Browser;

	public class NetDefine
	{
		/**连接socket*/
		public static const CONNECT_SOCKET:String = "connectSocket";
		
		public function NetDefine()
		{
			
		}
		
		public static function getQueryString(paramName:String):String
		{
			var param:String = "";
			var searchStr:String = Browser.window.location.search;
			if(searchStr != "" && searchStr.indexOf("?") != -1)
			{
				searchStr = searchStr.replace("?","");
				var strArr:Array = searchStr.split("&");
				var i:int;
				for(i = 0;i < strArr.length; i++)
				{
					var str:String = strArr[i];
					var arr:Array = str.split("=");
					if(arr[0] == paramName)
					{
						param = arr[1];
						break;
					}
				}
			}
			
			return param;
		}
	}
}