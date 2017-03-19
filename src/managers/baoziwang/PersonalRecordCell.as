package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Label;
	
	public class PersonalRecordCell extends Box
	{
		public function PersonalRecordCell()
		{
			super();
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var recordLabel:Label = getChildByName("recordLabel") as Label;
			var bigLabel:Label = getChildByName("bigLabel") as Label;
			var smallLabel:Label = getChildByName("smallLabel") as Label;

			//value.winScore
			//value.small
			//value.big
			//value.isBanker
			//value.time
			//value.result
			var resultStr:String = "";
			switch(value.result)
			{
				case BaoziwangDefine.RESULT_SMALL:
					resultStr = "【小】"
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					resultStr = "【豹子】"
					break;
				case BaoziwangDefine.RESULT_BIG:
					resultStr = "【大】"
					break;
			}
			var winStr:String = "";
			if(value.winScore >= 0)
			{
				winStr = "赢";
			}
			else
			{
				winStr = "输";
			}
			recordLabel.text = value.time + " 本局开"+resultStr + "，"+winStr+"：" + Math.abs(value.winScore);
			if(value.isBanker)
			{
				bigLabel.text = "";
				smallLabel.text = "本局坐庄";
			}
			else
			{
				bigLabel.text = "下注【大】：" + value.big;
				smallLabel.text = "下注【小】：" + value.small;
			}
		}
	}
}