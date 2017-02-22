package managers.serverLogin
{
	import managers.DataProxy;
	import managers.ManagerBase;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import system.Logger;

	/**服务器总的登录，还没有进入具体的某个游戏*/
	public class ServerLoginManager extends ManagerBase
	{
		public var roomList:Array;
		
		public function ServerLoginManager(uiClass:Class = null)
		{
			super(uiClass);
		}
		
		public function gameListRec(obj:Object):void
		{
			//obj.arGame
			//	obj.wGameID
			//	obj.dwOnLineCount
			//	obj.dwFullCount
			//	obj.szKindName
		}
		
		public function roomListRec(obj:Object):void
		{
			//obj.arRoom
			//	obj.wKindID
			//	obj.wNodeID
			//	obj.wSortID
			//	obj.wServerID
			//	obj.wServerPort
			//	obj.dwOnLineCount
			//	obj.dwFullCount
			//	obj.szServerAddr
			//	obj.szServerName
			
			roomList = obj.arRoom;
		}
		
		public function loginReq():void
		{
			var body:Object = {};
			body.account = NetDefine.getQueryString("account");
			body.password = NetDefine.getQueryString("password");
			NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_LOGIN_REQ,body);
		}
		
		public function loginSuccessRec(obj:Object):void
		{
			//obj.wFaceID
			//obj.dwUserID
			//obj.dwGameID
			//obj.dwGroupID
			//obj.dwCustomID
			//obj.dwUserMedal
			//obj.dwExperience
			//obj.dwLoveLiness
			//obj.lUserScore
			//obj.lUserInsure
			//obj.cbGender
			//obj.cbMoorMachine
			//obj.szAccounts
			//obj.szNickName
			//obj.szGroupName
			//obj.cbShowServerStatus
			
			DataProxy.userID = obj.dwUserID;
			DataProxy.nickName = obj.szNickName;
			DataProxy.account = obj.szAccounts;
			DataProxy.userScore = obj.lUserScore;
			DataProxy.gender = obj.cbGender;
		}
		
		public function loginFailureRec(obj:Object):void
		{
			//obj.lResultCode
			//obj.szDescribeString
			trace(obj.szDescribeString);
		}
		
		public function loginFinishRec(obj:Object):void
		{
			//obj.wIntermitTime
			//obj.wOnLineCountTime
			var i:int;
			for(i = 0; i < roomList.length; i++)
			{
				var roomInfo:Object = roomList[i];
				if(roomInfo.dwOnLineCount < roomInfo.dwFullCount)
				{
					DataProxy.kindID = roomInfo.wKindID;
					connectRoom(roomInfo.szServerAddr,roomInfo.wServerPort);
					break;
				}
			}
		}
		
		private function connectRoom(host:String,port:String):void
		{
			var data:Object = {};
			data.host = host;
			data.port = port;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		public function heartBeatRec(obj:Object):void
		{
			NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_HEART_BEAT_REQ,obj);
		}
		
	}
}