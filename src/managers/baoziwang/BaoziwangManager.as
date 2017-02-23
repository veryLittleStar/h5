package managers.baoziwang
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Loader;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Browser;
	
	import managers.DataProxy;
	import managers.ManagerBase;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import resource.ResLoader;
	import resource.ResType;
	
	import system.Loading;
	
	import ui.baoziwangUI;
	
	public class BaoziwangManager extends ManagerBase
	{
		private var _ui:baoziwangUI;
		public function get ui():baoziwangUI
		{
			return _ui;
		}
		/////////////////////////////////////////
		private var recordArr:Array = [];
		/////////////////////////////////////////
		public function BaoziwangManager(uiClass:Class=null)
		{
			super(baoziwangUI);
		}
		
		override protected function getResList():Array
		{
			return [
				{url: "res/atlas/animation/ybao_human.json", type: Loader.ATLAS},
				{url: "res/atlas/animation/ybao_human_big.json", type: Loader.ATLAS},
				{url: "res/atlas/ui/baseUI.json", type: Loader.ATLAS}
			];
		}
		
		override protected function initPanel():void
		{
			_ui = _view as baoziwangUI;
			_ui.tipBox.visible = false;
			_ui.mainPanelTop.init();
			_ui.mainPanelBottom.init();
			_ui.clockBox.init();
			_ui.diceCupBox.init();
			_ui.tipBox.init();
			_ui.laoPaoWang.init();
			_ui.chatAndUserList.init();
			connectLoginServer();
			Laya.stage.on(Event.KEY_UP,this,key_up);
		}
		
		private function connectLoginServer():void
		{
			Loading.getInstance().openMe();
			var data:Object = {};
			data.host = Browser.window.initConfig.loginHost;
			data.port = Browser.window.initConfig.loginPort;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
					_ui.clockBox.countDown(1,3000);
					break;
				case Keyboard.B:
					break;
				case Keyboard.S:
					yaoTouzi();
					break;
				case Keyboard.D:
					gameSceneRec({cbTimeLeave:10,cbGameStatus:0});
					break;
				case Keyboard.F:
					gameSceneRec({cbTimeLeave:18,cbGameStatus:100});
					break;
				case Keyboard.G:
					gameSceneRec({cbTimeLeave:12,cbGameStatus:101,arcbDice:[1,2,3]});
					break;
			}
		}
		
		public function gameFreeRec(obj:Object):void
		{
			//obj.cbTimeLeave
			//obj.nListUserCount
			
			var leftTime:int = obj.cbTimeLeave*1000;
			_ui.clockBox.countDown(2,leftTime - 2500);
			Laya.timer.once(leftTime - 2500,this,yaoTouzi);
		}
		
		private function yaoTouzi():void
		{
			_ui.laoPaoWang.changeMotion("yao",false);
		}
		
		public function gameStartRec(obj:Object):void
		{
			//obj.wBankerUser
			//obj.lBankerScore
			//obj.lUserMaxScore
			//obj.cbTimeLeave
			//obj.nChipRobotCount
			
			var leftTime:int = obj.cbTimeLeave*1000;
			_ui.tipBox.show(1);
			Laya.timer.once(3000,this,xiaZhu,[leftTime-3000]);
		}
		
		private function xiaZhu(leftTime:int):void
		{
			_ui.mainPanelBottom.canBetting = true;
			_ui.clockBox.countDown(1,leftTime);
		}
		
		public function gameEndRec(obj:Object):void
		{
			//obj.cbTimeLeave
			//obj.arcbDice
			//obj.lBankerScore					//庄家成绩
			//obj.lBankerTotallScore			//庄家成绩
			//obj.nBankerTime					//做庄次数
			//obj.lUserScore					//玩家成绩
			//obj.lUserReturnScore				//返回积分
			//obj.lRevenue						//游戏税收
			var leftTime:int = obj.cbTimeLeave*1000;
			_ui.tipBox.show(2);
			_ui.mainPanelBottom.canBetting = false;
			Laya.timer.once(3200,this,kaiZhong,[obj.arcbDice,leftTime-3200]);
			pushRecord(obj.arcbDice);
		}
		
		/**开盅*/
		public function kaiZhong(arr:Array,leftTime:int):void
		{
			_ui.clockBox.countDown(2,leftTime);
			_ui.diceCupBox.openDiceCup(arr);
			_ui.laoPaoWang.changeMotion("open",false);
		}
		
		public function gameSceneRec(obj:Object):void
		{
			//obj.cbGameStatus == 0
			//obj.cbTimeLeave
			//obj.lUserMaxScore
			//obj.wBankerUser
			//obj.cbBankerTime
			//obj.lBankerWinScore
			//obj.lBankerScore
			//obj.bEnableSysBanker
			//obj.lApplyBankerCondition
			//obj.lAreaLimitScore
			//obj.szGameRoomName
			//-----------------------------
			//obj.cbGameStatus	== 100|101
			//obj.cbTimeLeave
			//obj.arlAreaInAllScore
			//obj.arlUserInAllScore
			//obj.lUserMaxScore
			//obj.lApplyBankerCondition
			//obj.lAreaLimitScore
			//obj.arcbDice
			//obj.wBankerUser
			//obj.cbBankerTime
			//obj.lBankerWinScore
			//obj.lBankerScore
			//obj.bEnableSysBanker
			//obj.lEndBankerScore
			//obj.lEndUserScore
			//obj.lEndUserReturnScore
			//obj.lEndRevenue
			//obj.szGameRoomName
			trace(obj.cbGameStatus,"gameSceneRec");
			if(obj.bEnableSysBanker)
			{
				_ui.bankerNameLabel.text = "老炮王";
				_ui.bankerScoreLabel.text = "100亿";
			}
			else
			{
				_ui.bankerNameLabel.text = "";
				_ui.bankerScoreLabel.text = BaoziwangDefine.getScoreStr(obj.lBankerScore);
			}
			
			_ui.myMoneyLabel.text = BaoziwangDefine.getScoreStr(obj.lUserMaxScore);
			
			var leftTime:int = obj.cbTimeLeave*1000;
			if(obj.cbGameStatus == 0)
			{
				_ui.clockBox.countDown(2,leftTime);
				_ui.mainPanelBottom.canBetting = false;
				_ui.myJetion0.visible = _ui.myJetion1.visible = _ui.myJetion2.visible = false;
				_ui.allJetion0.visible = _ui.allJetion1.visible = _ui.allJetion2.visible = false;
			}
			else
			{
				if(obj.cbGameStatus == 100)
				{
					_ui.clockBox.countDown(1,leftTime);
					_ui.mainPanelBottom.canBetting = true;
				}
				if(obj.cbGameStatus == 101)
				{
					_ui.clockBox.countDown(2,leftTime);
					_ui.mainPanelBottom.canBetting = false;
				}
				//obj.arlAreaInAllScore
				//obj.arlUserInAllScore
				var i:int;
				for(i = 0; i < obj.arlAreaInAllScore.length; i++)
				{
					var mjLabel:Label = _ui["myJetion"+i] as Label;
					if(obj.arlUserInAllScore[i])
					{
						mjLabel.visible = true;
						mjLabel.text = BaoziwangDefine.getScoreStr1(obj.arlUserInAllScore[i]);
					}
					else
					{
						mjLabel.visible = false;
					}
				}
				
				for(i = 0; i < obj.arlAreaInAllScore.length; i++)
				{
					var ajLabel:Label = _ui["allJetion"+i] as Label;
					if(obj.arlAreaInAllScore[i])
					{
						ajLabel.visible = true;
						ajLabel.text = BaoziwangDefine.getScoreStr1(obj.arlAreaInAllScore[i]);
					}
					else
					{
						ajLabel.visible = false;
					}
				}
			}
		}
		
		public function gameRecordRec(obj:Object):void
		{
			//obj.arRecord
			//	obj.cbResult
			//	obj.cbDice0
			//	obj.cbDice1
			//	obj.cbDice2
			
			recordArr.splice(0);
			var arr:Array = obj.arRecord;
			var i:int = 0;
			for(i = arr.length - 1;i >= 0; i--)
			{
				recordArr.push(arr[i]);
			}
			_ui.mainPanelTop.recordInit(recordArr);
		}
		
		private function pushRecord(arr:Array):void
		{
			if(recordArr.length >= 50)
			{
				recordArr.pop();
			}
			var obj:Object = {};
			obj.cbDice0 = arr[0];
			obj.cbDice1 = arr[1];
			obj.cbDice2 = arr[2];
			if(obj.cbDice0 == obj.cbDice1 && obj.cbDice1 == obj.cbDice2)
			{
				obj.cbResult = BaoziwangDefine.RESULT_BAOZI;
			}
			else
			{
				if((obj.cbDice0 + obj.cbDice1 + obj.cbDice2) <= 10)
				{
					obj.cbResult = BaoziwangDefine.RESULT_SMALL;
				}
				else
				{
					obj.cbResult = BaoziwangDefine.RESULT_BIG;
				}
			}
			recordArr.unshift(obj);
			_ui.mainPanelTop.pushRecord(obj.cbResult);
		}
		
		public function updateUserInfo(userID:int):void
		{
			if(userID == DataProxy.userID)
			{
				_ui.myNameLabel.text = DataProxy.nickName;
				_ui.myMoneyLabel.text = BaoziwangDefine.getScoreStr(DataProxy.userScore);
				
			}
			_ui.chatAndUserList.updateUserInfo(userID);
		}
		
	}
}