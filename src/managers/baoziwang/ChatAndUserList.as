package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	
	public class ChatAndUserList extends Box
	{
		private var bgImage:Image;
		private var userArrow:Image;
		private var chatArrow:Image;
		private var userBtn:Box;
		private var chatBtn:Box;
		private var userList:List;
		
		private var _showState:int = 0;
		private var _choseState:int = 1;
		public function ChatAndUserList()
		{
			super();
		}
		
		public function init():void
		{
			bgImage = getChildByName("bgImage") as Image;
			userArrow = getChildByName("userArrow") as Image;
			chatArrow = getChildByName("chatArrow") as Image;
			userBtn = getChildByName("userBtn") as Box;
			chatBtn = getChildByName("chatBtn") as Box;
			userList = getChildByName("userList") as List;
			userBtn.on(Event.CLICK,this,userClick);
			chatBtn.on(Event.CLICK,this,chatClick);
			freshState();
			userList.array = [];
			this.x = -295;
		}
		
		private function chatClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 0;
			}
			else
			{
				if(_choseState == 0)
				{
					showState = 0;
				}
				choseState = 0;
			}
		}
		
		private function userClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 1;
			}
			else
			{
				if(_choseState == 1)
				{
					showState = 0;
				}
				choseState = 1;
			}
		}
		
		private function set showState(value:int):void
		{
			if(_showState == value)return;
			_showState = value;
			freshState();
			if(_showState == 0)
			{
				Tween.to(this,{x:-295},500,null,null,0,true);
				Laya.stage.off(Event.MOUSE_UP,this,stageMouseUp);
			}
			else
			{
				Tween.to(this,{x:-5},500,null,null,0,true);
				Laya.stage.on(Event.MOUSE_UP,this,stageMouseUp);
			}
		}
		
		private function stageMouseUp(event:Event = null):void
		{
			if(this.hitTestPoint(event.stageX,event.stageY))
			{
				
			}
			else
			{
				showState = 0;
			}
		}
		
		private function set choseState(value:int):void
		{
			if(_choseState == value)return;
			_choseState = value;
			freshState();
		}
		
		private function freshState():void
		{
			if(_showState == 0)	//隐藏聊天和玩家列表
			{
				userArrow.skin = "ui/baseUI/ttz_talk_j2.png";
				chatArrow.skin = "ui/baseUI/ttz_talk_j2.png";
			}
			else				//显示聊天和玩家列表
			{
				userArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				chatArrow.skin = "ui/baseUI/ttz_talk_j1.png";
			}
			if(_choseState == 0)//选中聊天
			{
				chatArrow.visible = true;
				userArrow.visible = false;
				userList.visible = false;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_2.png";
			}
			else				//选中玩家
			{
				chatArrow.visible = false;
				userArrow.visible = true;
				userList.visible = true;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_1.png";
			}
		}
		
		public function updateUserInfo(userID:int):void
		{
			var userInfo:Object = DataProxy.userInfoDic[userID];
			if(!userInfo)return;
			var i:int = 0;
			var exist:Boolean = false;
			for(i = 0;i < userList.array.length; i++)
			{
				var obj:Object = userList.array[i];
				if(obj.dwUserID == userID)
				{
					userList.changeItem(i,userInfo);
					exist = true;
					break;
				}
			}
			if(exist == false)
			{
				userList.addItem(userInfo);
			}
		}
	}
}