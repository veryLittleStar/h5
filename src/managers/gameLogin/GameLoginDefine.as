package managers.gameLogin
{
	public class GameLoginDefine
	{
		public static const MSG_ROOM_LOGIN_REQ:String = "21_1";
		
		public static const MSG_ROOM_LOGIN_SUCCESS_REC:String = "21_100";
		
		public static const MSG_ROOM_LOGIN_FAILURE_REC:String = "21_101";
		
		public static const MSG_ROOM_LOGIN_FINISH_REC:String = "21_102";
		
		public static const MSG_TABLE_STATUS_REC:String	= "24_100";
		
		public static const MSG_USER_STATUS_REC:String = "23_102";
		
		public static const MSG_USER_INFO_REC:String = "23_100";
		
		public static const MSG_USER_SCORE_REC:String = "23_101";
		
		public static const MSG_USER_RANK_LIST_REC:String = "23_104";
		
		public static const MSG_USER_SIT_DOWN_REQ:String = "23_3";
		
		public static const MSG_USER_STAND_UP_REQ:String = "23_4";
		
		public static const MSG_GAME_OPTION_REQ:String = "100_1";
		
		public function GameLoginDefine()
		{
		}
		
		public static const US_NULL:int			=			0x0;								//没有状态
		public static const US_FREE:int			= 			0x01;								//站立状态
		public static const US_SIT:int			=			0x02;								//坐下状态
		public static const US_READY:int			=			0x03;								//同意状态
		public static const US_LOOKON:int			=			0x04;								//旁观状态
		public static const US_PLAYING:int		= 			0x05;								//游戏状态
		public static const US_OFFLINE:int		= 			0x06;								//断线状态
		
	}
}