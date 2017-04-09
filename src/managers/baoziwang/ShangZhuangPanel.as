package managers.baoziwang
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.ui.List;
	
	import managers.DataProxy;
	
	import net.NetProxy;
	
	public class ShangZhuangPanel extends Box
	{
		private var bgMask:Sprite;
		private var bgImage:Image;
		private var conditionLabel:Label;
		private var playerList:List;
		private var applyBtn:Button;
		private var cancelBtn:Button;
		private var closeBtn:Button;
		
		public function ShangZhuangPanel()
		{
			super();
		}
		
		public function init():void
		{
			bgMask = new Sprite();
			bgMask.graphics.drawRect(0,0,Laya.stage.width,Laya.stage.height,"#000000");
			bgMask.alpha = 0.6;
			this.addChildAt(bgMask,0);
			
			bgImage = getChildByName("bgImage") as Image;
			
			conditionLabel = bgImage.getChildByName("conditionLabel") as Label;
			playerList = bgImage.getChildByName("playerList") as List;
			applyBtn = bgImage.getChildByName("applyBtn") as Button;
			cancelBtn = bgImage.getChildByName("cancelBtn") as Button;
			closeBtn = bgImage.getChildByName("closeBtn") as Button;
			
			this.visible = false;
			this.on(Event.CLICK,this,onClick);
			playerList.array = [];
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target)
			{
				case applyBtn:
					NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_APPLY_BANKER_REQ,{});
					break;
				case cancelBtn:
					NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_CANCEL_BANKER_REQ,{});
					break;
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
		
		public function szConditonUpdate(num:int):void
		{
			conditionLabel.text = "申请上庄条件："+BaoziwangDefine.getScoreStr(num)+"金币";
		}
		
		public function addApplyBanker(chairID:int):void
		{
			playerList.addItem({chairID:chairID,index:playerList.length});
		}
		
		public function removeApplyBanker(szName:String):void
		{
			var i:int;
			for(i = 0; i < playerList.array.length; i++)
			{
				var userInfo:Object = DataProxy.getUserInfoByChairID(playerList.array[i].chairID);
				if(userInfo.szNickName == szName)
				{
					playerList.deleteItem(i);
					break;
				}
			}
			updateBankerListIndex();
		}
		
		public function removeApplyBankerAll():void
		{
			playerList.array = [];
		}
		
		private function updateBankerListIndex():void
		{
			var i:int;
			for(i = 0; i < playerList.array.length; i++)
			{
				var item:Object = playerList.getItem(i);
				item.index = i;
				playerList.changeItem(i,item);
			}
		}
		
		public function updateMyBankerBtn():void
		{
			switch(DataProxy.myBankerState)
			{
				case 0:
					applyBtn.visible = true;
					cancelBtn.visible = false;
					break;
				case 1:
					applyBtn.visible = false;
					cancelBtn.visible = true;
					break;
				case 2:
					applyBtn.visible = false;
					cancelBtn.visible = true;
					break;
			}
		}
	}
}