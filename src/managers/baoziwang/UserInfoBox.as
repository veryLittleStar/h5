package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	
	import managers.ManagersMap;
	
	public class UserInfoBox extends Box
	{
		public function UserInfoBox()
		{
			super();
			this.on(Event.CLICK,this,onClick);
		}
		
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (!value)return;
			var userName:Label = getChildByName("userName") as Label;
			var userScore:Label = getChildByName("userScore") as Label;
			var portraitBox:Box = getChildByName("portraitBox") as Box;
			var portraitImage:Image = portraitBox.getChildByName("portraitImage") as Image;
			var portraitBg:Image = portraitBox.getChildByName("portraitBg") as Image;
			
			userName.text = value.szNickName;
			userScore.text = BaoziwangDefine.getScoreStr(value.lScore);
			portraitImage.skin = BaoziwangDefine.getPortraitImage(value.cbGender,value.wFaceID);
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target.name)
			{
				case "sChatBtn":
					if(dataSource)
					{
						ManagersMap.baoziwangManager.ui.chatAndUserList.chatSL(dataSource.dwUserID);
					}
					break;
				case "sCloseBtn":
					if(dataSource)
					{
						ManagersMap.baoziwangManager.ui.chatAndUserList.closeChatSL(dataSource.dwUserID);
					}
					event.stopPropagation();
					return;
					break;
			}
			ManagersMap.baoziwangManager.ui.chatAndUserList.choseChatSL(this);
		}
		
		public function choseMe(bool:Boolean):void
		{
			var choseMask:Image = getChildByName("choseMask") as Image;
			if(bool)
			{
				choseMask.visible = true;
			}
			else
			{
				choseMask.visible = false;
			}
		}
	}
}