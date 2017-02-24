package managers.baoziwang
{
	import laya.ui.Image;
	
	public class LittleChip extends Image
	{
		public var info:Object;
		public function LittleChip(skin:String=null)
		{
			super(skin);
			this.mouseEnabled = false;
		}
		
		public function updateInfo(obj:Object):void
		{
			//obj["wChairID"] 			//用户位置
			//obj["cbJettonArea"]		//筹码区域
			//obj["lJettonScore"]		//加注数目
			//obj["cbAndroid"]			//机器人
			info = obj;
			skin = "ui/baseUI/sgj_chip_x_"+BaoziwangDefine.getChipIndex(obj.lJettonScore)+".png";
		}
	}
}