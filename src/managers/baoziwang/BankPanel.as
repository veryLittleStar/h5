package managers.baoziwang
{
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Label;
	import laya.ui.Radio;
	import laya.ui.Tab;
	import laya.utils.Handler;
	
	public class BankPanel extends Box
	{
		private var bgMask:Sprite;
		
		private var closeBtn:Button;
		private var bankTypeBox:Box;
		private var bankTab:Tab;
		private var inPocketGoldLabel:Label;
		private var inBankGoldLabel:Label;
		
		private var bankTabBox:Box;
		private var getGoldBtn:Button;
		private var saveGoldBtn:Button;
		private var allSaveRadio:Radio;
		private var allGetRadio:Radio;
		private var goldNumInput:Input;
		private var savePwdInput:Input;
		
		private var giveTabBox:Box;
		private var targetUserIDInput:Input;
		private var giveGoldNumInput:Input;
		private var givePwdInput:Input;
		private var sureGiveBtn:Input;
		
		public function BankPanel()
		{
			super();
		}
		
		public function init():void
		{
			bgMask = new Sprite();
			bgMask.graphics.drawRect(0,0,Laya.stage.width,Laya.stage.height,"#000000");
			bgMask.alpha = 0.6;
			this.addChildAt(bgMask,0);
			
			bankTypeBox 		= getChildByName("bankTypeBox") as Box;
			closeBtn 			= bankTypeBox.getChildByName("closeBtn") as Button;
			bankTab				= bankTypeBox.getChildByName("bankTab") as Tab;
			inPocketGoldLabel	= bankTypeBox.getChildByName("inPocketGoldLabel") as Label;
			inBankGoldLabel		= bankTypeBox.getChildByName("inBankGoldLabel") as Label;
			
			bankTabBox			= bankTypeBox.getChildByName("bankTabBox") as Box;
			getGoldBtn			= bankTabBox.getChildByName("getGoldBtn") as Button;
			saveGoldBtn			= bankTabBox.getChildByName("saveGoldBtn") as Button;
			allSaveRadio		= bankTabBox.getChildByName("allSaveRadio") as Radio;
			allGetRadio			= bankTabBox.getChildByName("allGetRadio") as Radio;
			goldNumInput		= bankTabBox.getChildByName("goldNumInput") as Input;
			savePwdInput		= bankTabBox.getChildByName("savePwdInput") as Input;
			
			giveTabBox			= bankTypeBox.getChildByName("giveTabBox") as Box;
			targetUserIDInput	= giveTabBox.getChildByName("targetUserIDInput") as Input;
			giveGoldNumInput	= giveTabBox.getChildByName("giveGoldNumInput") as Input;
			givePwdInput		= giveTabBox.getChildByName("givePwdInput") as Input;
			sureGiveBtn			= giveTabBox.getChildByName("sureGiveBtn") as Input;
			
			bankTab.selectHandler = Handler.create(this,bankTabSelect,null,false);
			bankTabSelect();
			this.on(Event.CLICK,this,onClick);
		}
		
		private function bankTabSelect():void
		{
			if(bankTab.selectedIndex == 0)
			{
				bankTabBox.visible = true;
				giveTabBox.visible = false;
			}
			else
			{
				bankTabBox.visible = false;
				giveTabBox.visible = true;
			}
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target)
			{
				case closeBtn:
					closeMe();
					break;
			}
		}
		
		public function openMe():void
		{
			this.visible = true;
		}
		
		public function closeMe():void
		{
			this.visible = false;
		}
	}
}