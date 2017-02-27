package managers.baoziwang
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.ui.View;
	
	import managers.DataProxy;
	
	import ui.chatCellUI;
	
	public class ChatCell extends chatCellUI
	{
		public function ChatCell()
		{
			super();
		}
		
		public function updateInfo(obj:Object):void
		{
			//			vo["wChatLength"]				//信息长度
			//			vo["dwChatColor"]				//信息颜色
			//			vo["dwSendUserID"]				//发送用户
			//			vo["dwTargetUserID"]			//目标用户
			//			vo["szChatString"]				//聊天信息
			var chatBg:Image = getChildByName("chatBg") as Image;
			var portraitBox:Box = getChildByName("portraitBox") as Box;
			var portraitImage:Image = portraitBox.getChildByName("portraitImage") as Image;
			var chatLabel:Label = getChildByName("chatLabel") as Label;
			var nameLabel:Label = getChildByName("nameLabel") as Label;
			
			var userInfo:Object = DataProxy.userInfoDic[obj.dwSendUserID];
			if(userInfo)
			{
				portraitImage.skin = BaoziwangDefine.getPortraitImage(userInfo.cbGender,userInfo.wFaceID);
				nameLabel.text = userInfo.szNickName;
			}
			chatLabel.text = obj.szChatString;
			chatBg.height = chatLabel.textField.textHeight + 14;
			
			if((chatBg.height + 34) < 70)
			{
				this.height = 70;
			}
			else
			{
				this.height = chatBg.height + 34;
			}
		}
		
	}
}