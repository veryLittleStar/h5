package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Label;
	
	import managers.DataProxy;
	
	public class ApplyCell extends Box
	{
		public function ApplyCell()
		{
			super();
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var nameLabel:Label = getChildByName("nameLabel") as Label;
			var scoreLabel:Label = getChildByName("scoreLabel") as Label;
			var indexLabel:Label = getChildByName("indexLabel") as Label;
			indexLabel.text = (value.index+1) + "";
			var userInfo:Object = DataProxy.getUserInfoByChairID(value.chairID);
			if(userInfo)
			{
				nameLabel.text = userInfo.szNickName;
				scoreLabel.text = BaoziwangDefine.getScoreStr(userInfo.lScore);
			}
		}
		
	}
}