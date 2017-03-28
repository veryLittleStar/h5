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
			body.password = DataProxy.password;
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
			ManagersMap.systemMessageManager.showSysMessage(obj.szDescribeString);
		}
		
		public function roomLoginFinishRec(obj:Object):void
		{
			//
			sitDown();
		}
		
		public function sitDown():void
		{
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
			
			if(obj.dwUserID == DataProxy.userID)
			{
				if(obj.wTableID != DataProxy.tableID)
				{
					var body:Object = {};
					obj.body = body;
					body.cbAllowLookon = 0;
					body.dwFrameVersion = 0;
					body.dwClientVersion = 0;
					NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_GAME_OPTION_REQ,body);
					Loading.getInstance().closeMe();
				}
				DataProxy.userStatus= obj.cbUserStatus;
				DataProxy.tableID 	= obj.wTableID;
				DataProxy.chairID	= obj.wChairID;
				if(obj.cbUserStatus == GameLoginDefine.US_NULL || obj.cbUserStatus == GameLoginDefine.US_FREE)
				{
					if(DataProxy.standUPing)
					{
						DataProxy.standUPing = false;
						ManagersMap.baoziwangManager.ui.bankPanel.openMe();
					}
				}
				else
				{
					ManagersMap.baoziwangManager.ui.bankPanel.closeMe();
				}
			}
			
			var userInfo:Object = DataProxy.userInfoDic[obj.dwUserID];
			if(userInfo)
			{
				userInfo.dwUserID = obj.dwUserID;
				userInfo.wTableID = obj.wTableID;
				userInfo.wChairID = obj.wChairID;
				userInfo.cbUserStatus = obj.cbUserStatus;
			}
			
			ManagersMap.baoziwangManager.updateUserStatus(obj.dwUserID);
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
			//obj.lSelfOption
			//obj.lTodayRecord
			//obj.dwWinCount
			//obj.dwLostCount
			//obj.dwDrawCount
			//obj.dwFleeCount
			//obj.dwUserMedal
			//obj.dwExperience
			//obj.lLoveLiness
			if(obj.dwUserID == DataProxy.userID)
			{
				DataProxy.faceID 	= obj.wFaceID;
				DataProxy.gameID	= obj.dwGameID;
				DataProxy.nickName 	= obj.szNickName;
				DataProxy.gender 	= obj.cbGender;
				DataProxy.userScore = obj.lScore;
				DataProxy.userStatus= obj.cbUserStatus;
				DataProxy.tableID 	= obj.wTableID;
				DataProxy.chairID	= obj.wChairID;
				DataProxy.selfOption = obj.lSelfOption;
				DataProxy.todayRecord = obj.lTodayRecord;
				DataProxy.myUserInfo = obj;
				if(DataProxy.tableID != 65535)
				{
					var body:Object = {};
					obj.body = body;
					body.cbAllowLookon = 0;
					body.dwFrameVersion = 0;
					body.dwClientVersion = 0;
					NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_GAME_OPTION_REQ,body);
					Loading.getInstance().closeMe();
				}
			}
			DataProxy.userInfoDic[obj.dwUserID] = obj;
			ManagersMap.baoziwangManager.updateUserInfo(obj.dwUserID);
		}
		
		public function userScoreRec(obj:Object):void
		{
			//obj.dwUserID
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
			var userInfo:Object = DataProxy.userInfoDic[obj.dwUserID];
			if(userInfo)
			{
				userInfo.dwUserID =obj.dwUserID;
				userInfo.lScore =obj.lScore;
				userInfo.lGrade =obj.lGrade;
				userInfo.lInsure=obj.lInsure;
				userInfo.dwWinCount=obj.dwWinCount;
				userInfo.dwLostCount=obj.dwLostCount;
				userInfo.dwDrawCount=obj.dwDrawCount;
				userInfo.dwFleeCount=obj.dwFleeCount;
				userInfo.dwUserMedal=obj.dwUserMedal;
				userInfo.dwExperience=obj.dwExperience;
				userInfo.lLoveLiness=obj.lLoveLiness;
				
			}
			
			if(obj.dwUserID == DataProxy.userID)
			{
				DataProxy.userScore = obj.lScore;
			}
			else
			{
				ManagersMap.baoziwangManager.updateUserInfo(obj.dwUserID);
			}
			
		}
		
		public function userRankListRec(obj:Object):void
		{
			ManagersMap.baoziwangManager.ui.rankPanel.updateRankInfo(obj);
		}
		

	}
}