package managers.gameLogin
{
	import managers.DataProxy;
	import managers.ManagerBase;
	import managers.ManagersMap;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import system.Loading;
	import system.Logger;
	
	public class GameLoginManager extends ManagerBase
	{
		public function GameLoginManager(uiClass:Class=null)
		{
			super(uiClass);
		}
		
		public function roomLoginReq():void
		{
			var body:Object = {};
			body.account = NetDefine.getQueryString("account");
			body.password = NetDefine.getQueryString("password");
			body.dwUserID 	= DataProxy.userID;
			body.wKindID	= DataProxy.kindID;
			NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_ROOM_LOGIN_REQ,body);
		}
		
		public function roomLoginSuccessRec(obj:Object):void
		{
			//obj.dwUserRight
			//obj.dwMasterRight
		}
		
		public function roomLoginFailureRec(obj:Object):void
		{
			//obj.lErrorCode
			//obj.szDescribeString
			trace(obj.szDescribeString);
		}
		
		public function roomLoginFinishRec(obj:Object):void
		{
			//
			var body:Object = {};
			body.wTableID = 2;
			body.wChairID = 0;
			body.szPassword = "";
			NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_USER_SIT_DOWN_REQ,body);
		}
		
		
		public function tableStatusRec(obj:Object):void
		{
			//obj.arTableStatus
			//	obj.cbTableLock
			//	obj.cbPlayStatus
		}
		
		public function userStatusRec(obj:Object):void
		{
			//obj.dwUserID
			//obj.wTableID
			//obj.wChairID
			//obj.cbUserStatus
			if(obj.dwUserID != DataProxy.userID)return;
			if(obj.wTableID == DataProxy.tableID)return;
			DataProxy.tableID = obj.wTableID;
			DataProxy.chairID = obj.wChairID;
			var body:Object = {};
			obj.body = body;
			body.cbAllowLookon = 0;
			body.dwFrameVersion = 0;
			body.dwClientVersion = 0;
			NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_GAME_OPTION_REQ,body);
			ManagersMap.baoziwangManager.openMe();
		}
		
		public function userInfoRec(obj:Object):void
		{
			//obj.dwUserID
			//obj.dwGameID
			//obj.dwGroupID
			//obj.szNickName
			//obj.szGroupName
			//obj.szUnderWrite
			//obj.wFaceID
			//obj.dwCustomID
			//obj.cbGender
			//obj.cbMemberOrder
			//obj.cbMasterOrder
			//obj.wTableID
			//obj.wChairID
			//obj.cbUserStatus
			//obj.lScore
			//obj.lGrade
			//obj.lInsure
			//obj.dwWinCount
			//obj.dwLostCount
			//obj.dwDrawCount
			//obj.dwFleeCount
			//obj.dwUserMedal
			//obj.dwExperience
			//obj.lLoveLiness
			if(obj.dwUserID == DataProxy.userID)
			{
				DataProxy.gameID = obj.dwGameID;
				DataProxy.nickName = obj.szNickName;
				DataProxy.faceID = obj.wFaceID;
				
				DataProxy.allUsers[obj.dwUserID] = obj;
			}
			else
			{
				DataProxy.allUsers[obj.dwUserID] = obj;
			}
		}
		

	}
}