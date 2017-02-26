package managers
{
	import managers.baoziwang.BaoziwangManager;
	import managers.gameLogin.GameLoginManager;
	import managers.serverLogin.ServerLoginManager;
	import managers.systemMessage.SystemMessageManager;

	public class ManagersMap
	{
		public static var serverLoginManager:ServerLoginManager = null;
		public static var gameLoginManager:GameLoginManager = null;
		public static var baoziwangManager:BaoziwangManager = null;
		public static var systemMessageManager:SystemMessageManager = null
		
		public function ManagersMap()
		{
		}
		
		public static function init():void
		{
			serverLoginManager = new ServerLoginManager();
			gameLoginManager = new GameLoginManager();
			baoziwangManager = new BaoziwangManager();
			systemMessageManager = new SystemMessageManager();
		}
	}
}