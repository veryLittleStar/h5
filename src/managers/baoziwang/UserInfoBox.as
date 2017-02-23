package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	
	public class UserInfoBox extends Box
	{
		public function UserInfoBox()
		{
			super();
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var userName:Label = getChildByName("userName") as Label;
			var userScore:Label = getChildByName("userScore") as Label;
			var portraitBox:Box = getChildByName("portraitBox") as Box;
			var portraitImage:Image = portraitBox.getChildByName("portraitImage") as Image;
			var portraitBg:Image = portraitBox.getChildByName("portraitBg") as Image;
			
			userName.text = value.szNickName;
			userScore.text = BaoziwangDefine.getScoreStr(value.lScore);
			portraitImage.skin = BaoziwangDefine.getPortraitImage(value.cbGender,value.wFaceID);
		}
	}
}