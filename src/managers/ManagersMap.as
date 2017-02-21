package managers
{
	import managers.baoziwang.BaoziwangManager;
	import managers.gameLogin.GameLoginManager;
	import managers.serverLogin.ServerLoginManager;

	public class ManagersMap
	{
		public static var serverLoginManager:ServerLoginManager = null;
		public static var gameLoginManager:GameLoginManager = null;
		public static var baoziwangManager:BaoziwangManager = null;
		
		public function ManagersMap()
		{
		}
		
		public static function init():void
		{
			serverLoginManager = new ServerLoginManager();
			gameLoginManager = new GameLoginManager();
			baoziwangManager = new BaoziwangManager();
		}
	}
}