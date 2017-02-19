package resource
{
	public class ResLoader
	{
		public function ResLoader()
		{
			
		}
		
		public static function getResUrl(resType:String,resName:String):String
		{
			var resUrl:String;
			switch(resType)
			{
				case ResType.ANI_RES:
					resUrl = "res/atlas/animation/" + resName + ".json";
					break;
				case ResType.ANI_CFG:
					resUrl = "ani/" + resName + ".ani";
					break;
				case ResType.UI:
					resUrl = "res/atlas/ui/" + resName + ".json";
					break;
			}
			return resUrl;
		}
	}
}