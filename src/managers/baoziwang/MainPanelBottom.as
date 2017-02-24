package managers.baoziwang
{
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.DataProxy;
	
	public class MainPanelBottom extends Box
	{
		private var _canBetting:Boolean = false;
		private var chipsBg:Image;
		private var chips:List;
		private var autoBettingBtn:Button;
		public function MainPanelBottom()
		{
			super();
		}
		
		public function init():void
		{
			chipsBg = getChildByName("chipsBg") as Image;
			chips = chipsBg.getChildByName("chips") as List;
			autoBettingBtn = getChildByName("autoBettingBtn") as Button;
			chips.selectHandler = Handler.create(this,chipSelect,null,false);
			chips.array = [100,1000,5000,10000,100000];
		}
		
		public function set canBetting(value:Boolean):void
		{
			if(_canBetting == value)return;
			_canBetting = value;
			bettingStateChange();
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
				autoBettingBtn.disabled = false;
				
			}
			else
			{
				Tween.to(chipsBg,{y:50},500,null,null,0,true);
				autoBettingBtn.disabled = true;
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
		
	}
}