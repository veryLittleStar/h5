package managers
{
	import managers.baoziwang.BaoziwangDefine;
	import managers.gameLogin.GameLoginDefine;
	import managers.serverLogin.ServerLoginDefine;

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
				case BaoziwangDefine.MSG_BZW_GAME_RECORD_REC:
					ManagersMap.baoziwangManager.gameRecordRec(body);
					break;
				case BaoziwangDefine.MSG_BZW_GAME_SCENE_REC:
					ManagersMap.baoziwangManager.gameSceneRec(body);
					break;
			}
		}
		
		
	}
}