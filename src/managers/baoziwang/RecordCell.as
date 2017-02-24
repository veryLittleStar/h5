package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	
	public class RecordCell extends Box
	{
		private var bgImage:Image;
		private var dxImage:Image;
		private var dice0Image:Image;
		private var dice1Image:Image;
		private var dice2Image:Image;
		private var pointLabel:Label;
		public function RecordCell()
		{
			super();
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var bgImage:Image 		= getChildByName("bgImage") as Image;
			var dxImage:Image 		= getChildByName("dxImage") as Image;
			var dice0Image:Image 	= getChildByName("dice0Image") as Image;
			var dice1Image:Image 	= getChildByName("dice1Image") as Image;
			var dice2Image:Image 	= getChildByName("dice2Image") as Image;
			var pointLabel:Label 	= getChildByName("pointLabel") as Label;
			//	obj.cbResult
			//	obj.cbDice0
			//	obj.cbDice1
			//	obj.cbDice2
			if(value.arIndex == 0)
			{
				bgImage.visible = true;
			}
			else
			{
				bgImage.visible = false;
			}
			switch(value.cbResult)
			{
				case BaoziwangDefine.RESULT_SMALL:
					dxImage.skin = "ui/baseUI/yb_bj_zs_01.png";
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					dxImage.skin = "ui/baseUI/yb_bj_zs_03.png";
					break;
				case BaoziwangDefine.RESULT_BIG:
					dxImage.skin = "ui/baseUI/yb_bj_zs_02.png";
					break;
			}
			
			dice0Image.skin = "ui/baseUI/ttz_sezi_d_"+value.cbDice0+".png";
			dice1Image.skin = "ui/baseUI/ttz_sezi_d_"+value.cbDice1+".png";
			dice2Image.skin = "ui/baseUI/ttz_sezi_d_"+value.cbDice2+".png";
			
			var totalDice:int = value.cbDice0 + value.cbDice1 + value.cbDice2;
			pointLabel.text = totalDice + "";
		}
	}
}