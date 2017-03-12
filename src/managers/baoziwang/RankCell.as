package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	
	public class RankCell extends Box
	{
		public function RankCell()
		{
			super();
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var userRankLabel:Label = getChildByName("userRankLabel") as Label;
			var userNameLabel:Label = getChildByName("userNameLabel") as Label;
			var userScoreLabel:Label = getChildByName("userScoreLabel") as Label;
			var portraitBox:Box = getChildByName("portraitBox") as Box;
			var portraitImage:Image = portraitBox.getChildByName("portraitImage") as Image;
			var portraitBg:Image = portraitBox.getChildByName("portraitBg") as Image;
			
			userRankLabel.text = "排名："+ value.rankIndex;
			userNameLabel.text = "昵称："+ value.szNickName;
			userScoreLabel.text = BaoziwangDefine.getScoreStr(value.lScore);
			portraitImage.skin = BaoziwangDefine.getPortraitImage(value.cbGender,value.wFaceID);
		}
	}
}