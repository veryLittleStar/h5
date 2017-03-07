package managers
{
	import managers.baoziwang.BaoziwangDefine;
	import managers.gameLogin.GameLoginDefine;
	import managers.serverLogin.ServerLoginDefine;
	import managers.systemMessage.SystemMessageDefine;

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
			
		}
		
		/**@param header
		 * @param body*/
		public function messageHanlder(header:String,body:Object):void
		{
			switch(header)
			{
				case ServerLoginDefine.MSG_HEART_BEAT_REC:
					ManagersMap.serverLoginManager.heartBeatRec(body);
					break;
				case GameLoginDefine.MSG_TABLE_STATUS_REC:
					ManagersMap.gameLoginManager.tableStatusRec(body);
					break;
				case GameLoginDefine.MSG_USER_STATUS_REC:
					ManagersMap.gameLoginManager.userStatusRec(body);
					break;
				case GameLoginDefine.MSG_ROOM_LOGIN_SUCCESS_REC:
					ManagersMap.gameLoginManager.roomLoginSuccessRec(body);
					break;
				case GameLoginDefine.MSG_ROOM_LOGIN_FAILURE_REC:
					ManagersMap.gameLoginManager.roomLoginFailureRec(body);
					break;
				case GameLoginDefine.MSG_ROOM_LOGIN_FINISH_REC:
					ManagersMap.gameLoginManager.roomLoginFinishRec(body);
					break;
				case GameLoginDefine.MSG_USER_INFO_REC:
					ManagersMap.gameLoginManager.userInfoRec(body);
					break;
				case GameLoginDefine.MSG_USER_SCORE_REC:
					ManagersMap.gameLoginManager.userScoreRec(body);
					break;
				case ServerLoginDefine.MSG_LOGIN_SUCCESS_REC:
					ManagersMap.serverLoginManager.loginSuccessRec(body);
					break;
				case ServerLoginDefine.MSG_LOGIN_FAILURE_REC:
					ManagersMap.serverLoginManager.loginFailureRec(body);
					break;
				case ServerLoginDefine.MSG_LOGIN_FINISH_REC:
					ManagersMap.serverLoginManager.loginFinishRec(body);
					break;
				case ServerLoginDefine.MSG_LOGIN_ROOM_LIST_REC:
					ManagersMap.serverLoginManager.roomListRec(body);
					break;
				case ServerLoginDefine.MSG_LOGIN_GAME_LIST_REC:
					ManagersMap.serverLoginManager.gameListRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_FREE_REC:
					ManagersMap.baoziwangManager.gameFreeRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_START_REC:
					ManagersMap.baoziwangManager.gameStartRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_END_REC:
					ManagersMap.baoziwangManager.gameEndRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_RECORD_REC:
					ManagersMap.baoziwangManager.gameRecordRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_SCENE_REC:
					ManagersMap.baoziwangManager.gameSceneRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_PLACE_JETION_REC:
					ManagersMap.baoziwangManager.placeJetionRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_PLACE_JETION_FAIL_REC:
					ManagersMap.baoziwangManager.placeJetionFailRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_APPLY_BANKER_REC:
					ManagersMap.baoziwangManager.applyBankerRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_CANCEL_BANKER_REC:
					ManagersMap.baoziwangManager.cancelBankerRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_CHANGE_BANKER_REC:
					ManagersMap.baoziwangManager.changeBankerRec(body);
					break;
				case BaoziwangDefine.MSG_BANK_INSURE_INFO_REC:
					ManagersMap.baoziwangManager.bankInsureInfoRec(body);
					break;
				case BaoziwangDefine.MSG_BANK_INSURE_SUCCESS_REC:
					ManagersMap.baoziwangManager.bankInsureSuccessRec(body);
					break;
				case BaoziwangDefine.MSG_BANK_INSURE_FAILURE_REC:
					ManagersMap.baoziwangManager.bankInsureFailureRec(body);
					break;
				case BaoziwangDefine.MSG_BANK_CHANGE_PWD_REC:
					ManagersMap.baoziwangManager.bankChangePwdRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_SELF_OPTION_CHANGE_REC:
					ManagersMap.baoziwangManager.selfOptionChangeRec(body);
					break;
				case SystemMessageDefine.MSG_SYSTEM_MESSAGE_REC:
					ManagersMap.systemMessageManager.systemMessageRec(body);
					break;
				case "100_10":
					ManagersMap.baoziwangManager.userChatRec(body);
					break;
				case SystemMessageDefine.MSG_USER_REQUEST_FAILURE_REC:
					ManagersMap.systemMessageManager.userRequestFailureRec(body);
					break;
			}
		}
		
		
	}
}