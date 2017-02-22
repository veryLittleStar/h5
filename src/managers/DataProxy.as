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
		/**头像id*/
		public static var faceID:int = 0;
		/**用户性别*/
		public static var gender:int = 0;
		/**用户金币*/
		public static var userScore:int = 0;
		
		public static var allUsers:Object = {};
		
		
		public function DataProxy()
		{
		}
	}
}