/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class loginUI extends View {
		public var loginBox:Box;
		public var accountInput:TextInput;
		public var pwdInput:TextInput;
		public var mirCheckBox:CheckBox;
		public var loginBtn:Button;
		public var registerBtn:Button;
		public var serverComboBox:ComboBox;
		public var registerBox:Box;
		public var rSexRadio:RadioGroup;
		public var rAccountInput:TextInput;
		public var rPwdInput:TextInput;
		public var rPwdCheckInput:TextInput;
		public var rNickInput:TextInput;
		public var rBankPwdInput:TextInput;
		public var sureRegisterBtn:Button;
		public var cancelRegisterBtn:Button;

		public static var uiView:Object ={"type":"View","props":{"width":600,"sizeGrid":"50,49,50,50","height":400,"centerY":0,"centerX":0},"child":[{"type":"Image","props":{"y":-4,"x":-2,"width":603,"skin":"ui/baseUI/sz_db_3.png","sizeGrid":"72,127,86,137","height":409}},{"type":"Image","props":{"y":6,"x":10,"width":580,"skin":"ui/baseUI/sz_db_1.png","sizeGrid":"50,49,50,50","height":387}},{"type":"Image","props":{"y":274,"x":10,"width":580,"skin":"ui/baseUI/sz_db_2.png","sizeGrid":"10,49,45,47","height":112}},{"type":"Image","props":{"y":-40,"x":159,"skin":"ui/baseUI/sz_tt_db.png"},"child":[{"type":"Label","props":{"y":9,"x":111,"text":"登录","fontSize":25,"color":"#ffffff","bold":true}}]},{"type":"Box","props":{"var":"loginBox"},"child":[{"type":"Label","props":{"y":69,"x":108,"text":"账号","fontSize":25,"color":"#b0a871"}},{"type":"TextInput","props":{"y":65,"x":188,"width":275,"var":"accountInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":42,"fontSize":25,"color":"#ffffff"}},{"type":"Label","props":{"y":138,"x":108,"text":"密码","fontSize":25,"color":"#b0a871"}},{"type":"TextInput","props":{"y":135,"x":188,"width":275,"var":"pwdInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":42,"fontSize":25,"color":"#ffffff"}},{"type":"CheckBox","props":{"y":215,"x":107,"var":"mirCheckBox","stateNum":"2","skin":"ui/baseUI/button_check_group.png","scaleY":0.8,"scaleX":0.8}},{"type":"Label","props":{"y":223,"x":151,"text":"使用传奇账号登录","fontSize":20,"color":"#b0a871"}},{"type":"Button","props":{"y":304.00000000000006,"x":109,"var":"loginBtn","stateNum":"2","skin":"ui/baseUI/btn_login1.png","labelSize":25,"labelColors":"#f9f6f6","label":"登录"}},{"type":"Button","props":{"y":302.00000000000006,"x":328,"var":"registerBtn","stateNum":"2","skin":"ui/baseUI/btn_login2.png","name":"saveGoldBtn","labelSize":25,"labelColors":"#f9f6f6","label":"注册"}},{"type":"ComboBox","props":{"y":212,"x":322,"var":"serverComboBox","skin":"ui/baseUI/comboBox.png","labels":"label1,label2","labelSize":15,"itemSize":15}}]},{"type":"Box","props":{"y":0,"x":0,"var":"registerBox"},"child":[{"type":"RadioGroup","props":{"y":235,"x":206,"width":212,"var":"rSexRadio","space":100,"skin":"ui/baseUI/radio_1.png","selectedIndex":0,"scaleY":0.7,"scaleX":0.7,"labels":" , ","labelSize":38,"labelColors":"#b0a871,#b0a871,#b0a871,#b0a871","height":51}},{"type":"TextInput","props":{"y":35,"x":189,"width":238,"var":"rAccountInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":30,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":39,"x":127,"text":"账号","fontSize":20,"color":"#b0a871"}},{"type":"TextInput","props":{"y":75,"x":189,"width":238,"var":"rPwdInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":30,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":79,"x":126,"text":"密码","fontSize":20,"color":"#b0a871"}},{"type":"TextInput","props":{"y":115,"x":189,"width":238,"var":"rPwdCheckInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":30,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":119,"x":86,"text":"确认密码","fontSize":20,"color":"#b0a871"}},{"type":"TextInput","props":{"y":155,"x":189,"width":238,"var":"rNickInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":30,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":159,"x":127,"text":"昵称","fontSize":20,"color":"#b0a871"}},{"type":"TextInput","props":{"y":195,"x":189,"width":238,"var":"rBankPwdInput","skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"12,12,12,12","height":30,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":199,"x":67,"text":"保险箱密码","fontSize":20,"color":"#b0a871"}},{"type":"Label","props":{"y":239,"x":125,"width":40,"text":"性别","height":20,"fontSize":20,"color":"#b0a871"}},{"type":"Button","props":{"y":304.00000000000006,"x":109,"var":"sureRegisterBtn","stateNum":"2","skin":"ui/baseUI/btn_login1.png","labelSize":25,"labelColors":"#f9f6f6","label":"注册"}},{"type":"Button","props":{"y":302.00000000000006,"x":328,"var":"cancelRegisterBtn","stateNum":"2","skin":"ui/baseUI/btn_login2.png","name":"saveGoldBtn","labelSize":25,"labelColors":"#f9f6f6","label":"取消"}},{"type":"Label","props":{"y":239,"x":254,"width":40,"text":"男","height":20,"fontSize":20,"color":"#b0a871"}},{"type":"Label","props":{"y":239,"x":365,"width":40,"text":"女","height":20,"fontSize":20,"color":"#b0a871"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}