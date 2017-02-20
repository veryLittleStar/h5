package managers
{
	import managers.serverLogin.ServerLoginManager;
	import managers.baoziwang.MainPanelManager;

	public class ManagersMap
	{
		public static var mainPanelManager:MainPanelManager;
		public static var loginManager:ServerLoginManager;
		
		public function ManagersMap()
		{
		}
		
		public static function initManagers():void
		{
//			mainPanelManager = new MainPanelManager();
			loginManager = new ServerLoginManager();
		}
	}
}