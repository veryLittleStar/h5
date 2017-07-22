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
		private var mirAllJetion0:int = 0;
		private var mirAllJetion2:int = 0;
		private var myJetion0:int = 0;
		private var myJetion2:int = 0;
		
		public var preRoundJetionArr:Array = [];
		public var curRoundJetionArr:Array = [];
		private var gameStatus:int = 0;
		private var userWinScore:int = 0;
		private var bankerWinScore:int = 0;
		
		private var userJetionScore:int = 0;
		private var userBankCostScore:int = 0;
		
		private var lastIsBanker:Boolean = false;
		/////////////////////////////////////////
		public function BaoziwangManager(uiClass:Class=null)
		{
			super(BaoziwangUI);
		}
		
		override protected function getResList():Array
		{
			return [
				
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
			_ui.rankPanel.init();
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
			if(gameStatus != 100)return;
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
			//obj.SBanker
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
			mirAllJetion0 = 0;
			mirAllJetion2 = 0;
			myJetion0 = 0;
			myJetion2 = 0;
			userJetionScore = 0;
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
			
			DataProxy.SBanker = obj.SBanker;
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
			
			var recordInfo:Object = {};
			recordInfo.winScore = userWinScore;
			recordInfo.small = myJetion2;
			recordInfo.big = myJetion0;
			recordInfo.isBanker = (DataProxy.SBanker && DataProxy.SBanker.chIsMir == 0 && DataProxy.SBanker.wChair == DataProxy.chairID)?true:false;
			recordInfo.result = curResult;
			if(recordInfo.isBanker)
			{
				trace(123456,"下庄回钱：",userBankCostScore);
				DataProxy.userScore += userBankCostScore;
				trace(123456,"下庄回钱后自己的钱：",DataProxy.userScore);
			}
			lastIsBanker = recordInfo.isBanker;
			_ui.rankPanel.updatePersonalRecord(recordInfo);
			_ui.rankPanel.rankReqThisRound = false;
			
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
			
			if(userWinScore > 0)
			{
				DataProxy.userScore += userWinScore + userJetionScore;
				_ui.myMoneyLabel.text = DataProxy.userScore + "";
				trace(123456,"下庄赢钱后自己的钱：",DataProxy.userScore);
			}
			else
			{
				if(lastIsBanker)
				{
					DataProxy.userScore += userWinScore;
					_ui.myMoneyLabel.text = DataProxy.userScore + "";
					trace(123456,"下庄输钱后自己的钱：",DataProxy.userScore);
				}
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
				userWinLabel.text = Math.abs(userWinScore).toString();
				userWinLabel.x = (Laya.stage.width - userWinLabel.width)/2;
				userWinLabel.y = Laya.stage.height/2 + 100;
				Laya.stage.addChild(userWinLabel);
				var userPoint:Point = new Point();
				userPoint.x = 20;
				userPoint.y = -35;
				userPoint = _ui.mainPanelBottom.localToGlobal(userPoint);
				
				var userWinImage:Image = new Image();
				if(userWinScore > 0)
				{
					userWinImage.skin = "ui/baseUI/win.png";
				}
				else
				{
					userWinImage.skin = "ui/baseUI/lose.png";
				}
				userWinLabel.addChild(userWinImage);
				userWinImage.x = (userWinLabel.width -userWinLabel.textField.textWidth)/2-userWinImage.width;
				userWinImage.y = (userWinLabel.height - userWinImage.height)/2;
				
				Tween.to(userWinLabel,{x:userPoint.x,y:userPoint.y},300,null,Handler.create(this,winLabelDelay,[userWinLabel]),0,true);
				
			}
			if(bankerWinScore)
			{
				var bankerWinLabel:BmpFontLabel = new BmpFontLabel();
				bankerWinLabel.font = "benz_xz_total";
				bankerWinLabel.align = "center";
				bankerWinLabel.width = 170;
				bankerWinLabel.text = Math.abs(bankerWinScore).toString();
				bankerWinLabel.x = (Laya.stage.width - bankerWinLabel.width)/2;
				bankerWinLabel.y = Laya.stage.height/2 - 100;
				Laya.stage.addChild(bankerWinLabel);
				var bankerPoint:Point = new Point();
				bankerPoint.x = _ui.mainPanelTop.width/2 - bankerWinLabel.width/2 + 15;
				bankerPoint.y = 30;
				bankerPoint =_ui.mainPanelTop.localToGlobal(bankerPoint);
				
				var bankerWinImage:Image = new Image();
				if(bankerWinScore > 0)
				{
					bankerWinImage.skin = "ui/baseUI/win.png";
				}
				else
				{
					bankerWinImage.skin = "ui/baseUI/lose.png";
				}
				bankerWinLabel.addChild(bankerWinImage);
				bankerWinImage.x = (bankerWinLabel.width - bankerWinLabel.textField.textWidth)/2-bankerWinImage.width;
				bankerWinImage.y = (bankerWinLabel.height - bankerWinImage.height)/2;
				Tween.to(bankerWinLabel,{x:bankerPoint.x,y:bankerPoint.y},300,null,Handler.create(this,winLabelDelay,[bankerWinLabel]),0,true);
			}
			
			function winLabelDelay(label:BmpFontLabel):void
			{
				Laya.timer.once(2500,this,winLabelRemove,[label],false);
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
			
			//obj.SBanker
			//obj.cbBankerTime
			//obj.lBankerWinScore
			//obj.bEnableSysBanker
			
			//obj.lApplyBankerCondition
			//obj.lAreaLimitScore
			//obj.szGameRoomName
			//-----------------------------
			//obj.cbGameStatus	== 100|101
			//obj.cbTimeLeave
			//obj.arlAreaInAllScore
			//obj.arMirlAreaInAllScore
			//obj.arlUserInAllScore
			//obj.lUserMaxScore
			//obj.lApplyBankerCondition
			//obj.lAreaLimitScore
			//obj.arcbDice
			
			//obj.SBanker
			//obj.cbBankerTime				//庄家局数
			//obj.lBankerWinScore			//庄家成绩
			//obj.bEnableSysBanker			//系统做庄
			
			//obj.lEndBankerScore
			//obj.lEndUserScore
			//obj.lEndUserReturnScore
			//obj.lEndRevenue
			//obj.szGameRoomName
			trace(obj.cbGameStatus,"gameSceneRec");
			DataProxy.enableSysBanker = obj.bEnableSysBanker;
			gameStatus = obj.cbGameStatus;
			_ui.shangZhuangPanel.szConditonUpdate(obj.lApplyBankerCondition);
			
			
			DataProxy.SBanker = obj.SBanker;
			if(DataProxy.SBanker.chIsMir == 0 && DataProxy.chairID == DataProxy.SBanker.wChair)
			{
				DataProxy.myBankerState = 2;
				if(obj.cbGameStatus == 100 || obj.cbGameStatus == 101)
				{
					userBankCostScore = DataProxy.SBanker.nGold;
					DataProxy.userScore -= userBankCostScore;
					_ui.myMoneyLabel.text = DataProxy.userScore + "";
				}
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
					_ui.myJetion0.text =obj.arlUserInAllScore[0] + "";
					myJetion0 = obj.arlUserInAllScore[0];
				}
				if(obj.arlUserInAllScore[2])
				{
					_ui.myJetion2.visible = true;
					_ui.myJetion2.text = obj.arlUserInAllScore[2] + "";
					myJetion2 = obj.arlUserInAllScore[2];
				}
				
				if(obj.cbGameStatus == 100 || obj.cbGameStatus == 101)
				{
					userJetionScore = myJetion0 + myJetion2;
					DataProxy.userScore -= userJetionScore;
					_ui.myMoneyLabel.text = DataProxy.userScore + "";
				}
				
				allJetion0 = obj.arlUserInAllScore[0];
				mirAllJetion0 = obj.arMirlAreaInAllScore[0];
				if((allJetion0 + mirAllJetion0) > 0)
				{
					_ui.allJetion0.visible = true;
					_ui.allJetion0.text = (allJetion0 + mirAllJetion0) + "";
				}
				
				allJetion2 = obj.arlUserInAllScore[2];
				mirAllJetion2 = obj.arMirlAreaInAllScore[2];
				if((allJetion2 + mirAllJetion2) > 0)
				{
					_ui.allJetion2.visible = true;
					_ui.allJetion2.text = (allJetion2 + mirAllJetion2) + "";
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
		
		public function updateUserInfo(userID:int = -1):void
		{
			if(userID == DataProxy.userID || userID == -1)
			{
				_ui.myNameLabel.text = "昵称：" + DataProxy.nickName;
				_ui.myMoneyLabel.text = DataProxy.userScore + "";
				_ui.myGameIDLabel.text = "游戏ID：" + DataProxy.gameID;
				_ui.myPortraitImage.skin = BaoziwangDefine.getPortraitImage(DataProxy.gender,DataProxy.faceID);
				_ui.configPanel.updateLimitNum(DataProxy.selfOption);
				_ui.rankPanel.updateTodayRecord();
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
				_ui["myJetion"+obj.cbJettonArea].text = this["myJetion"+obj.cbJettonArea] + "";
				_ui["myJetion"+obj.cbJettonArea].visible = true;
				DataProxy.userScore -= obj.lJettonScore;
				DataProxy.myUserInfo.lScore -= obj.lJettonScore;
				userJetionScore += obj.lJettonScore;
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
			_ui["allJetion"+obj.cbJettonArea].text = this["allJetion"+obj.cbJettonArea] + this["mirAllJetion" + obj.cbJettonArea] + "";
			_ui["allJetion"+obj.cbJettonArea].visible = true;
			
			SoundManager.playSound("music/ttz_chip_player.mp3");
		}
		
		public function mirPlaceJetionRec(obj:Object):void
		{
			//obj.arMirlAreaInAllScore
			mirAllJetion0 = obj.arMirlAreaInAllScore[0];
			if((allJetion0 + mirAllJetion0) > 0)
			{
				_ui.allJetion0.visible = true;
				_ui.allJetion0.text = (allJetion0 + mirAllJetion0) + "";
			}
			
			mirAllJetion2 = obj.arMirlAreaInAllScore[2];
			if((allJetion2 + mirAllJetion2) > 0)
			{
				_ui.allJetion2.visible = true;
				_ui.allJetion2.text = (allJetion2 + mirAllJetion2) + "";
			}
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
			return;
			//	vo["wChairID"] 		//申请玩家
		}
		
		public function applyBankerNewRec(obj:Object):void
		{
			//obj.btCount
			//obj.arApplyBanker
			//	obj.chIsMir
			//	obj.szServer
			//	obj.wChair
			//	obj.szName
			//	obj.nGold
			//	obj.time
			var i:int;
			for(i = 0; i < obj.arApplyBanker.length; i++)
			{
				var SBanker:Object = obj.arApplyBanker[i];
				SBanker.index = i;
				if(SBanker.chIsMir == 0 && DataProxy.chairID == SBanker.wChair)
				{
					DataProxy.myBankerState = 1;
					_ui.mainPanelTop.updateBankerBtn();
					_ui.shangZhuangPanel.updateMyBankerBtn();
				}
			}
			_ui.shangZhuangPanel.addApplyBanker(obj);
		}
		
		public function cancelBankerRec(obj:Object):void
		{
			//vo["chIsMir"] 		
			//vo["wChair"] 		
			//vo["szName"] 	
			
			if(obj.chIsMir == 0 && obj.wChair == DataProxy.chairID)
			{
				DataProxy.myBankerState = 0;
				_ui.mainPanelTop.updateBankerBtn();
				_ui.shangZhuangPanel.updateMyBankerBtn();
			}
			
			_ui.shangZhuangPanel.removeApplyBanker(obj);
		}
		
		private var changeBankerInfoDelay:Object;
		private var changeBankerDelay:Boolean = false;
		public function changeBankerRec(obj:Object):void
		{
			//obj.SBanker
			//	obj.chIsMir
			//	obj.szServer
			//	obj.wChair
			//	obj.szName
			//	obj.nGold
			//	obj.time
			
			if(changeBankerDelay)
			{
				changeBankerInfoDelay = obj;
				return;
			}
			
			if(DataProxy.myBankerState == 2)
			{
				if(obj.SBanker.wChair != DataProxy.chairID)
				{
					DataProxy.myBankerState = 0;
					_ui.mainPanelTop.updateBankerBtn();
					_ui.shangZhuangPanel.updateMyBankerBtn();
				}
			}
			
			if(obj.SBanker.chIsMir == 0)
			{
				if(DataProxy.chairID == obj.SBanker.wChair)
				{
					DataProxy.myBankerState = 2;
					_ui.mainPanelTop.updateBankerBtn();
					_ui.shangZhuangPanel.updateMyBankerBtn();
					userBankCostScore = obj.SBanker.nGold;
					trace(123456,"上庄扣钱：",userBankCostScore);
					DataProxy.userScore -= userBankCostScore;
					trace(123456,"上庄扣钱后自己的钱：",DataProxy.userScore);
					_ui.myMoneyLabel.text = DataProxy.userScore + "";
				}
			}
			DataProxy.SBanker = obj.SBanker;
			_ui.mainPanelTop.updateBankerInfo();
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