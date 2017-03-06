package managers
{
	public class DataProxy
	{
		/**玩家id*/
		public static var userID:int = 0;
		/**游戏id*/
		public static var kindID:int = 0;
		/**玩家桌子号*/
		public static var tableID:int = 65535;
		/**玩家椅子号*/
		public static var chairID:int = 65535;
		/***/
		public static var gameID:int = 0;
		/**玩家姓名*/
		public static var nickName:String = "";
		/**账号*/
		public static var account:String = "";
		/**密码*/
		public static var password:String = "";
		/**头像id*/
		public static var faceID:int = 0;
		/**用户性别*/
		public static var gender:int = 0;
		/**用户金币*/
		public static var userScore:int = 0;
		/**用户状态*/
		public static var userStatus:int = 0;
		/**这是所有玩家的用户数据*/
		public static var userInfoDic:Object = {};
		/***/
		public static var myUserInfo:Object ={};
		/**当前庄家userID*/
		public static var bankerChairID:int = 65535;
		/**当前庄家的金币*/
		public static var bankerSocre:int = -1;
		/**我的坐庄状态 0无状态  1排队状态  2坐庄状态*/
		public static var myBankerState:int = 0;
		
		public static var standUPing:Boolean = false;
		
		
		public function DataProxy()
		{
		}
		
		public static function getUserInfoByChairID(chairID:int):Object
		{
			for each(var userInfo:Object in userInfoDic)
			{
				if(userInfo.wChairID == chairID)
				{
					return userInfo;
				}
			}
			return null;
		}
		
		public static function getUserInfoByName(nameStr:String):Object
		{
			for each(var userInfo:Object in userInfoDic)
			{
				if(userInfo.szNickName == nameStr)
				{
					return userInfo;
				}
			}
			return null;
		}
		
		/////////////////////用户状态////////////////////////////////
		//用户状态
		public static const US_NULL:int		=				0x00								//没有状态
		public static const US_FREE:int		=				0x01								//站立状态
		public static const US_SIT:int		=				0x02								//坐下状态
		public static const US_READY:int		=				0x03								//同意状态
		public static const US_LOOKON:int		=				0x04								//旁观状态
		public static const US_PLAYING:int	=				0x05								//游戏状态
		public static const US_OFFLINE:int	=				0x06								//断线状态
	}
}