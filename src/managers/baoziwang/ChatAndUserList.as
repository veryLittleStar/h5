package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.ui.Panel;
	import laya.ui.TextInput;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	import managers.gameLogin.GameLoginDefine;
	
	import net.NetProxy;
	
	import ui.chatCellUI;
	
	public class ChatAndUserList extends Box
	{
		private var bgImage:Image;
		private var userArrow:Image;
		private var sChatArrow:Image;
		private var rChatArrow:Image;
		private var userBtn:Box;
		private var sChatBtn:Box;
		private var rChatBtn:Box;
		private var userList:List;
		private var rChatBox:Box;
		private var rChatPanel:Panel;
		private var rChatInput:TextInput;
		private var sChatBox:Box;
		private var sChatUserList:List;
		private var sChatInput:TextInput;
		private var sChatPanel:Panel;
		
		private var _showState:int = 0;
		private var _choseState:int = 1;
		private var chatCellArr:Array = [];
		
		private var sChatDataDic:Object = {};
		public function ChatAndUserList()
		{
			super();
		}
		
		public function init():void
		{
			bgImage = getChildByName("bgImage") as Image;
			userArrow = getChildByName("userArrow") as Image;
			sChatArrow = getChildByName("sChatArrow") as Image;
			rChatArrow = getChildByName("rChatArrow") as Image;
			userBtn = getChildByName("userBtn") as Box;
			sChatBtn = getChildByName("sChatBtn") as Box;
			rChatBtn = getChildByName("rChatBtn") as Box;
			userList = getChildByName("userList") as List;
			rChatBox = getChildByName("rChatBox") as Box;
			rChatInput = rChatBox.getChildByName("rChatInput") as TextInput;
			rChatPanel = rChatBox.getChildByName("rChatPanel") as Panel;
			sChatBox = getChildByName("sChatBox") as Box;
			sChatUserList = sChatBox.getChildByName("sChatUserList") as List;
			sChatInput = sChatBox.getChildByName("sChatInput") as TextInput;
			sChatPanel = sChatBox.getChildByName("sChatPanel") as Panel;
			
			sChatBtn.on(Event.CLICK,this,sChatClick);
			rChatBtn.on(Event.CLICK,this,rChatClick);
			userBtn.on(Event.CLICK,this,userClick);
			
			freshState();
			userList.array = [];
			this.x = -295;
			rChatInput.maxChars = 127;
			rChatInput.on(Event.ENTER,this,rChatInputEnter);
			sChatUserList.array = [];
			sChatInput.on(Event.ENTER,this,sChatInputEnter);
		}
		
		private function sChatClick(event:* = null):void
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
		
		private function rChatClick(event:* = null):void
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
		
		private function userClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 2;
			}
			else
			{
				if(_choseState == 2)
				{
					showState = 0;
				}
				choseState = 2;
			}
		}
		
		private function set showState(value:int):void
		{
			if(_showState == value)return;
			_showState = value;
			freshState();
			if(_showState == 0)
			{
				Tween.to(this,{x:-295},300,null,null,0,true);
				Laya.stage.off(Event.MOUSE_UP,this,stageMouseUp);
			}
			else
			{
				Tween.to(this,{x:-5},300,null,null,0,true);
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
				sChatArrow.skin = "ui/baseUI/ttz_talk_j2.png";
				rChatArrow.skin = "ui/baseUI/ttz_talk_j2.png";
			}
			else				//显示聊天和玩家列表
			{
				userArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				sChatArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				rChatArrow.skin = "ui/baseUI/ttz_talk_j1.png";
			}
			if(_choseState == 0)//选中私聊
			{
				sChatArrow.visible = true;
				rChatArrow.visible = false;
				userArrow.visible = false;
				sChatBox.visible = true;
				rChatBox.visible = false;
				userList.visible = false;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_0.png";
				if(sChatUserList.array.length && sChatUserList.selectedIndex == -1)
				{
					sChatUserList.selectedIndex = 0;
					sChatSelect();
				}
			}
			else if(_choseState == 1)//选中公聊
			{
				sChatArrow.visible = false;
				rChatArrow.visible = true;
				userArrow.visible = false;
				sChatBox.visible = false;
				rChatBox.visible = true;
				userList.visible = false;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_1.png";
			}
			else				//选中用户列表
			{
				sChatArrow.visible = false;
				rChatArrow.visible = false;
				userArrow.visible = true;
				sChatBox.visible = false;
				rChatBox.visible = false;
				userList.visible = true;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_2.png";
			}
		}
		
		public function updateUserInfo(userID:int):void
		{
			updateUserStatus(userID);
		}
		
		public function updateUserStatus(userID:int):void
		{
			var userInfo:Object = DataProxy.userInfoDic[userID];
			if(!userInfo)return;
			var i:int;
			var obj:Object;
			if(userInfo.cbUserStatus == GameLoginDefine.US_NULL || userInfo.cbUserStatus == GameLoginDefine.US_NULL)
			{
				for(i = 0;i < userList.array.length; i++)
				{
					obj = userList.array[i];
					if(obj.dwUserID == userID)
					{
						userList.deleteItem(i);
						break;
					}
				}
			}
			else
			{
				var exist:Boolean = false;
				for(i = 0;i < userList.array.length; i++)
				{
					obj = userList.array[i];
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
		
		private function rChatInputEnter(event:Event):void
		{
			if(rChatInput.text == "")
			{
				
			}
			else
			{
				var body:Object = {};
				body.wChatLength 	= rChatInput.text.length;
				body.dwChatColor 	= 0;
				body.dwTargetUserID = 0;
				body.szChatString 	= rChatInput.text;
				NetProxy.getInstance().sendToServer("100_10",body);
				rChatInput.text = "";
			}
		}
		
		private function sChatInputEnter(event:Event):void
		{
			if(sChatInput.text == "" || !sChatUserList.selectedItem)
			{
				
			}
			else
			{
				var body:Object = {};
				body.wChatLength 	= sChatInput.text.length;
				body.dwChatColor 	= 0;
				body.dwTargetUserID = sChatUserList.selectedItem.dwUserID;
				body.szChatString 	= sChatInput.text;
				NetProxy.getInstance().sendToServer("100_10",body);
				sChatInput.text = "";
			}
		}
		
		public function userChatRec(obj:Object):void
		{
			//			vo["wChatLength"]				//信息长度
			//			vo["dwChatColor"]				//信息颜色
			//			vo["dwSendUserID"]				//发送用户
			//			vo["dwTargetUserID"]			//目标用户
			//			vo["szChatString"]				//聊天信息
			if(obj.dwTargetUserID == 0)
			{
				if(chatCellArr.length >= 50)
				{
					Pool.recover("chatCellUI",chatCellArr.shift());
				}
				var chatCell:ChatCell = Pool.getItemByClass("chatCellUI",ChatCell);
				chatCell.updateInfo(obj);
				chatCellArr.push(chatCell);
				rChatPanel.addChild(chatCell);
				
				var i:int;
				var posY:int = 0;
				for(i = 0; i < chatCellArr.length; i++)
				{
					chatCell = chatCellArr[i];
					chatCell.x = -8;
					chatCell.y = posY;
					posY += chatCell.height;
				}
				rChatPanel.refresh();
				rChatPanel.scrollTo(0,posY);
			}
			else
			{
				var sChatCellArr:Array;
				var relateUserID:int = 0;
				if(obj.dwSendUserID == DataProxy.userID)
				{
					relateUserID = obj.dwTargetUserID;
				}
				if(obj.dwTargetUserID == DataProxy.userID)
				{
					relateUserID = obj.dwSendUserID;
				}
				sChatCellArr = sChatDataDic[relateUserID];
				if(!sChatCellArr)
				{
					sChatCellArr = [];
					sChatDataDic[relateUserID] = sChatCellArr;
				}
				if(sChatCellArr.length >= 50)
				{
					Pool.recover("chatCellUI",sChatCellArr.shift());
				}
				var sChatCell:ChatCell = Pool.getItemByClass("chatCellUI",ChatCell);
				sChatCell.updateInfo(obj);
				sChatCellArr.push(sChatCell);
				chatSL(relateUserID,false);
				if(relateUserID == sChatUserList.selectedItem.dwUserID)
				{
					freshSChatPanel();
				}
			}
			
		}
		
		private function freshSChatPanel():void
		{
			sChatPanel.removeChildren();
			if(!sChatUserList.selectedItem)return;
			var sChatCellArr:Array = sChatDataDic[sChatUserList.selectedItem.dwUserID];
			if(!sChatCellArr)return;
			var i:int;
			var posY:int = 0;
			var sChatCell:ChatCell;
			for(i = 0; i < sChatCellArr.length; i++)
			{
				sChatCell = sChatCellArr[i];
				sChatCell.x = -8;
				sChatCell.y = posY;
				posY += sChatCell.height;
				sChatPanel.addChild(sChatCell);
			}
			sChatPanel.refresh();
			sChatPanel.scrollTo(0,posY);
		}
		
		public function chatSL(userID:int,chose:Boolean = true):void
		{
			if(DataProxy.userID == userID)return;
			var userInfo:Object = DataProxy.userInfoDic[userID];
			if(!userInfo)return;
			var i:int = 0;
			var exist:Boolean = false;
			for(i = 0;i < sChatUserList.array.length; i++)
			{
				var obj:Object = sChatUserList.array[i];
				if(obj.dwUserID == userID)
				{
					sChatUserList.changeItem(i,userInfo);
					if(chose)
					{
						sChatUserList.selectedIndex = i;
						sChatSelect();
					}
					exist = true;
					break;
				}
			}
			if(exist == false)
			{
				sChatUserList.addItem(userInfo);
				(sChatUserList.getCell(i) as UserInfoBox).choseMe(false);
				if(chose)
				{
					sChatUserList.selectedIndex = i;
					sChatSelect();
				}
			}
			if(chose)
			{
				choseState = 0;
			}
			if(sChatUserList.selectedIndex == -1)
			{
				sChatUserList.selectedIndex = 0;
				sChatSelect();
			}
		}
		
		public function closeChatSL(userID:int):void
		{
			var i:int = 0;
			for(i = 0;i < sChatUserList.array.length; i++)
			{
				var obj:Object = sChatUserList.array[i];
				if(obj.dwUserID == userID)
				{
					sChatUserList.deleteItem(i);
					delete sChatDataDic[userID];
					sChatSelect();
					break;
				}
			}
		}
		
		public function choseChatSL(userInfoBox:UserInfoBox):void
		{
			var i:int;
			for(i = 0; i < sChatUserList.array.length; i++)
			{
				if(userInfoBox == sChatUserList.getCell(i))
				{
					sChatUserList.selectedIndex = i;
					sChatSelect();
					break;
				}
			}
		}
		
		private function sChatSelect():void
		{
			if(sChatUserList.array.length == 0)
			{
				sChatUserList.selectedIndex = -1;
			}
			else
			{
				if(sChatUserList.selectedIndex >= sChatUserList.array.length)
				{
					sChatUserList.selectedIndex = 0;
				}
			}
			var i:int;
			for(i = 0; i < sChatUserList.array.length; i++)
			{
				var userInfoBox:UserInfoBox = sChatUserList.getCell(i) as UserInfoBox;
				if(sChatUserList.selectedIndex == i)
				{
					userInfoBox.choseMe(true);
				}
				else
				{
					userInfoBox.choseMe(false);
				}
			}
			freshSChatPanel();
		}
	}
}