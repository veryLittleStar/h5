package managers.baoziwang
{
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.ui.List;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	import managers.ManagersMap;
	import managers.gameLogin.GameLoginDefine;
	
	import net.NetProxy;
	
	public class MainPanelTop extends Box
	{
		private var recordList:List;
		private var recordListBox:Box;
		private var recordArr:Array;
		private var applySZBtn:Button;
		private var applyingSZBtn:Button;
		private var ingSZBtn:Button;
		private var bankerImage:Image;
		private var bankerNameLabel:Label;
		private var bankerScoreLabel:Label;
		private var bankerPortrait:Box;
		private var portraitImage:Image;
		
		private var tempImage:Image;
		
		public function MainPanelTop()
		{
			super();
		}
		
		public function init():void
		{
			recordListBox = getChildByName("recordListBox") as Box;
			recordList = recordListBox.getChildByName("recordList") as List;
			recordListBox.scrollRect = new Rectangle(0,0,180,26);
			
			applySZBtn = getChildByName("applySZBtn") as Button;
			applyingSZBtn = getChildByName("applyingSZBtn") as Button;
			ingSZBtn = getChildByName("ingSZBtn") as Button;
			this.on(Event.CLICK,this,onClick);
			
			bankerImage = getChildByName("bankerImage") as Image;
			bankerNameLabel = getChildByName("bankerNameLabel") as Label;
			bankerScoreLabel = getChildByName("bankerScoreLabel") as Label;
			
			bankerPortrait = getChildByName("bankerPortrait") as Box;
			portraitImage = bankerPortrait.getChildByName("portraitImage") as Image;
			
			bankBtn = getChildByName("bankBtn") as Button;
			configBtn = getChildByName("configBtn") as Button;
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target)
			{
				case applySZBtn:
					ManagersMap.baoziwangManager.ui.shangZhuangPanel.openMe();
					break;
				case applyingSZBtn:
					ManagersMap.baoziwangManager.ui.shangZhuangPanel.openMe();
					break;
				case ingSZBtn:
					ManagersMap.baoziwangManager.ui.shangZhuangPanel.openMe();
					break;
				case bankBtn:
					openBankBtn();
					break;
				case configBtn:
					
					break;
			}
		}
		
		public function recordInit(arr:Array):void
		{
			recordArr = arr;
			freshRecord();
		}
		
		public function pushRecord(result:int):void
		{
			if(!tempImage)
			{
				tempImage = new Image(getRecordSkin(result));
				tempImage.pivotX = tempImage.x = tempImage.width/2;
				tempImage.pivotY = tempImage.y = tempImage.height/2;
				tempImage.visible = false;
				recordListBox.addChild(tempImage);
			}
			else
			{
				tempImage.skin = getRecordSkin(result);
			}
			Tween.to(recordList,{x:30},100,null,Handler.create(this,showNewRecord),5000,true);
		}
		
		private function showNewRecord():void
		{
			tempImage.visible = true;
			tempImage.scaleX = tempImage.scaleY = 1.5;
			Tween.to(tempImage,{scaleX:1,scaleY:1},100,null,Handler.create(this,showNewRecordEnd),0,true);
		}
		
		private function showNewRecordEnd():void
		{
			freshRecord();
		}
		
		private function freshRecord():void
		{
			Tween.clearTween(recordList);
			recordList.x = 0;
			if(tempImage)tempImage.visible = false;
			var i:int;
			for(i = 0; i < recordList.cells.length; i++)
			{
				var recordImage:Image = recordList.cells[i] as Image;
				var record:Object = recordArr[i];
				if(!record)
				{
					recordImage.visible = false;
				}
				else
				{
					recordImage.visible = true;
					recordImage.skin = getRecordSkin(record.cbResult);
				}
			}
		}
		
		private function getRecordSkin(result:int):String
		{
			var skin:String = "ui/baseUI/yb_bj_zs_01.png";
			switch(result)
			{
				case BaoziwangDefine.RESULT_SMALL:
					skin = "ui/baseUI/yb_bj_zs_01.png";
					break;
				case BaoziwangDefine.RESULT_BIG:
					skin = "ui/baseUI/yb_bj_zs_02.png";
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					skin = "ui/baseUI/yb_bj_zs_03.png";
					break;
			}
			return skin;
		}
		
		public function updateBankerInfo():void
		{
			if(DataProxy.bankerChairID == 65535)
			{
				bankerNameLabel.text = "老炮王";
				bankerScoreLabel.text = "100亿";
				bankerImage.visible = true;
				bankerPortrait.visible = false;
			}
			else
			{
				bankerImage.visible = false;
				bankerPortrait.visible = true;
				bankerScoreLabel.text = BaoziwangDefine.getScoreStr(DataProxy.bankerSocre);
				
				var bankerInfo:Object = DataProxy.getUserInfoByChairID(DataProxy.bankerChairID);
				if(bankerInfo)
				{
					bankerNameLabel.text = bankerInfo.szNickName;
					portraitImage.skin = BaoziwangDefine.getPortraitImage(bankerInfo.cbGender,bankerInfo.wFaceID);
				}
			}
			
		}
		
		public function updateBankerBtn():void
		{
			switch(DataProxy.myBankerState)
			{
				case 0:
					applySZBtn.visible = true;
					applyingSZBtn.visible = false;
					ingSZBtn.visible = false;
					break;
				case 1:
					applySZBtn.visible = false;
					applyingSZBtn.visible = true;
					ingSZBtn.visible = false;
					break;
				case 2:
					applySZBtn.visible = false;
					applyingSZBtn.visible = false;
					ingSZBtn.visible = true;
					break;
			}
		}
		
		private function openBankBtn():void
		{
			var body:Object = {};
			body.wTableID 	= DataProxy.tableID;
			body.wChairID 	= DataProxy.chairID;
			body.cbForceLeave 	= 0;
			NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_USER_STAND_UP_REQ,body);
		}
	}
}