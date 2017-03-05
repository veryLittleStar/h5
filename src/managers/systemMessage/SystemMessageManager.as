package managers.systemMessage
{
	import laya.display.Text;
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.ManagerBase;
	
	import system.UILayer;
	
	public class SystemMessageManager extends ManagerBase
	{
		private var showArr:Array = [];
		public function SystemMessageManager(uiClass:Class=null)
		{
			super(uiClass);
			Laya.stage.on(Event.KEY_UP,this,key_up);
		}
		
		private function key_up():void
		{
		}
		
		public function systemMessageRec(obj:Object):void
		{
			//vo["wType"]			//消息类型
			//vo["wLength"]			//消息长度
			//vo["szString"]		//消息内容  实际并不会发1024 最多1024
			showSysMessage(obj.szString);
		}
		
		public function userRequestFailureRec(obj:Object):void
		{
//			vo["lErrorCode"]				//错误代码
//			vo["wlength"]						
//			vo["szDescribeString"]			//描述信息
			switch(obj.lErrorCode)
			{
				case 4:
					showSysMessage("正在游戏当中不能进入银行");
					break;
				default:
					showSysMessage(obj.szDescribeString);
					break;
			}
		}
		
		public function showSysMessage(str:String):void
		{
			moveShowText();
			var text:Text = new Text();
			text.fontSize = 20;
			text.color = "#f4f3ec";
			text.text = str;
			UILayer.layerAlert.addChild(text);
			text.x = (Laya.stage.width - text.textWidth)/2;
			text.y = Laya.stage.height - 100;
			showArr.push(text);
			Laya.timer.once(3000,this,delayText,[text],false);
		}
		
		private function delayText(text:Text):void
		{
			Tween.to(text,{alpha:0},500,null,Handler.create(this,removeText,[text]));
		}
		
		private function removeText(text:Text):void
		{
			text.removeSelf();
		}
		
		private function moveShowText():void
		{
			var i:int;
			for(i = 0;i < showArr.length;i++)
			{
				var text:Text = showArr[i];
				text.y = text.y - text.textHeight - 5;
			}
		}
		
	}
}