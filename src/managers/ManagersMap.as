package managers
{
	import managers.login.LoginManager;
	import managers.mainPanel.MainPanelManager;

	public class ManagersMap
	{
		public static var mainPanelManager:MainPanelManager;
		public static var loginManager:LoginManager;
		
		public function ManagersMap()
		{
		}
		
		public static function initManagers():void
		{
//			mainPanelManager = new MainPanelManager();
			loginManager = new LoginManager();
		}
	}
}