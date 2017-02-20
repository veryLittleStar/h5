package managers.serverLogin
{
	import net.NetDefine;
	import net.NetProxy;
	/**服务器总的登录，还没有进入具体的某个游戏*/
	public class ServerLoginManager
	{
		public var userData:Object = {};
		public var tableList:Array;
		
		public function ServerLoginManager()
		{
			
		}
		
		public function roomListRec(obj:Object):void
		{
			var arRoom:Array = obj.arRoom;
			var i:int;
			for(i = 0; i < arRoom.length; i++)
			{
				var roomInfo:Object = arRoom[i];
				if(roomInfo.dwOnLineCount < roomInfo.dwFullCount)
				{
					userData.wKindID = roomInfo.wKindID;
					connectRoom(roomInfo.szServerAddr,roomInfo.wServerPort);
					break;
				}
			}
		}
		
		public function loginSuccessRec(obj:Object):void
		{
			userData.dwUserID = obj.dwUserID;
		}
		
		private function connectRoom(host:String,port:String):void
		{
			var data:Object = {};
			data.host = host;
			data.port = port;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		public function roomLoginFinishRec(obj:Object):void
		{
			var obj:Object = {};
			obj.header = "23_3";
			var body:Object = {};
			obj.body = body;
			body.wTableID = 2;
			body.wChairID = 0;
			body.szPassword = "";
			NetProxy.getInstance().execute(NetDefine.SEND_TO_SERVER,obj);
		}
		
		public function tableStatusRec(obj:Object):void
		{
			//obj.arTableStatus
			//	obj.cbTableLock
			//	obj.cbPlayStatus
			tableList = obj.arTableStatus;
		}
	}
}