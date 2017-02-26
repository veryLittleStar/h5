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
			var nameLabel:Label = getChildByName("nameLabel") as Label;
			var scoreLabel:Label = getChildByName("scoreLabel") as Label;
			var userInfo:Object = DataProxy.getUserInfoByChairID(value);
			if(userInfo)
			{
				nameLabel.text = userInfo.szNickName;
				scoreLabel.text = BaoziwangDefine.getScoreStr(userInfo.lScore);
			}
		}
		
		public function updateIndex(index:int):void
		{
			var indexLabel:Label = getChildByName("indexLabel") as Label;
			indexLabel.text = (index+1) + "";
		}
	}
}