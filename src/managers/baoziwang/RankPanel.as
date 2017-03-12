package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Tween;
	
	public class RankPanel extends Box
	{
		private var bgImage:Image;
		private var winArrow:Image;
		private var loseArrow:Image;
		private var winBtn:Box;
		private var loseBtn:Box;
		private var winList:List;
		private var loseList:List;
		
		private var _showState:int = 0;
		private var _choseState:int = 0;
		public function RankPanel()
		{
			super();
		}
		
		public function init():void
		{
			bgImage = getChildByName("bgImage") as Image;
			winArrow = getChildByName("winArrow") as Image;
			loseArrow = getChildByName("loseArrow") as Image;
			winBtn = getChildByName("winBtn") as Box;
			loseBtn = getChildByName("loseBtn") as Box;
			winList = getChildByName("winList") as List;
			loseList = getChildByName("loseList") as List;
			
			winBtn.on(Event.CLICK,this,winClick);
			loseBtn.on(Event.CLICK,this,loseClick);
			
			freshState();
			winList.array = [];
			loseList.array = [];
			this.x = Laya.stage.width - 35;
		}
		
		private function stageMouseUp(event:Event = null):void
		{
			if(this.hitTestPoint(event.stageX,event.stageY))
			{
				
			}
			else
			{
				showState = 0;
			}
		}
		
		private function winClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 0;
			}
			else
			{
				if(_choseState == 0)
				{
					showState = 0;
				}
				choseState = 0;
			}
		}
		
		private function loseClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 1;
			}
			else
			{
				if(_choseState == 1)
				{
					showState = 0;
				}
				choseState = 1;
			}
		}
		
		private function set showState(value:int):void
		{
			if(_showState == value)return;
			_showState = value;
			freshState();
			if(_showState == 0)
			{
				Tween.to(this,{x:Laya.stage.width - 35},300,null,null,0,true);
				Laya.stage.off(Event.MOUSE_UP,this,stageMouseUp);
			}
			else
			{
				Tween.to(this,{x:Laya.stage.width - 35 - 295},300,null,null,0,true);
				Laya.stage.on(Event.MOUSE_UP,this,stageMouseUp);
			}
		}
		
		private function set choseState(value:int):void
		{
			if(_choseState == value)return;
			_choseState = value;
			freshState();
		}
		
		private function freshState():void
		{
			if(_showState == 0)	//隐藏排行榜
			{
				winArrow.skin = "ui/baseUI/ttz_talk_j2.png";
				loseArrow.skin = "ui/baseUI/ttz_talk_j2.png";
			}
			else				//显示排行榜
			{
				winArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				loseArrow.skin = "ui/baseUI/ttz_talk_j1.png";
			}
			if(_choseState == 0)//选中赢钱
			{
				winArrow.visible = true;
				loseArrow.visible = false;
				winList.visible = true;
				loseList.visible = false;
				bgImage.skin = "ui/baseUI/ttz_rank_bg_0.png";
			}
			else				//选中输钱
			{
				winArrow.visible = false;
				loseArrow.visible = true;
				winList.visible = false;
				loseList.visible = true;
				bgImage.skin = "ui/baseUI/ttz_rank_bg_1.png";
			}
		}
		
		public function updateRankInfo(obj:Object):void
		{
			//obj.cType 0赢钱  1输钱
			//obj.arRank
			//	obj.szNickName
			//	obj.lScore
			if(obj.cType == 0)
			{
				updateWinRank(obj.arRank);
			}
			
			if(obj.cType == 1)
			{
				updateLoseRank(obj.arRank);
			}
		}
		
		private function updateWinRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			winList.array = rankArr;
		}
		
		private function updateLoseRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			loseList.array = rankArr;
		}
		
		
	}
}