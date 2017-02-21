package managers.baoziwang
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Loader;
	
	import managers.ManagerBase;
	
	import net.NetDefine;
	import net.NetProxy;
	
	import ui.BaoziwangUI;
	
	public class BaoziwangManager extends ManagerBase
	{
		private var _ui:BaoziwangUI;
		public function get ui():BaoziwangUI
		{
			return _ui;
		}
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
					_ui.tipBox.show(2);
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
			//--------------------------------------
			//obj.cbGameStatus == 1||2
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
		
	}
}