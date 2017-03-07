package managers.baoziwang
{
	import laya.maths.Point;
	import laya.ui.Image;
	import laya.ui.View;
	
	import managers.ManagersMap;

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
		
		public static const MSG_BZW_ALL_IN_JETION_REQ:String = "200_5";
		
		public static const MSG_BZW_PLACE_JETION_REC:String = "200_101";
		
		public static const MSG_BZW_PLACE_JETION_FAIL_REC:String = "200_107";
		
		public static const MSG_BZW_APPLY_BANKER_REQ:String = "200_2";
		
		public static const MSG_BZW_APPLY_BANKER_REC:String = "200_103";
		
		public static const MSG_BZW_CANCEL_BANKER_REQ:String = "200_3";
		
		public static const MSG_BZW_CANCEL_BANKER_REC:String = "200_108";
		
		public static const MSG_BZW_CHANGE_BANKER_REC:String = "200_104";
		
		public static const MSG_BANK_INSURE_INFO_REQ:String = "25_1";
		
		public static const MSG_BANK_SAVE_SCORE_REQ:String = "25_2";
		
		public static const MSG_BANK_TAKE_SCORE_REQ:String = "25_3";
		
		public static const MSG_BANK_TRANSFER_SCORE_REQ:String = "25_4";
		
		public static const MSG_BANK_INSURE_INFO_REC:String = "25_100";
		
		public static const MSG_BANK_INSURE_SUCCESS_REC:String = "25_101";
		
		public static const MSG_BANK_INSURE_FAILURE_REC:String = "25_102";
		
		public static const MSG_BANK_CHANGE_PWD_REQ:String = "25_6";
		
		public static const MSG_BANK_CHANGE_PWD_REC:String = "25_104";
		
		public static const MSG_BZW_SELF_OPTION_CHANGE_REQ:String = "200_6";
		
		public static const MSG_BZW_SELF_OPTION_CHANGE_REC:String = "200_6";
		
		/////////////////////////
		public static const RESULT_BIG:int 	= 0;
		public static const RESULT_BAOZI:int 	= 1;
		public static const RESULT_SMALL:int 	= 2;
		////////////////////////////////////////////
		public static const GAME_STATUS_FREE:int = 0;
		public static const GAME_STATUS_START:int = 100;
		public static const GAME_STATUS_END:int = 101;
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
		
		public static function getChipIndex(chipScore:int):int
		{
			var chipIndex:int = 0;
			switch(chipScore)
			{
				case 100:
					chipIndex = 1;
					break;
				case 1000:
					chipIndex = 2;
					break;
				case 5000:
					chipIndex = 3;
					break;
				case 10000:
					chipIndex = 4;
					break;
				case 100000:
					chipIndex = 5;
					break;
			}
			return chipIndex;
		}
		
		
		public static function getChipScore(chipIndex:int):int
		{
			var score:int = 0;
			switch(chipIndex)
			{
				case 1:
					score = 100;
					break;
				case 2:
					score = 1000;
					break;
				case 3:
					score = 5000;
					break;
				case 4:
					score = 10000;
					break;
				case 5:
					score = 100000;
					break;
			}
			return score;
		}
		
		public static function getDiceTargetPoint(result:int):Point
		{
			var target:Image = ManagersMap.baoziwangManager.ui.xLightBtn;
			switch(result)
			{
				case BaoziwangDefine.RESULT_SMALL:
					target = ManagersMap.baoziwangManager.ui.xLightBtn;
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					target = ManagersMap.baoziwangManager.ui.bankerImage;
					break;
				case BaoziwangDefine.RESULT_BIG:
					target = ManagersMap.baoziwangManager.ui.dLightBtn;
					break;
			}
			var point:Point = new Point();
			point.x = target.x + target.width/2;
			point.y = target.y + target.height/2;
			return point;
		}
	}
}