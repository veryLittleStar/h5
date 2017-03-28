package managers.serverLogin
{
	import laya.display.Input;
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Browser;
	import laya.utils.Handler;
	
	import managers.DataProxy;
	import managers.ManagerBase;
	import managers.ManagersMap;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import system.Loading;
	import system.Logger;
	
	import ui.loginUI;

	/**服务器总的登录，还没有进入具体的某个游戏*/
	public class ServerLoginManager extends ManagerBase
	{
		private var _ui:loginUI;
		public var roomList:Array;
		
		private var serverList:Array = [];
		
		private var loginOrRegister:int = 0;
		
		public function ServerLoginManager(uiClass:Class = null)
		{
			super(loginUI);
		}
		
		override protected function initPanel():void
		{
			_ui = _view as loginUI;
			
			_ui.registerBox.visible = false;
			_ui.loginBox.visible = true;
			_ui.on(Event.CLICK,this,onClick);
			
			_ui.pwdInput.type = Input.TYPE_PASSWORD;
			_ui.rPwdInput.type = Input.TYPE_PASSWORD;
			_ui.rPwdCheckInput.type = Input.TYPE_PASSWORD;
			_ui.rBankPwdInput.type = Input.TYPE_PASSWORD;
			
			_ui.rAccountInput.maxChars = 12;
			_ui.rAccountInput.restrict = "0-9a-zA-Z";
			_ui.rNickInput.maxChars = 8;
			_ui.rPwdInput.maxChars = 12;
			_ui.rPwdCheckInput.maxChars = 12;
			_ui.rBankPwdInput.maxChars = 12;
			
			freshMirCheck();
			Laya.loader.load("serverList.json",Handler.create(this,serverListLoaded),null,Loader.JSON);
		}
		
		private function serverListLoaded(e:* = null):void
		{
			serverList = e;
			if(serverList && serverList is Array)
			{
				var labels:String = "";
				var i:int;
				for(i = 0; i < serverList.length; i++)
				{
					if(i == 0)
					{
						labels += serverList[i].name;
					}
					else
					{
						labels += "," + serverList[i].name;
					}
				}
				_ui.serverComboBox.labels = labels;
				_ui.serverComboBox.selectedIndex = 0;
			}
		}
		
		private function onClick(event:Event):void
		{
			switch(event.target)
			{
				case _ui.loginBtn:
					if(NetProxy.getInstance().socketConnected())
					{
						loginReq();
					}
					else
					{
						loginOrRegister = 0;
						connectLoginServer();
					}
					break;
				case _ui.registerBtn:
					_ui.registerBox.visible = true;
					_ui.loginBox.visible = false;
					break;
				case _ui.cancelRegisterBtn:
					_ui.registerBox.visible = false;
					_ui.loginBox.visible = true;
					break;
				case _ui.sureRegisterBtn:
					if(NetProxy.getInstance().socketConnected())
					{
						registerReq();
					}
					else
					{
						loginOrRegister = 1;
						connectLoginServer();
					}
					break;
				case _ui.mirCheckBox:
					freshMirCheck();
					break;
			}
		}
		
		private function sureRegisterClick():void
		{
			
		}
		
		private function freshMirCheck():void
		{
			if(_ui.mirCheckBox.selected)
			{
				_ui.serverComboBox.disabled = false;
			}
			else
			{
				_ui.serverComboBox.disabled = true;
			}
		}
		
		public function connectLoginServer():void
		{
			var data:Object = {};
			data.host = Browser.window.initConfig.loginHost;
			data.port = Browser.window.initConfig.loginPort;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		public function gameListRec(obj:Object):void
		{
			//obj.arGame
			//	obj.wGameID
			//	obj.dwOnLineCount
			//	obj.dwFullCount
			//	obj.szKindName
		}
		
		public function roomListRec(obj:Object):void
		{
			//obj.arRoom
			//	obj.wKindID
			//	obj.wNodeID
			//	obj.wSortID
			//	obj.wServerID
			//	obj.wServerPort
			//	obj.dwOnLineCount
			//	obj.dwFullCount
			//	obj.szServerAddr
			//	obj.szServerName
			
			roomList = obj.arRoom;
		}
		
		
		
		public function registerReq():void
		{
			if(_ui.rAccountInput.text == "")
			{
				ManagersMap.systemMessageManager.showSysMessage("账号不能为空");
				return;
			}
			if(_ui.rPwdInput.text == "")
			{
				ManagersMap.systemMessageManager.showSysMessage("密码不能为空");
				return;
			}
			if(_ui.rNickInput.text == "")
			{
				ManagersMap.systemMessageManager.showSysMessage("昵称不能为空");
				return;
			}
			if(_ui.rBankPwdInput.text == "")
			{
				ManagersMap.systemMessageManager.showSysMessage("保险箱密码不能为空");
				return;
			}
			if(_ui.rPwdCheckInput.text != _ui.rPwdInput.text)
			{
				ManagersMap.systemMessageManager.showSysMessage("两次输入的密码不一致");
				return;
			}
			var body:Object = {};
			body.szLogonPass = _ui.rPwdInput.text;
			body.szInsurePass = _ui.rBankPwdInput.text;
			body.wFaceID = Browser.now()%4;
			body.cbGender = _ui.rSexRadio.selectedIndex;
			body.szAccounts = _ui.rAccountInput.text;
			body.szNickName = _ui.rNickInput.text;
			NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_REGISTER_ACCOUNT_REQ,body);
		}
		
		public function loginReq():void
		{
			var body:Object = {};
			if(Browser.window.location.search == "")
			{
				if(_ui.mirCheckBox.selected)
				{
					body.cbGateID = parseInt(serverList[_ui.serverComboBox.selectedIndex].g);
					body.cbServerID = parseInt(serverList[_ui.serverComboBox.selectedIndex].s);
					body.szAccount = _ui.accountInput.text;
					body.szPwd = _ui.pwdInput.text;
					NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_LOGIN_THIRD_PART_MIR_REQ,body);
				}
				else
				{
					body.account = _ui.accountInput.text;
					body.password = _ui.pwdInput.text;
					NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_LOGIN_REQ,body);
				}
			}
			else
			{
				var pid:String = NetDefine.getQueryString("pid");
				if(pid != "")
				{
					body.g = parseInt(NetDefine.getQueryString("g"));
					body.s = parseInt(NetDefine.getQueryString("s"));
					body.pid = pid;
					NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_LOGIN_THIRD_PART_REQ,body);
				}
				else
				{
					body.account = NetDefine.getQueryString("account");
					body.password = NetDefine.getQueryString("password");
					NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_LOGIN_REQ,body);
				}
			}
		}
		
		public function onSocketConnect():void
		{
			if(loginOrRegister == 0)
			{
				loginReq();
			}
			else
			{
				registerReq();
			}
		}
		
		public function loginSuccessRec(obj:Object):void
		{
			//obj.wFaceID
			//obj.dwUserID
			//obj.dwGameID
			//obj.dwGroupID
			//obj.dwCustomID
			//obj.dwUserMedal
			//obj.dwExperience
			//obj.dwLoveLiness
			//obj.lUserScore
			//obj.lUserInsure
			//obj.cbGender
			//obj.cbMoorMachine
			//obj.szAccounts
			//obj.szNickName
			//obj.szGroupName
			//obj.cbShowServerStatus
			
			DataProxy.userID 	= obj.dwUserID;
			DataProxy.faceID 	= obj.wFaceID;
			DataProxy.gameID	= obj.dwGameID;
			DataProxy.nickName 	= obj.szNickName;
			DataProxy.account 	= obj.szAccounts;
			DataProxy.password	= obj.szPassword;
			DataProxy.userScore = obj.lUserScore;
			DataProxy.gender 	= obj.cbGender;
		}
		
		public function loginFailureRec(obj:Object):void
		{
			//obj.lResultCode
			//obj.szDescribeString
			ManagersMap.systemMessageManager.showSysMessage(obj.szDescribeString);
		}
		
		public function loginFinishRec(obj:Object):void
		{
			//obj.wIntermitTime
			//obj.wOnLineCountTime
			var i:int;
			for(i = 0; i < roomList.length; i++)
			{
				var roomInfo:Object = roomList[i];
				if(roomInfo.dwOnLineCount < roomInfo.dwFullCount)
				{
					DataProxy.kindID = roomInfo.wKindID;
					connectRoom(roomInfo.szServerAddr,roomInfo.wServerPort);
					break;
				}
			}
		}
		
		private function connectRoom(host:String,port:String):void
		{
			var data:Object = {};
			data.host = host;
			data.port = port;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		public function heartBeatRec(obj:Object):void
		{
			NetProxy.getInstance().sendToServer(ServerLoginDefine.MSG_HEART_BEAT_REQ,obj);
		}
		
	}
}