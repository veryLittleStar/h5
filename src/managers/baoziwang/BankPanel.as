package managers.baoziwang
{
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.CheckBox;
	import laya.ui.Label;
	import laya.ui.Radio;
	import laya.ui.Tab;
	import laya.utils.Handler;
	
	import managers.DataProxy;
	import managers.ManagersMap;
	
	import net.NetProxy;
	
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
		private var allSaveCheckBox:CheckBox;
		private var allGetCheckBox:CheckBox;
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
			allSaveCheckBox		= bankTabBox.getChildByName("allSaveCheckBox") as CheckBox;
			allGetCheckBox		= bankTabBox.getChildByName("allGetCheckBox") as CheckBox;
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
			
			goldNumInput.restrict = "0-9";
			savePwdInput.type = Input.TYPE_PASSWORD;
			savePwdInput.prompt = "存款不需要输入密码";
			givePwdInput.type = Input.TYPE_PASSWORD;
			giveGoldNumInput.restrict = "0-9";
			targetUserIDInput.prompt = "请输入玩家的游戏ID";
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
					ManagersMap.gameLoginManager.sitDown();
					break;
				case saveGoldBtn:
					saveGoldClick();
					break;
				case getGoldBtn:
					getGoldClick();
					break;
				case sureGiveBtn:
					sureGiveClick();
					break;
			}
		}
		
		public function openMe():void
		{
			this.visible = true;
			var body:Object = {};
			body.cbActivityGame 	= 0;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BANK_INSURE_INFO_REQ,body);
		}
		
		public function closeMe():void
		{
			this.visible = false;
		}
		
		public function bankInsureInfoRec(obj:Object):void
		{
			//vo["cbActivityGame"] 					//游戏动作
			//vo["wRevenueTake"] 					//税收比例
			//vo["wRevenueTransfer"] 				//转账税收比例
			//vo["wServerID"] 						//房间标识
			//vo["lUserScore"] 						//用户金币
			//vo["lUserInsure"] 					//银行金币
			//vo["lTransferPrerequisite"] 			//转账条件
			updateSocre(obj.lUserScore,obj.lUserInsure);
		}
		
		public function bankInsureSuccessRec(obj:Object):void
		{
//			vo["cbActivityGame"] 				//游戏动作
//			vo["lUserScore"] 					//身上金币
//			vo["lUserInsure"] 					//银行金币
//			vo["wLength"] 						//消息长度
//			vo["szDescribeString"] 				//描述消息
			updateSocre(obj.lUserScore,obj.lUserInsure);
			ManagersMap.systemMessageManager.showSysMessage(obj.szDescribeString);
		}
		
		public function bankInsureFailureRec(obj:Object):void
		{
//			vo["cbActivityGame"] 				//游戏动作
//			vo["lErrorCode"] 					//错误代码
//			vo["wLength"] 						//消息长度
//			vo["szDescribeString"] 				//描述消息
			ManagersMap.systemMessageManager.showSysMessage(obj.szDescribeString);
		}
		
		private function updateSocre(pocketScore:int,bankScore:int):void
		{
			inPocketGoldLabel.text = pocketScore + "";
			inBankGoldLabel.text = bankScore + "";
		}
		
		private function saveGoldClick():void
		{
			var saveNum:int = 0;
			if(allSaveCheckBox.selected)
			{
				saveNum = parseInt(inPocketGoldLabel.text);
			}
			else
			{
				saveNum = parseInt(goldNumInput.text);
			}
			
			var body:Object = {};
			body.cbActivityGame 	= 1;
			body.lSaveScore			= saveNum;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BANK_SAVE_SCORE_REQ,body);
		}
		
		private function getGoldClick():void
		{
			var takeNum:int = 0;
			if(allGetCheckBox.selected)
			{
				takeNum = parseInt(inBankGoldLabel.text);
			}
			else
			{
				takeNum = parseInt(goldNumInput.text);
			}
			var body:Object = {};
			body.cbActivityGame 	= 2;
			body.lTakeScore			= takeNum;
			body.szInsurePass		= savePwdInput.text;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BANK_TAKE_SCORE_REQ,body);
		}
		
		private function sureGiveClick():void
		{
			var body:Object = {};
			body.cbActivityGame 	= 3;
			body.cbByNickName		= 0;
			body.lTransferScore		= parseInt(giveGoldNumInput.text); 
			body.szNickName			= targetUserIDInput.text;
			body.szInsurePass		= givePwdInput.text;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BANK_TRANSFER_SCORE_REQ,body);
		}
		
	}
}