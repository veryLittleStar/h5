package managers.baoziwang
{
	import customUI.BmpFontLabel;
	
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.maths.Point;
	import laya.media.SoundManager;
	import laya.net.Loader;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	import managers.ManagerBase;
	import managers.ManagersMap;
	import managers.gameLogin.GameLoginDefine;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import resource.ResLoader;
	import resource.ResType;
	
	import system.Loading;
	
	import ui.BaoziwangUI;
	
	public class BaoziwangManager extends ManagerBase
	{
		private var _ui:BaoziwangUI;
		public function get ui():BaoziwangUI
		{
			return _ui;
		}
		/////////////////////////////////////////
		private var recordArr:Array = [];
		private var tempChipArr:Array = [];
		public var maxScore:int = 0;
		private var curResult:int = 0;
		private var allJetion0:int = 0;
		private var allJetion2:int = 0;
		private var myJetion0:int = 0;
		private var myJetion2:int = 0;
		
		public var preRoundJetionArr:Array = [];
		public var curRoundJetionArr:Array = [];
		private var gameStatus:int = 0;
		private var userWinScore:int = 0;
		private var bankerWinScore:int = 0;
		/////////////////////////////////////////
		public function BaoziwangManager(uiClass:Class=null)
		{
			super(BaoziwangUI);
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
			_ui = _view as BaoziwangUI;
			_ui.tipBox.visible = false;
			_ui.mainPanelTop.init();
			_ui.mainPanelBottom.init();
			_ui.clockBox.init();
			_ui.diceCupBox.init();
			_ui.tipBox.init();
			_ui.laoPaoWang.init();
			_ui.chatAndUserList.init();
			_ui.recordPanel.init();
			_ui.shangZhuangPanel.init();
			_ui.bankPanel.init();
			_ui.configPanel.init();
			connectLoginServer();
			Laya.stage.on(Event.KEY_UP,this,key_up);
			_ui.recordBtn.on(Event.MOUSE_UP,this,recordBtnMouseUp);
			_ui.xLightBtn.on(Event.CLICK,this,lightBtnClick);
			_ui.dLightBtn.on(Event.CLICK,this,lightBtnClick);
			_ui.configBtn.on(Event.CLICK,this,configClick);
			_ui.bankBtn.on(Event.CLICK,this,bankClick);
			SoundManager.playMusic("music/ybao_bg.mp3");
		}
		
		private function recordBtnMouseUp(event:Event = null):void
		{
			event.stopPropagation();
			if(_ui.recordPanel.visible)
			{
				_ui.recordPanel.closeMe();
			}
			else
			{
				_ui.recordPanel.openMe(recordArr);
			}
		}
		
		private function connectLoginServer():void
		{
			Loading.getInstance().openMe();
			var data:Object = {};
			data.host = Browser.window.initConfig.loginHost;
			data.port = Browser.window.initConfig.loginPort;
			NetProxy.getInstance().execute(NetDefine.CONNECT_SOCKET,data);
		}
		
		private function configClick(event:Event):void
		{
			_ui.configPanel.openMe();
		}
		
		private function bankClick(event:Event):void
		{
			DataProxy.standUPing = true;
			var body:Object = {};
			body.wTableID 	= DataProxy.tableID;
			body.wChairID 	= DataProxy.chairID;
			body.cbForceLeave 	= 0;
			NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_USER_STAND_UP_REQ,body);
		}
		
		private function lightBtnClick(event:Event):void
		{
			switch(event.currentTarget)
			{
				case _ui.xLightBtn:
					placeJetionReq(BaoziwangDefine.RESULT_SMALL);
					break;
				case _ui.dLightBtn:
					placeJetionReq(BaoziwangDefine.RESULT_BIG);
					break;
			}
		}
		
		private function placeJetionReq(area:int):void
		{
			var body:Object = {};
			body.cbJettonArea 	= area;
			if(_ui.mainPanelBottom.selectChipScore)
			{
				body.lJettonScore	= _ui.mainPanelBottom.selectChipScore;
			}
			else
			{
				body.lJettonScore	= 100;
			}
			
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_PLACE_JETION_REQ,body);
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
					break;
			}
		}
		
		public function gameFreeRec(obj:Object):void
		{
			//obj.cbTimeLeave
			//obj.nListUserCount
			gameStatus = BaoziwangDefine.GAME_STATUS_FREE;
			var leftTime:int = obj.cbTimeLeave*1000;
			_ui.clockBox.countDown(2,leftTime - 2500);
			Laya.timer.once(leftTime - 2500,this,yaoTouzi);
			
		}
		
		private function yaoTouzi():void
		{
			_ui.laoPaoWang.changeMotion("yao",false);
			SoundManager.playSound("music/roll.mp3");
		}
		
		public function gameStartRec(obj:Object):void
		{
			//obj.wBankerUser
			//obj.lBankerScore
			//obj.lUserMaxScore
			//obj.cbTimeLeave
			//obj.nChipRobotCount
			gameStatus = BaoziwangDefine.GAME_STATUS_START;
			var leftTime:int = obj.cbTimeLeave*1000;
			_ui.tipBox.show(1);
			Laya.timer.once(2500,this,xiaZhu,[leftTime-2500]);
			maxScore = obj.lUserMaxScore;
			allJetion0 = 0;
			allJetion2 = 0;
			myJetion0 = 0;
			myJetion2 = 0;
			SoundManager.playSound("music/xzTip.mp3");
			
			if(curRoundJetionArr.length)
			{
				preRoundJetionArr.splice(0);
				while(curRoundJetionArr.length)
				{
					preRoundJetionArr.push(curRoundJetionArr.shift());
				}
			}
			_ui.mainPanelBottom.updateAutoBettingBtn();
			
			DataProxy.bankerChairID = obj.wBankerUser;
			DataProxy.bankerSocre = obj.lBankerScore;
			_ui.mainPanelTop.updateBankerInfo();
			_ui.mainPanelBottom.updateMBtn(-1);
		}
		
		private function xiaZhu(leftTime:int):void
		{
			_ui.mainPanelBottom.canBetting = true;
			_ui.clockBox.countDown(1,leftTime);
			_ui.xLightBtn.shine();
			_ui.dLightBtn.shine();
		}
		
		public function gameEndRec(obj:Object):void
		{
			//obj.cbTimeLeave
			//obj.arcbDice
			//obj.btBankerWin
			//obj.lBankerScore					//庄家成绩
			//obj.lBankerTotallScore			//庄家成绩
			//obj.nBankerTime					//做庄次数
			//obj.btWin
			//obj.lUserScore					//玩家成绩
			//obj.lUserReturnScore				//返回积分
			//obj.lRevenue						//游戏税收
			gameStatus = BaoziwangDefine.GAME_STATUS_END;
			changeBankerDelay = true;
			var endTime:int = obj.cbTimeLeave*1000 + Browser.now();
			curResult = pushRecord(obj.arcbDice);
			Laya.timer.once(800,this,maiDingLiShou,[endTime,obj.arcbDice]);
			_ui.mainPanelBottom.canBetting = false;
			_ui.mainPanelBottom.updateMBtn(-2);
			if(obj.btWin)
			{
				userWinScore = obj.lUserScore;
			}
			else
			{
				userWinScore = -obj.lUserScore;
			}
			if(obj.btBankerWin)
			{
				bankerWinScore = obj.lBankerScore;
			}
			else
			{
				bankerWinScore = -obj.lBankerScore;
			}
		}
		
		private function maiDingLiShou(endTime:int,diceArr:Array):void
		{
			_ui.tipBox.show(2);
			Laya.timer.once(2500,this,kaiZhong,[diceArr,endTime]);
			SoundManager.playSound("music/kpTip.mp3");
		}
		
		/**开盅*/
		public function kaiZhong(arr:Array,endTime:int):void
		{
			_ui.diceCupBox.openDiceCup(arr);
			_ui.laoPaoWang.changeMotion("open",false);
			Laya.timer.once(6500,this,shouChouMa);
			Laya.timer.once(6000,this,flyWinScore);
		}
		
		private function shouChouMa():void
		{
			while(tempChipArr.length)
			{
				var chip:LittleChip = tempChipArr.pop();
				var destPoint:Point = new Point();
				var startPoint:Point = new Point();
				startPoint= chip.localToGlobal(startPoint);
				chip.x = startPoint.x;
				chip.y = startPoint.y;
				Laya.stage.addChild(chip);
				if(curResult == chip.info.cbJettonArea)
				{
					if(chip.info.wChairID == DataProxy.chairID)
					{
						destPoint.x = 35;
						destPoint.y = 35;
						destPoint = _ui.mainPanelBottom.localToGlobal(destPoint);
					}
					else
					{
						destPoint.y = Laya.stage.height * 0.66;
						destPoint.x = -chip.width;
					}
				}
				else
				{
					destPoint.x = 410;
					destPoint.y = 30;
					destPoint = _ui.mainPanelTop.localToGlobal(destPoint);
				}
				Tween.to(chip,{x:destPoint.x,y:destPoint.y},300,null,Handler.create(this,chipDisappear,[chip]),0,true);
			}
			_ui.myJetion0.visible = false;
			_ui.myJetion2.visible = false;
			_ui.allJetion0.visible = false;
			_ui.allJetion2.visible = false;
			_ui.diceCupBox.reset();
			SoundManager.playSound("music/ttz_chip_player.mp3");
			updateUserInfo(DataProxy.userID);
			changeBankerDelay = false;
			if(changeBankerInfoDelay)
			{
				changeBankerRec(changeBankerInfoDelay);
				changeBankerInfoDelay = null;
			}
		}
		
		private function chipDisappear(chip:Image):void
		{
			chip.removeSelf();
			Pool.recover("littleChip",chip);
		}
		
		private function flyWinScore():void
		{
			if(userWinScore)
			{
				var userWinLabel:BmpFontLabel = new BmpFontLabel();
				userWinLabel.font = "benz_xz_me";
				userWinLabel.align = "center";
				userWinLabel.width = 170;
				userWinLabel.text = userWinScore.toString();
				userWinLabel.x = (Laya.stage.width - userWinLabel.width)/2;
				userWinLabel.y = Laya.stage.height/2 + 100;
				Laya.stage.addChild(userWinLabel);
				var userPoint:Point = new Point();
				userPoint.x = 40 - 85;
				userPoint.y = 25;
				userPoint = _ui.mainPanelBottom.localToGlobal(userPoint);
				Tween.to(userWinLabel,{x:userPoint.x,y:userPoint.y},300,null,Handler.create(this,winLabelDelay,[userWinLabel]),0,true);
				
			}
			if(bankerWinScore)
			{
				var bankerWinLabel:BmpFontLabel = new BmpFontLabel();
				bankerWinLabel.font = "benz_xz_total";
				bankerWinLabel.align = "center";
				bankerWinLabel.width = 170;
				bankerWinLabel.text = bankerWinScore.toString();
				bankerWinLabel.x = (Laya.stage.width - bankerWinLabel.width)/2;
				bankerWinLabel.y = Laya.stage.height/2 - 100;
				Laya.stage.addChild(bankerWinLabel);
				var bankerPoint:Point = new Point();
				bankerPoint.x = 410 - 85;
				bankerPoint.y = 30;
				bankerPoint =_ui.mainPanelTop.localToGlobal(bankerPoint);
				Tween.to(bankerWinLabel,{x:bankerPoint.x,y:bankerPoint.y},300,null,Handler.create(this,winLabelDelay,[bankerWinLabel]),0,true);
			}
			
			function winLabelDelay(label:BmpFontLabel):void
			{
				Laya.timer.once(1000,this,winLabelRemove,[label],false);
			}
			
			function winLabelRemove(label:BmpFontLabel):void
			{
				label.removeSelf();
			}
		}
		
		public function gameSceneRec(obj:Object):void
		{
			//obj.cbGameStatus == 0
			//obj.cbTimeLeave
			//obj.lUserMaxScore
			
			//obj.wBankerChairID
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
			
			//obj.wBankerChairID			//当前庄家
			//obj.cbBankerTime				//庄家局数
			//obj.lBankerWinScore			//庄家成绩
			//obj.lBankerScore				//庄家分数
			//obj.bEnableSysBanker			//系统做庄
			
			//obj.lEndBankerScore
			//obj.lEndUserScore
			//obj.lEndUserReturnScore
			//obj.lEndRevenue
			//obj.szGameRoomName
			trace(obj.cbGameStatus,"gameSceneRec");
			gameStatus = obj.cbGameStatus;
			_ui.shangZhuangPanel.szConditonUpdate(obj.lApplyBankerCondition);
			
			DataProxy.bankerChairID = obj.wBankerChairID;
			DataProxy.bankerSocre = obj.lBankerScore;
			if(DataProxy.chairID == obj.wBankerChairID)
			{
				DataProxy.myBankerState = 2;
			}
			_ui.mainPanelTop.updateBankerBtn();
			_ui.shangZhuangPanel.updateMyBankerBtn();
			_ui.mainPanelTop.updateBankerInfo();
			
			maxScore = obj.lUserMaxScore;
			
			var leftTime:int = obj.cbTimeLeave*1000;
			if(obj.cbGameStatus == 0)
			{
				_ui.clockBox.countDown(2,leftTime);
				_ui.mainPanelBottom.canBetting = false;
				_ui.myJetion0.visible  = _ui.myJetion2.visible = false;
				_ui.allJetion0.visible = _ui.allJetion2.visible = false;
			}
			else
			{
				if(obj.cbGameStatus == 100)
				{
					_ui.clockBox.countDown(1,leftTime);
					_ui.mainPanelBottom.canBetting = true;
					_ui.mainPanelBottom.updateMBtn(-1);
				}
				if(obj.cbGameStatus == 101)
				{
					_ui.clockBox.countDown(2,leftTime);
					_ui.mainPanelBottom.canBetting = false;
					changeBankerDelay = true;
					_ui.mainPanelBottom.updateMBtn(-2);
				}
				//obj.arlAreaInAllScore
				//obj.arlUserInAllScore
				_ui.myJetion0.visible = false;
				_ui.myJetion2.visible = false;
				_ui.allJetion0.visible = false;
				_ui.allJetion2.visible = false;
				
				if(obj.arlUserInAllScore[0])
				{
					_ui.myJetion0.visible = true;
					_ui.myJetion0.text = BaoziwangDefine.getScoreStr1(obj.arlUserInAllScore[0]);
				}
				if(obj.arlUserInAllScore[2])
				{
					_ui.myJetion2.visible = true;
					_ui.myJetion2.text = BaoziwangDefine.getScoreStr1(obj.arlUserInAllScore[2]);
				}
				
				if(obj.arlAreaInAllScore[0])
				{
					_ui.allJetion0.visible = true;
					_ui.allJetion0.text = BaoziwangDefine.getScoreStr1(obj.arlUserInAllScore[0]);
				}
				if(obj.arlAreaInAllScore[2])
				{
					_ui.allJetion2.visible = true;
					_ui.allJetion2.text = BaoziwangDefine.getScoreStr1(obj.arlUserInAllScore[2]);
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
		
		private function pushRecord(arr:Array):int
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
			return obj.cbResult;
		}
		
		public function updateUserInfo(userID:int):void
		{
			if(userID == DataProxy.userID)
			{
				_ui.myNameLabel.text = "昵称：" + DataProxy.nickName;
				_ui.myMoneyLabel.text = DataProxy.userScore + "";
				_ui.myGameIDLabel.text = "游戏ID：" + DataProxy.gameID;
				_ui.myPortraitImage.skin = BaoziwangDefine.getPortraitImage(DataProxy.gender,DataProxy.faceID);
				_ui.configPanel.updateLimitNum(DataProxy.selfOption);
				return;
			}
			_ui.chatAndUserList.updateUserInfo(userID);
		}
		
		public function updateUserStatus(userID:int):void
		{
			if(userID == DataProxy.userID)
			{
				return;
			}
			_ui.chatAndUserList.updateUserStatus(userID);
		}
		
		public function placeJetionRec(obj:Object):void
		{
			//obj["wChairID"] 			//用户位置
			//obj["cbJettonArea"]		//筹码区域
			//obj["lJettonScore"]		//加注数目
			//obj["cbAndroid"]			//机器人
			//obj.cbAllIn				//是否秒下
			var jettonScore:int = obj.lJettonScore;
			while(jettonScore >= 100)
			{
				var tempScore:int = 0;
				if(jettonScore >= 100000)
				{
					tempScore = 100000;
				}
				else if(jettonScore >= 10000)
				{
					tempScore = 10000;
				}
				else if(jettonScore >= 5000)
				{
					tempScore = 5000;
				}
				else if(jettonScore >= 1000)
				{
					tempScore = 1000;
				}
				else
				{
					tempScore = 100;
				}
				jettonScore -= tempScore;
				var chipIndex:int = BaoziwangDefine.getChipIndex(tempScore);
				if(chipIndex)
				{
					var chipPoint:Point;
					var destPoint:Point;
					var chip:LittleChip = Pool.getItemByClass("littleChip",LittleChip);
					var chipInfo:Object = {};
					chipInfo.wChairID = obj.wChairID;
					chipInfo.cbJettonArea = obj.cbJettonArea;
					chipInfo.lJettonScore = tempScore;
					chip.updateInfo(chipInfo);
					tempChipArr.push(chip);
					destPoint = getRandomPointByArea(obj.cbJettonArea);
					
					if(obj.wChairID == DataProxy.chairID)
					{
						chipPoint = _ui.mainPanelBottom.getChipPosByScore(tempScore);
						if(chipPoint)
						{
							chip.x = chipPoint.x;
							chip.y = chipPoint.y;
							Laya.stage.addChild(chip);
							Tween.to(chip,{x:destPoint.x,y:destPoint.y},300,null,Handler.create(this,chipFlyEnd,[chip]));
						}
					}
					else
					{
						chipPoint = new Point();
						chipPoint.y = Laya.stage.height * 0.6;
						chipPoint.x = -chip.width;
						chip.x = chipPoint.x;
						chip.y = chipPoint.y;
						Laya.stage.addChild(chip);
						Tween.to(chip,{x:destPoint.x,y:destPoint.y},300,null,Handler.create(this,chipFlyEnd,[chip]));
					}
				}
			}
			
			
			
			if(obj.wChairID == DataProxy.chairID)
			{
				if(obj.cbAllIn)
				{
					_ui.mainPanelBottom.updateMBtn(obj.cbJettonArea);
				}
				this["myJetion"+obj.cbJettonArea] += obj.lJettonScore;
				_ui["myJetion"+obj.cbJettonArea].text = BaoziwangDefine.getScoreStr1(this["myJetion"+obj.cbJettonArea]);
				_ui["myJetion"+obj.cbJettonArea].visible = true;
				DataProxy.userScore -= obj.lJettonScore;
				DataProxy.myUserInfo.lScore -= obj.lJettonScore;
				updateUserInfo(DataProxy.userID);
				curRoundJetionArr.push(obj);
				if(preRoundJetionArr.length)
				{
					preRoundJetionArr.splice(0);
					_ui.mainPanelBottom.updateAutoBettingBtn();
				}
				_ui.mainPanelBottom.autoBeting = false;
			}
			this["allJetion"+obj.cbJettonArea] += obj.lJettonScore;
			_ui["allJetion"+obj.cbJettonArea].text = BaoziwangDefine.getScoreStr1(this["allJetion"+obj.cbJettonArea]);
			_ui["allJetion"+obj.cbJettonArea].visible = true;
			
			SoundManager.playSound("music/ttz_chip_player.mp3");
		}
		
		private function chipFlyEnd(chip:LittleChip):void
		{
			var point:Point = new Point(chip.x,chip.y);
			point = _ui.table.globalToLocal(point);
			_ui.table.addChild(chip);
			chip.x = point.x;
			chip.y = point.y;
		}
		
		private function getRandomPointByArea(area:int):Point
		{
			var target:Image = _ui.xLightBtn;
			switch(area)
			{
				case BaoziwangDefine.RESULT_SMALL:
					target = _ui.xLightBtn;
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					target = _ui.bankerImage;
					break;
				case BaoziwangDefine.RESULT_BIG:
					target = _ui.dLightBtn;
					break;
			}
			var point:Point = new Point();
			point.x = target.x + target.width/2 * Math.random() + target.width/4;
			point.y = target.y + target.height/2 * Math.random() + target.height/4;
			return point;
		}
		
		public function placeJetionFailRec(obj:Object):void
		{
			//obj["wPlaceUser"] 			//下注玩家
			//obj["lJettonArea"]			//下注区域
			//obj["lPlaceScore"] 			//当前下注
			_ui.mainPanelBottom.autoBeting = false;
		}
		
		public function applyBankerRec(obj:Object):void
		{
			//	vo["wChairID"] 		//申请玩家
			if(DataProxy.chairID == obj.wChairID)
			{
				DataProxy.myBankerState = 1;
				_ui.mainPanelTop.updateBankerBtn();
				_ui.shangZhuangPanel.updateMyBankerBtn();
			}
			_ui.shangZhuangPanel.addApplyBanker(obj.wChairID);
		}
		
		public function cancelBankerRec(obj:Object):void
		{
			//vo["szCancelUser"] 	//取消申请玩家
			if(DataProxy.nickName == obj.szCancelUser)
			{
				DataProxy.myBankerState = 0;
				_ui.mainPanelTop.updateBankerBtn();
				_ui.shangZhuangPanel.updateMyBankerBtn();
			}
			var userInfo:Object = DataProxy.getUserInfoByName(obj.szCancelUser);
			if(userInfo.wChairID == DataProxy.bankerChairID)
			{
				DataProxy.bankerChairID = 65535;
				_ui.mainPanelTop.updateBankerInfo();
			}
			_ui.shangZhuangPanel.removeApplyBanker(obj.szCancelUser);
		}
		
		private var changeBankerInfoDelay:Object;
		private var changeBankerDelay:Boolean = false;
		public function changeBankerRec(obj:Object):void
		{
			//vo["wBankerChairID"] 			//当庄玩家chairID
			//vo["lBankerScore"] 			//庄家金币
			if(changeBankerDelay)
			{
				changeBankerInfoDelay = obj;
				return;
			}
			if(DataProxy.chairID == DataProxy.bankerChairID && obj.wBankerChairID != DataProxy.chairID)
			{
				DataProxy.myBankerState = 0;
				_ui.mainPanelTop.updateBankerBtn();
				_ui.shangZhuangPanel.updateMyBankerBtn();
			}
			if(DataProxy.chairID == obj.wBankerChairID)
			{
				DataProxy.myBankerState = 2;
				_ui.mainPanelTop.updateBankerBtn();
				_ui.shangZhuangPanel.updateMyBankerBtn();
			}
			DataProxy.bankerChairID = obj.wBankerChairID;
			DataProxy.bankerSocre = obj.lBankerScore;
			_ui.mainPanelTop.updateBankerInfo();
			var userInfo:Object = DataProxy.getUserInfoByChairID(obj.wBankerChairID);
			if(userInfo)
			{
				_ui.shangZhuangPanel.removeApplyBanker(userInfo.szNickName);
			}
		}
		
		public function userChatRec(obj:Object):void
		{
			_ui.chatAndUserList.userChatRec(obj);
		}
		
		public function bankInsureInfoRec(obj:Object):void
		{
			_ui.bankPanel.bankInsureInfoRec(obj);
		}
		
		public function bankInsureSuccessRec(obj:Object):void
		{
			_ui.bankPanel.bankInsureSuccessRec(obj);
		}
		
		public function bankInsureFailureRec(obj:Object):void
		{
			_ui.bankPanel.bankInsureFailureRec(obj);
		}
		
		public function bankChangePwdRec(obj:Object):void
		{
			//vo["lErrorCode"] 				//错误代码
			//vo["wLength"] 				//消息长度
			//vo["szDescribeString"] 		//描述消息
			ManagersMap.systemMessageManager.showSysMessage(obj.szDescribeString);
		}
		
		public function selfOptionChangeRec(obj:Object):void
		{
			DataProxy.selfOption = obj.lSelfOption;
			_ui.configPanel.updateLimitNum(obj.lSelfOption);
		}
		
	}
}