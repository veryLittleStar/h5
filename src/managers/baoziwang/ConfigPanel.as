package managers.baoziwang
{
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Label;
	
	import managers.ManagersMap;
	
	import net.NetProxy;
	
	public class ConfigPanel extends Box
	{
		private var bgMask:Sprite;
		
		private var closeBtn:Button;
		private var configBox:Box;
		private var changePassBtn:Button;
		private var limitNumLabel:Label;
		private var limitNumInput:Input;
		private var limitSureBtn:Button;
		private var passBox:Box;
		private var oldPassInput:Input;
		private var newPassInput:Input;
		private var ensureInput:Input;
		private var passSureBtn:Button;
		private var passReturnBtn:Button;
		
		public function ConfigPanel()
		{
			super();
		}
		
		public function init():void
		{
			bgMask = new Sprite();
			bgMask.graphics.drawRect(0,0,Laya.stage.width,Laya.stage.height,"#000000");
			bgMask.alpha = 0.6;
			this.addChildAt(bgMask,0);
			
			closeBtn 		= getChildByName("closeBtn") as Button;
			
			configBox 		= getChildByName("configBox") as Box;
			changePassBtn 	= configBox.getChildByName("changePassBtn") as Button;
			limitNumLabel 	= configBox.getChildByName("limitNumLabel") as Label;
			limitNumInput 	= configBox.getChildByName("limitNumInput") as Input;
			limitSureBtn	= configBox.getChildByName("limitSureBtn") as Button;
			
			passBox 		= getChildByName("passBox") as Box;
			oldPassInput 	= passBox.getChildByName("oldPassInput") as Input;
			newPassInput 	= passBox.getChildByName("newPassInput") as Input;
			ensureInput 	= passBox.getChildByName("ensureInput") as Input;
			passSureBtn 	= passBox.getChildByName("passSureBtn") as Button;
			passReturnBtn 	= passBox.getChildByName("passReturnBtn") as Button;
			
			this.visible = false;
			this.on(Event.CLICK,this,onClick);
			
			limitNumInput.restrict = "0-9";
			oldPassInput.restrict = "0-9";
			newPassInput.restrict = "0-9";
			ensureInput.restrict = "0-9";
			oldPassInput.type = Input.TYPE_PASSWORD;
			newPassInput.type = Input.TYPE_PASSWORD;
			ensureInput.type = Input.TYPE_PASSWORD;
			oldPassInput.prompt = "未设置密码时无需输入";
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target)
			{
				case closeBtn:
					closeMe();
					break;
				case changePassBtn:
					showPassBox(true);
					break;
				case passReturnBtn:
					showPassBox(false);
					break;
				case passSureBtn:
					passSureClick();
					break;
				case limitSureBtn:
					limitSureClick();
					break;
			}
		}
		
		public function openMe():void
		{
			this.visible = true;
			showPassBox(false);
		}
		
		public function closeMe():void
		{
			this.visible = false;
		}
		
		private function showPassBox(bool:Boolean):void
		{
			if(bool)
			{
				oldPassInput.text = "";
				newPassInput.text = "";
				ensureInput.text = "";
				passBox.visible = true;
				configBox.visible = false;
			}
			else
			{
				passBox.visible = false;
				configBox.visible = true;
			}
		}
		
		public function updateLimitNum(limitNum:int):void
		{
			if(limitNum == 0)
			{
				limitNumLabel.text = "无限制";
			}
			else
			{
				limitNumLabel.text = limitNum + "";
			}
			limitNumInput.text = "";
		}
		
		private function passSureClick():void
		{
			if(newPassInput.text != ensureInput.text)
			{
				ManagersMap.systemMessageManager.showSysMessage("两次输入的新密码不一致");
				return;
			}
			var body:Object = {};
			body.szDesPassword = newPassInput.text;
			body.szScrPassword = oldPassInput.text;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BANK_CHANGE_PWD_REQ,body);
		}
		
		private function limitSureClick():void
		{
			if(limitNumInput.text == "")
			{
				ManagersMap.systemMessageManager.showSysMessage("请输入秒注限制数值");
				return;
			}
			
			var body:Object = {};
			body.lSelfOption 	= parseInt(limitNumInput.text);
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_SELF_OPTION_CHANGE_REQ,body);
		}
	}
}