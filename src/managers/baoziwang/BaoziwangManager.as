package managers.baoziwang
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Loader;
	import laya.ui.Image;
	
	import managers.DataProxy;
	import managers.ManagerBase;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import resource.ResLoader;
	import resource.ResType;
	
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
			_ui.mainPanelBottom.init();
			_ui.clockBox.init();
			_ui.diceCupBox.init();
			_ui.tipBox.init();
			
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
					kaiZhong();
					break;
			}
		}
		
		private function yaoTouzi():void
		{
			_ui.laoPaoWang.changeMotion("yao",false);
			Laya.timer.once(2500,_ui.tipBox,_ui.tipBox.show,[1]);
		}
		
		private function qingXiaZhu():void
		{
			_ui.tipBox.show(1);
		}
		
		/**买定离手*/
		public function maiDingLiShou():void
		{
			_ui.tipBox.show(2);
			_ui.mainPanelBottom.canBetting = false;
		}
		
		/**开盅*/
		public function kaiZhong():void
		{
			_ui.clockBox.countDown(2,5000);
			_ui.diceCupBox.openDiceCup([3,5,3]);
			_ui.laoPaoWang.changeMotion("open",false);
		}
		
		private function xxx():void
		{
			_ui.diceCupBox.openDiceCup([1,6,6]);
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
			if(arr.length > 8)
			{
				i = arr.length - 8;
			}
			for(;i < arr.length; i++)
			{
				recordArr.push(arr[i]);
			}
			freshRecord();
			_ui.myNameLabel.text = DataProxy.nickName;
		}
		
		private function pushRecord(arr:Array):void
		{
			if(recordArr.length >= 8)
			{
				recordArr.shift();
			}
			var obj:Object = {};
			obj.cbDice0 = arr[0];
			obj.cbDice1 = arr[1];
			obj.cbDice2 = arr[2];
			if(obj.cbDice0 == obj.cbDice1 &&  obj.cbDice1 == obj.cbDice2)
			{
				obj.cbResult = 1;
			}
			else
			{
				if((obj.cbDice0 + obj.cbDice1 + obj.cbDice2) <= 10)
				{
					obj.cbResult = 2;
				}
				else
				{
					obj.cbResult = 0;
				}
			}
			recordArr.push(obj);
			freshRecord();
		}
		
		private function freshRecord():void
		{
			var i:int;
			for(i = 0; i < _ui.recordList.cells.length; i++)
			{
				var recordImage:Image = _ui.recordList.cells[i] as Image;
				var record:Object = recordArr[recordArr.length - i - 1];
				if(!record)
				{
					recordImage.visible = false;
				}
				else
				{
					recordImage.visible = true;
					switch(record.cbResult)
					{
						case BaoziwangDefine.RESULT_SMALL:
							recordImage.skin = "ui/baseUI/yb_bj_zs_01.png";
							break;
						case BaoziwangDefine.RESULT_BIG:
							recordImage.skin = "ui/baseUI/yb_bj_zs_02.png";
							break;
						case BaoziwangDefine.RESULT_BAOZI:
							recordImage.skin = "ui/baseUI/yb_bj_zs_03.png";
							break;
					}
				}
			}
		}
		
		public function gameStartRec(obj:Object):void
		{
			//obj.wBankerUser
			//obj.lBankerScore
			//obj.lUserMaxScore
			//obj.cbTimeLeave
			//obj.nChipRobotCount
		}
		
		public function gameFreeRec(obj:Object):void
		{
			//obj.cbTimeLeave
			//obj.nListUserCount
		}
		
		public function gameSceneRec(obj:Object):void
		{
			switch(obj.cbGameStatus)
			{
				case 0:
					trace("---------------------------------------");
					changeStateFree(obj);
					break;
				case 100:
					changeStateBet(obj);
					break;
				case 101:
					changeStateEnd(obj);
					break;
			}
		}
		
		private function changeStateFree(obj:Object):void
		{
			//obj.cbGameStatus
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
		}
		
		private function changeStateBet(obj:Object):void
		{
			//obj.cbGameStatus
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
		}
		
		private function changeStateEnd(obj:Object):void
		{
			//obj.cbGameStatus
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
			pushRecord(obj.arcbDice);
		}
		
	}
}