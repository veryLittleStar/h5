package system
{
	public class Logger
	{
		public function Logger()
		{
		}
		
		public static function log(...parameters):void
		{
			trace(parameters);
		}
	}
}