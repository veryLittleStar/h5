package managers.baoziwang
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.media.SoundManager;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	import managers.ManagersMap;
	
	import net.NetProxy;
	
	public class MainPanelBottom extends Box
	{
		private var _canBetting:Boolean = false;
		private var chipsBg:Image;
		private var chips:List;
		private var autoBettingBtn:Button;
		private var mxBtn:Button;
		private var mdBtn:Button;
		private var activeSelectSound:Boolean = true;
		public var autoBeting:Boolean = false;
		public function MainPanelBottom()
		{
			super();
		}
		
		public function init():void
		{
			chipsBg = getChildByName("chipsBg") as Image;
			chips = chipsBg.getChildByName("chips") as List;
			autoBettingBtn = getChildByName("autoBettingBtn") as Button;
			mxBtn = getChildByName("mxBtn") as Button;
			mdBtn = getChildByName("mdBtn") as Button;
			chips.selectHandler = Handler.create(this,chipSelect,null,false);
			chips.array = [100,1000,5000,10000,100000];
			autoBettingBtn.on(Event.CLICK,this,autoBetClick);
			mxBtn.on(Event.CLICK,this,mxClick);
			mdBtn.on(Event.CLICK,this,mdClick);
		}
		
		public function set canBetting(value:Boolean):void
		{
			if(_canBetting == value)return;
			_canBetting = value;
			bettingStateChange();
			updateAutoBettingBtn();
			if(_canBetting)
			{
				SoundManager.playSound("music/ttz_my_board.mp3");
			}
		}
		
		public function get canBetting():Boolean
		{
			return _canBetting;
		}
		
		private function bettingStateChange():void
		{
			if(_canBetting)
			{
				Tween.to(chipsBg,{y:20},500,null,Handler.create(this,chipActive),0,true);
			}
			else
			{
				Tween.to(chipsBg,{y:50},500,null,null,0,true);
				chips.selectEnable = false;
				for(var i:int; i < chips.cells.length; i++)
				{
					var chipCell:ChipCell = chips.cells[i] as ChipCell;
					chipCell.selected = false;
				}
			}
		}
		
		private function chipActive():void
		{
			chips.selectEnable = true;
			activeSelectSound = false;
			if(chips.selectedIndex == -1)
			{
				chips.selectedIndex = 0;
			}
			else
			{
				chipSelect();
			}
		}
		
		private function chipSelect():void
		{
			for(var i:int; i < chips.cells.length; i++)
			{
				var chipCell:ChipCell = chips.cells[i] as ChipCell;
				if(i == chips.selectedIndex)
				{
					chipCell.selected = true;
				}
				else
				{
					chipCell.selected = false;
				}
			}
			if(activeSelectSound == false)
			{
				activeSelectSound = true
			}
			else
			{
				SoundManager.playSound("music/ttz_card_send.mp3");
			}
		}
		
		public function get selectChipScore():int
		{
			return chips.selectedItem as int;
		}
		
		public function getChipPosByScore(score:int):Point
		{
			var i:int;
			for(i = 0; i < 5; i++)
			{
				var chipScore:int = chips.getItem(i) as int;
				if(chipScore == score)
				{
					var cell:Box = chips.getCell(i);
					var point:Point = new Point();
					point = cell.localToGlobal(point);
					return point;
				}
			}
			return null;
		}
		
		public function updateAutoBettingBtn():void
		{
			if(_canBetting && ManagersMap.baoziwangManager.preRoundJetionArr.length)
			{
				autoBettingBtn.disabled = false;
			}
			else
			{
				autoBettingBtn.disabled = true;
			}
		}
		
		private function autoBetClick(event:Event):void
		{
			if(autoBeting)return;
			var arr:Array = ManagersMap.baoziwangManager.preRoundJetionArr;
			var preTotalJetion:int = 0;
			var i:int = 0;
			for(i = 0; i < arr.length; i++)
			{
				preTotalJetion += arr[i].lJettonScore;
			}
			
			if(preTotalJetion >DataProxy.userScore)
			{
				ManagersMap.systemMessageManager.showSysMessage("您的金币不足");
				return;
			}
			else
			{
				for(i = 0; i < arr.length; i++)
				{
					var body:Object = {};
					body.cbJettonArea 	= arr[i].cbJettonArea;
					body.lJettonScore   = arr[i].lJettonScore;	
					NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_PLACE_JETION_REQ,body);
				}
				autoBeting = true;
			}
		}
		
		private function mxClick(obj:Object):void
		{
			var body:Object = {};
			body.cbJettonArea 	= BaoziwangDefine.RESULT_SMALL;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_ALL_IN_JETION_REQ,body);
		}
		
		private function mdClick(obj:Object):void
		{
			var body:Object = {};
			body.cbJettonArea 	= BaoziwangDefine.RESULT_BIG;
			NetProxy.getInstance().sendToServer(BaoziwangDefine.MSG_BZW_ALL_IN_JETION_REQ,body);
		}
		
		public function updateMBtn(allInArea:int):void
		{
			if(allInArea == -1)
			{
				mdBtn.disabled = false;
				mxBtn.disabled = false;
				return;
			}
			if(allInArea == -2)
			{
				mdBtn.disabled = true;
				mxBtn.disabled = true;
				return;
			}
			if(allInArea == BaoziwangDefine.RESULT_SMALL)
			{
				mdBtn.disabled = true;
			}
			else
			{
				mdBtn.disabled = false;
			}
			
			if(allInArea == BaoziwangDefine.RESULT_BIG)
			{
				mxBtn.disabled = true;
			}
			else
			{
				mxBtn.disabled = false;
			}
		}
		
	}
}