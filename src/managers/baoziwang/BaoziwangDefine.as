package managers.baoziwang
{
	public class BaoziwangDefine
	{
		//msg
		public static const MSG_BZW_GAME_FREE_REC:String 	= "200_99";
		
		public static const MSG_BZW_GAME_START_REC:String	= "200_100";
		
		public static const MSG_BZW_GAME_END_REC:String = "200_102";
		
		public static const MSG_BZW_GAME_OPTION_REQ:String = "100_1";
		
		public static const MSG_BZW_GAME_RECORD_REC:String = "200_106";
		
		public static const MSG_BZW_GAME_SCENE_REC:String = "100_101";
		
		public static const MSG_BZW_PLACE_JETION_REQ:String = "200_1";
		
		public static const MSG_BZW_PLACE_JETION_REC:String = "200_101";
		
		public static const MSG_BZW_PLACE_JETION_FAIL_REC:String = "200_107";
		
		/////////////////////////
		public static const RESULT_BIG:int 	= 0;
		public static const RESULT_BAOZI:int 	= 1;
		public static const RESULT_SMALL:int 	= 2;
		////////////////////////////////////////////
		public function BaoziwangDefine()
		{
		}
		
		/**系统文本*/
		public static function getScoreStr(num:int):String
		{
			var str:String = "";
			if(num < 100000)
			{
				str = num+"";
			}
			else if(num < 100000000)
			{
				str = Math.floor(num/10000) + "万";
			}
			else
			{
				str = Math.floor(num/100000000) + "亿";
			}
			return str;
		}
		
		/**美术字*/
		public static function getScoreStr1(num:int):String
		{
			var str:String = "";
			if(num < 100000)
			{
				str = num+"";
			}
			else if(num < 100000000)
			{
				str = Math.floor(num/10000) + "w";
			}
			else
			{
				str = Math.floor(num/100000000) + "y";
			}
			return str;
		}
		
		public static function getPortraitBg():String
		{
			return "";
		}
		
		public static function getPortraitImage(gender:int,faceID:int):String
		{
			var index:int = faceID % 4;
			var str:String;
			if(gender == 0)
			{
				str = "ui/baseUI/lob_men_" + index + ".jpg";
			}
			else
			{
				str = "ui/baseUI/lob_women_" + index + ".jpg";
			}
			return str;
		}
	}
}